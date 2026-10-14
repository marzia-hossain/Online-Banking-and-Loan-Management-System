<?php
session_start();
include 'db_config.php';

// 1. Check login
if (!isset($_SESSION['customer_id'])) {
    die("Unauthorized access!");
}

$customer_id = $_SESSION['customer_id'];

// 2. Get form data
$receiver_wallet_id = intval($_POST['receiver_wallet_id']);
$bill_type = $_POST['bill_type'];
$amount = floatval($_POST['amount']);

if ($amount <= 0) {
    die("Invalid amount!");
}

// 3. Get sender wallet
$stmt = $conn->prepare("SELECT wallet_id FROM customer WHERE customer_id = ?");
$stmt->bind_param("i", $customer_id);
$stmt->execute();
$result = $stmt->get_result();
$row = $result->fetch_assoc();

$sender_wallet_id = $row['wallet_id'];

// 4. Prevent self payment
if ($sender_wallet_id == $receiver_wallet_id) {
    die("You cannot pay yourself!");
}

// 5. Check balance
$stmt = $conn->prepare("SELECT balance FROM wallet WHERE wallet_id = ?");
$stmt->bind_param("i", $sender_wallet_id);
$stmt->execute();
$result = $stmt->get_result();
$wallet = $result->fetch_assoc();

if ($wallet['balance'] < $amount) {

    // log failed payment
    $stmt = $conn->prepare("
        INSERT INTO payment 
        (customer_wallet_id, receiver_wallet_id, bill_type, amount, status)
        VALUES (?, ?, ?, ?, 'failed')
    ");
    $stmt->bind_param("iisd", $sender_wallet_id, $receiver_wallet_id, $bill_type, $amount);
    $stmt->execute();

    die("Insufficient balance!");
}

// 6. Start transaction
$conn->begin_transaction();

try {

    // deduct from customer
    $stmt = $conn->prepare("
        UPDATE wallet 
        SET balance = balance - ? 
        WHERE wallet_id = ?
    ");
    $stmt->bind_param("di", $amount, $sender_wallet_id);
    $stmt->execute();

    // add to receiver (merchant/service provider)
    $stmt = $conn->prepare("
        UPDATE wallet 
        SET balance = balance + ? 
        WHERE wallet_id = ?
    ");
    $stmt->bind_param("di", $amount, $receiver_wallet_id);
    $stmt->execute();

    // log payment
    $stmt = $conn->prepare("
        INSERT INTO payment 
        (customer_wallet_id, receiver_wallet_id, bill_type, amount, status)
        VALUES (?, ?, ?, ?, 'success')
    ");
    $stmt->bind_param("iisd", $sender_wallet_id, $receiver_wallet_id, $bill_type, $amount);
    $stmt->execute();

    $conn->commit();

    header("Location: dashboard.php?msg=payment_success");
    exit();

} catch (Exception $e) {
    $conn->rollback();
    echo "Payment failed!";
}
?>