<?php
session_start();
header('Content-Type: application/json');

// Check if admin is logged in
if (!isset($_SESSION['admin_logged_in'])) {
    http_response_code(401);
    echo json_encode(['success' => false, 'message' => 'Unauthorized access']);
    exit;
}

require_once 'config.php';

// Get article ID
$article_id = isset($_GET['id']) ? trim($_GET['id']) : '';

if (empty($article_id)) {
    http_response_code(400);
    echo json_encode(['success' => false, 'message' => 'Article ID is required']);
    exit;
}

// Fetch article
$sql = "SELECT * FROM articles WHERE article_id = ?";
$stmt = $conn->prepare($sql);

if (!$stmt) {
    http_response_code(500);
    echo json_encode(['success' => false, 'message' => 'Database error: ' . $conn->error]);
    exit;
}

$stmt->bind_param("s", $article_id);
$stmt->execute();
$result = $stmt->get_result();

if ($result->num_rows > 0) {
    $article = $result->fetch_assoc();
    echo json_encode([
        'success' => true,
        'article' => $article
    ]);
} else {
    http_response_code(404);
    echo json_encode(['success' => false, 'message' => 'Article not found']);
}

$stmt->close();
$conn->close();
?>
