<?php
session_start();
include 'db_config.php';

// 1. Check login
if (!isset($_SESSION['customer_id'])) {
    die("Unauthorized access!");
}

$customer_id = $_SESSION['customer_id'];

// 2. Get POST data safely
$receiver_wallet = intval($_POST['receiver_wallet']);
$amount = floatval($_POST['amount']);
$pin = $_POST['pin'];

// 3. Validate amount
if ($amount <= 0) {
    die("Invalid amount!");
}

// 4. Get sender info (wallet + PIN)
$stmt = $conn->prepare("SELECT wallet_id, pin FROM customer WHERE customer_id = ?");
$stmt->bind_param("i", $customer_id);
$stmt->execute();
$result = $stmt->get_result();
$row = $result->fetch_assoc();

$sender_wallet = $row['wallet_id'];
$stored_pin = $row['pin'];

// 5. PIN check (IMPORTANT SECURITY FIX)
if (!password_verify($pin, $stored_pin)) {
    die("Invalid PIN!");
}

// 6. Prevent self transfer
if ($sender_wallet == $receiver_wallet) {
    die("You cannot send money to your own wallet!");
}

// 7. Check sender balance
$stmt = $conn->prepare("SELECT balance FROM wallet WHERE wallet_id = ?");
$stmt->bind_param("i", $sender_wallet);
$stmt->execute();
$result = $stmt->get_result();
$wallet = $result->fetch_assoc();

if ($wallet['balance'] < $amount) {

    // log failed transaction
    $stmt = $conn->prepare("
        INSERT INTO transaction 
        (sender_wallet_id, receiver_wallet_id, amount, status)
        VALUES (?, ?, ?, 'failed')
    ");
    $stmt->bind_param("iid", $sender_wallet, $receiver_wallet, $amount);
    $stmt->execute();

    die("Insufficient balance!");
}

// 8. TRANSACTION START
$conn->begin_transaction();

try {

    // deduct sender
    $stmt = $conn->prepare("
        UPDATE wallet 
        SET balance = balance - ? 
        WHERE wallet_id = ?
    ");
    $stmt->bind_param("di", $amount, $sender_wallet);
    $stmt->execute();

    // add receiver
    $stmt = $conn->prepare("
        UPDATE wallet 
        SET balance = balance + ? 
        WHERE wallet_id = ?
    ");
    $stmt->bind_param("di", $amount, $receiver_wallet);
    $stmt->execute();

    // log transaction
    $stmt = $conn->prepare("
        INSERT INTO transaction 
        (sender_wallet_id, receiver_wallet_id, amount, status)
        VALUES (?, ?, ?, 'success')
    ");
    $stmt->bind_param("iid", $sender_wallet, $receiver_wallet, $amount);
    $stmt->execute();

    $conn->commit();

    header("Location: dashboard.php?msg=success");
    exit();

} catch (Exception $e) {
    $conn->rollback();
    echo "Transaction failed!";
}
?>