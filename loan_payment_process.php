<?php
session_start();
include 'db_config.php';

$installment_id = intval($_POST['installment_id']);
$amount = floatval($_POST['amount']);

// Insert payment
$stmt = $conn->prepare("
    INSERT INTO loan_payment (installment_id, wallet_id, amount, status)
    VALUES (?, 1, ?, 'success')
");

$stmt->bind_param("id", $installment_id, $amount);
$stmt->execute();

// Update installment
$conn->query("
    UPDATE loan_installment
    SET paid_amount = paid_amount + $amount,
        status = 'partial'
    WHERE installment_id = $installment_id
");

header("Location: loan_status.php");
exit();
?>