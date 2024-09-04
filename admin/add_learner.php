<?php
// Start output buffering
ob_start();

// Start the session if it's not already started
if (session_status() == PHP_SESSION_NONE) {
    session_start();
}

// Check if the user is logged in
if (!isset($_SESSION['admin_id'])) {
    header("Location: index.php");
    exit();
}

require 'includes/header.php';
require 'db.php';
require '../vendor/autoload.php'; // Make sure to include the Composer autoload file

use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;

// Fetch parents for dropdown
$parents = [];
try {
    $stmt = $db->query("SELECT parent_id, parent_name, parent_surname, parent_email FROM parent");
    $parents = $stmt->fetchAll(PDO::FETCH_ASSOC);
} catch (PDOException $e) {
    echo "<p>Error fetching parents: " . htmlspecialchars($e->getMessage()) . "</p>";
}

// Fetch bus routes for dropdown
$busses = [];
try {
    $stmt = $db->query("SELECT bus_id FROM busses");
    $busses = $stmt->fetchAll(PDO::FETCH_ASSOC);
} catch (PDOException $e) {
    echo "<p>Error fetching busses: " . htmlspecialchars($e->getMessage()) . "</p>";
}

// Check if the form is submitted
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['add_child'])) {
    // Retrieve and sanitize form inputs
    $parent_id = htmlspecialchars(trim($_POST['parent_id']));
    $bus_id = htmlspecialchars(trim($_POST['bus_id']));
    $admin_id = $_SESSION['admin_id'];
    $name = htmlspecialchars(trim($_POST['learner_name']));
    $surname = htmlspecialchars(trim($_POST['learner_surname']));
    $dob = htmlspecialchars(trim($_POST['learner_dob']));
    $home_address = htmlspecialchars(trim($_POST['learner_home_address']));
    $phone = htmlspecialchars(trim($_POST['learner_phone']));
    $grade = htmlspecialchars(trim($_POST['learner_grade']));

    // Ensure bus_id exists
    $bus_exists = false;
    foreach ($busses as $bus) {
        if ($bus['bus_id'] == $bus_id) {
            $bus_exists = true;
            break;
        }
    }

    if (!$bus_exists) {
        echo "<p>Error: The selected bus route does not exist.</p>";
    } else {
        try {
            // Start a transaction
            $db->beginTransaction();

            // Insert into learner table
            $sql = "
                INSERT INTO learner (parent_id, bus_id, admin_id, learner_name, learner_surname, learner_dob, learner_home_address, learner_phone, learner_grade, created_at)
                VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, NOW())
            ";
            $stmt = $db->prepare($sql);
            $stmt->execute([$parent_id, $bus_id, $admin_id, $name, $surname, $dob, $home_address, $phone, $grade]);

            // Get the last inserted learner_id
            $learner_id = $db->lastInsertId();

            // Generate a unique application number
            $application_no = 'APP' . str_pad($learner_id, 6, '0', STR_PAD_LEFT);

            // Insert into student_app table
            $sql = "
                INSERT INTO student_app (learner_id, parent_id, app_no, route_id, stop_id, status, app_date)
                VALUES (?, ?, ?, ?, ?, ?, NOW())
            ";
            $stmt = $db->prepare($sql);
            $stmt->execute([$learner_id, $parent_id, $application_no, $bus_id, null, 'pending']);

            // Fetch parent email
            $sql = "SELECT parent_email FROM parent WHERE parent_id = ?";
            $stmt = $db->prepare($sql);
            $stmt->execute([$parent_id]);
            $parent = $stmt->fetch(PDO::FETCH_ASSOC);
            $parent_email = $parent['parent_email'];

            // Commit the transaction
            $db->commit();

            // Send confirmation email
            $mail = new PHPMailer(true);
            try {
                // Server settings
                $mail->isSMTP();                                       // Set mailer to use SMTP
                $mail->Host = 'smtp.gmail.com';                      // Specify main and backup SMTP servers
                $mail->SMTPAuth = true;                                // Enable SMTP authentication
                $mail->Username = 'obrsystemict3715@gmail.com';            // SMTP username
                $mail->Password = 'cxop xmuk zrle corl';               // SMTP password
                $mail->SMTPSecure = 'tls';                             // Enable TLS encryption, `ssl` also accepted
                $mail->Port = 587;                                    // TCP port to connect to

                // SSL options (for testing only)
                $mail->SMTPOptions = array(
                    'ssl' => array(
                        'verify_peer' => false,
                        'verify_peer_name' => false,
                        'allow_self_signed' => true
                    )
                );

                // Recipients
                $mail->setFrom('your_email@example.com', 'Online Bus Registration System');
                $mail->addAddress($parent_email);       // Add a recipient

                // Content
                $mail->isHTML(true);                                        // Set email format to HTML
                $mail->Subject = 'Child Application Confirmation';
                $mail->Body    = "Dear Parent,<br><br>Your child has been successfully added with Application Number: <strong>$application_no</strong>.<br><br>Thank you.";

                $mail->send();
            } catch (Exception $e) {
                echo "Message could not be sent. Mailer Error: {$mail->ErrorInfo}";
            }

            // Redirect to the success page with the application number
            header("Location: success.php?application_no=" . urlencode($application_no));
            exit();
        } catch (PDOException $e) {
            // Rollback the transaction on error
            $db->rollBack();
            echo "<p>Error: " . htmlspecialchars($e->getMessage()) . "</p>";
        }
    }
}
?>

