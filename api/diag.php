<?php
// api/diag.php
// Diagnostic script to check database connectivity and content on InfinityFree

header("Content-Type: application/json; charset=UTF-8");
include_once 'db_connect.php';

$results = [
    "status" => "Starting diagnostics...",
    "connection" => "Failed",
    "tables" => []
];

try {
    // 1. Check Connection (done by include, but confirming)
    if ($conn) {
        $results["connection"] = "Success";
    }

    // 2. Check Tables existence and row counts
    $tables = ['menu_items', 'users', 'orders'];
    
    foreach ($tables as $table) {
        try {
            $stmt = $conn->query("SELECT COUNT(*) FROM $table");
            $count = $stmt->fetchColumn();
            $results["tables"][$table] = [
                "status" => "Found",
                "row_count" => $count
            ];
        } catch (PDOException $e) {
            $results["tables"][$table] = [
                "status" => "Error: " . $e->getMessage(),
                "row_count" => 0
            ];
        }
    }

    $results["status"] = "Diagnostics completed.";

} catch (Exception $e) {
    $results["status"] = "General Error: " . $e->getMessage();
}

echo json_encode($results, JSON_PRETTY_PRINT);
?>
