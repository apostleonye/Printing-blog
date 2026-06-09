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

// Get POST data
$article_id = isset($_POST['article_id']) ? trim($_POST['article_id']) : '';
$title = isset($_POST['title']) ? trim($_POST['title']) : '';
$category = isset($_POST['category']) ? trim($_POST['category']) : '';
$author = isset($_POST['author']) ? trim($_POST['author']) : '';
$hero_image_url = isset($_POST['hero_image_url']) ? trim($_POST['hero_image_url']) : '';
$image_caption = isset($_POST['image_caption']) ? trim($_POST['image_caption']) : '';
$article_body = isset($_POST['article_body']) ? $_POST['article_body'] : '';
$meta_description = isset($_POST['meta_description']) ? trim($_POST['meta_description']) : '';

// Validation
if (empty($article_id) || empty($title) || empty($category) || empty($article_body)) {
    echo json_encode([
        'success' => false,
        'message' => 'Missing required fields'
    ]);
    exit;
}

// Prepare SQL statement
$sql = "INSERT INTO articles (article_id, title, category, author, hero_image_url, image_caption, article_body, meta_description, published_date)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, NOW())
        ON DUPLICATE KEY UPDATE
        title = ?,
        category = ?,
        author = ?,
        hero_image_url = ?,
        image_caption = ?,
        article_body = ?,
        meta_description = ?";

$stmt = $conn->prepare($sql);

if (!$stmt) {
    http_response_code(500);
    echo json_encode([
        'success' => false,
        'message' => 'Database error: ' . $conn->error
    ]);
    exit;
}

$stmt->bind_param(
    "ssssssssssssss",
    $article_id, $title, $category, $author, $hero_image_url, $image_caption, $article_body, $meta_description,
    $title, $category, $author, $hero_image_url, $image_caption, $article_body, $meta_description
);

if ($stmt->execute()) {
    echo json_encode([
        'success' => true,
        'message' => 'Article published successfully!',
        'article_id' => $article_id
    ]);
} else {
    http_response_code(500);
    echo json_encode([
        'success' => false,
        'message' => 'Failed to publish article: ' . $stmt->error
    ]);
}

$stmt->close();
$conn->close();
?>
