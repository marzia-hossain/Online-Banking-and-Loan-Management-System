<?php
session_start();
include 'db_config.php';

// FIX: consistent session variable
if (!isset($_SESSION['customer_id'])) {
    header("Location: login.html");
    exit();
}

$customer_id = $_SESSION['customer_id'];

// Get user + wallet info
$query = "SELECT c.fullname, w.wallet_id, w.balance
          FROM customer c
          JOIN wallet w ON c.wallet_id = w.wallet_id
          WHERE c.customer_id = ?";

$stmt = $conn->prepare($query);
$stmt->bind_param("i", $customer_id);
$stmt->execute();
$result = $stmt->get_result();
$data = $result->fetch_assoc();
?>

<!DOCTYPE html>
<html>
<head>
    <title>Dashboard</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>

<div class="app-container">

    <!-- Header -->
    <div style="display:flex; justify-content: space-between; align-items:center;">
        <h2>Welcome, <?php echo htmlspecialchars($data['fullname']); ?></h2>
        <a href="notification.php">🔔</a>
    </div>

    <!-- Wallet Info -->
    <p><strong>Wallet ID:</strong> <?php echo $data['wallet_id']; ?></p>
    <p><strong>Balance:</strong> ৳ <?php echo number_format($data['balance'], 2); ?></p>

    <!-- Navigation -->
    <div class="nav-menu">

        <a href="send_money.html" class="nav-item">Send Money</a>

        <a href="bill.html" class="nav-item">Pay Bills & Merchant</a>

        <a href="loan.html" class="nav-item">Loan Service</a>

        <a href="agent.html" class="nav-item">Cash In / Cash Out</a>

        <a href="notification.php" class="nav-item">Notifications</a>

    </div>

    <!-- Logout -->
    <a href="logout.php">
        <button>Logout</button>
    </a>

</div>

</body>
</html>