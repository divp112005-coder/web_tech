<?php
// api/db_connect.php
// InfinityFree Deployment - PDO Database Connection Template
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");
header("Content-Type: application/json; charset=UTF-8");

// TODO: Confirm the DB Name placeholder with your actual InfinityFree Database Name in vPanel!
$host = 'sql100.infinityfree.com'; // MySQL Hostname from InfinityFree
$db_name = 'if0_41634489_food_db'; // Assuming food_db is your DB name, confirm in vPanel
$username = 'if0_41634489'; // Your InfinityFree vPanel Username
$password = 'xsAE24YtGiDuQi'; // Your InfinityFree control panel password or DB password

try {
    // 1. Establish secure PDO connection
    $conn = new PDO("mysql:host=" . $host . ";dbname=" . $db_name, $username, $password);
    
    // 2. Configure PDO to throw exceptions on errors
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    
    // 3. Recommended: Set default fetch mode to associative arrays
    $conn->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE, PDO::FETCH_ASSOC);

} catch(PDOException $exception) {
    // 4. Graceful error handling: DO NOT leak server details or $exception->getMessage() on production!
    http_response_code(500);
    echo json_encode(array(
        "error" => "Database connection failed. Please check your database settings."
    ));
    exit();
}
?>