<div class="container-fluid">
    <div class="row">
        <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 main-content">
            <div class="chart-placeholder">
                <br>
                <div class="container">
                    <!-- HTML Form for adding learners -->
                    <form method="POST" action="add_learner.php" class="container mt-4">
                        <div class="row">
                            <!-- Parent ID Dropdown -->
                            <div class="col-md-6 mb-3">
                                <label for="parent_id" class="form-label">Parent</label>
                                <select id="parent_id" name="parent_id" class="form-select" required>
                                    <option value="">Select Parent</option>
                                    <?php foreach ($parents as $parent): ?>
                                        <option value="<?php echo htmlspecialchars($parent['parent_id']); ?>">
                                            <?php echo htmlspecialchars($parent['parent_name'] . ' ' . $parent['parent_surname']); ?>
                                        </option>
                                    <?php endforeach; ?>
                                </select>
                            </div>

                            <!-- Bus ID Dropdown -->
                            <div class="col-md-6 mb-3">
                                <label for="bus_id" class="form-label">Bus Route</label>
                                <select id="bus_id" name="bus_id" class="form-select" required>
                                    <option value="">Select Route</option>
                                    <?php foreach ($busses as $bus): ?>
                                        <option value="<?php echo htmlspecialchars($bus['bus_id']); ?>">
                                            <?php echo htmlspecialchars($bus['bus_id']); ?>
                                        </option>
                                    <?php endforeach; ?>
                                </select>
                            </div>

                            <!-- Admin ID (hidden field) -->
                            <input type="hidden" name="admin_id" value="<?php echo htmlspecialchars($_SESSION['admin_id']); ?>">

                            <!-- Child's Name -->
                            <div class="col-md-6 mb-3">
                                <label for="learner_name" class="form-label">Child's Name</label>
                                <input type="text" id="learner_name" name="learner_name" class="form-control" placeholder="Child's Name" required>
                            </div>

                            <!-- Surname -->
                            <div class="col-md-6 mb-3">
                                <label for="learner_surname" class="form-label">Surname</label>
                                <input type="text" id="learner_surname" name="learner_surname" class="form-control" placeholder="Surname" required>
                            </div>

                            <!-- Date of Birth -->
                            <div class="col-md-6 mb-3">
                                <label for="learner_dob" class="form-label">Date of Birth</label>
                                <input type="date" id="learner_dob" name="learner_dob" class="form-control" required>
                            </div>

                            <!-- Home Address -->
                            <div class="col-md-6 mb-3">
                                <label for="learner_home_address" class="form-label">Home Address</label>
                                <input type="text" id="learner_home_address" name="learner_home_address" class="form-control" placeholder="Home Address" required>
                            </div>

                            <!-- Phone -->
                            <div class="col-md-6 mb-3">
                                <label for="learner_phone" class="form-label">Phone</label>
                                <input type="tel" id="learner_phone" name="learner_phone" class="form-control" placeholder="Phone" required>
                            </div>

                            <!-- Grade -->
                            <div class="col-md-6 mb-3">
                                <label for="learner_grade" class="form-label">Grade</label>
                                <select id="learner_grade" name="learner_grade" class="form-select" required>
                                    <option value="">Select Grade</option>
                                    <option value="7">7</option>
                                    <option value="8">8</option>
                                    <option value="9">9</option>
                                    <option value="10">10</option>
                                    <option value="11">11</option>
                                    <option value="12">12</option>
                                </select>
                            </div>

                            <!-- Submit Button -->
                            <div class="col-12">
                                <button type="submit" name="add_child" class="btn btn-primary">Add Child</button>   
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </main>
    </div>
</div>

<?php require 'includes/footer.php'; ?>

<?php
// End output buffering and send output to browser
ob_end_flush();
?>

