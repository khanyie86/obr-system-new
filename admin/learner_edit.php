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

// Fetch learner details for editing
$learner = [];
if (isset($_GET['learner_id'])) {
    $learner_id = htmlspecialchars(trim($_GET['learner_id']));
    try {
        $stmt = $db->prepare("SELECT * FROM learner WHERE learner_id = ?");
        $stmt->execute([$learner_id]);
        $learner = $stmt->fetch(PDO::FETCH_ASSOC);
    } catch (PDOException $e) {
        echo "<p>Error fetching learner details: " . htmlspecialchars($e->getMessage()) . "</p>";
    }
} else {
    echo "<p>Error: Learner ID is not provided.</p>";
    exit();
}

// Handle the form submission for updating learner details
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['edit_child'])) {
    // Retrieve and sanitize form inputs
    $name = htmlspecialchars(trim($_POST['learner_name']));
    $surname = htmlspecialchars(trim($_POST['learner_surname']));
    $dob = htmlspecialchars(trim($_POST['learner_dob']));
    $home_address = htmlspecialchars(trim($_POST['learner_home_address']));
    $phone = htmlspecialchars(trim($_POST['learner_phone']));
    $grade = htmlspecialchars(trim($_POST['learner_grade']));

    try {
        // Update the learner details in the database
        $sql = "
            UPDATE learner 
            SET learner_name = ?, learner_surname = ?, learner_dob = ?, learner_home_address = ?, learner_phone = ?, learner_grade = ?
            WHERE learner_id = ?
        ";
        $stmt = $db->prepare($sql);
        $stmt->execute([$name, $surname, $dob, $home_address, $phone, $grade, $learner_id]);

        // Redirect to the success page
        header("Location: success.php?message=" . urlencode("Child details updated successfully."));
        exit();
    } catch (PDOException $e) {
        echo "<p>Error: " . htmlspecialchars($e->getMessage()) . "</p>";
    }
}
?>

<div class="container-fluid">
    <div class="row">
        <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 main-content">
            <div class="chart-placeholder">
                <br>
                <div class="container">
                    <!-- Form for editing learner details -->
                    <form method="POST" action="learner_edit.php?learner_id=<?php echo htmlspecialchars($learner['learner_id']); ?>" class="container mt-4">
                        <div class="row">
                            <!-- Child's Name -->
                            <div class="col-md-6 mb-3">
                                <label for="learner_name" class="form-label">Child's Name</label>
                                <input type="text" id="learner_name" name="learner_name" class="form-control" value="<?php echo htmlspecialchars($learner['learner_name']); ?>" required>
                            </div>

                            <!-- Surname -->
                            <div class="col-md-6 mb-3">
                                <label for="learner_surname" class="form-label">Surname</label>
                                <input type="text" id="learner_surname" name="learner_surname" class="form-control" value="<?php echo htmlspecialchars($learner['learner_surname']); ?>" required>
                            </div>

                            <!-- Date of Birth -->
                            <div class="col-md-6 mb-3">
                                <label for="learner_dob" class="form-label">Date of Birth</label>
                                <input type="date" id="learner_dob" name="learner_dob" class="form-control" value="<?php echo htmlspecialchars($learner['learner_dob']); ?>" required>
                            </div>

                            <!-- Home Address -->
                            <div class="col-md-6 mb-3">
                                <label for="learner_home_address" class="form-label">Home Address</label>
                                <input type="text" id="learner_home_address" name="learner_home_address" class="form-control" value="<?php echo htmlspecialchars($learner['learner_home_address']); ?>" required>
                            </div>

                            <!-- Phone -->
                            <div class="col-md-6 mb-3">
                                <label for="learner_phone" class="form-label">Phone</label>
                                <input type="tel" id="learner_phone" name="learner_phone" class="form-control" value="<?php echo htmlspecialchars($learner['learner_phone']); ?>" required>
                            </div>

                            <!-- Grade -->
                            <div class="col-md-6 mb-3">
                                <label for="learner_grade" class="form-label">Grade</label>
                                <select id="learner_grade" name="learner_grade" class="form-select" required>
                                    <option value="7" <?php echo $learner['learner_grade'] == 7 ? 'selected' : ''; ?>>7</option>
                                    <option value="8" <?php echo $learner['learner_grade'] == 8 ? 'selected' : ''; ?>>8</option>
                                    <option value="9" <?php echo $learner['learner_grade'] == 9 ? 'selected' : ''; ?>>9</option>
                                    <option value="10" <?php echo $learner['learner_grade'] == 10 ? 'selected' : ''; ?>>10</option>
                                    <option value="11" <?php echo $learner['learner_grade'] == 11 ? 'selected' : ''; ?>>11</option>
                                    <option value="12" <?php echo $learner['learner_grade'] == 12 ? 'selected' : ''; ?>>12</option>
                                </select>
                            </div>

                            <!-- Submit Button -->
                            <div class="col-12">
                                <button type="submit" name="learner_edit" class="btn btn-primary">Update Child</button>
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
