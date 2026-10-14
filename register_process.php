<?php
include 'db_config.php';

if ($_SERVER["REQUEST_METHOD"] == "POST") {

    $fullname = $_POST['full_name'];
    $phone = $_POST['phone'];
    $email = $_POST['email'];
    $nid = $_POST['nid'];
    $dob = $_POST['dob'];
    $address = $_POST['address'];
    $password = password_hash($_POST['password'], PASSWORD_DEFAULT);

    // 🔥 Check duplicate phone/email first
    $check = $conn->prepare("SELECT customer_id FROM customer WHERE phone = ? OR email = ?");
    $check->bind_param("ss", $phone, $email);
    $check->execute();
    $result = $check->get_result();

    if ($result->num_rows > 0) {
        die("Phone or Email already exists!");
    }

    // Start transaction
    $conn->begin_transaction();

    try {

        // 1. Create wallet
        $wallet_stmt = $conn->prepare("
            INSERT INTO wallet (balance, wallet_status, wallet_type)
            VALUES (0.00, 'active', 'customer')
        ");

        $wallet_stmt->execute();
        $wallet_id = $conn->insert_id;

        // 2. Insert customer
        $stmt = $conn->prepare("
            INSERT INTO customer
            (fullname, phone, email, nid, date_of_birth, password, wallet_id, address)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?)
        ");

        $stmt->bind_param(
            "ssssssis",
            $fullname,
            $phone,
            $email,
            $nid,
            $dob,
            $password,
            $wallet_id,
            $address
        );

        $stmt->execute();

        // 3. Commit
        $conn->commit();

        header("Location: login.html");
        exit();

    } catch (Exception $e) {

        $conn->rollback();
        echo "Registration failed: " . $e->getMessage();
    }
}
?>