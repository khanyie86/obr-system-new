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
?>

<div class="container-fluid">
    <div class="row">
        <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 main-content">
            <div class="chart-placeholder">
                <br>
                <div class="container">
                <h3 class="mt-5">Waiting List</h3>
                    <table class="table table-striped mt-3">
                        <thead>
                        <tr>
                            <th>Waiting List No</th>
                            <th>Learner ID</th>
                            <th>Admin ID</th>
                            <th>learner Name</th>
                            <th>learner Phone</th>
                            <th>Waitinglist Group</th>
                        </tr>
                        </thead>
                        <tbody>
                        <?php
                    // Database credentials
                    $host = getenv('DB_HOST') ?: 'localhost';
                    $dbname = getenv('DB_NAME') ?: 'bus_reg_system';
                    $username = getenv('DB_USER') ?: 'root';
                    $password = getenv('DB_PASS') ?: '';

                    // Data Source Name (DSN)
                    $dsn = "mysql:host=$host;dbname=$dbname;charset=utf8mb4";

                    try {
                        // Create a PDO instance (connect to the database)
                        $db = new PDO($dsn, $username, $password);

                        // Set PDO attributes to throw exceptions on errors
                        $db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
                        $db->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE, PDO::FETCH_ASSOC);

                        // Optional: Set PDO attributes for persistent connection
                        // $db->setAttribute(PDO::ATTR_PERSISTENT, true);

                        // Optional: Configure to use buffered queries (default in MySQL)
                        // $db->setAttribute(PDO::MYSQL_ATTR_USE_BUFFERED_QUERY, true);

                        // Query to retrieve data from the waitinglist table
                        $sql = "SELECT * FROM waiting_list";
                        $stmt = $db->query($sql);

                        // Check if there are results
                        if ($stmt->rowCount() > 0) {
                            // Output data of each row
                            while ($row = $stmt->fetch()) {
                                echo "<tr>
                                <td>{$row['waitinglist_no']}</td>
                                <td>{$row['learner_id']}</td>
                                <td>{$row['admin_id']}</td>
                                <td>{$row['learner_name']}</td>
                                <td>{$row['learner_phone']}</td>
                                <td>{$row['waitinglist_group']}</td>
                              </tr>";
                                }
                        } else {
                            echo "0 results";
                        }
                    } catch (PDOException $e) {
                        // Handle connection error
                        echo "Connection failed: " . $e->getMessage();
                        exit;
                    }
                    ?>


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
