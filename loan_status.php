<?php
session_start();
include 'db_config.php';

$customer_id = $_SESSION['customer_id'];

$stmt = $conn->prepare("
    SELECT l.*
    FROM loan l
    JOIN customer c ON l.customer_wallet_id = c.wallet_id
    WHERE c.customer_id = ?
    ORDER BY l.loan_id DESC
");

$stmt->bind_param("i", $customer_id);
$stmt->execute();
$result = $stmt->get_result();
?>

<!DOCTYPE html>
<html>
<head>
    <title>My Loans</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>

<div class="app-container">

    <a href="dashboard.php" class="back-btn">← Back</a>

    <h2>My Loans</h2>

    <?php while ($row = $result->fetch_assoc()) { ?>

        <div style="border:1px solid #ddd; padding:10px; margin-bottom:10px;">
            <p><strong>Amount:</strong> ৳<?php echo $row['amount']; ?></p>
            <p><strong>Interest:</strong> <?php echo $row['interest_rate']; ?>%</p>
            <p><strong>Status:</strong> <?php echo $row['status']; ?></p>
            <p><strong>Duration:</strong> <?php echo $row['duration']; ?> months</p>
        </div>

    <?php } ?>

</div>

</body>
</html>