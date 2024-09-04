-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 05, 2024 at 03:05 AM
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
-- Database: `bus_reg_system`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `admin_id` int(11) NOT NULL,
  `admin_initials` varchar(10) DEFAULT NULL,
  `admin_surname` varchar(100) DEFAULT NULL,
  `admin_email` varchar(100) DEFAULT NULL,
  `admin_phone` varchar(15) DEFAULT NULL,
  `admin_passcode` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`admin_id`, `admin_initials`, `admin_surname`, `admin_email`, `admin_phone`, `admin_passcode`, `created_at`) VALUES
(1000001, 'JD', 'Doe', 'jd.doe@example.com', '1112233445', '$2y$10$.b1S/Kal.0ALDKgrLc.dD.t6XQA//UBQFJQir0ksVEZ47OlPTOU06', '2024-07-31 19:20:31'),
(1000002, 'AS', 'Smith', 'as.smith@example.com', '1112233446', '$2y$10$.b1S/Kal.0ALDKgrLc.dD.t6XQA//UBQFJQir0ksVEZ47OlPTOU06', '2024-07-31 19:20:31'),
(1000003, 'LT', 'Brown', 'lt.brown@example.com', '1112233447', '$2y$10$.b1S/Kal.0ALDKgrLc.dD.t6XQA//UBQFJQir0ksVEZ47OlPTOU06', '2024-07-31 19:20:31');

-- --------------------------------------------------------

--
-- Table structure for table `busses`
--

