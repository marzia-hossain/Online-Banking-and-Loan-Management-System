<?php
session_start();
include 'db_config.php';

if ($_SERVER["REQUEST_METHOD"] != "POST") {
    die("Invalid request!");
}

$phone = $_POST['phone'];
$pin = $_POST['pin'];

/* -------------------------
   1. EMPLOYEE LOGIN
   ------------------------- */
$stmt = $conn->prepare("SELECT * FROM employee WHERE phone = ?");
$stmt->bind_param("s", $phone);
$stmt->execute();
$empResult = $stmt->get_result();

if ($empResult->num_rows == 1) {

    $emp = $empResult->fetch_assoc();

    if ($pin == "123") {

        $_SESSION['employee_id'] = $emp['employee_id'];
        $_SESSION['employee_name'] = $emp['name'];

        header("Location: employee_dashboard.php");
        exit();

    } else {
        die("Invalid employee password!");
    }
}

/* -------------------------
   2. CUSTOMER LOGIN
   ------------------------- */
$stmt = $conn->prepare("SELECT customer_id, fullname, password FROM customer WHERE phone = ?");
$stmt->bind_param("s", $phone);
$stmt->execute();
$result = $stmt->get_result();

if ($result->num_rows == 1) {

    $user = $result->fetch_assoc();

    if (password_verify($pin, $user['password'])) {

        $_SESSION['customer_id'] = $user['customer_id'];
        $_SESSION['customer_name'] = $user['fullname'];

        header("Location: dashboard.php");
        exit();

    } else {
        die("Invalid PIN!");
    }

} else {
    die("User not found!");
}
?>