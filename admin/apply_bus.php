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

// Fetch data from the database for the form
try {
    // Fetch learners from the database
    $stmt = $db->query("SELECT learner_id, learner_name, learner_surname FROM learner");
    $learners = $stmt->fetchAll(PDO::FETCH_ASSOC);

    // Fetch routes from the database
    $stmt = $db->query("SELECT route_id, route_destination FROM routes");
    $routes = $stmt->fetchAll(PDO::FETCH_ASSOC);

    // Fetch stops from the database
    $stmt = $db->query("SELECT stop_id, stop_name FROM stops");
    $stops = $stmt->fetchAll(PDO::FETCH_ASSOC);
} catch (PDOException $e) {
    echo "Error fetching data: " . $e->getMessage();
    exit();
}
?>

<div class="container-fluid">
    <div class="row">
        <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 main-content">
            <div class="chart-placeholder">
                <br>
                <div class="container mt-5">
                    <h2>Apply for Bus Registration</h2>
                    <form method="POST" action="" class="needs-validation" novalidate>
                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label for="learner_id" class="form-label">Learner</label>
                                <select id="learner_id" name="learner_id" class="form-select" required>
                                    <option value="">Select Learner</option>
                                    <?php foreach ($learners as $learner): ?>
                                        <option value="<?php echo htmlspecialchars($learner['learner_id']); ?>">
                                            <?php echo htmlspecialchars($learner['learner_name'] . ' ' . $learner['learner_surname']); ?>
                                        </option>
                                    <?php endforeach; ?>
                                </select>
                                <div class="invalid-feedback">
                                    Please select a learner.
                                </div>
                            </div>

                            <div class="col-md-6">
                                <label for="route_id" class="form-label">Bus Route</label>
                                <select id="route_id" name="route_id" class="form-select" required>
                                    <option value="">Select Route</option>
                                    <?php foreach ($routes as $route): ?>
                                        <option value="<?php echo htmlspecialchars($route['route_id']); ?>">
                                            <?php echo htmlspecialchars($route['route_destination']); ?>
                                        </option>
                                    <?php endforeach; ?>
                                </select>
                                <div class="invalid-feedback">
                                    Please select a bus route.
                                </div>
                            </div>
                        </div>

                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label for="stop_id" class="form-label">Bus Stop</label>
                                <select id="stop_id" name="stop_id" class="form-select" required>
                                    <option value="">Select Stop</option>
                                    <?php foreach ($stops as $stop): ?>
                                        <option value="<?php echo htmlspecialchars($stop['stop_id']); ?>">
                                            <?php echo htmlspecialchars($stop['stop_name']); ?>
                                        </option>
                                    <?php endforeach; ?>
                                </select>
                                <div class="invalid-feedback">
                                    Please select a bus stop.
                                </div>
                            </div>
                        </div>

                        <button type="submit" class="btn btn-primary">Submit Application</button>
                    </form>
                </div>
            </div>
        </main>
    </div>
</div>

<script>
    // JavaScript to enable Bootstrap validation feedback
    (function () {
        'use strict';
        var forms = document.querySelectorAll('.needs-validation');
        Array.prototype.slice.call(forms).forEach(function (form) {
            form.addEventListener('submit', function (event) {
                if (!form.checkValidity()) {
                    event.preventDefault();
                    event.stopPropagation();
                }
                form.classList.add('was-validated');
            }, false);
        });
    })();
</script>

<?php require 'includes/footer.php'; ?>

<?php
// End output buffering and send output to browser
ob_end_flush();
?>
