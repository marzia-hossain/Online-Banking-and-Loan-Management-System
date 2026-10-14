<?php
session_start();
include 'db_config.php';

if (!isset($_SESSION['customer_id'])) {
    header("Location: login.html");
    exit();
}

$customer_id = $_SESSION['customer_id'];

// Get notifications for logged-in user
$stmt = $conn->prepare("
    SELECT message, type, created_at, status
    FROM notification
    WHERE customer_id = ?
    ORDER BY notification_id DESC
");

$stmt->bind_param("i", $customer_id);
$stmt->execute();
$result = $stmt->get_result();
?>

<!DOCTYPE html>
<html>
<head>
    <title>Notifications</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>

<div class="app-container">

    <a href="dashboard.php" class="back-btn">← Back</a>

    <h2>Notifications</h2>

    <?php if ($result->num_rows > 0) { ?>

        <?php while ($row = $result->fetch_assoc()) { ?>

            <div style="padding:10px; border-bottom:1px solid #eee; margin-bottom:10px;">

                <p>
                    <?php echo htmlspecialchars($row['message']); ?>
                </p>

                <small>
                    Type: <?php echo $row['type']; ?> |
                    Status: <?php echo $row['status']; ?> |
                    <?php echo $row['created_at']; ?>
                </small>

            </div>

        <?php } ?>

    <?php } else { ?>

        <p>No notifications found.</p>

    <?php } ?>

</div>

</body>
</html>