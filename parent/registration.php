<?php
session_start();

// Database configuration
$servername = "localhost";
$username = "root"; // Change to your database username
$password = ""; // Change to your database password
$dbname = "bus_reg_system";

// Enable MySQLi exceptions
mysqli_report(MYSQLI_REPORT_ERROR | MYSQLI_REPORT_STRICT);

// Create connection
try {
    $conn = new mysqli($servername, $username, $password, $dbname);
} catch (mysqli_sql_exception $e) {
    error_log("Connection failed: " . $e->getMessage()); // Log the error
    die("Sorry, we are experiencing technical difficulties. Please try again later."); // User-friendly message
}

// Include PHPMailer
use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;
require '../vendor/autoload.php';

// Initialize error message variables
$error_message = "";
$email_error_message = "";

// Check if form is submitted
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Sanitize and validate input
    $firstname = filter_var(trim($_POST['firstname']), FILTER_SANITIZE_STRING);
    $lastname = filter_var(trim($_POST['lastname']), FILTER_SANITIZE_STRING);
    $email = filter_var(trim($_POST['email']), FILTER_SANITIZE_EMAIL);
    $phone = filter_var(trim($_POST['phone']), FILTER_SANITIZE_STRING);
    $password = $_POST['password'];

    if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
        $error_message = "Invalid email format.";
    } else {
        // Hash the password
        $hashed_password = password_hash($password, PASSWORD_DEFAULT);

        // Prepare and bind
        try {
            $stmt = $conn->prepare("INSERT INTO Parent (Parent_Name, Parent_Surname, Parent_Email, Parent_CellNo, Parent_Passcode, Status, created_at) VALUES (?, ?, ?, ?, ?, ?, NOW())");
            if (!$stmt) {
                throw new mysqli_sql_exception("Prepare statement failed: " . $conn->error); // Throw an exception if preparation fails
            }
            $status = 'active';
            $stmt->bind_param("ssssss", $firstname, $lastname, $email, $phone, $hashed_password, $status);

            if ($stmt->execute()) {
                // Send confirmation email
                $mail = new PHPMailer(true);
                $mail->SMTPDebug = 0; // Set to 2 for debug output

                try {
                    // Server settings
                    $mail->isSMTP();
                    $mail->Host = 'smtp.gmail.com';
                    $mail->SMTPAuth = true;
                    $mail->Username = 'obrsystemict3715@gmail.com';
                    $mail->Password = 'cxop xmuk zrle corxl';
                    $mail->SMTPSecure = 'tls';
                    $mail->Port = 587;

                    // SSL options (for testing only)
                    $mail->SMTPOptions = array(
                        'ssl' => array(
                            'verify_peer' => false,
                            'verify_peer_name' => false,
                            'allow_self_signed' => true
                        )
                    );

                    // Recipients
                    $mail->setFrom('obrsystemict3715@gmail.com', 'Online Bus Registration System');
                    $mail->addAddress($email, "$firstname $lastname");

                    // Content
                    $mail->isHTML(true);
                    $mail->Subject = 'Registration Confirmation';
                    $mail->Body    = 'Thank you for registering with the Online Bus Registration System. Your registration is successful!';
                    $mail->AltBody = 'Thank you for registering with the Online Bus Registration System. Your registration is successful!';

                    $mail->send();
                    $success_message = 'Registration successful and email sent';
                } catch (Exception $e) {
                    error_log("Email could not be sent. Mailer Error: {$mail->ErrorInfo}"); // Log email error
                    $email_error_message = "Registration successful but email could not be sent: " . $mail->ErrorInfo;
                }
            } else {
                throw new mysqli_sql_exception("Execute statement failed: " . $stmt->error); // Throw an exception if execution fails
            }
            $stmt->close();
        } catch (mysqli_sql_exception $e) {
            error_log("Database error: " . $e->getMessage()); // Log the error
            if ($e->getCode() == 1062) { // Error code for duplicate entry
                $error_message = "The email address is already registered.";
            } else {
                $error_message = "An error occurred during registration. Please try again.";
            }
        }
    }
}
$conn->close();
?>

<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Parent Registration</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <style>
        .centered-div {
            width: 50%;
            margin: auto;
        }
        .error-message, .email-error-message {
            color: red;
            font-weight: bold;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="row justify-content-center">
        <div class="centered-div">
            <div class="text-center my-4">
                <img src="image/logo.png" alt="Logo" class="img-fluid" style="max-width: 200px;">
                <h3>OBR Parent Registration</h3>
            </div>

            <?php if (!empty($error_message)): ?>
                <div class="error-message">
                    <?php echo htmlspecialchars($error_message); ?>
                </div>
            <?php endif; ?>

            <?php if (!empty($email_error_message)): ?>
                <div class="email-error-message">
                    <?php echo htmlspecialchars($email_error_message); ?>
                </div>
            <?php endif; ?>

            <form action="registration.php" method="post">
                <div class="form-group mb-3">
                    <label for="firstname">First Name</label>
                    <input type="text" placeholder="Enter First Name" name="firstname" class="form-control" id="firstname" value="<?php echo htmlspecialchars($firstname ?? ''); ?>" required>
                </div>
                <div class="form-group mb-3">
                    <label for="lastname">Last Name</label>
                    <input type="text" placeholder="Enter Last Name" name="lastname" class="form-control" id="lastname" value="<?php echo htmlspecialchars($lastname ?? ''); ?>" required>
                </div>
                <div class="form-group mb-3">
                    <label for="email">Email</label>
                    <input type="email" placeholder="Enter Email" name="email" class="form-control" id="email" value="<?php echo htmlspecialchars($email ?? ''); ?>" required>
                </div>
                <div class="form-group mb-3">
                    <label for="phone">Phone</label>
                    <input type="text" placeholder="Enter Phone" name="phone" class="form-control" id="phone" value="<?php echo htmlspecialchars($phone ?? ''); ?>" required>
                </div>
                <div class="form-group mb-3">
                    <label for="password">Password</label>
                    <input type="password" placeholder="Enter Password" name="password" class="form-control" id="password" required>
                </div>
                <div class="form-btn">
                    <input type="submit" value="Register" name="register" class="btn btn-primary">
                </div>
            </form>
            <div>
                <p>Already registered? <a href="index.php">Login Here</a></p>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>
</html>
