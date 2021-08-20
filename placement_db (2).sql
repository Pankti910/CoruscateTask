-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 20, 2021 at 09:08 PM
-- Server version: 10.4.20-MariaDB
-- PHP Version: 8.0.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `placement_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `role`
--

CREATE TABLE `role` (
  `roleId` int(11) NOT NULL,
  `rolename` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `role`
--

INSERT INTO `role` (`roleId`, `rolename`) VALUES
(1, 'Student'),
(2, 'Recruiter');

-- --------------------------------------------------------

--
-- Table structure for table `slot_book`
--

CREATE TABLE `slot_book` (
  `id` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `date` date NOT NULL,
  `status` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `slot_book`
--

INSERT INTO `slot_book` (`id`, `userId`, `date`, `status`) VALUES
(10, 3, '2021-08-23', 0),
(11, 1, '2021-09-01', 0);

-- --------------------------------------------------------

--
-- Table structure for table `userlogin`
--

CREATE TABLE `userlogin` (
  `userId` int(11) NOT NULL,
  `username` varchar(30) NOT NULL,
  `password` varchar(30) NOT NULL,
  `roleId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `userlogin`
--

INSERT INTO `userlogin` (`userId`, `username`, `password`, `roleId`) VALUES
(1, 'pankti', '123', 1),
(2, 'riya', 'riya', 2),
(3, 'veer', 'veer', 1),
(4, 'kashish', 'kashish', 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `role`
--
ALTER TABLE `role`
  ADD PRIMARY KEY (`roleId`);

--
-- Indexes for table `slot_book`
--
ALTER TABLE `slot_book`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `userId_2` (`userId`),
  ADD KEY `userid` (`userId`);

--
-- Indexes for table `userlogin`
--
ALTER TABLE `userlogin`
  ADD PRIMARY KEY (`userId`),
  ADD UNIQUE KEY `username` (`username`),
  ADD KEY `role` (`roleId`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `role`
--
ALTER TABLE `role`
  MODIFY `roleId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `slot_book`
--
ALTER TABLE `slot_book`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `userlogin`
--
ALTER TABLE `userlogin`
  MODIFY `userId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `slot_book`
--
ALTER TABLE `slot_book`
  ADD CONSTRAINT `fk_user` FOREIGN KEY (`userId`) REFERENCES `userlogin` (`userid`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `userlogin`
--
ALTER TABLE `userlogin`
  ADD CONSTRAINT `fk_role` FOREIGN KEY (`roleId`) REFERENCES `role` (`roleId`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
