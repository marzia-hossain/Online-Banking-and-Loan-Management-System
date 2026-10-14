<!DOCTYPE html>
<html>
<head>
    <title>Loan Payment</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>

<div class="app-container">

    <a href="loan_status.php" class="back-btn">← Back</a>

    <h2>Pay Installment</h2>

    <form action="loan_payment_process.php" method="POST">

        <label>Installment ID:</label>
        <input type="number" name="installment_id" required>

        <label>Amount:</label>
        <input type="number" name="amount" required>

        <button type="submit">Pay</button>

    </form>

</div>

</body>
</html>