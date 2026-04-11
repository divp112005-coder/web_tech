<?php
include_once 'db_connect.php';

$data = json_decode(file_get_contents("php://input"));

if (!empty($data->username) && !empty($data->password)) {
    $query = "SELECT id, first_name, last_name, username, password_hash FROM users WHERE username = :username LIMIT 0,1";
    $stmt = $conn->prepare($query);

    $username = htmlspecialchars(strip_tags($data->username));
    $stmt->bindParam(':username', $username);
    $stmt->execute();
    
    $num = $stmt->rowCount();

    if ($num > 0) {
        $row = $stmt->fetch(PDO::FETCH_ASSOC);
        $password_hash = $row['password_hash'];

        if (password_verify($data->password, $password_hash)) {
            http_response_code(200);
            echo json_encode(array(
                "message" => "Login successful.",
                "user" => array(
                    "id" => $row['id'],
                    "first_name" => $row['first_name'],
                    "last_name" => $row['last_name'],
                    "username" => $row['username']
                )
            ));
        } else {
            http_response_code(401);
            echo json_encode(array("message" => "Login failed. Password incorrect."));
        }
    } else {
        http_response_code(404);
        echo json_encode(array("message" => "Login failed. User not found."));
    }
} else {
    http_response_code(400);
    echo json_encode(array("message" => "Incomplete data."));
}
?>
