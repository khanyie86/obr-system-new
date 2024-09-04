<?php
// Start the session if it's not already started
if (session_status() == PHP_SESSION_NONE) {
    session_start();
}
// Check if the user is logged in
if (!isset($_SESSION['admin_id'])) {
    header("Location: index.php");
    exit();
}
?>

<?php require 'includes/header.php'; ?>

                    <?php


                    // Database configuration
                    $servername = "localhost";
                    $username = "root"; // Change to your database username
                    $password = ""; // Change to your database password
                    $dbname = "bus_reg_system";

                    // Create connection
                    $conn = new mysqli($servername, $username, $password, $dbname);

                    // Check connection
                    if ($conn->connect_error) {
                        die("Connection failed: " . $conn->connect_error);
                    }

                    // Fetch users
                    $sql = "SELECT parent_id, parent_name, parent_surname, parent_email, parent_cellno, parent_passcode, status, created_at FROM parent";
                    $result = $conn->query($sql);

                    $conn->close();
                    ?>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" integrity="sha384-k6RqeWeci5ZR/Lv4MR0sA0FfDOMt23cez/3paNdF+Z4pb9fq6hLQ9D3T+GOZ4pR" crossorigin="anonymous">

<div class="container-fluid">
    <div class="row">
        <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 main-content">
            <div class="chart-placeholder">
                <div class="container">
                    <div class="container mt-5">
                        <br>
                        <br>
                        <h2>System Users</h2>
                        <table class="table table-bordered">
                            <thead>
                            <tr>
                                <th>Parent ID</th>
                                <th>First Name</th>
                                <th>Last Name</th>
                                <th>Email</th>
                                <th>Phone</th>
                                <th>Status</th>
                                <th>Created At</th>
                                <th>Actions</th>
                            </tr>
                            </thead>
                            <tbody>
                            <?php if ($result->num_rows > 0): ?>
                                <?php while($row = $result->fetch_assoc()): ?>
                                    <tr>
                                        <td><?php echo htmlspecialchars($row['parent_id']); ?></td>
                                        <td><?php echo htmlspecialchars($row['parent_name']); ?></td>
                                        <td><?php echo htmlspecialchars($row['parent_surname']); ?></td>
                                        <td><?php echo htmlspecialchars($row['parent_email']); ?></td>
                                        <td><?php echo htmlspecialchars($row['parent_cellno']); ?></td>
                                        <td>
                                            <select class="form-select" onchange="updateStatus(<?php echo $row['parent_id']; ?>, this.value)">
                                                <option value="active" <?php if ($row['status'] == 'active') echo 'selected'; ?>>Active</option>
                                                <option value="suspended" <?php if ($row['status'] == 'suspended') echo 'selected'; ?>>Suspended</option>
                                            </select>
                                        </td>
                                        <td><?php echo htmlspecialchars($row['created_at']); ?></td>
                                        <td>
                                            <a href="edit_user.php?id=<?php echo $row['parent_id']; ?>" class="btn btn-sm btn-primary">Edit</a>
                                        </td>
                                    </tr>
                                <?php endwhile; ?>
                            <?php else: ?>
                                <tr>
                                    <td colspan="8">No users found</td>
                                </tr>
                            <?php endif; ?>
                            </tbody>
                        </table>
                    </div>

                    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
                    <script>
                        function updateStatus(userId, status) {
                            // Make an AJAX call to update user status
                            fetch('update_status.php', {
                                method: 'POST',
                                headers: {
                                    'Content-Type': 'application/json'
                                },
                                body: JSON.stringify({ parent_id: userId, status: status })
                            })
                                .then(response => response.json())
                                .then(data => {
                                    if (data.success) {
                                        alert('Status updated successfully');
                                    } else {
                                        alert('Failed to update status');
                                    }
                                })
                                .catch(error => {
                                    console.error('Error:', error);
                                });
                        }
                    </script>
                    </body>
                    </html>




                </div>
            </div>
        </main>
    </div>
</div>
<?php require 'includes/footer.php'; ?>



