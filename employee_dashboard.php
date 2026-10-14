<?php
session_start();
include 'db_config.php';

if (!isset($_SESSION['employee_id'])) {
    header("Location: login.html");
    exit();
}
?>

<!DOCTYPE html>
<html>
<head>
    <title>Employee Dashboard</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>

<div class="app-container">

    <h2>Employee Dashboard</h2>
    <p>Welcome, <?php echo $_SESSION['employee_name']; ?></p>

    <form method="POST">

        <label>Select Table:</label>
        <select name="table">

            <option value="customer">Customer</option>
            <option value="employee">Employee</option>
            <option value="agent">Agent</option>
            <option value="merchant">Merchant</option>
            <option value="service_provider">Service Provider</option>
            <option value="wallet">Wallet</option>
            <option value="transaction">Transaction</option>
            <option value="cash_transaction">Cash Transaction</option>
            <option value="payment">Payment</option>
            <option value="loan">Loan</option>
            <option value="loan_installment">Loan Installment</option>
            <option value="loan_payment">Loan Payment</option>
            <option value="notification">Notification</option>
            <option value="document_verification">Document Verification</option>

        </select>

        <button type="submit">View</button>

    </form>

    <hr>

    <?php
    if (isset($_POST['table'])) {

        $table = $_POST['table'];

        $result = $conn->query("SELECT * FROM $table LIMIT 50");

        echo "<h3>Table: $table</h3>";
        echo "<table border='1' style='width:100%; font-size:12px;'>";

        while ($row = $result->fetch_assoc()) {
            echo "<tr>";
            foreach ($row as $col) {
                echo "<td>$col</td>";
            }
            echo "</tr>";
        }

        echo "</table>";
    }
    ?>

    <br>
    <a href="logout.php">Logout</a>

</div>

</body>
</html>