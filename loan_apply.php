<?php
session_start();
include 'db_config.php';

if (!isset($_SESSION['customer_id'])) {
    die("Unauthorized");
}

$customer_id = $_SESSION['customer_id'];

$amount = floatval($_POST['amount']);
$interest = floatval($_POST['interest_rate']);
$duration = intval($_POST['duration']);

// Get wallet
$stmt = $conn->prepare("SELECT wallet_id FROM customer WHERE customer_id = ?");
$stmt->bind_param("i", $customer_id);
$stmt->execute();
$result = $stmt->get_result();
$data = $result->fetch_assoc();

$wallet_id = $data['wallet_id'];

// Calculate dates
$start_date = date("Y-m-d");
$end_date = date("Y-m-d", strtotime("+$duration months"));

// Insert loan
$stmt = $conn->prepare("
    INSERT INTO loan 
    (customer_wallet_id, amount, interest_rate, duration, start_date, end_date, status)
    VALUES (?, ?, ?, ?, ?, ?, 'pending')
");

$stmt->bind_param("iddiss", $wallet_id, $amount, $interest, $duration, $start_date, $end_date);
$stmt->execute();

header("Location: dashboard.php?loan=applied");
exit();
?>