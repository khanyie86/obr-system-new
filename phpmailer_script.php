<?php
use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;

// Load Composer's autoloader
require 'vendor/autoload.php';

// Create an instance of PHPMailer
$mail = new PHPMailer(true);

//$mail->SMTPDebug = 2; // 1 = errors and messages, 2 = messages only


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
    $mail->setFrom('kpmahlaole@gmail.com', 'Online Bus Registration System');
    $mail->addAddress('kpmahlaole@gmail.com', 'Admin Portal');     // Add a recipient

    // Content
    $mail->isHTML(true);                                  // Set email format to HTML
    $mail->Subject = 'Here is the subject';
    $mail->Body    = 'This is the HTML message body <b>in bold!</b>';
    $mail->AltBody = 'This is the body in plain text for non-HTML mail clients';

    $mail->send();
    echo 'Message has been sent';
} catch (Exception $e) {
    echo "Message could not be sent. Mailer Error: {$mail->ErrorInfo}";
}
