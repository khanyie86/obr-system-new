-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 29, 2024 at 09:05 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `bus_reg_system`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `admin_id` int(11) NOT NULL,
  `initials` varchar(50) NOT NULL,
  `surname` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(100) NOT NULL,
  `phone` varchar(15) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`admin_id`, `initials`, `surname`, `email`, `password`, `phone`, `created_at`) VALUES
(1, 'TK', 'Raffaello', 'RaffaelloCapon@jourrapide.com', '$2y$10$LSeBrqXHor8Vo2Ya5XRnHeqKekgZZPaCcYNqNcv/muXAfCo39XFSa', '0614244508', '2024-07-29 18:08:46');

-- --------------------------------------------------------

--
-- Table structure for table `bus_registration`
--

CREATE TABLE `bus_registration` (
  `bus_reg_no` int(11) NOT NULL,
  `learner_id` int(11) NOT NULL,
  `parent_id` int(11) NOT NULL,
  `route_id` int(11) NOT NULL,
  `status` enum('''approved''','''pending''','''rejected''','') NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `learner`
--

CREATE TABLE `learner` (
  `learner_id` int(11) NOT NULL,
  `parent_id` int(11) NOT NULL,
  `bus_id` int(11) NOT NULL,
  `admin_id` int(11) NOT NULL,
  `learner_name` varchar(255) NOT NULL,
  `learner_surname` varchar(255) NOT NULL,
  `learner_dob` date NOT NULL,
  `learner_home_address` varchar(255) NOT NULL,
  `learner_phone` varchar(15) NOT NULL,
  `learner_grade` enum('8','9','10','11','12') NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `learner`
--

INSERT INTO `learner` (`learner_id`, `parent_id`, `bus_id`, `admin_id`, `learner_name`, `learner_surname`, `learner_dob`, `learner_home_address`, `learner_phone`, `learner_grade`, `created_at`) VALUES
(3000001, 2000001, 60001, 1000002, 'Betsy', 'Calabrese', '2004-11-27', '2042 Morgan Rd', '0845607026', '12', '2024-05-20 07:37:06'),
(3000002, 2000001, 60001, 1000002, 'Betsy', 'Calabrese', '2004-11-27', '2042 Morgan Rd', '0845607026', '12', '2024-05-20 07:38:45'),
(3000003, 2000001, 60001, 1000002, 'Betsy', 'Calabrese', '2004-11-27', '2042 Morgan Rd', '0845607026', '12', '2024-05-20 07:38:45'),
(3000004, 2000001, 60001, 1000002, 'Russell', 'Nucci', '2008-03-22', '707 Akasia St', '0826126014', '10', '2024-05-20 07:38:45'),
(3000005, 2000001, 60001, 1000002, 'Brenda', 'Giordano', '2006-06-20', '533 Heuvel St', '0833333490', '11', '2024-05-20 07:38:45'),
(3000006, 2000001, 60001, 1000002, 'Francis', 'Toscani', '2007-04-11', '639 Robertson Ave', '0827701832', '11', '2024-05-20 07:38:45'),
(3000007, 2000001, 60001, 1000002, 'Josefina', 'Rossi', '2010-03-08', '1123 Oranje St', '0827190801', '8', '2024-05-20 07:38:45'),
(3000008, 2000001, 60001, 1000002, 'Stephen', 'Mazzanti', '2004-11-10', '671 Gemsbok St', '0848680322', '12', '2024-05-20 07:38:45'),
(3000009, 2000001, 60001, 1000002, 'Erin', 'Siciliano', '2004-12-11', '2179 Telford Ave', '0855210206', '12', '2024-05-20 07:38:45'),
(3000010, 2000001, 60001, 1000002, 'Billie', 'Colombo', '2010-06-05', '142 Nelson Mandela Drive', '0847280809', '8', '2024-05-20 07:38:45'),
(3000011, 2000001, 60001, 1000002, 'Frank', 'Bergamaschi', '2003-11-18', '894 Gray Pl', '0853309605', '12', '2024-05-20 07:38:45'),
(3000012, 2000001, 60001, 1000002, 'Weston', 'Schiavone', '2004-03-17', '22 Robertson Ave', '0832507231', '12', '2024-05-20 07:38:45'),
(3000013, 2000001, 60001, 1000002, 'Mary', 'Calabrese', '2004-09-29', '1850 Church St', '0842549458', '12', '2024-05-20 07:38:45'),
(3000014, 2000001, 60001, 1000002, 'Teresa', 'Iadanza', '2004-05-27', '1907 Schoeman St', '0821405192', '12', '2024-05-20 07:38:45'),
(3000015, 2000001, 60001, 1000002, 'Virginia', 'Davide', '2006-06-03', '678 Gemsbok St', '0834067279', '11', '2024-05-20 07:38:45'),
(3000016, 2000001, 60001, 1000002, 'Misty', 'Buccho', '2007-03-28', '1500 Hoog St', '0836798051', '11', '2024-05-20 07:38:45'),
(3000017, 2000001, 60001, 1000002, 'Lana', 'Sagese', '2006-06-07', '34 Mosman Rd', '0851477732', '11', '2024-05-20 07:38:45'),
(3000018, 2000001, 60001, 1000002, 'Lisa', 'Moretti', '2007-04-15', '1979 Dorp St', '0852706763', '11', '2024-05-20 07:38:45'),
(3000019, 2000001, 60001, 1000002, 'Evelyn', 'Trentini', '2005-09-07', '747 Daffodil Dr', '0839718116', '12', '2024-05-20 07:38:45'),
(3000020, 2000001, 60001, 1000002, 'Vicky', 'Bianchi', '2004-12-18', '508 Willow St', '0824251916', '12', '2024-05-20 07:38:45'),
(3000021, 2000001, 60001, 1000002, 'Sharon', 'Romano', '2005-11-12', '238 Heuvel St', '0846858947', '12', '2024-05-20 07:38:45'),
(3000022, 2000001, 60001, 1000002, 'Freida', 'Padovesi', '2010-09-02', '238 Heuvel St', '0859164938', '8', '2024-05-20 07:38:45'),
(3000023, 2000001, 60001, 1000002, 'John', 'Palerma', '2005-06-16', '1812 Robertson Ave', '0835459795', '12', '2024-05-20 07:38:45'),
(3000024, 2000001, 60001, 1000002, 'Marc', 'Calabresi', '2006-07-30', '32 Prospect St', '0855264405', '12', '2024-05-20 07:38:45'),
(3000025, 2000001, 60001, 1000002, 'Janet', 'Manna', '2009-01-24', '1500 President St', '0834885450', '9', '2024-05-20 07:38:45'),
(3000026, 2000001, 60001, 1000002, 'Kathleen', 'Monaldo', '2007-12-12', '129 Zigzag Rd', '0841528631', '11', '2024-05-20 07:38:45'),
(3000027, 2000001, 60001, 1000002, 'Felipe', 'Siciliano', '2011-01-26', '2425 Mark Street', '0855557524', '8', '2024-05-20 07:38:45'),
(3000028, 2000001, 60001, 1000002, 'Adrianne', 'Napolitani', '2006-09-02', '1443 Bad St', '0834319526', '11', '2024-05-20 07:38:45'),
(3000029, 2000001, 60001, 1000002, 'Paul', 'Fallaci', '2011-11-01', '458 Impala St', '0857958923', '8', '2024-05-20 07:38:45'),
(3000030, 2000001, 60001, 1000002, 'John', 'Lo Duca', '2008-07-06', '1958 Bhoola Rd', '0858727444', '10', '2024-05-20 07:38:45'),
(3000031, 2000001, 60001, 1000002, 'Dawn', 'Iadanza', '2010-03-14', '444 Barlow Street', '0853841725', '8', '2024-05-20 07:38:45'),
(3000032, 2000001, 60001, 1000002, 'Willie', 'Ferrari', '2008-08-16', '593 Glyn St', '0839970010', '10', '2024-05-20 07:38:45'),
(3000033, 2000001, 60001, 1000002, 'Julie', 'Pisano', '2010-12-15', '1989 Mark Street', '0853925991', '10', '2024-05-20 07:38:45'),
(3000034, 2000001, 60001, 1000002, 'Donald', 'Colombo', '2005-10-18', '603 Impala St', '0842970383', '12', '2024-05-20 07:38:45'),
(3000035, 2000001, 60001, 1000002, 'Amy', 'Milani', '2009-03-14', '228 Kort St', '0843451927', '9', '2024-05-20 07:38:45'),
(3000036, 2000001, 60002, 1000002, 'Theresa', 'Romani', '2004-05-06', '827 Plein St', '0836114513', '12', '2024-05-20 07:38:45'),
(3000037, 2000001, 60002, 1000002, 'Elizabeth', 'Colombo', '2010-03-05', '130 Rus St', '0828030923', '8', '2024-05-20 07:38:45'),
(3000038, 2000001, 60002, 1000002, 'Jorge', 'Toscani', '2005-01-22', '1061 Telford Ave', '0846343401', '12', '2024-05-20 07:38:45'),
(3000039, 2000001, 60002, 1000002, 'Lisa', 'Udinese', '2004-06-07', '776 Marconi St', '0839444375', '12', '2024-05-20 07:38:45'),
(3000040, 2000001, 60002, 1000002, 'Glen', 'Palerma', '2006-07-12', '232 Rissik St', '0852257028', '11', '2024-05-20 07:38:45'),
(3000041, 2000001, 60002, 1000002, 'Kathleen', 'De Luca', '2006-10-24', '1973 Station Road', '0859042869', '11', '2024-05-20 07:38:45'),
(3000042, 2000001, 60002, 1000002, 'Robert', 'Cattaneo', '2006-11-12', '1572 Mark Street', '0836834661', '11', '2024-05-20 07:38:45'),
(3000043, 2000001, 60002, 1000002, 'Kevin', 'Cocci', '2010-10-10', '1146 Bezuidenhout St', '0826993388', '8', '2024-05-20 07:38:45'),
(3000044, 2000001, 60003, 1000002, 'Betty', 'Bellucci', '2007-11-10', '133 St. John Street', '0834642318', '11', '2024-05-20 07:38:45'),
(3000045, 2000001, 60003, 1000002, 'Eliza', 'Marchesi', '2003-06-13', '14 Bhoola Rd', '0824901217', '12', '2024-05-20 07:38:45'),
(3000046, 2000001, 60003, 1000002, 'Martha', 'Padovesi', '2006-02-02', '1724 Oost St', '0839475874', '11', '2024-05-20 07:38:45'),
(3000047, 2000001, 60003, 1000002, 'Martha', 'Padovesi', '2006-02-02', '1724 Oost St', '0839475874', '11', '2024-05-20 07:38:45'),
(3000048, 2000001, 60003, 1000002, 'Marco', 'Genovesi', '2008-11-02', '2409 Daffodil Dr', '0847098778', '10', '2024-05-20 07:38:45'),
(3000049, 2000001, 60003, 1000002, 'Mary', 'Cattaneo', '2007-02-07', '2143 Langley St', '0839398264', '11', '2024-05-20 07:38:45'),
(3000050, 2000001, 60003, 1000002, 'Brian', 'Udinesi', '2003-05-09', '1582 Prospect St', '0842251703', '12', '2024-05-20 07:38:45'),
(3000051, 2000001, 60003, 1000002, 'Marylin', 'Pisani', '2010-10-22', '785 Schoeman St', '0847086055', '8', '2024-05-20 07:38:45'),
(3000052, 2000001, 60003, 1000002, 'Janie', 'Toscani', '2007-03-17', '821 Oxford St', '0821140767', '11', '2024-05-20 07:38:45'),
(3000053, 2000001, 60003, 1000002, 'James', 'Iadanza', '2007-02-19', '1190 President St', '0831995142', '11', '2024-05-20 07:38:45'),
(3000054, 2000001, 60003, 1000002, 'Maria', 'Romani', '2006-02-19', '1235 Mark Street', '0825545372', '11', '2024-05-20 07:38:45');

-- --------------------------------------------------------

--
-- Table structure for table `parent`
--

CREATE TABLE `parent` (
  `parent_id` int(11) NOT NULL,
  `firstname` varchar(255) NOT NULL,
  `lastname` varchar(255) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(15) NOT NULL,
  `password` varchar(255) NOT NULL,
  `status` enum('active','inactive','pending','suspended','blocked') NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `parent`
--

INSERT INTO `parent` (`parent_id`, `firstname`, `lastname`, `email`, `phone`, `password`, `status`, `created_at`) VALUES
(2000001, 'Raffaello', 'Capon2', 'RaffaelloCapon@jourrapide.com', '0671231230', '$2y$10$LSeBrqXHor8Vo2Ya5XRnHeqKekgZZPaCcYNqNcv/muXAfCo39XFSa', 'active', '2024-07-29 19:03:45');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`admin_id`);

--
-- Indexes for table `learner`
--
ALTER TABLE `learner`
  ADD PRIMARY KEY (`learner_id`),
  ADD KEY `fk_parent` (`parent_id`);

--
-- Indexes for table `parent`
--
ALTER TABLE `parent`
  ADD PRIMARY KEY (`parent_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `parent`
--
ALTER TABLE `parent`
  MODIFY `parent_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2000003;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `learner`
--
ALTER TABLE `learner`
  ADD CONSTRAINT `fk_parent` FOREIGN KEY (`parent_id`) REFERENCES `parent` (`parent_id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
