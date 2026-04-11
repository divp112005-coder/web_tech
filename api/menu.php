<?php
include_once 'db_connect.php';

$query = "SELECT id, name, description, price, category, image_url, is_available FROM menu_items WHERE is_available = 1";
$stmt = $conn->prepare($query);
$stmt->execute();

$num = $stmt->rowCount();

if ($num > 0) {
    $menu_arr = array();
    $menu_arr["records"] = array();

    while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
        extract($row);
        $menu_item = array(
            "id" => $id,
            "name" => $name,
            "description" => $description,
            "price" => $price,
            "category" => $category,
            "image_url" => $image_url,
            "is_available" => $is_available
        );
        array_push($menu_arr["records"], $menu_item);
    }
    
    http_response_code(200);
    echo json_encode($menu_arr);
} else {
    http_response_code(404);
    echo json_encode(array("message" => "No menu items found."));
}
?>
