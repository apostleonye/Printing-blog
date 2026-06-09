<?php
session_start();
header('Content-Type: application/json');

// Simple authentication (in production, use proper password hashing and database)
define('ADMIN_USERNAME', 'admin');
define('ADMIN_PASSWORD', 'admin123');

$username = isset($_POST['username']) ? trim($_POST['username']) : '';
$password = isset($_POST['password']) ? $_POST['password'] : '';

// Validate input
if (empty($username) || empty($password)) {
    echo json_encode([
        'success' => false,
        'message' => 'Username and password are required.'
    ]);
    exit;
}

// Check credentials
if ($username === ADMIN_USERNAME && $password === ADMIN_PASSWORD) {
    // Set session variables
    $_SESSION['admin_logged_in'] = true;
    $_SESSION['admin_username'] = $username;
    $_SESSION['login_time'] = time();
    
    echo json_encode([
        'success' => true,
        'message' => 'Login successful'
    ]);
} else {
    echo json_encode([
        'success' => false,
        'message' => 'Invalid username or password.'
    ]);
}
?>
