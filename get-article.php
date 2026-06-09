<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');

// Database Connection
$servername = "localhost";
$username = "root"; // Change to your DB username
$password = ""; // Change to your DB password
$dbname = "printing_blog"; // Change to your DB name

$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    http_response_code(500);
    echo json_encode(['error' => 'Database connection failed']);
    exit;
}

// Get article ID from query parameter
$article_id = isset($_GET['id']) ? $conn->real_escape_string($_GET['id']) : null;

if (!$article_id) {
    http_response_code(400);
    echo json_encode(['error' => 'Article ID is required']);
    exit;
}

// Fetch article from database
$sql = "SELECT 
    article_id,
    title,
    category,
    published_date,
    author,
    hero_image_url,
    image_caption,
    article_body,
    meta_description
FROM articles 
WHERE article_id = ?";

$stmt = $conn->prepare($sql);
$stmt->bind_param("s", $article_id);
$stmt->execute();
$result = $stmt->get_result();

if ($result->num_rows > 0) {
    $article = $result->fetch_assoc();
    
    // Fetch related articles (same category, different article)
    $relatedSql = "SELECT 
        article_id,
        title,
        category,
        published_date,
        hero_image_url
    FROM articles 
    WHERE category = ? AND article_id != ?
    LIMIT 3";
    
    $relatedStmt = $conn->prepare($relatedSql);
    $relatedStmt->bind_param("ss", $article['category'], $article_id);
    $relatedStmt->execute();
    $relatedResult = $relatedStmt->get_result();
    
    $related_articles = [];
    while ($row = $relatedResult->fetch_assoc()) {
        $related_articles[] = $row;
    }
    
    $article['related_articles'] = $related_articles;
    
    // Return successful response
    http_response_code(200);
    echo json_encode($article);
} else {
    http_response_code(404);
    echo json_encode(['error' => 'Article not found']);
}

$stmt->close();
$conn->close();
?>
