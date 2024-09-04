<?php
// Start output buffering
ob_start();

// Start the session if it's not already started
if (session_status() == PHP_SESSION_NONE) {
    session_start();
}

// Check if the user is logged in
if (!isset($_SESSION['parent_id'])) {
    header("Location: index.php");
    exit();
}

require 'includes/header.php';
require 'db.php';

// Initialize variables for form data and error messages
$error_msg = '';
$bus_id = $admin_id = '';

// Check if the form is submitted
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['add_child'])) {
    // Retrieve and sanitize form inputs
    $parent_id = $_SESSION['parent_id'];
    $bus_id = htmlspecialchars(trim($_POST['bus_id']));
    $admin_id = htmlspecialchars(trim($_POST['admin_id']));
    $name = htmlspecialchars(trim($_POST['learner_name']));
    $surname = htmlspecialchars(trim($_POST['learner_surname']));
    $dob = htmlspecialchars(trim($_POST['learner_dob']));
    $home_address = htmlspecialchars(trim($_POST['learner_home_address']));
    $phone = htmlspecialchars(trim($_POST['learner_phone']));
    $grade = htmlspecialchars(trim($_POST['learner_grade']));

    // Check if bus_id exists in the busses table
    $bus_check_stmt = $db->prepare("SELECT COUNT(*) FROM busses WHERE bus_id = ?");
    $bus_check_stmt->execute([$bus_id]);
    if ($bus_check_stmt->fetchColumn() == 0) {
        $error_msg = "Invalid bus selected. Please choose a valid bus.";
    } else {
        // Prepare SQL statement
        $sql = "
            INSERT INTO learner (parent_id, bus_id, admin_id, learner_name, learner_surname, learner_dob, learner_home_address, learner_phone, learner_grade, created_at)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, NOW())
        ";
        $stmt = $db->prepare($sql);

        try {
            // Bind parameters and execute the statement
            $stmt->execute([$parent_id, $bus_id, $admin_id, $name, $surname, $dob, $home_address, $phone, $grade]);

            // Redirect to the success page
            header("Location: success.php"); // specify the target page here
            exit();
        } catch (PDOException $e) {
            // Display error message in a user-friendly manner
            $error_msg = "Error: " . htmlspecialchars($e->getMessage());
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
                    <?php if (!empty($error_msg)): ?>
                        <div class="alert alert-danger" role="alert">
                            <?php echo $error_msg; ?>
                        </div>
                    <?php endif; ?>

                    <form method="POST" action="add_child.php" class="container mt-4">
                        <div class="row">
                            <!-- Parent ID (hidden field) -->
                            <input type="hidden" name="parent_id" value="<?php echo htmlspecialchars($_SESSION['parent_id']); ?>">

                            <!-- Bus ID (hidden field) -->
                            <input type="hidden" name="bus_id" value="<?php echo htmlspecialchars($bus_id); ?>">

                            <!-- Admin ID (hidden field) -->
                            <input type="hidden" name="admin_id" value="<?php echo htmlspecialchars($admin_id); ?>">

                            <!-- Child's Name -->
                            <div class="col-md-6 mb-3">
                                <label for="learner_name" class="form-label">Learner's Name</label>
                                <input type="text" id="learner_name" name="learner_name" class="form-control" placeholder="Learner's Name" value="<?php echo htmlspecialchars($name ?? ''); ?>" required>
                            </div>

                            <!-- Surname -->
                            <div class="col-md-6 mb-3">
                                <label for="learner_surname" class="form-label">Surname</label>
                                <input type="text" id="learner_surname" name="learner_surname" class="form-control" placeholder="Surname" value="<?php echo htmlspecialchars($surname ?? ''); ?>" required>
                            </div>

                            <!-- Date of Birth -->
                            <div class="col-md-6 mb-3">
                                <label for="learner_dob" class="form-label">Date of Birth</label>
                                <input type="date" id="learner_dob" name="learner_dob" class="form-control" value="<?php echo htmlspecialchars($dob ?? ''); ?>" required>
                            </div>

                            <!-- Home Address -->
                            <div class="col-md-6 mb-3">
                                <label for="learner_home_address" class="form-label">Home Address</label>
                                <input type="text" id="learner_home_address" name="learner_home_address" class="form-control" placeholder="Home Address" value="<?php echo htmlspecialchars($home_address ?? ''); ?>" required>
                            </div>

                            <!-- Phone -->
                            <div class="col-md-6 mb-3">
                                <label for="learner_phone" class="form-label">Phone</label>
                                <input type="tel" id="learner_phone" name="learner_phone" class="form-control" placeholder="Phone" value="<?php echo htmlspecialchars($phone ?? ''); ?>" required>
                            </div>

                            <!-- Grade -->
                            <div class="col-md-6 mb-3">
                                <label for="learner_grade" class="form-label">Grade</label>
                                <select id="learner_grade" name="learner_grade" class="form-select" required>
                                    <option value="">Select Grade</option>
                                    <option value="8" <?php if (isset($grade) && $grade == 8) echo 'selected'; ?>>8</option>
                                    <option value="9" <?php if (isset($grade) && $grade == 9) echo 'selected'; ?>>9</option>
                                    <option value="10" <?php if (isset($grade) && $grade == 10) echo 'selected'; ?>>10</option>
                                    <option value="11" <?php if (isset($grade) && $grade == 11) echo 'selected'; ?>>11</option>
                                    <option value="12" <?php if (isset($grade) && $grade == 12) echo 'selected'; ?>>12</option>
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


