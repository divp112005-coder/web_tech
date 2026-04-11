<?php
include_once 'db_connect.php';

$data = json_decode(file_get_contents("php://input"));

if (!empty($data->user_id)) {
    try {
        $user_id = htmlspecialchars(strip_tags($data->user_id));
        
        // Fetch User Info
        $queryUser = "SELECT email, created_at FROM users WHERE id = :user_id LIMIT 1";
        $stmtUser = $conn->prepare($queryUser);
        $stmtUser->bindParam(':user_id', $user_id);
        $stmtUser->execute();
        
        $userInfo = $stmtUser->fetch(PDO::FETCH_ASSOC);
        
        if (!$userInfo) {
            http_response_code(404);
            echo json_encode(array("message" => "User not found."));
            exit();
        }

        // Fetch Orders
        $queryOrders = "SELECT id, total_price, status, created_at FROM orders WHERE user_id = :user_id ORDER BY created_at DESC";
        $stmtOrders = $conn->prepare($queryOrders);
        $stmtOrders->bindParam(':user_id', $user_id);
        $stmtOrders->execute();
        
        $ordersCount = $stmtOrders->rowCount();
        $ordersArray = array();

        if ($ordersCount > 0) {
            while ($orderRow = $stmtOrders->fetch(PDO::FETCH_ASSOC)) {
                $order_id = $orderRow['id'];
                
                // Fetch Order Items for this Order
                $queryItems = "SELECT oi.quantity, oi.price_at_order, mi.name, mi.category 
                               FROM order_items oi 
                               JOIN menu_items mi ON oi.menu_item_id = mi.id 
                               WHERE oi.order_id = :order_id";
                $stmtItems = $conn->prepare($queryItems);
                $stmtItems->bindParam(':order_id', $order_id);
                $stmtItems->execute();
                
                $itemsArray = array();
                while ($itemRow = $stmtItems->fetch(PDO::FETCH_ASSOC)) {
                    array_push($itemsArray, $itemRow);
                }
                
                $orderRow['items'] = $itemsArray;
                array_push($ordersArray, $orderRow);
            }
        }
        
        http_response_code(200);
        echo json_encode(array(
            "user" => $userInfo,
            "orders" => $ordersArray
        ));

    } catch (PDOException $e) {
        http_response_code(500);
        echo json_encode(array("message" => "Database error: " . $e->getMessage()));
    }
} else {
    http_response_code(400);
    echo json_encode(array("message" => "Incomplete input data."));
}
?>
