<?php
include_once 'db_connect.php';

$data = json_decode(file_get_contents("php://input"));

if (!empty($data->user_id) && !empty($data->cart_items) && !empty($data->total_price)) {
    try {
        $conn->beginTransaction();

        // 1. Insert into orders table
        $order_query = "INSERT INTO orders (user_id, total_price, status) VALUES (:user_id, :total_price, 'Pending')";
        $order_stmt = $conn->prepare($order_query);
        
        $user_id = htmlspecialchars(strip_tags($data->user_id));
        $total_price = htmlspecialchars(strip_tags($data->total_price));
        
        $order_stmt->bindParam(':user_id', $user_id);
        $order_stmt->bindParam(':total_price', $total_price);
        $order_stmt->execute();
        
        $order_id = $conn->lastInsertId();

        // 2. Insert into order_items table
        $item_query = "INSERT INTO order_items (order_id, menu_item_id, quantity, price_at_order) VALUES (:order_id, :menu_item_id, :quantity, :price_at_order)";
        $item_stmt = $conn->prepare($item_query);

        foreach ($data->cart_items as $item) {
            $menu_item_id = htmlspecialchars(strip_tags($item->id));
            $quantity = htmlspecialchars(strip_tags($item->quantity));
            $price_at_order = htmlspecialchars(strip_tags($item->price));

            $item_stmt->bindParam(':order_id', $order_id);
            $item_stmt->bindParam(':menu_item_id', $menu_item_id);
            $item_stmt->bindParam(':quantity', $quantity);
            $item_stmt->bindParam(':price_at_order', $price_at_order);
            $item_stmt->execute();
        }

        $conn->commit();

        http_response_code(201);
        echo json_encode(array("message" => "Order placed successfully.", "order_id" => $order_id));
    } catch (PDOException $e) {
        $conn->rollBack();
        http_response_code(503);
        echo json_encode(array("message" => "Unable to place order. Error: " . $e->getMessage()));
    }
} else {
    http_response_code(400);
    echo json_encode(array("message" => "Incomplete data. Cannot place order."));
}
?>