CREATE TABLE `busses` (
  `bus_id` int(11) NOT NULL,
  `route_id` int(11) DEFAULT NULL,
  `learner_id` int(11) NOT NULL,
  `capacity` int(6) NOT NULL,
  `bus_spacestatus` enum('''available''','''absent''','','') DEFAULT NULL,
  `date` date NOT NULL DEFAULT current_timestamp(),
  `bus_time` time DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `busses`
--

INSERT INTO `busses` (`bus_id`, `route_id`, `learner_id`, `capacity`, `bus_spacestatus`, `date`, `bus_time`) VALUES
(60001, 3001, 3000001, 35, '\'available\'', '2024-08-04', '06:22:00'),
(60002, 3002, 3000002, 8, '\'available\'', '2024-08-04', '06:25:00'),
(60003, 3003, 3000003, 15, '\'available\'', '2024-08-04', '06:20:00'),
(60004, 3004, 3000004, 35, '\'available\'', '2024-08-04', '14:30:00'),
(60005, 3005, 3000005, 8, '\'available\'', '2024-08-04', '14:39:00'),
(60006, 3006, 3000006, 15, '\'available\'', '2024-08-04', '14:40:00');

-- --------------------------------------------------------

--
-- Table structure for table `bus_notifications`
--

CREATE TABLE `bus_notifications` (
  `id` int(11) NOT NULL,
  `bus_id` int(11) NOT NULL,
  `message` text NOT NULL,
  `date_sent` timestamp NOT NULL DEFAULT current_timestamp(),
  `status` enum('delayed','on_time','changed') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `bus_notifications`
--

INSERT INTO `bus_notifications` (`id`, `bus_id`, `message`, `date_sent`, `status`) VALUES
(1, 60001, 'The bus will be delayed by 15 minutes.', '2024-07-31 15:10:19', 'delayed'),
(2, 60002, 'The bus route has been changed.', '2024-07-31 15:10:19', 'changed'),
(3, 60003, 'The bus is on time.', '2024-07-31 15:10:19', 'on_time');

-- --------------------------------------------------------

--
-- Table structure for table `drop_off`
--

CREATE TABLE `drop_off` (
  `dropoff_no` int(11) NOT NULL,
  `dropoff_name` varchar(100) DEFAULT NULL,
  `dropoff_point` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `drop_off`
--

INSERT INTO `drop_off` (`dropoff_no`, `dropoff_name`, `dropoff_point`) VALUES
(1, 'Corner of Panorama and Marabou Road', '1A'),
(2, 'Corner of Kolgansstraat and Skimmerstraat', '1B'),
(3, 'Corner of Reddersburg Street and Mafeking Drive', '2A'),
(4, 'Corner of Theuns van Niekerkstraat and Roosmarynstraat', '2B'),
(5, 'Corner of Jasper Drive and Tieroog Street', '3A'),
(6, 'Corner of Louise Street and Von Willich Drive', '3B');

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
(3000004, 2000004, 60001, 1000002, 'Russell', 'Nucci', '2008-03-22', '707 Akasia St', '0826126014', '10', '2024-05-20 07:38:45'),
(3000005, 2000005, 60001, 1000002, 'Brenda', 'Giordano', '2006-06-20', '533 Heuvel St', '0833333490', '11', '2024-05-20 07:38:45'),
(3000006, 2000006, 60001, 1000002, 'Francis', 'Toscani', '2007-04-11', '639 Robertson Ave', '0827701832', '11', '2024-05-20 07:38:45'),
(3000007, 2000007, 60001, 1000002, 'Josefina', 'Rossi', '2010-03-08', '1123 Oranje St', '0827190801', '8', '2024-05-20 07:38:45'),
(3000008, 2000008, 60001, 1000002, 'Stephen', 'Mazzanti', '2004-11-10', '671 Gemsbok St', '0848680322', '12', '2024-05-20 07:38:45'),
(3000009, 2000009, 60001, 1000002, 'Erin', 'Siciliano', '2004-12-11', '2179 Telford Ave', '0855210206', '12', '2024-05-20 07:38:45'),
(3000010, 2000010, 60001, 1000002, 'Billie', 'Colombo', '2010-06-05', '142 Nelson Mandela Drive', '0847280809', '8', '2024-05-20 07:38:45'),
(3000011, 2000011, 60001, 1000002, 'Frank', 'Bergamaschi', '2003-11-18', '894 Gray Pl', '0853309605', '12', '2024-05-20 07:38:45'),
(3000012, 2000012, 60001, 1000002, 'Weston', 'Schiavone', '2004-03-17', '22 Robertson Ave', '0832507231', '12', '2024-05-20 07:38:45'),
(3000013, 2000001, 60001, 1000002, 'Mary', 'Calabrese', '2004-09-29', '1850 Church St', '0842549458', '12', '2024-05-20 07:38:45'),
(3000014, 2000014, 60001, 1000002, 'Teresa', 'Iadanza', '2004-05-27', '1907 Schoeman St', '0821405192', '12', '2024-05-20 07:38:45'),
(3000015, 2000015, 60001, 1000002, 'Virginia', 'Davide', '2006-06-03', '678 Gemsbok St', '0834067279', '11', '2024-05-20 07:38:45'),
(3000016, 2000016, 60001, 1000002, 'Misty', 'Buccho', '2007-03-28', '1500 Hoog St', '0836798051', '11', '2024-05-20 07:38:45'),
(3000017, 2000017, 60001, 1000002, 'Lana', 'Sagese', '2006-06-07', '34 Mosman Rd', '0851477732', '11', '2024-05-20 07:38:45'),
(3000018, 2000018, 60001, 1000002, 'Lisa', 'Moretti', '2007-04-15', '1979 Dorp St', '0852706763', '11', '2024-05-20 07:38:45'),
(3000019, 2000019, 60001, 1000002, 'Evelyn', 'Trentini', '2005-09-07', '747 Daffodil Dr', '0839718116', '12', '2024-05-20 07:38:45'),
(3000020, 2000020, 60001, 1000002, 'Vicky', 'Bianchi', '2004-12-18', '508 Willow St', '0824251916', '12', '2024-05-20 07:38:45'),
(3000021, 2000021, 60001, 1000002, 'Sharon', 'Romano', '2005-11-12', '238 Heuvel St', '0846858947', '12', '2024-05-20 07:38:45'),
(3000022, 2000022, 60001, 1000002, 'Freida', 'Padovesi', '2010-09-02', '238 Heuvel St', '0859164938', '8', '2024-05-20 07:38:45'),
(3000023, 2000023, 60001, 1000002, 'John', 'Palerma', '2005-06-16', '1812 Robertson Ave', '0835459795', '12', '2024-05-20 07:38:45'),
(3000024, 2000024, 60001, 1000002, 'Marc', 'Calabresi', '2006-07-30', '32 Prospect St', '0855264405', '12', '2024-05-20 07:38:45'),
(3000025, 2000025, 60001, 1000002, 'Janet', 'Manna', '2009-01-24', '1500 President St', '0834885450', '9', '2024-05-20 07:38:45'),
(3000026, 2000026, 60001, 1000002, 'Kathleen', 'Monaldo', '2007-12-12', '129 Zigzag Rd', '0841528631', '11', '2024-05-20 07:38:45'),
(3000027, 2000027, 60001, 1000002, 'Felipe', 'Siciliano', '2011-01-26', '2425 Mark Street', '0855557524', '8', '2024-05-20 07:38:45'),
(3000028, 2000028, 60001, 1000002, 'Adrianne', 'Napolitani', '2006-09-02', '1443 Bad St', '0834319526', '11', '2024-05-20 07:38:45'),
(3000029, 2000029, 60001, 1000002, 'Paul', 'Fallaci', '2011-11-01', '458 Impala St', '0857958923', '8', '2024-05-20 07:38:45'),
(3000030, 2000030, 60001, 1000002, 'John', 'Lo Duca', '2008-07-06', '1958 Bhoola Rd', '0858727444', '10', '2024-05-20 07:38:45'),
(3000031, 2000031, 60001, 1000002, 'Dawn', 'Iadanza', '2010-03-14', '444 Barlow Street', '0853841725', '8', '2024-05-20 07:38:45'),
(3000032, 2000032, 60001, 1000002, 'Willie', 'Ferrari', '2008-08-16', '593 Glyn St', '0839970010', '10', '2024-05-20 07:38:45'),
(3000033, 2000033, 60001, 1000002, 'Julie', 'Pisano', '2010-12-15', '1989 Mark Street', '0853925991', '10', '2024-05-20 07:38:45'),
(3000034, 2000034, 60001, 1000002, 'Donald', 'Colombo', '2005-10-18', '603 Impala St', '0842970383', '12', '2024-05-20 07:38:45'),
(3000035, 2000035, 60001, 1000002, 'Amy', 'Milani', '2009-03-14', '228 Kort St', '0843451927', '9', '2024-05-20 07:38:45'),
(3000036, 2000036, 60002, 1000002, 'Theresa', 'Romani', '2004-05-06', '827 Plein St', '0836114513', '12', '2024-05-20 07:38:45'),
(3000037, 2000037, 60002, 1000002, 'Elizabeth', 'Colombo', '2010-03-05', '130 Rus St', '0828030923', '8', '2024-05-20 07:38:45'),
(3000038, 2000038, 60002, 1000002, 'Jorge', 'Toscani', '2005-01-22', '1061 Telford Ave', '0846343401', '12', '2024-05-20 07:38:45'),
(3000039, 2000039, 60002, 1000002, 'Lisa', 'Udinese', '2004-06-07', '776 Marconi St', '0839444375', '12', '2024-05-20 07:38:45'),
(3000040, 2000040, 60002, 1000002, 'Glen', 'Palerma', '2006-07-12', '232 Rissik St', '0852257028', '11', '2024-05-20 07:38:45'),
(3000041, 2000041, 60002, 1000002, 'Kathleen', 'De Luca', '2006-10-24', '1973 Station Road', '0859042869', '11', '2024-05-20 07:38:45'),
(3000042, 2000042, 60002, 1000002, 'Robert', 'Cattaneo', '2006-11-12', '1572 Mark Street', '0836834661', '11', '2024-05-20 07:38:45'),
(3000043, 2000043, 60002, 1000002, 'Kevin', 'Cocci', '2010-10-10', '1146 Bezuidenhout St', '0826993388', '8', '2024-05-20 07:38:45'),
(3000044, 2000044, 60003, 1000002, 'Betty', 'Bellucci', '2007-11-10', '133 St. John Street', '0834642318', '11', '2024-05-20 07:38:45'),
(3000045, 2000045, 60003, 1000002, 'Eliza', 'Marchesi', '2003-06-13', '14 Bhoola Rd', '0824901217', '12', '2024-05-20 07:38:45'),
(3000046, 2000046, 60003, 1000002, 'Martha', 'Padovesi', '2006-02-02', '1724 Oost St', '0839475874', '11', '2024-05-20 07:38:45'),
(3000047, 2000047, 60003, 1000002, 'Martha', 'Padovesi', '2006-02-02', '1724 Oost St', '0839475874', '11', '2024-05-20 07:38:45'),
(3000048, 2000048, 60003, 1000002, 'Marco', 'Genovesi', '2008-11-02', '2409 Daffodil Dr', '0847098778', '10', '2024-05-20 07:38:45'),
(3000049, 2000049, 60003, 1000002, 'Mary', 'Cattaneo', '2007-02-07', '2143 Langley St', '0839398264', '11', '2024-05-20 07:38:45'),
(3000050, 2000050, 60003, 1000002, 'Brian', 'Udinesi', '2003-05-09', '1582 Prospect St', '0842251703', '12', '2024-05-20 07:38:45'),
(3000051, 2000051, 60003, 1000002, 'Marylin', 'Pisani', '2010-10-22', '785 Schoeman St', '0847086055', '8', '2024-05-20 07:38:45'),
(3000052, 2000052, 60003, 1000002, 'Janie', 'Toscani', '2007-03-17', '821 Oxford St', '0821140767', '11', '2024-05-20 07:38:45'),
(3000053, 2000053, 60003, 1000002, 'James', 'Iadanza', '2007-02-19', '1190 President St', '0831995142', '11', '2024-05-20 07:38:45'),
(3000054, 2000054, 60003, 1000002, 'Maria', 'Romani', '2006-02-19', '1235 Mark Street', '0825545372', '11', '2024-05-20 07:38:45'),
(3000055, 2000055, 60003, 1000002, 'Andile', 'Buccho', '2006-05-08', '11 President Street Germiston 1401', '0789219963', '12', '2024-08-03 05:37:39'),
(3000056, 2000056, 60003, 1000002, 'Shle', 'Buccho', '2009-02-08', '11 President Street Germiston 1401', '0841238953', '9', '2024-08-03 05:38:36'),
(3000057, 2000057, 60003, 1000002, 'Andile', 'MAHLAOLE', '2006-05-26', '11 President Street Germiston 1401', '0789219963', '10', '2024-08-03 05:40:03'),
(3000058, 2000058, 60003, 1000002, 'Mendy', 'Palerma', '2009-12-30', '13Presidentstain Street Alberton', '0846543564', '10', '2024-08-03 05:41:59');

-- --------------------------------------------------------

--
-- Table structure for table `parent`
--

CREATE TABLE `parent` (
  `parent_id` int(11) NOT NULL,
  `parent_name` varchar(255) NOT NULL,
  `parent_surname` varchar(255) NOT NULL,
  `parent_email` varchar(100) NOT NULL,
  `parent_cellno` varchar(15) NOT NULL,
  `parent_passcode` varchar(255) NOT NULL,
  `status` enum('active','suspended','inactive','pending','') NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `parent`
--

INSERT INTO `parent` (`parent_id`, `parent_name`, `parent_surname`, `parent_email`, `parent_cellno`, `parent_passcode`, `status`, `created_at`) VALUES
(1, 'KATLEGO', 'MAHLAOLE', 'ArmandoArcuri@jourrapide.com', '2000064', '$2y$10$R7SdHFkW4LEm/9v8OkmAx.m2cQM7FvqzfnQxCPqGfwV5OHLAZPPgS', '', '2024-07-22 14:54:53'),
(2000001, 'Zoey', 'Que', 'khanyibu86@gmail.com', '0838932816', '$2y$10$AI1yRJ2qnij4sx9JvI48k.Qnw7EK0Cb/eezQ2NDvbXGfv9aHiR3CK', '', '2024-07-22 15:07:24'),
(2000002, 'Delfina', 'Milano', 'DelfinaMilano@rhyta.com', '0853932545', 'beeCexee4yoo', '', '2024-05-20 02:40:46'),
(2000003, 'Carla', 'Calabrese', 'CarlaCalabrese@dayrep.com', '0854386318', 'pae4eej5aG', '', '2024-05-20 02:40:46'),
(2000004, 'Editta', 'Nucci', 'EdittaNucci@superrito.com', '0839050267', 'eimohsh0ooC', '', '2024-05-20 02:40:46'),
(2000005, 'Alfonsa', 'Giordano', 'AlfonsaGiordano@teleworm.us', '0827728367', 'Ci1wa5die', '', '2024-05-20 02:40:46'),
(2000006, 'Benedetta', 'Toscani', 'BenedettaToscani@fleckens.hu', '0838625382', 'ufeiBu3oo', '', '2024-05-20 02:40:46'),
(2000007, 'Gianna', 'Rossi', 'GiannaRossi@rhyta.com', '0859941184', 'HohCu7Loh', '', '2024-05-20 02:40:46'),
(2000008, 'Luigina', 'Mazzanti', 'LuiginaMazzanti@rhyta.com', '0851186345', 'Sheisaiz0ei', '', '2024-05-20 02:40:46'),
(2000009, 'Ortensia', 'Siciliano', 'OrtensiaSiciliano@teleworm.us', '0837516963', 'AiGhahch5', '', '2024-05-20 02:40:46'),
(2000010, 'Pantaleone', 'Colombo', 'PantaleoneColombo@jourrapide.com', '0837838296', 'Quahd0aing', '', '2024-05-20 02:40:46'),
(2000011, 'Camilla', 'Bergamaschi', 'CamillaBergamaschi@einrot.com', '0846622247', 'ootheo7ooD', '', '2024-05-20 02:40:46'),
(2000012, 'Nella', 'Schiavone', 'NellaSchiavone@cuvox.de', '0857405755', 'feem7Eiz', '', '2024-05-20 02:40:46'),
(2000013, 'Tiziano', 'Calabrese', 'TizianoCalabrese@fleckens.hu', '0844304179', 'taebe1Xei', '', '2024-05-20 02:40:46'),
(2000014, 'Alfonsa', 'Iadanza', 'AlfonsaIadanza@jourrapide.com', '0838967759', 'aiSa3Boosh1', '', '2024-05-20 02:40:46'),
(2000015, 'Andrea', 'Davide', 'AndreaDavide@jourrapide.com', '0828334560', 'thoo7eeS', '', '2024-05-20 02:40:46'),
(2000016, 'Ester', 'Buccho', 'EsterBuccho@armyspy.com', '0848575616', 'fu4guChoo', '', '2024-05-20 02:40:46'),
(2000017, 'Edoardo', 'Sagese', 'EdoardoSagese@rhyta.com', '0853690476', 'Ohbaungae9oo', '', '2024-05-20 02:40:46'),
(2000018, 'Filiberto', 'Moretti', 'FilibertoMoretti@fleckens.hu', '0822326313', 'ailoo7ahZ', '', '2024-05-20 02:40:46'),
(2000019, 'Ines', 'Trentini', 'InesTrentini@armyspy.com', '0855116828', 'cexooH1Hoh', '', '2024-05-20 02:40:46'),
(2000020, 'Marina', 'Bianchi', 'MarinaBianchi@dayrep.com', '0858197289', 'ePhephoo3', '', '2024-05-20 02:40:46'),
(2000021, 'Fiamma', 'Romano', 'FiammaRomano@gustr.com', '0835053239', 'eb0aiMai', '', '2024-05-20 02:40:46'),
(2000022, 'Andrea', 'Padovesi', 'AndreaPadovesi@dayrep.com', '0859282378', 'Shool8zeem', '', '2024-05-20 02:40:46'),
(2000023, 'Violetta', 'Palerma', 'ViolettaPalerma@dayrep.com', '0827989493', 'AiShohoh6sh', '', '2024-05-20 02:40:46'),
(2000024, 'Alfio', 'Calabresi', 'AlfioCalabresi@armyspy.com', '0848546404', 'rua8maiQua5', '', '2024-05-20 02:40:46'),
(2000025, 'Geronima', 'Manna', 'GeronimaManna@teleworm.us', '0847704000', 'ohV2joengou4', '', '2024-05-20 02:40:46'),
(2000026, 'Corinna', 'Monaldo', 'CorinnaMonaldo@armyspy.com', '0834501435', 'edahY4eg', '', '2024-05-20 02:40:46'),
(2000027, 'Battista', 'Siciliano', 'BattistaSiciliano@cuvox.de', '0831464995', 'Tohl4wev4', '', '2024-05-20 02:40:46'),
(2000028, 'Fantino', 'Napolitani', 'FantinoNapolitani@cuvox.de', '0841389935', 'aetigh0Aivae', '', '2024-05-20 02:40:46'),
(2000029, 'Emanuela', 'Fallaci', 'EmanuelaFallaci@teleworm.us', '0857576710', 'Zoe4keis1ee', '', '2024-05-20 02:40:46'),
(2000030, 'Arturo', 'Lo Duca', 'ArturoLoDuca@jourrapide.com', '0858951745', 'yai4ahPee', '', '2024-05-20 02:40:46'),
(2000031, 'Tiziana', 'Iadanza', 'TizianaIadanza@fleckens.hu', '0822364013', 'iucheiW9ah', '', '2024-05-20 02:40:46'),
(2000032, 'Taziana', 'Ferrari', 'TazianaFerrari@einrot.com', '0853940017', 'IecohW5d', '', '2024-05-20 02:40:46'),
(2000033, 'Santina', 'Pisano', 'SantinaPisano@fleckens.hu', '0831898228', 'aedaeR6o', '', '2024-05-20 02:40:46'),
(2000034, 'Aurelia', 'Colombo', 'AureliaColombo@rhyta.com', '0846892352', 'Aipa7kahn3', '', '2024-05-20 02:40:46'),
(2000035, 'Vera', 'Milani', 'VeraMilani@gustr.com', '0857739848', 'aiF9uYeigh', '', '2024-05-20 02:40:46'),
(2000036, 'Elda', 'Romani', 'EldaRomani@rhyta.com', '0829908994', 'Cae6eev0aop', '', '2024-05-20 02:40:46'),
(2000037, 'Virgilia', 'Colombo', 'VirgiliaColombo@armyspy.com', '0851027918', 'vei7dueC5eu', '', '2024-05-20 02:40:46'),
(2000038, 'Nunzia', 'Toscani', 'NunziaToscani@teleworm.us', '0841085158', 'Ohqu3ve7ai', '', '2024-05-20 02:40:46'),
(2000039, 'Debora', 'Udinese', 'DeboraUdinese@gustr.com', '0848974472', 'dae1meiCh', '', '2024-05-20 02:40:46'),
(2000040, 'Mariano', 'Palerma', 'MarianoPalerma@teleworm.us', '0859706688', 'shie0ohChei', '', '2024-05-20 02:40:46'),
(2000041, 'Fausto', 'De Luca', 'FaustoDeLuca@superrito.com', '0855376399', 'ooZ7aeCh7gu', '', '2024-05-20 02:40:46'),
(2000042, 'Eugenia', 'Cattaneo', 'EugeniaCattaneo@rhyta.com', '0825460604', 'Joz8aehoh', '', '2024-05-20 02:40:46'),
(2000043, 'Alide', 'Cocci', 'AlideCocci@rhyta.com', '0859205781', 'aequ6bai1Ei', '', '2024-05-20 02:40:46'),
(2000044, 'Geronima', 'Bellucci', 'GeronimaBellucci@armyspy.com', '0838668346', 'haebai6H', '', '2024-05-20 02:40:46'),
(2000045, 'Iacopo', 'Marchesi', 'IacopoMarchesi@gustr.com', '0833458656', 'johai9Ku3ah', '', '2024-05-20 02:40:46'),
(2000046, 'Loredana', 'Padovesi', 'LoredanaPadovesi@einrot.com', '0831606193', 'Beu3eeNg', '', '2024-05-20 02:40:46'),
(2000047, 'Cornelio', 'Genovesi', 'CornelioGenovesi@jourrapide.com', '0854428285', 'aiXoowie4ki', '', '2024-05-20 02:40:46'),
(2000048, 'Gilda', 'Cattaneo', 'GildaCattaneo@dayrep.com', '0821686604', 'Quahghu6j', '', '2024-05-20 02:40:46'),
(2000049, 'Lorenzo', 'Udinesi', 'LorenzoUdinesi@rhyta.com', '0836732833', 'meG8uphie0v', '', '2024-05-20 02:40:46'),
(2000050, 'Ileana', 'Pisani', 'IleanaPisani@dayrep.com', '0833803686', 'sohTeekoh2', '', '2024-05-20 02:40:46'),
(2000051, 'Adelaide', 'Toscani', 'AdelaideToscani@cuvox.de', '0858478931', 'Ex8teaY9', '', '2024-05-20 02:40:46'),
(2000052, 'Nadia', 'Iadanza', 'NadiaIadanza@gustr.com', '0839158643', 'phaim3aShoo', '', '2024-05-20 02:40:46'),
(2000053, 'Dorotea', 'Mazzi', 'DoroteaMazzi@rhyta.com', '0842941924', 'bae4aaT9vov', '', '2024-05-20 02:40:46'),
(2000054, 'Elvia', 'Rossi', 'ElviaRossi@superrito.com', '0858052745', 'bevuu5OguBoo', '', '2024-05-20 02:40:46'),
(2000055, 'Emanuela', 'Lorenzo', 'EmanuelaLorenzo@armyspy.com', '0824870596', 'aaw6Ohcha6j', '', '2024-05-20 02:40:46'),
(2000056, 'Oberto', 'Palerma', 'ObertoPalerma@armyspy.com', '0823130522', 'iet4goxaeHo', '', '2024-05-20 02:40:46'),
(2000057, 'Tranquillina', 'Zetticci', 'TranquillinaZetticci@superrito.com', '0822699469', 'Wiehieth9em', '', '2024-05-20 02:40:46'),
(2000058, 'Veronica', 'Baresi', 'VeronicaBaresi@einrot.com', '0827042091', 'iNge9laaqu3', '', '2024-05-20 02:40:46'),
(2000059, 'Lioba', 'Fiorentini', 'LiobaFiorentini@gustr.com', '0837964354', 'Ach7aenoh', '', '2024-05-20 02:40:46'),
(2000060, 'Sebastiano', 'Buccho', 'RaffaelloCapon@jourrapide.com', '0852926036', '$2y$10$.b1S/Kal.0ALDKgrLc.dD.t6XQA//UBQFJQir0ksVEZ47OlPTOU06', 'active', '2024-08-02 06:22:16'),
(2000061, 'John', 'Doe', 'john.doe@example.com', '0834556789', 'password123', '', '2024-08-02 05:46:57'),
(2000062, 'Jane', 'Smith', 'jane.smith@example.com', '0812345678', 'password456', '', '2024-08-02 05:54:46'),
(2000063, 'Quinzio', 'Cremonesi', 'Kpmahlaole@gmail.com', '0712367894', '$2y$10$UExGsart7H2Zb5lcMO6qdu6yNrSy57uR4aCVuCB5sDH8uopOpEeFa', '', '2024-08-02 05:55:38'),
(2000064, 'Alberto', 'Siciliano', 'unclekatz@programmer.net', '0612345687', '$2y$10$S9Y1rXz0X0Y/ENFwNWlNnuRqxghdDK5YMs5QklWB5uKUXsBlpfPLy', '', '2024-08-02 05:56:18');

-- --------------------------------------------------------

--
-- Table structure for table `pick_up`
--

CREATE TABLE `pick_up` (
  `pickup_no` int(11) NOT NULL,
  `pickup_name` varchar(100) DEFAULT NULL,
  `pickup_point` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pick_up`
--

INSERT INTO `pick_up` (`pickup_no`, `pickup_name`, `pickup_point`) VALUES
(1, 'Corner of Panorama and Marabou Road', '1A'),
(2, 'Corner of Kolgansstraat and Skimmerstraat', '1B'),
(3, 'Corner of Reddersburg Street and Mafeking Drive', '2A'),
(4, 'Corner of Theuns van Niekerkstraat and Roosmarynstraat', '2B'),
(5, 'Corner of Jasper Drive and Tieroog Street', '3A'),
(6, 'Corner of Louise Street and Von Willich Drive', '3B');

-- --------------------------------------------------------

--
-- Table structure for table `registrations`
--

CREATE TABLE `registrations` (
  `bus_reg_no` int(11) NOT NULL,
  `parent_id` int(11) NOT NULL,
  `route_id` int(11) NOT NULL,
  `stop_id` int(11) DEFAULT NULL,
  `registration_date` date NOT NULL DEFAULT current_timestamp(),
  `status` enum('''approved''','''pending''','''rejected''','') NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `registrations`
--

INSERT INTO `registrations` (`bus_reg_no`, `parent_id`, `route_id`, `stop_id`, `registration_date`, `status`, `created_at`) VALUES
(2400001, 2000001, 3001, 1, '2024-08-04', '\'approved\'', '2024-08-04 06:00:35'),
(2400002, 2000002, 3002, 2, '2024-08-04', '\'approved\'', '2024-08-04 06:00:50'),
(2400003, 2000003, 3003, 3, '2024-08-04', '\'approved\'', '2024-08-04 06:01:00');

-- --------------------------------------------------------

--
-- Table structure for table `routes`
--

CREATE TABLE `routes` (
  `route_id` int(11) NOT NULL,
  `pickup_no` int(11) DEFAULT NULL,
  `dropoff_no` int(11) DEFAULT NULL,
  `route_times` time DEFAULT NULL,
  `route_destination` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `routes`
--

INSERT INTO `routes` (`route_id`, `pickup_no`, `dropoff_no`, `route_times`, `route_destination`) VALUES
(3001, 1, 1, '06:22:00', 'Rooihuiskraal'),
(3002, 2, 2, '06:30:00', 'Rooihuiskraal'),
(3003, 3, 3, '06:40:00', 'Centurion'),
(3004, 4, 4, '06:25:00', 'Wierdapark'),
(3005, 5, 5, '06:35:00', 'Wierdapark'),
(3006, 6, 6, '06:20:00', 'Centurion');

-- --------------------------------------------------------

--
-- Table structure for table `stops`
--

CREATE TABLE `stops` (
  `stop_id` int(11) NOT NULL,
  `route_id` int(11) NOT NULL,
  `stop_name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `stops`
--

INSERT INTO `stops` (`stop_id`, `route_id`, `stop_name`) VALUES
(1, 3001, 'Corner of Panorama and Marabou Road'),
(2, 3002, 'Corner of Reddersburg Street and Mafeking Drive'),
(3, 3003, 'Corner of Jasper Drive and Tieroog Street');

-- --------------------------------------------------------

--
-- Table structure for table `student_app`
--

CREATE TABLE `student_app` (
  `app_no` int(11) NOT NULL,
  `learner_id` int(11) DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `status` enum('''approve''','''pending''','','') DEFAULT NULL,
  `app_date` date NOT NULL DEFAULT current_timestamp(),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `student_app`
--

INSERT INTO `student_app` (`app_no`, `learner_id`, `parent_id`, `status`, `app_date`, `created_at`) VALUES
(240001, 3000048, 2000003, '\'approve\'', '2024-08-04', '2024-08-04 15:38:24'),
(240002, 3000046, 2000003, '\'approve\'', '2024-08-04', '2024-08-04 15:38:40'),
(240003, 3000011, 2000002, '\'approve\'', '2024-08-04', '2024-08-04 15:39:03'),
(240004, 3000012, 2000012, '\'approve\'', '2024-08-04', '2024-08-04 15:39:28'),
(240005, 3000014, 2000010, '\'approve\'', '2024-08-04', '2024-08-04 15:39:47'),
(240006, 3000015, 2000010, '\'approve\'', '2024-08-04', '2024-08-04 15:40:09'),
(240007, 3000016, 2000012, '\'approve\'', '2024-08-04', '2024-08-04 15:40:34'),
(240008, 3000017, 2000012, '\'approve\'', '2024-08-04', '2024-08-04 15:40:55');

-- --------------------------------------------------------

--
-- Table structure for table `waiting_list`
--

CREATE TABLE `waiting_list` (
  `waitinglist_no` int(11) NOT NULL,
  `learner_id` int(11) DEFAULT NULL,
  `admin_id` int(11) DEFAULT NULL,
  `learner_name` varchar(100) DEFAULT NULL,
  `learner_phone` varchar(100) DEFAULT NULL,
  `waitinglist_group` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `waiting_list`
--

INSERT INTO `waiting_list` (`waitinglist_no`, `learner_id`, `admin_id`, `learner_name`, `learner_phone`, `waitinglist_group`) VALUES
(2400001, 3000005, 1000002, 'Brenda', '0833333490', 'a'),
(2400002, 3000025, 1000002, 'Janet', '0834885450', 'b'),
(2400003, 3000007, 1000002, 'Josefina', '0827190801', 'b'),
(2400004, 3000009, 1000002, 'Erin', '0855210206', 'c'),
(2400005, 3000051, 1000002, 'Marylin', '0847086055', 'c'),
(2400006, 3000052, 1000002, 'Janie', '0821140767', 'c'),
(2400007, 3000053, 1000002, 'James', '0831995142', 'a'),
(2400008, 3000054, 1000002, 'Maria', '0825545372', 'a'),
(2400009, 3000055, 1000002, 'Andile', '0789219963', 'a'),
(2400010, 3000056, 1000002, 'Shle', '0841238953', 'a'),
(2400011, 3000057, 1000002, 'Andile', '0789219963', 'c'),
(2400012, 3000058, 1000002, 'Mendy', '0846543564', 'b');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`admin_id`),
  ADD UNIQUE KEY `admin_email` (`admin_email`);

--
-- Indexes for table `busses`
--
ALTER TABLE `busses`
  ADD PRIMARY KEY (`bus_id`),
  ADD KEY `idx_bus_route` (`route_id`),
  ADD KEY `fk_busses_learner` (`learner_id`);

--
-- Indexes for table `bus_notifications`
--
ALTER TABLE `bus_notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_bus_notifications_bus` (`bus_id`);

--
-- Indexes for table `drop_off`
--
ALTER TABLE `drop_off`
  ADD PRIMARY KEY (`dropoff_no`);

--
-- Indexes for table `learner`
--
ALTER TABLE `learner`
  ADD PRIMARY KEY (`learner_id`),
  ADD KEY `idx_learner_bus` (`bus_id`),
  ADD KEY `idx_learner_admin` (`admin_id`),
  ADD KEY `idx_learner_parent` (`parent_id`);

--
-- Indexes for table `parent`
--
ALTER TABLE `parent`
  ADD PRIMARY KEY (`parent_id`),
  ADD UNIQUE KEY `parent_email` (`parent_email`);

--
-- Indexes for table `pick_up`
--
ALTER TABLE `pick_up`
  ADD PRIMARY KEY (`pickup_no`);

--
-- Indexes for table `registrations`
--
ALTER TABLE `registrations`
  ADD PRIMARY KEY (`bus_reg_no`),
  ADD KEY `parent_id` (`parent_id`),
  ADD KEY `route_id` (`route_id`),
  ADD KEY `fk_stop_id` (`stop_id`);

--
-- Indexes for table `routes`
--
ALTER TABLE `routes`
  ADD PRIMARY KEY (`route_id`),
  ADD KEY `fk_routes_pickup` (`pickup_no`),
  ADD KEY `fk_routes_dropoff` (`dropoff_no`);

--
-- Indexes for table `stops`
--
ALTER TABLE `stops`
  ADD PRIMARY KEY (`stop_id`),
  ADD KEY `route_id` (`route_id`);

--
-- Indexes for table `student_app`
--
ALTER TABLE `student_app`
  ADD PRIMARY KEY (`app_no`),
  ADD KEY `idx_student_app_learner` (`learner_id`),
  ADD KEY `idx_student_app_parent` (`parent_id`);

--
-- Indexes for table `waiting_list`
--
ALTER TABLE `waiting_list`
  ADD PRIMARY KEY (`waitinglist_no`),
  ADD KEY `idx_waiting_list_learner` (`learner_id`),
  ADD KEY `idx_waiting_list_admin` (`admin_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `admin_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1000004;

--
-- AUTO_INCREMENT for table `busses`
--
ALTER TABLE `busses`
  MODIFY `bus_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=60007;

--
-- AUTO_INCREMENT for table `bus_notifications`
--
ALTER TABLE `bus_notifications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `drop_off`
--
ALTER TABLE `drop_off`
  MODIFY `dropoff_no` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `learner`
--
ALTER TABLE `learner`
  MODIFY `learner_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3000069;

--
-- AUTO_INCREMENT for table `parent`
--
ALTER TABLE `parent`
  MODIFY `parent_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2000066;

--
-- AUTO_INCREMENT for table `registrations`
--
ALTER TABLE `registrations`
  MODIFY `bus_reg_no` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2400004;

--
-- AUTO_INCREMENT for table `routes`
--
ALTER TABLE `routes`
  MODIFY `route_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3007;

--
-- AUTO_INCREMENT for table `stops`
--
ALTER TABLE `stops`
  MODIFY `stop_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `student_app`
--
ALTER TABLE `student_app`
  MODIFY `app_no` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=240009;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `busses`
--
ALTER TABLE `busses`
  ADD CONSTRAINT `busses_ibfk_1` FOREIGN KEY (`learner_id`) REFERENCES `learner` (`learner_id`);

--
-- Constraints for table `bus_notifications`
--
ALTER TABLE `bus_notifications`
  ADD CONSTRAINT `fk_bus_notifications_bus` FOREIGN KEY (`bus_id`) REFERENCES `busses` (`bus_id`);

--
-- Constraints for table `learner`
--
ALTER TABLE `learner`
  ADD CONSTRAINT `fk_learner_admin` FOREIGN KEY (`admin_id`) REFERENCES `admin` (`admin_id`),
  ADD CONSTRAINT `fk_learner_bus` FOREIGN KEY (`bus_id`) REFERENCES `busses` (`bus_id`),
  ADD CONSTRAINT `fk_learner_parent` FOREIGN KEY (`parent_id`) REFERENCES `parent` (`parent_id`);

--
-- Constraints for table `registrations`
--
ALTER TABLE `registrations`
  ADD CONSTRAINT `registrations_ibfk_1` FOREIGN KEY (`parent_id`) REFERENCES `parent` (`parent_id`),
  ADD CONSTRAINT `registrations_ibfk_2` FOREIGN KEY (`stop_id`) REFERENCES `stops` (`stop_id`),
  ADD CONSTRAINT `registrations_ibfk_3` FOREIGN KEY (`route_id`) REFERENCES `routes` (`route_id`);

--
-- Constraints for table `routes`
--
ALTER TABLE `routes`
  ADD CONSTRAINT `routes_ibfk_1` FOREIGN KEY (`pickup_no`) REFERENCES `pick_up` (`pickup_no`),
  ADD CONSTRAINT `routes_ibfk_2` FOREIGN KEY (`dropoff_no`) REFERENCES `drop_off` (`dropoff_no`);

--
-- Constraints for table `stops`
--
ALTER TABLE `stops`
  ADD CONSTRAINT `stops_ibfk_1` FOREIGN KEY (`route_id`) REFERENCES `routes` (`route_id`);

--
-- Constraints for table `student_app`
--
ALTER TABLE `student_app`
  ADD CONSTRAINT `fk_student_app_learner` FOREIGN KEY (`learner_id`) REFERENCES `learner` (`learner_id`),
  ADD CONSTRAINT `fk_student_app_parent` FOREIGN KEY (`parent_id`) REFERENCES `parent` (`parent_id`);

--
-- Constraints for table `waiting_list`
--
ALTER TABLE `waiting_list`
  ADD CONSTRAINT `fk_waiting_list_admin` FOREIGN KEY (`admin_id`) REFERENCES `admin` (`admin_id`),
  ADD CONSTRAINT `fk_waiting_list_learner` FOREIGN KEY (`learner_id`) REFERENCES `learner` (`learner_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
