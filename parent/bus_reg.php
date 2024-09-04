<?php

// Start the session if it's not already started
if (session_status() == PHP_SESSION_NONE) {
    session_start();
}


// Check if the user is logged in
if (!isset($_SESSION['parent_id'])) {
    header("Location: index.php");
    exit();
}
?>

<?php require 'includes/header.php'; ?>

<div class="container-fluid">
    <div class="row">


        <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 main-content">
            <div class="chart-placeholder">
                <br>
                <div class="container">


                    <?php
                    require 'db.php';
                    try {
                        // Fetch registrations with child, route, and stop details in a single query
                        $stmt = $db->prepare("
                            SELECT * FROM `registrations` 
                        ");
                        $stmt->execute([]);
                        $registrations = $stmt->fetchAll(PDO::FETCH_ASSOC);
                    } catch (PDOException $e) {
                        echo "Error fetching registrations: " . $e->getMessage();
                        exit; // Stop execution if there's an error
                    }

                    if (empty($registrations)) {
                        echo "<p>No registrations found for this parent.</p>";
                    } else {
                        echo "<table class='table table-striped'>";
                        echo "<thead><tr><th>Parent ID</th><th>Route ID</th><th>Stop ID</th><th>Status</th><th>Registration Date</th></tr></thead>";
                        echo "<tbody>";
                        foreach ($registrations as $registration) {
                            echo "<tr>";
                            echo "<td>" . htmlspecialchars($registration['parent_id']) . "</td>";
                            echo "<td>" . htmlspecialchars($registration['route_id']) . "</td>";
                            echo "<td>" . htmlspecialchars($registration['stop_id']) . "</td>";
                            echo "<td>" . htmlspecialchars($registration['status']) . "</td>";
                            echo "<td>" . htmlspecialchars($registration['registration_date']) . "</td>";
                            echo "<td>";
                            if ($registration['status'] === 'Approved') {
                                echo "<a href='add_child.php' target='_blank'>Pay</a>";
                            } else {
                                echo "waiting list";
                            }
                            echo "</td>";
                            echo "</tr>";
                        }
                        echo "</tbody></table>";
                    }
                    ?>

                    <script>
                        function confirmDelete(name) {
                            return confirm('Are you sure you want to delete ' + name + '?');
                        }
                    </script>

                </div>
            </div>
        </main>
    </div>
</div>

<?php require 'includes/footer.php'; ?>
