<?php
session_start();
include 'db_config.php';

if (!isset($_SESSION['employee_id'])) {
    die("Unauthorized access");
}

$id = $_GET['id'];
$status = $_GET['status'];

// validate status
if ($status != 'verified' && $status != 'rejected') {
    die("Invalid status");
}

// update document
$stmt = $conn->prepare("
    UPDATE document_verification 
    SET status = ? 
    WHERE verification_id = ?
");

$stmt->bind_param("si", $status, $id);
$stmt->execute();

header("Location: employee_dashboard.php?table=document_verification");
exit();
?>