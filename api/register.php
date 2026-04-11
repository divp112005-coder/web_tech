<?php
include_once 'db_connect.php';

$data = json_decode(file_get_contents("php://input"));

if (
    !empty($data->first_name) &&
    !empty($data->last_name) &&
    !empty($data->username) &&
    !empty($data->password) &&
    !empty($data->email)
) {
    try {
        $query = "INSERT INTO users (first_name, last_name, username, password_hash, email) VALUES (:first_name, :last_name, :username, :password_hash, :email)";
        $stmt = $conn->prepare($query);

        $first_name = htmlspecialchars(strip_tags($data->first_name));
        $last_name = htmlspecialchars(strip_tags($data->last_name));
        $username = htmlspecialchars(strip_tags($data->username));
        $email = htmlspecialchars(strip_tags($data->email));
        $password_hash = password_hash($data->password, PASSWORD_BCRYPT);

        $stmt->bindParam(':first_name', $first_name);
        $stmt->bindParam(':last_name', $last_name);
        $stmt->bindParam(':username', $username);
        $stmt->bindParam(':password_hash', $password_hash);
        $stmt->bindParam(':email', $email);

        if ($stmt->execute()) {
            http_response_code(201);
            echo json_encode(array("message" => "User was created."));
        } else {
            http_response_code(503);
            echo json_encode(array("message" => "Unable to create user."));
        }
    } catch (PDOException $e) {
        if ($e->errorInfo[1] == 1062) {
            http_response_code(400);
            echo json_encode(array("message" => "Username or email already exists."));
        } else {
            http_response_code(500);
            echo json_encode(array("message" => "Database error: " . $e->getMessage()));
        }
    }
} else {
    http_response_code(400);
    echo json_encode(array("message" => "Incomplete data."));
}
?>
