<?php
session_start();
include 'db_config.php';

// 1. Check login (you should set customer/agent auth later)
if (!isset($_SESSION['customer_id'])) {
    die("Unauthorized access!");
}

// 2. Get input
$agent_wallet_id = intval($_POST['agent_wallet_id']);
$type = $_POST['type']; // cash_in / cash_out
$amount = floatval($_POST['amount']);

if ($amount <= 0) {
    die("Invalid amount!");
}

// 3. Get customer wallet (sender/receiver depends on type)
$customer_id = $_SESSION['customer_id'];

$stmt = $conn->prepare("SELECT wallet_id FROM customer WHERE customer_id = ?");
$stmt->bind_param("i", $customer_id);
$stmt->execute();
$result = $stmt->get_result();
$row = $result->fetch_assoc();

$customer_wallet_id = $row['wallet_id'];

// 4. Start transaction
$conn->begin_transaction();

try {

    if ($type == "cash_in") {

        // Customer gives money → agent receives
        $stmt = $conn->prepare("
            UPDATE wallet 
            SET balance = balance - ? 
            WHERE wallet_id = ?
        ");
        $stmt->bind_param("di", $amount, $customer_wallet_id);
        $stmt->execute();

        $stmt = $conn->prepare("
            UPDATE wallet 
            SET balance = balance + ? 
            WHERE wallet_id = ?
        ");
        $stmt->bind_param("di", $amount, $agent_wallet_id);
        $stmt->execute();

    } else if ($type == "cash_out") {

        // Agent gives money → customer receives
        $stmt = $conn->prepare("
            UPDATE wallet 
            SET balance = balance - ? 
            WHERE wallet_id = ?
        ");
        $stmt->bind_param("di", $amount, $agent_wallet_id);
        $stmt->execute();

        $stmt = $conn->prepare("
            UPDATE wallet 
            SET balance = balance + ? 
            WHERE wallet_id = ?
        ");
        $stmt->bind_param("di", $amount, $customer_wallet_id);
        $stmt->execute();

    } else {
        throw new Exception("Invalid transaction type");
    }

    // 5. Insert into cash_transaction table
    $stmt = $conn->prepare("
        INSERT INTO cash_transaction 
        (customer_wallet_id, agent_wallet_id, type, amount)
        VALUES (?, ?, ?, ?)
    ");
    $stmt->bind_param("iisd", $customer_wallet_id, $agent_wallet_id, $type, $amount);
    $stmt->execute();

    $conn->commit();

    header("Location: dashboard.php?msg=cash_success");
    exit();

} catch (Exception $e) {
    $conn->rollback();
    echo "Cash transaction failed!";
}
?>