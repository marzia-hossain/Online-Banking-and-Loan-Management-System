-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 03, 2026 at 05:57 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `online_banking_loan_management_system`
--

-- --------------------------------------------------------

--
-- Table structure for table `agent`
--

CREATE TABLE `agent` (
  `agent_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `phone` varchar(15) NOT NULL,
  `location` varchar(100) DEFAULT NULL,
  `wallet_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `agent`
--

INSERT INTO `agent` (`agent_id`, `name`, `phone`, `location`, `wallet_id`) VALUES
(1, 'Agent Rahman', '01810000001', 'Dhaka', 2),
(2, 'Agent Karim', '01810000002', 'Gazipur', 5),
(3, 'Agent Sohel', '01810000003', 'Sylhet', 10),
(4, 'Agent Tarek', '01810000004', 'Chittagong', 14);

-- --------------------------------------------------------

--
-- Table structure for table `cash_transaction`
--

CREATE TABLE `cash_transaction` (
  `cash_transaction_id` int(11) NOT NULL,
  `customer_wallet_id` int(11) NOT NULL,
  `agent_wallet_id` int(11) NOT NULL,
  `type` enum('cash_in','cash_out') NOT NULL,
  `amount` decimal(12,2) NOT NULL,
  `transaction_date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `cash_transaction`
--

INSERT INTO `cash_transaction` (`cash_transaction_id`, `customer_wallet_id`, `agent_wallet_id`, `type`, `amount`, `transaction_date`) VALUES
(1, 1, 2, 'cash_in', 1000.00, '2026-05-03 15:29:04'),
(2, 3, 5, 'cash_out', 500.00, '2026-05-03 15:29:04'),
(3, 6, 10, 'cash_in', 2000.00, '2026-05-03 15:29:04'),
(4, 9, 14, 'cash_out', 700.00, '2026-05-03 15:29:04'),
(5, 11, 2, 'cash_in', 1500.00, '2026-05-03 15:29:04'),
(6, 1, 5, 'cash_out', 300.00, '2026-05-03 15:29:04'),
(7, 3, 10, 'cash_in', 1200.00, '2026-05-03 15:29:04'),
(8, 6, 14, 'cash_out', 400.00, '2026-05-03 15:29:04'),
(9, 9, 2, 'cash_in', 900.00, '2026-05-03 15:29:04'),
(10, 11, 5, 'cash_out', 600.00, '2026-05-03 15:29:04'),
(11, 1, 10, 'cash_in', 1100.00, '2026-05-03 15:29:04'),
(12, 3, 14, 'cash_out', 250.00, '2026-05-03 15:29:04'),
(13, 6, 2, 'cash_in', 1700.00, '2026-05-03 15:29:04'),
(14, 9, 5, 'cash_out', 800.00, '2026-05-03 15:29:04'),
(15, 11, 10, 'cash_in', 1300.00, '2026-05-03 15:29:04');

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `customer_id` int(11) NOT NULL,
  `fullname` varchar(100) NOT NULL,
  `phone` varchar(15) NOT NULL,
  `email` varchar(100) NOT NULL,
  `nid` varchar(20) DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `registration_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `wallet_id` int(11) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`customer_id`, `fullname`, `phone`, `email`, `nid`, `date_of_birth`, `password`, `registration_date`, `wallet_id`, `address`) VALUES
(1, 'Rahim Uddin', '01710000001', 'rahim@gmail.com', '199000000001', '1995-05-10', 'pass123', '2026-05-03 14:04:56', 1, 'Dhaka'),
(2, 'Ayesha Akter', '01710000003', 'ayesha@gmail.com', '199000000003', '1998-07-15', 'pass123', '2026-05-03 14:04:56', 3, 'Dhaka'),
(3, 'Sabbir Hossain', '01710000006', 'sabbir@gmail.com', '199000000006', '1996-11-18', 'pass123', '2026-05-03 14:04:56', 6, 'Khulna'),
(4, 'Sumaiya Khan', '01710000009', 'sumaiya@gmail.com', '199000000009', '2000-08-14', 'pass123', '2026-05-03 14:04:56', 9, 'Dhaka'),
(5, 'Jannat Ara', '01710000011', 'jannat@gmail.com', '199000000011', '1995-10-11', 'pass123', '2026-05-03 14:04:56', 11, 'Cumilla');

-- --------------------------------------------------------

--
-- Table structure for table `document_verification`
--

CREATE TABLE `document_verification` (
  `verification_id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `document_type` enum('nid','passport','driving_license','birth_certificate') NOT NULL,
  `upload_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `status` enum('pending','verified','rejected') DEFAULT 'pending',
  `verified_by_employee_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `document_verification`
--

INSERT INTO `document_verification` (`verification_id`, `customer_id`, `document_type`, `upload_date`, `status`, `verified_by_employee_id`) VALUES
(16, 1, 'nid', '2026-05-03 15:50:39', 'verified', 1),
(17, 2, 'passport', '2026-05-03 15:50:39', 'pending', NULL),
(18, 3, 'nid', '2026-05-03 15:50:39', 'verified', 2),
(19, 4, 'driving_license', '2026-05-03 15:50:39', 'rejected', 1),
(20, 5, 'nid', '2026-05-03 15:50:39', 'verified', 2),
(21, 1, 'birth_certificate', '2026-05-03 15:50:39', 'pending', NULL),
(22, 2, 'nid', '2026-05-03 15:50:39', 'verified', 1),
(23, 3, 'passport', '2026-05-03 15:50:39', 'verified', 2),
(24, 4, 'nid', '2026-05-03 15:50:39', 'pending', NULL),
(25, 5, 'driving_license', '2026-05-03 15:50:39', 'verified', 1),
(26, 1, 'nid', '2026-05-03 15:50:39', 'verified', 2),
(27, 2, 'passport', '2026-05-03 15:50:39', 'rejected', 1),
(28, 3, 'nid', '2026-05-03 15:50:39', 'verified', 2),
(29, 4, 'birth_certificate', '2026-05-03 15:50:39', 'pending', NULL),
(30, 5, 'nid', '2026-05-03 15:50:39', 'verified', 1);

-- --------------------------------------------------------

--
-- Table structure for table `employee`
--

CREATE TABLE `employee` (
  `employee_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `phone` varchar(15) NOT NULL,
  `role` varchar(50) NOT NULL,
  `salary` decimal(10,2) NOT NULL,
  `join_date` date NOT NULL,
  `nid` varchar(20) DEFAULT NULL,
  `wallet_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `employee`
--

INSERT INTO `employee` (`employee_id`, `name`, `phone`, `role`, `salary`, `join_date`, `nid`, `wallet_id`) VALUES
(1, 'Atik Rahman', '01910000001', 'System Admin', 50000.00, '2025-01-10', '199000000014', 14),
(2, 'Mojammel', '01910000002', 'Customer Support', 30000.00, '2025-02-15', '199000000015', 15);

-- --------------------------------------------------------

--
-- Table structure for table `loan`
--

CREATE TABLE `loan` (
  `loan_id` int(11) NOT NULL,
  `customer_wallet_id` int(11) NOT NULL,
  `amount` decimal(12,2) NOT NULL,
  `interest_rate` decimal(5,2) NOT NULL,
  `duration` int(11) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `status` enum('pending','approved','active','closed','rejected') DEFAULT 'pending'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `loan`
--

INSERT INTO `loan` (`loan_id`, `customer_wallet_id`, `amount`, `interest_rate`, `duration`, `start_date`, `end_date`, `status`) VALUES
(1, 1, 5000.00, 10.50, 12, '2025-01-01', '2025-12-31', 'active'),
(2, 3, 3000.00, 9.00, 6, '2025-02-01', '2025-07-31', 'approved'),
(3, 6, 10000.00, 12.00, 24, '2025-03-01', '2027-02-28', 'pending'),
(4, 9, 7000.00, 11.00, 18, '2025-01-15', '2026-07-14', 'active'),
(5, 11, 2000.00, 8.50, 6, '2025-04-01', '2025-09-30', 'closed'),
(6, 1, 4000.00, 10.00, 12, '2025-05-01', '2026-04-30', 'approved'),
(7, 3, 8000.00, 12.50, 24, '2025-06-01', '2027-05-31', 'active'),
(8, 6, 1500.00, 9.50, 3, '2025-07-01', '2025-09-30', 'rejected'),
(9, 9, 6000.00, 11.50, 12, '2025-08-01', '2026-07-31', 'pending'),
(10, 11, 9000.00, 13.00, 36, '2025-09-01', '2028-08-31', 'active'),
(11, 1, 2500.00, 8.00, 6, '2025-02-10', '2025-08-09', 'closed'),
(12, 3, 11000.00, 12.00, 24, '2025-03-15', '2027-03-14', 'active'),
(13, 6, 5000.00, 10.00, 12, '2025-04-20', '2026-04-19', 'approved'),
(14, 9, 3500.00, 9.00, 9, '2025-05-25', '2026-02-24', 'pending'),
(15, 11, 12000.00, 14.00, 36, '2025-06-30', '2028-06-29', 'active');

-- --------------------------------------------------------

--
-- Table structure for table `loan_installment`
--

CREATE TABLE `loan_installment` (
  `installment_id` int(11) NOT NULL,
  `loan_id` int(11) NOT NULL,
  `due_date` date NOT NULL,
  `amount` decimal(12,2) NOT NULL,
  `paid_amount` decimal(12,2) DEFAULT 0.00,
  `due_amount` decimal(12,2) GENERATED ALWAYS AS (`amount` - `paid_amount`) STORED,
  `status` enum('pending','partial','paid','overdue') DEFAULT 'pending'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `loan_installment`
--

INSERT INTO `loan_installment` (`installment_id`, `loan_id`, `due_date`, `amount`, `paid_amount`, `status`) VALUES
(1, 1, '2025-02-01', 500.00, 500.00, 'paid'),
(2, 2, '2025-03-01', 400.00, 200.00, 'partial'),
(3, 3, '2025-04-01', 600.00, 0.00, 'pending'),
(4, 4, '2025-05-01', 700.00, 700.00, 'paid'),
(5, 5, '2025-06-01', 300.00, 0.00, 'overdue'),
(6, 6, '2025-07-01', 800.00, 800.00, 'paid'),
(7, 7, '2025-08-01', 900.00, 450.00, 'partial'),
(8, 8, '2025-09-01', 1000.00, 0.00, 'pending'),
(9, 9, '2025-10-01', 650.00, 650.00, 'paid'),
(10, 10, '2025-11-01', 1200.00, 0.00, 'overdue');

-- --------------------------------------------------------

--
-- Table structure for table `loan_payment`
--

CREATE TABLE `loan_payment` (
  `payment_id` int(11) NOT NULL,
  `installment_id` int(11) NOT NULL,
  `wallet_id` int(11) NOT NULL,
  `amount` decimal(12,2) NOT NULL,
  `payment_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `status` enum('success','failed','pending') DEFAULT 'success'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `loan_payment`
--

INSERT INTO `loan_payment` (`payment_id`, `installment_id`, `wallet_id`, `amount`, `payment_date`, `status`) VALUES
(1, 1, 1, 500.00, '2026-05-03 15:42:29', 'success'),
(2, 2, 3, 200.00, '2026-05-03 15:42:29', 'success'),
(3, 3, 6, 600.00, '2026-05-03 15:42:29', 'pending'),
(4, 4, 9, 700.00, '2026-05-03 15:42:29', 'success'),
(5, 5, 11, 300.00, '2026-05-03 15:42:29', 'failed');

-- --------------------------------------------------------

--
-- Table structure for table `merchant`
--

CREATE TABLE `merchant` (
  `merchant_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `wallet_id` int(11) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `merchant`
--

INSERT INTO `merchant` (`merchant_id`, `name`, `wallet_id`, `email`, `address`) VALUES
(1, 'Daraz BD', 4, 'daraz@gmail.com', 'Dhaka'),
(2, 'Pickaboo', 8, 'pickaboo@gmail.com', 'Dhaka'),
(3, 'Foodpanda BD', 12, 'foodpanda@gmail.com', 'Dhaka');

-- --------------------------------------------------------

--
-- Table structure for table `notification`
--

CREATE TABLE `notification` (
  `notification_id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `message` varchar(255) NOT NULL,
  `type` enum('transaction','payment','loan','security','system') NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `status` enum('unread','read') DEFAULT 'unread'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `notification`
--

INSERT INTO `notification` (`notification_id`, `customer_id`, `message`, `type`, `created_at`, `status`) VALUES
(1, 1, 'You sent money successfully', 'transaction', '2026-05-03 15:54:23', 'read'),
(2, 2, 'Loan approved for your account', 'loan', '2026-05-03 15:54:23', 'unread'),
(3, 3, 'Payment to merchant successful', 'payment', '2026-05-03 15:54:23', 'read'),
(4, 4, 'Cash in received from agent', 'transaction', '2026-05-03 15:54:23', 'unread'),
(5, 5, 'Your document verified successfully', 'security', '2026-05-03 15:54:23', 'read'),
(6, 1, 'Loan installment due soon', 'loan', '2026-05-03 15:54:23', 'unread'),
(7, 2, 'Transaction failed due to low balance', 'transaction', '2026-05-03 15:54:23', 'read'),
(8, 3, 'Payment received successfully', 'payment', '2026-05-03 15:54:23', 'read'),
(9, 4, 'New login detected', 'security', '2026-05-03 15:54:23', 'unread'),
(10, 5, 'System maintenance scheduled', 'system', '2026-05-03 15:54:23', 'read');

-- --------------------------------------------------------

--
-- Table structure for table `payment`
--

CREATE TABLE `payment` (
  `payment_id` int(11) NOT NULL,
  `customer_wallet_id` int(11) NOT NULL,
  `receiver_wallet_id` int(11) NOT NULL,
  `bill_type` enum('electricity','water','internet','mobile_recharge','shopping','service_fee') NOT NULL,
  `amount` decimal(12,2) NOT NULL,
  `payment_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `status` enum('success','pending','failed') DEFAULT 'success'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `payment`
--

INSERT INTO `payment` (`payment_id`, `customer_wallet_id`, `receiver_wallet_id`, `bill_type`, `amount`, `payment_date`, `status`) VALUES
(1, 1, 4, 'shopping', 1200.00, '2026-05-03 15:24:10', 'success'),
(2, 3, 8, 'shopping', 800.00, '2026-05-03 15:24:10', 'failed'),
(3, 6, 12, 'shopping', 450.00, '2026-05-03 15:24:10', 'success'),
(4, 9, 4, 'shopping', 700.00, '2026-05-03 15:24:10', 'pending'),
(5, 11, 8, 'shopping', 250.00, '2026-05-03 15:24:10', 'success'),
(6, 1, 7, 'electricity', 300.00, '2026-05-03 15:24:10', 'success'),
(7, 3, 7, 'electricity', 500.00, '2026-05-03 15:24:10', 'failed'),
(8, 6, 7, 'internet', 200.00, '2026-05-03 15:24:10', 'success'),
(9, 9, 13, 'internet', 150.00, '2026-05-03 15:24:10', 'pending'),
(10, 11, 13, 'mobile_recharge', 400.00, '2026-05-03 15:24:10', 'success'),
(11, 1, 12, 'service_fee', 100.00, '2026-05-03 15:24:10', 'success'),
(12, 3, 4, 'shopping', 600.00, '2026-05-03 15:24:10', 'failed'),
(13, 6, 8, 'shopping', 350.00, '2026-05-03 15:24:10', 'success'),
(14, 9, 12, 'service_fee', 220.00, '2026-05-03 15:24:10', 'pending'),
(15, 11, 4, 'shopping', 500.00, '2026-05-03 15:24:10', 'success');

-- --------------------------------------------------------

--
-- Table structure for table `service_provider`
--

CREATE TABLE `service_provider` (
  `service_provider_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `service_type` varchar(100) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `wallet_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `service_provider`
--

INSERT INTO `service_provider` (`service_provider_id`, `name`, `service_type`, `email`, `address`, `wallet_id`) VALUES
(1, 'Bkash Support', 'Mobile Banking Service', 'bkash@gmail.com', 'Dhaka', 7),
(2, 'Nagad Support', 'Digital Payment Service', 'nagad@gmail.com', 'Dhaka', 13);

-- --------------------------------------------------------

--
-- Table structure for table `transaction`
--

CREATE TABLE `transaction` (
  `transaction_id` int(11) NOT NULL,
  `sender_wallet_id` int(11) NOT NULL,
  `receiver_wallet_id` int(11) NOT NULL,
  `transaction_type` enum('send_money') DEFAULT 'send_money',
  `amount` decimal(12,2) NOT NULL,
  `transaction_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `status` enum('success','pending','failed') DEFAULT 'success'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `transaction`
--

INSERT INTO `transaction` (`transaction_id`, `sender_wallet_id`, `receiver_wallet_id`, `transaction_type`, `amount`, `transaction_date`, `status`) VALUES
(1, 1, 3, 'send_money', 500.00, '2026-05-03 15:11:16', 'success'),
(2, 3, 6, 'send_money', 200.00, '2026-05-03 15:11:16', 'failed'),
(3, 6, 9, 'send_money', 150.00, '2026-05-03 15:11:16', 'success'),
(4, 9, 11, 'send_money', 300.00, '2026-05-03 15:11:16', 'pending'),
(5, 11, 1, 'send_money', 100.00, '2026-05-03 15:11:16', 'success'),
(6, 1, 6, 'send_money', 250.00, '2026-05-03 15:11:16', 'success'),
(7, 3, 9, 'send_money', 400.00, '2026-05-03 15:11:16', 'failed'),
(8, 6, 11, 'send_money', 180.00, '2026-05-03 15:11:16', 'success'),
(9, 9, 1, 'send_money', 220.00, '2026-05-03 15:11:16', 'pending'),
(10, 11, 3, 'send_money', 350.00, '2026-05-03 15:11:16', 'success'),
(11, 1, 9, 'send_money', 600.00, '2026-05-03 15:11:16', 'success'),
(12, 3, 11, 'send_money', 120.00, '2026-05-03 15:11:16', 'failed'),
(13, 6, 1, 'send_money', 90.00, '2026-05-03 15:11:16', 'success'),
(14, 9, 3, 'send_money', 500.00, '2026-05-03 15:11:16', 'pending'),
(15, 11, 6, 'send_money', 75.00, '2026-05-03 15:11:16', 'success');

-- --------------------------------------------------------

--
-- Table structure for table `wallet`
--

CREATE TABLE `wallet` (
  `wallet_id` int(11) NOT NULL,
  `balance` decimal(12,2) DEFAULT 0.00,
  `qr_code` varchar(255) DEFAULT NULL,
  `wallet_status` enum('active','inactive','suspended') DEFAULT 'active',
  `wallet_type` enum('agent','customer','merchant','service_provider','employee') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `wallet`
--

INSERT INTO `wallet` (`wallet_id`, `balance`, `qr_code`, `wallet_status`, `wallet_type`) VALUES
(1, 5000.00, 'QR001ABC', 'active', 'customer'),
(2, 12000.50, 'QR002DEF', 'active', 'agent'),
(3, 300.75, 'QR003GHI', 'inactive', 'customer'),
(4, 8900.00, 'QR004JKL', 'active', 'merchant'),
(5, 15000.00, 'QR005MNO', 'suspended', 'agent'),
(6, 750.25, 'QR006PQR', 'active', 'customer'),
(7, 2200.00, 'QR007STU', 'active', 'service_provider'),
(8, 9800.80, 'QR008VWX', 'inactive', 'merchant'),
(9, 4300.00, 'QR009YZA', 'active', 'customer'),
(10, 6700.60, 'QR010BCD', 'active', 'agent'),
(11, 250.00, 'QR011EFG', 'suspended', 'customer'),
(12, 14500.00, 'QR012HIJ', 'active', 'merchant'),
(13, 800.90, 'QR013KLM', 'active', 'service_provider'),
(14, 9999.99, 'QR014NOP', 'inactive', 'employee'),
(15, 1234.56, 'QR015QRS', 'active', 'employee');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `agent`
--
ALTER TABLE `agent`
  ADD PRIMARY KEY (`agent_id`),
  ADD UNIQUE KEY `phone` (`phone`),
  ADD UNIQUE KEY `wallet_id` (`wallet_id`);

--
-- Indexes for table `cash_transaction`
--
ALTER TABLE `cash_transaction`
  ADD PRIMARY KEY (`cash_transaction_id`),
  ADD KEY `customer_wallet_id` (`customer_wallet_id`),
  ADD KEY `agent_wallet_id` (`agent_wallet_id`);

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`customer_id`),
  ADD UNIQUE KEY `phone` (`phone`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `nid` (`nid`),
  ADD UNIQUE KEY `wallet_id` (`wallet_id`);

--
-- Indexes for table `document_verification`
--
ALTER TABLE `document_verification`
  ADD PRIMARY KEY (`verification_id`),
  ADD KEY `customer_id` (`customer_id`),
  ADD KEY `verified_by_employee_id` (`verified_by_employee_id`);

--
-- Indexes for table `employee`
--
ALTER TABLE `employee`
  ADD PRIMARY KEY (`employee_id`),
  ADD UNIQUE KEY `phone` (`phone`),
  ADD UNIQUE KEY `nid` (`nid`),
  ADD UNIQUE KEY `wallet_id` (`wallet_id`);

--
-- Indexes for table `loan`
--
ALTER TABLE `loan`
  ADD PRIMARY KEY (`loan_id`),
  ADD KEY `customer_wallet_id` (`customer_wallet_id`);

--
-- Indexes for table `loan_installment`
--
ALTER TABLE `loan_installment`
  ADD PRIMARY KEY (`installment_id`),
  ADD KEY `loan_id` (`loan_id`);

--
-- Indexes for table `loan_payment`
--
ALTER TABLE `loan_payment`
  ADD PRIMARY KEY (`payment_id`),
  ADD KEY `installment_id` (`installment_id`),
  ADD KEY `wallet_id` (`wallet_id`);

--
-- Indexes for table `merchant`
--
ALTER TABLE `merchant`
  ADD PRIMARY KEY (`merchant_id`),
  ADD UNIQUE KEY `wallet_id` (`wallet_id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `notification`
--
ALTER TABLE `notification`
  ADD PRIMARY KEY (`notification_id`),
  ADD KEY `customer_id` (`customer_id`);

--
-- Indexes for table `payment`
--
ALTER TABLE `payment`
  ADD PRIMARY KEY (`payment_id`),
  ADD KEY `customer_wallet_id` (`customer_wallet_id`),
  ADD KEY `receiver_wallet_id` (`receiver_wallet_id`);

--
-- Indexes for table `service_provider`
--
ALTER TABLE `service_provider`
  ADD PRIMARY KEY (`service_provider_id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `wallet_id` (`wallet_id`);

--
-- Indexes for table `transaction`
--
ALTER TABLE `transaction`
  ADD PRIMARY KEY (`transaction_id`),
  ADD KEY `sender_wallet_id` (`sender_wallet_id`),
  ADD KEY `receiver_wallet_id` (`receiver_wallet_id`);

--
-- Indexes for table `wallet`
--
ALTER TABLE `wallet`
  ADD PRIMARY KEY (`wallet_id`),
  ADD UNIQUE KEY `qr_code` (`qr_code`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `agent`
--
ALTER TABLE `agent`
  MODIFY `agent_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `cash_transaction`
--
ALTER TABLE `cash_transaction`
  MODIFY `cash_transaction_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `customer`
--
ALTER TABLE `customer`
  MODIFY `customer_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `document_verification`
--
ALTER TABLE `document_verification`
  MODIFY `verification_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `employee`
--
ALTER TABLE `employee`
  MODIFY `employee_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `loan`
--
ALTER TABLE `loan`
  MODIFY `loan_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `loan_installment`
--
ALTER TABLE `loan_installment`
  MODIFY `installment_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `loan_payment`
--
ALTER TABLE `loan_payment`
  MODIFY `payment_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `merchant`
--
ALTER TABLE `merchant`
  MODIFY `merchant_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `notification`
--
ALTER TABLE `notification`
  MODIFY `notification_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `payment`
--
ALTER TABLE `payment`
  MODIFY `payment_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `service_provider`
--
ALTER TABLE `service_provider`
  MODIFY `service_provider_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `transaction`
--
ALTER TABLE `transaction`
  MODIFY `transaction_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `wallet`
--
ALTER TABLE `wallet`
  MODIFY `wallet_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `agent`
--
ALTER TABLE `agent`
  ADD CONSTRAINT `agent_ibfk_1` FOREIGN KEY (`wallet_id`) REFERENCES `wallet` (`wallet_id`);

--
-- Constraints for table `cash_transaction`
--
ALTER TABLE `cash_transaction`
  ADD CONSTRAINT `cash_transaction_ibfk_1` FOREIGN KEY (`customer_wallet_id`) REFERENCES `wallet` (`wallet_id`),
  ADD CONSTRAINT `cash_transaction_ibfk_2` FOREIGN KEY (`agent_wallet_id`) REFERENCES `wallet` (`wallet_id`);

--
-- Constraints for table `customer`
--
ALTER TABLE `customer`
  ADD CONSTRAINT `customer_ibfk_1` FOREIGN KEY (`wallet_id`) REFERENCES `wallet` (`wallet_id`);

--
-- Constraints for table `document_verification`
--
ALTER TABLE `document_verification`
  ADD CONSTRAINT `document_verification_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`),
  ADD CONSTRAINT `document_verification_ibfk_2` FOREIGN KEY (`verified_by_employee_id`) REFERENCES `employee` (`employee_id`);

--
-- Constraints for table `employee`
--
ALTER TABLE `employee`
  ADD CONSTRAINT `employee_ibfk_1` FOREIGN KEY (`wallet_id`) REFERENCES `wallet` (`wallet_id`);

--
-- Constraints for table `loan`
--
ALTER TABLE `loan`
  ADD CONSTRAINT `loan_ibfk_1` FOREIGN KEY (`customer_wallet_id`) REFERENCES `wallet` (`wallet_id`);

--
-- Constraints for table `loan_installment`
--
ALTER TABLE `loan_installment`
  ADD CONSTRAINT `loan_installment_ibfk_1` FOREIGN KEY (`loan_id`) REFERENCES `loan` (`loan_id`);

--
-- Constraints for table `loan_payment`
--
ALTER TABLE `loan_payment`
  ADD CONSTRAINT `loan_payment_ibfk_1` FOREIGN KEY (`installment_id`) REFERENCES `loan_installment` (`installment_id`),
  ADD CONSTRAINT `loan_payment_ibfk_2` FOREIGN KEY (`wallet_id`) REFERENCES `wallet` (`wallet_id`);

--
-- Constraints for table `merchant`
--
ALTER TABLE `merchant`
  ADD CONSTRAINT `merchant_ibfk_1` FOREIGN KEY (`wallet_id`) REFERENCES `wallet` (`wallet_id`);

--
-- Constraints for table `notification`
--
ALTER TABLE `notification`
  ADD CONSTRAINT `notification_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`);

--
-- Constraints for table `payment`
--
ALTER TABLE `payment`
  ADD CONSTRAINT `payment_ibfk_1` FOREIGN KEY (`customer_wallet_id`) REFERENCES `wallet` (`wallet_id`),
  ADD CONSTRAINT `payment_ibfk_2` FOREIGN KEY (`receiver_wallet_id`) REFERENCES `wallet` (`wallet_id`);

--
-- Constraints for table `service_provider`
--
ALTER TABLE `service_provider`
  ADD CONSTRAINT `service_provider_ibfk_1` FOREIGN KEY (`wallet_id`) REFERENCES `wallet` (`wallet_id`);

--
-- Constraints for table `transaction`
--
ALTER TABLE `transaction`
  ADD CONSTRAINT `transaction_ibfk_1` FOREIGN KEY (`sender_wallet_id`) REFERENCES `wallet` (`wallet_id`),
  ADD CONSTRAINT `transaction_ibfk_2` FOREIGN KEY (`receiver_wallet_id`) REFERENCES `wallet` (`wallet_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
