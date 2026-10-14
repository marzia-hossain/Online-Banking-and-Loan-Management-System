<?php
session_start();
include 'db_config.php';

$loan_id = $_GET['loan_id'];

$stmt = $conn->prepare("
    SELECT * FROM loan_installment
    WHERE loan_id = ?
    ORDER BY due_date ASC
");

$stmt->bind_param("i", $loan_id);
$stmt->execute();
$result = $stmt->get_result();
?>

<!DOCTYPE html>
<html>
<head>
    <title>Loan Installments</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>

<div class="app-container">

    <a href="loan_status.php" class="back-btn">← Back</a>

    <h2>Installments</h2>

    <?php while ($row = $result->fetch_assoc()) { ?>

        <div style="border:1px solid #ddd; padding:10px; margin-bottom:10px;">
            <p><strong>Due Date:</strong> <?php echo $row['due_date']; ?></p>
            <p><strong>Amount:</strong> ৳<?php echo $row['amount']; ?></p>
            <p><strong>Paid:</strong> ৳<?php echo $row['paid_amount']; ?></p>
            <p><strong>Status:</strong> <?php echo $row['status']; ?></p>
        </div>

    <?php } ?>

</div>

</body>
</html>