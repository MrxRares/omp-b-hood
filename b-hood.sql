-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 04, 2026 at 09:17 PM
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
-- Database: `b-hood`
--

-- --------------------------------------------------------

--
-- Table structure for table `atm`
--

CREATE TABLE `atm` (
  `ID` int(11) NOT NULL,
  `X` float NOT NULL,
  `Y` float NOT NULL,
  `Z` float NOT NULL,
  `R` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `atm`
--

INSERT INTO `atm` (`ID`, `X`, `Y`, `Z`, `R`) VALUES
(1, 2216.57, 1675.92, 1007.97, 98.9999),
(2, 2255.2, 1678.34, 1007.97, -81.1);

-- --------------------------------------------------------

--
-- Table structure for table `banlog`
--

CREATE TABLE `banlog` (
  `ID` int(11) NOT NULL,
  `ip` varchar(25) NOT NULL,
  `player` varchar(25) NOT NULL,
  `admin` varchar(25) NOT NULL,
  `reason` varchar(60) NOT NULL,
  `day` int(11) NOT NULL DEFAULT 0,
  `time` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `bans`
--

CREATE TABLE `bans` (
  `ID` int(11) NOT NULL,
  `PlayerName` varchar(30) NOT NULL,
  `AdminName` varchar(30) NOT NULL,
  `Reason` varchar(128) NOT NULL,
  `IP` varchar(16) NOT NULL DEFAULT 'NULL',
  `Days` int(11) NOT NULL,
  `Time` int(15) NOT NULL DEFAULT -1,
  `Active` int(11) NOT NULL,
  `Date` varchar(60) NOT NULL DEFAULT '1999-1-1 10:00',
  `Userid` int(11) NOT NULL,
  `ByUserid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `bans`
--

INSERT INTO `bans` (`ID`, `PlayerName`, `AdminName`, `Reason`, `IP`, `Days`, `Time`, `Active`, `Date`, `Userid`, `ByUserid`) VALUES
(1, '', 'DaduAdv', 'Mue', '94.176.5.142', 0, -1, 0, '19-03-2023 21:36:09', 0, 6);

-- --------------------------------------------------------

--
-- Table structure for table `bizz`
--

CREATE TABLE `bizz` (
  `ID` int(11) NOT NULL,
  `Owned` int(11) NOT NULL,
  `Owner` varchar(25) NOT NULL DEFAULT 'The State',
  `Type` int(11) NOT NULL,
  `Message` varchar(50) NOT NULL,
  `EntranceX` float NOT NULL,
  `EntranceY` float NOT NULL,
  `EntranceZ` float NOT NULL,
  `ExitX` float NOT NULL,
  `ExitY` float NOT NULL,
  `ExitZ` float NOT NULL,
  `LevelNeeded` int(11) NOT NULL,
  `BuyPrice` int(11) NOT NULL,
  `EntranceCost` int(11) NOT NULL DEFAULT 5000,
  `Till` int(11) NOT NULL,
  `Locked` int(11) NOT NULL,
  `Interior` int(11) NOT NULL,
  `Virtual` int(11) NOT NULL,
  `Radio` int(11) NOT NULL DEFAULT -1,
  `Static` int(11) NOT NULL,
  `Gas` int(11) NOT NULL,
  `Products` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `bizz`
--

INSERT INTO `bizz` (`ID`, `Owned`, `Owner`, `Type`, `Message`, `EntranceX`, `EntranceY`, `EntranceZ`, `ExitX`, `ExitY`, `ExitZ`, `LevelNeeded`, `BuyPrice`, `EntranceCost`, `Till`, `Locked`, `Interior`, `Virtual`, `Radio`, `Static`, `Gas`, `Products`) VALUES
(1, 1, 'The State', 6, '24/7', 2063.08, 2308.88, 10.8203, -25.9517, -187.761, 1003.55, 7, 0, 2000, 58500, 0, 17, 1, -1, 0, 0, 0),
(2, 1, 'The State', 7, 'Binco', 2102.14, 2257.42, 11.0234, 207.655, -110.479, 1005.13, 7, 0, 2000, 36000, 0, 15, 2, -1, 0, 0, 0),
(3, 1, 'The State', 9, 'Casino', 1290.96, -1161.12, 23.961, 2234.07, 1714.11, 1012.35, 7, 0, 2000, 32000, 0, 1, 6, -1, 0, 0, 0),
(4, 1, 'Madalin31', 1, 'Banca', 1462.35, -1011.23, 26.8438, 2305.07, -15.9066, 26.7422, 7, 0, 2000, 2000, 0, 0, 4, 1, 0, 0, 0),
(5, 1, 'The State', 1, 'Banca', 2196.58, 1677.17, 12.3672, 2305.07, -15.9066, 26.7422, 7, 0, 2000, 2000, 0, 0, 5, -1, 0, 0, 0),
(6, 1, 'The State', 9, 'Casino', 2017.04, 1916.5, 12.3424, 2234.07, 1714.11, 1012.35, 7, 0, 2000, 6000, 0, 1, 6, -1, 0, 0, 0),
(7, 1, 'The State', 5, 'Sex Shop', 2085.12, 2074.01, 11.0547, -100.354, -25.0326, 1000.72, 7, 0, 2000, 3000, 0, 3, 7, -1, 0, 0, 0),
(8, 1, 'The State', 16, 'Gas Station', 2187.95, 2469.64, 11.2422, 0, 0, 0, 7, 0, 2000, 2000, 0, 0, 8, -1, 1, 0, 0),
(9, 1, 'The State', 10, 'CNN', 2868.99, 2438.48, 11.069, 0, 0, 0, 7, 0, 2000, 2000, 0, 0, 9, -1, 1, 0, 0),
(10, 1, 'The State', 4, 'Restaurant', 2014.9, 1150.44, 10.8203, -794.96, 489.431, 1376.2, 7, 0, 2000, 2000, 0, 1, 10, -1, 0, 0, 0),
(11, 1, 'The State', 15, 'Paintball', 2186.65, 1113.42, 12.6484, 0, 0, 0, 7, 0, 2000, 2000, 0, 0, 11, -1, 1, 0, 0),
(12, 1, 'The State', 2, 'Gun Shop', 2596.12, 1089.14, 10.8222, 285.676, -86.3199, 1001.52, 7, 0, 2000, 2000, 0, 4, 12, -1, 0, 0, 0),
(13, 1, 'The State', 6, '24/7', 2637.19, 1129.51, 11.1797, -25.9517, -187.761, 1003.55, 7, 0, 2000, 17750, 0, 17, 13, -1, 0, 0, 0),
(14, 1, 'The State', 16, 'Gas Station', 2123.88, 914.969, 10.8203, 0, 0, 0, 7, 0, 2000, 2000, 0, 0, 14, -1, 1, 0, 0),
(15, 1, 'The State', 6, '24/7', 2194.94, 1990.99, 12.2969, -25.9517, -187.761, 1003.55, 7, 0, 2000, 2000, 0, 17, 15, -1, 0, 0, 0),
(16, 1, 'The State', 8, 'Burger', 1872.25, 2071.86, 11.0625, 363.04, -75.3009, 1001.51, 7, 0, 2000, 7000, 0, 10, 16, -1, 0, 0, 0),
(17, 1, 'The State', 18, 'PNS', 1966.14, 2162.65, 10.8203, 0, 0, 0, 7, 0, 2000, 2000, 0, 0, 17, -1, 1, 0, 0),
(18, 1, 'The State', 19, 'Pizza', 2764.23, 2469.39, 11.0625, 372.286, -133.524, 1001.49, 7, 0, 2000, 2000, 0, 5, 18, -1, 0, 0, 0),
(19, 1, 'The State', 7, 'Binco', 2779.65, 2453.67, 11.0625, 207.655, -110.479, 1005.13, 7, 0, 2000, 2000, 0, 15, 19, -1, 0, 0, 0),
(20, 1, 'The State', 2, 'Gun Shop', 2556.99, 2065.36, 11.0995, 285.676, -86.3199, 1001.52, 7, 0, 2000, 2000, 0, 4, 20, -1, 0, 0, 0),
(21, 1, 'The State', 8, 'Burger', 2472.84, 2034.26, 11.0625, 363.04, -75.3009, 1001.51, 7, 0, 2000, 2000, 0, 10, 21, -1, 0, 0, 0),
(22, 1, 'The State', 16, 'Gas Station', 2639.46, 1065.67, 10.8203, 0, 0, 0, 7, 0, 2000, 2000, 0, 0, 22, -1, 1, 0, 0),
(23, 1, 'The State', 11, 'Rent Moto', 2200.86, 1394.81, 11.0625, 0, 0, 0, 7, 0, 2000, 122000, 0, 0, 23, -1, 1, 0, 0),
(24, 1, 'The State', 12, 'Rent Car', 2227.35, 1398.33, 11.0625, 0, 0, 0, 7, 0, 2000, 31400, 0, 0, 24, -1, 1, 0, 0),
(25, 1, 'The State', 6, '24/7', 1833.76, -1842.51, 13.5781, -25.9517, -187.761, 1003.55, 7, 0, 2000, 4000, 0, 17, 25, -1, 0, 0, 0),
(26, 1, 'The State', 17, 'Race Arena', 1099.66, 1601.43, 12.5469, 0, 0, 0, 7, 0, 2000, 2000, 0, 0, 26, -1, 1, 1, 0),
(27, 1, 'The State', 3, 'Club', 1837.02, -1682.32, 13.3236, 493.397, -24.8437, 1000.68, 7, 0, 2000, 4000, 0, 17, 27, -1, 0, 0, 0),
(28, 1, 'The State', 16, 'Gas Station', 1928.58, -1776.24, 13.5469, 0, 0, 0, 7, 0, 2000, 2000, 0, 0, 28, -1, 1, 0, 0),
(29, 1, 'The State', 18, 'PNS', 488.377, -1733.41, 11.1841, 0, 0, 0, 7, 0, 2000, 2000, 0, 0, 29, -1, 1, 0, 0),
(30, 1, 'The State', 18, 'PNS', 2073.61, -1831.61, 13.5469, 0, 0, 0, 7, 0, 2000, 2000, 0, 0, 30, -1, 1, 0, 0),
(31, 1, 'The State', 19, 'Pizza', 2105.33, -1806.58, 13.5547, 372.286, -133.524, 1001.49, 7, 0, 2000, 2000, 0, 5, 31, -1, 0, 0, 0),
(32, 1, 'The State', 10, 'CNN', 649.291, -1357.32, 13.5672, 0, 0, 0, 7, 0, 2000, 2000, 0, 0, 32, -1, 1, 0, 0),
(33, 1, 'The State', 13, 'GYM', 2229.82, -1721.38, 13.5624, 772.302, -4.8968, 1000.73, 7, 0, 2000, 2000, 0, 5, 33, -1, 0, 0, 0),
(34, 1, 'The State', 10, 'CNN', -1782.32, 573.38, 35.1641, 0, 0, 0, 7, 0, 2000, 2000, 0, 0, 34, -1, 1, 0, 0),
(35, 1, 'The State', 7, 'Binco', 1456.55, -1137.76, 23.9572, 207.655, -110.479, 1005.13, 7, 0, 2000, 4000, 0, 15, 35, -1, 0, 0, 0),
(36, 1, 'The State', 18, 'PNS', -1904.66, 276.029, 41.0469, 0, 0, 0, 7, 0, 2000, 2000, 0, 0, 36, -1, 1, 0, 0),
(37, 1, 'The State', 18, 'PNS', 1024.82, -1031.38, 31.9847, 0, 0, 0, 7, 0, 2000, 2000, 0, 0, 37, -1, 1, 0, 0),
(38, 1, 'The State', 20, 'Tunning', 1034.55, -1028.3, 32.1016, 0, 0, 0, 7, 0, 2000, 2000, 0, 0, 38, -1, 1, 0, 0),
(39, 1, 'The State', 20, 'Tunning', -1942.84, 238.277, 34.1251, 0, 0, 0, 7, 0, 2000, 2000, 0, 0, 39, -1, 1, 0, 0),
(40, 1, 'The State', 14, 'Car Color', 1616.44, -1498.45, 14.2309, 0, 0, 0, 7, 0, 2000, 2000, 0, 0, 40, -1, 1, 0, 0),
(41, 1, 'The State', 6, '24/7', 1000.42, -919.976, 42.3281, -25.9517, -187.761, 1003.55, 7, 0, 2000, 4000, 0, 17, 41, -1, 0, 0, 0),
(42, 1, 'The State', 16, 'Gas Station', 1006.22, -930.103, 42.3281, 0, 0, 0, 7, 0, 2000, 2000, 0, 0, 42, -1, 1, 0, 0),
(43, 1, 'The State', 16, 'Gas Station', -2410.9, 964.916, 45.4609, 0, 0, 0, 7, 0, 2000, 2000, 0, 0, 43, -1, 1, 0, 0),
(44, 1, 'The State', 6, '24/7', -2420.16, 969.855, 45.2969, -25.9517, -187.761, 1003.55, 7, 0, 2000, 4000, 0, 17, 44, -1, 0, 0, 0),
(45, 1, 'The State', 18, 'PNS', -2425.46, 1029.79, 50.3906, 0, 0, 0, 7, 0, 2000, 2000, 0, 0, 45, -1, 1, 0, 0),
(46, 1, 'The State', 6, '24/7', -2442.65, 755.418, 35.1719, -25.9517, -187.761, 1003.55, 7, 0, 2000, 10000, 0, 17, 46, -1, 0, 0, 0),
(47, 1, 'The State', 8, 'Burger', -2336.87, -166.736, 35.5547, 363.04, -75.3009, 1001.51, 7, 0, 2000, 2000, 0, 10, 47, -1, 0, 0, 0),
(48, 1, 'The State', 8, 'Burger', -2672.34, 257.94, 4.63281, 363.04, -75.3009, 1001.51, 7, 0, 2000, 2000, 0, 10, 48, -1, 0, 0, 0),
(49, 1, 'The State', 8, 'Burger', -326.047, 821.71, 14.2697, 363.04, -75.3009, 1001.51, 7, 0, 2000, 4000, 0, 10, 49, -1, 0, 0, 0),
(50, 1, 'The State', 7, 'Binco', 1656.85, 1733.25, 10.8281, 207.655, -110.479, 1005.13, 7, 0, 2000, 10500, 0, 15, 50, -1, 0, 0, 0),
(51, 1, 'The State', 5, 'Sex Shop', 1087.64, -922.48, 43.3906, -100.354, -25.0326, 1000.72, 7, 0, 2000, 4000, 0, 3, 51, -1, 0, 0, 0),
(52, 1, 'The State', 2, 'Gun Shop', 1368.84, -1279.85, 13.5469, 285.676, -86.3199, 1001.52, 7, 0, 2000, 340000, 0, 4, 52, -1, 0, 0, 0),
(53, 1, 'The State', 6, '24/7', 1352.35, -1759.25, 13.5078, -25.9517, -187.761, 1003.55, 7, 0, 2000, 2000, 0, 17, 53, -1, 0, 0, 0),
(54, 1, 'The State', 16, 'Gas Station', -2034.87, 148.606, 28.8359, 0, 0, 0, 7, 0, 2000, 2000, 0, 0, 54, -1, 1, 0, 0),
(55, 0, 'The State', 1, 'Banca', -2766.55, 375.614, 6.33468, 2305.07, -15.9066, 26.7422, 7, 0, 2000, 4000, 0, 0, 55, -1, 0, 0, 0),
(56, 1, 'The State', 1, 'Banca', -1492.13, 920.147, 7.1875, 2305.07, -15.9066, 26.7422, 7, 0, 2000, 2000, 0, 0, 56, -1, 0, 0, 0),
(57, 1, 'The State', 19, 'Pizza', 1367.56, 248.225, 19.5669, 372.286, -133.524, 1001.49, 7, 0, 2000, 2000, 0, 5, 57, -1, 0, 0, 0),
(58, 1, 'The State', 6, '24/7', 1642.27, -2334.86, 13.5469, -25.9517, -187.761, 1003.55, 7, 0, 2000, 2000, 0, 17, 58, -1, 0, 0, 0),
(59, 0, 'The State', 7, 'Binco', 1685.62, -2335.07, 13.5469, 207.655, -110.479, 1005.13, 7, 0, 2000, 2000, 0, 15, 59, -1, 0, 0, 0),
(60, 1, 'The State', 21, 'Biliard', 1498.66, -1580.94, 13.5498, 501.981, -69.1501, 998.758, 7, 0, 2000, 10000, 0, 11, 0, -1, 0, 0, 0),
(61, 1, 'The State', 21, 'Biliard', 2089.97, 1514.59, 10.8203, 501.981, -69.1501, 998.758, 7, 0, 2000, 2000, 0, 11, 0, -1, 0, 0, 0),
(62, 1, 'The State', 18, 'PNS', 719.921, -464.703, 16.3359, 0, 0, 0, 7, 0, 5000, 2000, 0, 0, 62, -1, 1, 0, 0),
(63, 0, 'The State', 7, 'Binco', -2178.54, -42.4316, 35.3203, 207.655, -110.479, 1005.13, 4, 1, 5000, 32000, 0, 15, 63, -1, 0, 0, 0),
(64, 0, 'The State', 6, '24/7', -2156.29, 337.305, 35.3203, -25.9517, -187.761, 1003.55, 5, 1, 5000, 16250, 0, 17, 64, -1, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `blacklist`
--

CREATE TABLE `blacklist` (
  `ID` int(10) NOT NULL,
  `Userid` int(10) NOT NULL,
  `Name` varchar(256) NOT NULL,
  `Faction` int(10) NOT NULL,
  `Reason` int(10) NOT NULL,
  `Added` varchar(256) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cars`
--

CREATE TABLE `cars` (
  `ID` int(11) NOT NULL,
  `Model` int(11) NOT NULL,
  `Locationx` float NOT NULL,
  `Locationy` float NOT NULL,
  `Locationz` float NOT NULL,
  `Angle` float NOT NULL,
  `ColorOne` int(11) NOT NULL,
  `ColorTwo` int(11) NOT NULL,
  `Owner` varchar(25) NOT NULL DEFAULT 'Dealership',
  `Value` int(11) NOT NULL,
  `License` varchar(15) NOT NULL DEFAULT 'LS-01-RGM',
  `Alarm` int(11) NOT NULL,
  `Lockk` int(11) NOT NULL,
  `paintjob` int(11) NOT NULL DEFAULT 3,
  `KM` float NOT NULL,
  `Userid` int(11) NOT NULL DEFAULT 0,
  `Confiscated` int(2) NOT NULL,
  `Points` int(10) NOT NULL DEFAULT 5,
  `Tax` int(10) NOT NULL DEFAULT 50,
  `Fuel` int(10) NOT NULL DEFAULT 100,
  `Neon` int(10) NOT NULL,
  `Text` varchar(256) NOT NULL DEFAULT '-',
  `ColorText` int(11) NOT NULL,
  `Virtual` int(11) NOT NULL,
  `RainBow` int(11) NOT NULL,
  `Stage` int(11) NOT NULL,
  `MaxSpeed` int(11) NOT NULL,
  `Days` int(11) NOT NULL,
  `Temporar` int(11) NOT NULL,
  `TemporarTime` int(11) NOT NULL,
  `VIP` int(11) NOT NULL,
  `Cordonate` varchar(50) NOT NULL DEFAULT '0.0|0.0|0.0|0.0|0.0|0.0',
  `Components` varchar(50) NOT NULL DEFAULT '0|0|0|0',
  `TimeGoto` int(11) NOT NULL,
  `Mods` varchar(50) NOT NULL DEFAULT '0|0|0|0|0|0|0|0|0|0|0|0|0|0',
  `Premium` tinyint(1) NOT NULL,
  `Garage` int(11) NOT NULL DEFAULT -1,
  `NeonObj` varchar(32) NOT NULL DEFAULT '-1|-1',
  `PFuel` tinyint(1) NOT NULL,
  `SNeon` int(11) NOT NULL,
  `Special` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `cars`
--

INSERT INTO `cars` (`ID`, `Model`, `Locationx`, `Locationy`, `Locationz`, `Angle`, `ColorOne`, `ColorTwo`, `Owner`, `Value`, `License`, `Alarm`, `Lockk`, `paintjob`, `KM`, `Userid`, `Confiscated`, `Points`, `Tax`, `Fuel`, `Neon`, `Text`, `ColorText`, `Virtual`, `RainBow`, `Stage`, `MaxSpeed`, `Days`, `Temporar`, `TemporarTime`, `VIP`, `Cordonate`, `Components`, `TimeGoto`, `Mods`, `Premium`, `Garage`, `NeonObj`, `PFuel`, `SNeon`, `Special`) VALUES
(26, 411, -1638.24, 1297.27, 6.7628, 313.503, 1, 1, 'Madalin31', 1, 'New Car', 0, 0, 3, 7.8354, 3, 0, 4, 85, 77, 7, '{FF3399}Epic Times', 0, 0, 1, 4, 0, 3, 0, 0, 1, '0.0|0.0|0.0|0.0|0.0|0.0', '0|0|0|0', 1679388630, '0|0|0|0|0|0|0|0|0|0|0|0|0|0', 0, -1, '18647 18647', 0, 1, 1),
(27, 411, -1641.52, 1300.66, 6.7574, 313.815, 1, 1, 'DEIMAN0009', 1, 'New Car', 0, 1, 3, 0, 2, 0, 5, 50, 100, 0, '{FF3399}Epic Times', 0, 0, 0, 0, 0, 2, 0, 0, 1, '0.0|0.0|0.0|0.0|0.0|0.0', '0|0|0|0', 0, '0|0|0|0|0|0|0|0|0|0|0|0|0|0', 0, -1, '-1|-1', 0, 0, 1),
(28, 411, -1634.16, 1293.5, 6.7652, 314.257, 1, 1, 'xT.shark', 1, 'New Car', 0, 1, 3, 0, 4, 0, 5, 50, 100, 0, '{FF3399}Epic Times', 0, 0, 0, 0, 0, 2, 0, 0, 1, '0.0|0.0|0.0|0.0|0.0|0.0', '0|0|0|0', 0, '0|0|0|0|0|0|0|0|0|0|0|0|0|0', 0, -1, '-1|-1', 0, 0, 1),
(29, 411, -1652.33, 1311.34, 6.7613, 315.208, 1, 1, 'DaduAdv', 1, 'New Car', 0, 0, 3, 0, 6, 0, 5, 50, 100, 0, '{FF3399}Epic Times', 0, 0, 0, 0, 0, 2, 0, 0, 1, '0.0|0.0|0.0|0.0|0.0|0.0', '0|0|0|0', 0, '0|0|0|0|0|0|0|0|0|0|0|0|0|0', 0, -1, '-1|-1', 0, 0, 1),
(30, 411, -1630.85, 1289.61, 6.7661, 313.109, 1, 1, 'DaduAdv', 1, 'New Car', 0, 1, 3, 0, 6, 0, 5, 50, 100, 0, '{FF3399}Epic Times', 0, 0, 0, 0, 0, 2, 0, 0, 1, '0.0|0.0|0.0|0.0|0.0|0.0', '0|0|0|0', 0, '0|0|0|0|0|0|0|0|0|0|0|0|0|0', 0, -1, '-1|-1', 0, 0, 1),
(31, 411, -1638.24, 1297.27, 6.7628, 313.503, 1, 1, 'HALKFLORIN67', 1, 'New Car', 0, 0, 3, 0, 7, 0, 5, 50, 100, 0, '{FF3399}Epic Times', 0, 0, 1, 0, 0, 2, 0, 0, 1, '0.0|0.0|0.0|0.0|0.0|0.0', '0|0|0|0', 0, '0|0|0|0|0|0|0|0|0|0|0|0|0|0', 0, -1, '-1|-1', 0, 0, 1),
(32, 411, -1630.85, 1289.61, 6.7661, 313.109, 1, 1, 'Lucifer89.', 1, 'New Car', 0, 1, 3, 0, 10, 0, 4, 39, 100, 0, '{FF3399}Epic Times', 0, 0, 0, 0, 0, 2, 0, 0, 1, '0.0|0.0|0.0|0.0|0.0|0.0', '0|0|0|0', 0, '0|0|0|0|0|0|0|0|0|0|0|0|0|0', 0, -1, '-1|-1', 0, 0, 1),
(33, 541, -1630.85, 1289.61, 6.7661, 313.109, 1, 1, 'Madalin31', 430000000, 'New Car', 0, 1, 3, 0, 3, 0, 5, 50, 100, 0, '-', 0, 0, 0, 0, 0, 1, 0, 0, 0, '0.0|0.0|0.0|0.0|0.0|0.0', '0|0|0|0', 0, '0|0|0|0|0|0|0|0|0|0|0|0|0|0', 0, -1, '-1|-1', 0, 0, 0),
(34, 522, -1630.85, 1289.61, 6.7661, 313.109, 1, 1, 'HALKFLORIN67', 1, 'New Car', 0, 0, 3, 0, 7, 0, 5, 50, 100, 0, '-', 0, 0, 0, 0, 0, 1, 0, 0, 0, '0.0|0.0|0.0|0.0|0.0|0.0', '0|0|0|0', 0, '0|0|0|0|0|0|0|0|0|0|0|0|0|0', 1, -1, '-1|-1', 0, 0, 0),
(35, 560, -1648.56, 1307.83, 6.7573, 313.77, 1, 1, 'HALKFLORIN67', 1, 'New Car', 0, 1, 3, 0, 7, 0, 5, 50, 100, 0, '-', 0, 0, 0, 0, 0, 1, 0, 0, 0, '0.0|0.0|0.0|0.0|0.0|0.0', '0|0|0|0', 0, '0|0|0|0|0|0|0|0|0|0|0|0|0|0', 1, -1, '-1|-1', 0, 0, 0),
(36, 413, -1630.85, 1289.61, 6.7661, 313.109, 1, 1, 'Madalin31', 4200000, 'New Car', 0, 1, 3, 0, 3, 0, 5, 50, 100, 0, '-', 0, 0, 0, 0, 0, 1, 0, 0, 0, '0.0|0.0|0.0|0.0|0.0|0.0', '0|0|0|0', 0, '0|0|0|0|0|0|0|0|0|0|0|0|0|0', 0, -1, '-1|-1', 0, 0, 0),
(37, 541, -1630.85, 1289.61, 6.7661, 313.109, 1, 1, 'Madalin31', 430000000, 'New Car', 0, 1, 3, 0, 3, 0, 5, 50, 100, 0, '-', 0, 0, 0, 0, 0, 1, 0, 0, 0, '0.0|0.0|0.0|0.0|0.0|0.0', '0|0|0|0', 0, '0|0|0|0|0|0|0|0|0|0|0|0|0|0', 0, -1, '-1|-1', 0, 0, 0),
(38, 411, -1630.85, 1289.61, 6.7661, 313.109, 1, 1, 'Madalin31', 1, 'New Car', 0, 1, 3, 0, 3, 0, 5, 50, 100, 0, '-', 0, 0, 0, 0, 0, 1, 0, 0, 0, '0.0|0.0|0.0|0.0|0.0|0.0', '0|0|0|0', 0, '0|0|0|0|0|0|0|0|0|0|0|0|0|0', 1, -1, '-1|-1', 0, 0, 0),
(39, 411, -1638.24, 1297.27, 6.7628, 313.503, 3, 1, 'Bucsa', 1, 'New Car', 0, 0, 3, 11.3211, 11, 1, 5, 50, 80, 0, 'FARCRY3', 0, 0, 1, 4, 0, 1, 0, 0, 1, '0.0|0.0|0.0|0.0|0.0|0.0', '0|0|0|0', 1679336045, '0|0|0|0|0|0|0|0|0|0|0|0|0|0', 1, -1, '-1|-1', 0, 0, 0),
(40, 411, -1648.56, 1307.83, 6.7573, 313.77, 1, 1, 'Bucsa', 1, 'New Car', 0, 1, 3, 0, 11, 0, 5, 50, 100, 0, '-', 0, 0, 0, 0, 0, 1, 0, 0, 0, '0.0|0.0|0.0|0.0|0.0|0.0', '0|0|0|0', 0, '0|0|0|0|0|0|0|0|0|0|0|0|0|0', 0, -1, '-1|-1', 1, 0, 0),
(41, 423, -1634.16, 1293.5, 6.7652, 314.257, 1, 1, 'Bucsa', 1, 'New Car', 0, 1, 3, 0, 11, 0, 5, 50, 100, 0, '-', 0, 0, 0, 0, 0, 1, 0, 0, 0, '0.0|0.0|0.0|0.0|0.0|0.0', '0|0|0|0', 0, '0|0|0|0|0|0|0|0|0|0|0|0|0|0', 1, -1, '-1|-1', 0, 0, 0),
(42, 411, 1525.88, 2258.18, 10.5474, 180.253, 0, 0, 'Bucsa', 0, 'LS-01-RGM', 0, 0, 3, 0, 0, 1, 5, 50, 100, 3, '-', 0, 0, 0, 0, 0, 0, 1, 5, 0, '0.0|0.0|0.0|0.0|0.0|0.0', '0|0|0|0', 0, '0|0|0|0|0|0|0|0|0|0|0|0|0|0', 0, -1, '-1|-1', 0, 0, 0),
(43, 522, 1525.88, 2258.18, 10.5474, 180.253, 0, 0, 'DEIMAN0009', 0, 'LS-01-RGM', 0, 0, 3, 0, 0, 0, 5, 50, 100, 0, '-', 0, 0, 0, 0, 0, 0, 0, 0, 0, '0.0|0.0|0.0|0.0|0.0|0.0', '0|0|0|0', 0, '0|0|0|0|0|0|0|0|0|0|0|0|0|0', 0, -1, '-1|-1', 0, 0, 0),
(44, 562, -1648.56, 1307.83, 6.7573, 313.77, 1, 1, 'Mr.Rares', 61000069, 'New Car', 0, 1, 2, 10.9863, 12, 0, 5, 50, 88, 0, 'Mr.Rares', 0, 0, 1, 0, 0, 0, 0, 0, 1, '0.0|0.0|0.0|0.0|0.0|0.0', '0|0|0|0', 1793737264, '0|0|0|0|0|0|0|0|0|0|0|0|0|0', 0, -1, '-1|-1', 0, 0, 0),
(45, 411, -1630.85, 1289.61, 6.7661, 313.109, 1, 1, 'Mr.Rares', 555555555, 'New Car', 0, 1, 3, 0, 12, 0, 5, 50, 100, 0, '-', 0, 0, 0, 0, 0, 0, 0, 0, 0, '0.0|0.0|0.0|0.0|0.0|0.0', '0|0|0|0', 0, '0|0|0|0|0|0|0|0|0|0|0|0|0|0', 0, -1, '-1|-1', 0, 0, 0),
(47, 411, -1630.85, 1289.61, 6.7661, 313.109, 1, 1, 'MrxRares', 555555555, 'New Car', 0, 1, 3, 3.2265, 13, 0, 5, 50, 99, 0, '-', 0, 0, 0, 0, 0, 0, 0, 0, 0, '0.0|0.0|0.0|0.0|0.0|0.0', '0|0|0|0', 0, '0|0|0|0|0|0|0|0|0|0|0|0|0|0', 0, -1, '-1|-1', 0, 0, 0),
(49, 562, -1638.24, 1297.27, 6.7628, 313.503, 1, 1, 'MrxRares', 61000069, 'New Car', 0, 1, 2, 17.0964, 13, 0, 5, 37, 88, 7, 'MrxRares', 0, 0, 3, 4, 0, 0, 0, 0, 1, '0.0|0.0|0.0|0.0|0.0|0.0', '0|0|0|0', 1793822913, '0|0|0|0|0|0|0|0|0|0|0|0|0|0', 0, -1, '18647 18647', 0, 1, 0);

-- --------------------------------------------------------

--
-- Table structure for table `clanhq`
--

CREATE TABLE `clanhq` (
  `ID` int(11) NOT NULL,
  `PosX` float NOT NULL,
  `PosY` float NOT NULL,
  `PosZ` float NOT NULL,
  `EnterX` float NOT NULL,
  `EnterY` float NOT NULL,
  `EnterZ` float NOT NULL,
  `VirtualWorld` int(11) NOT NULL,
  `Price` int(11) NOT NULL,
  `Clan` int(11) NOT NULL,
  `Status` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `clans`
--

CREATE TABLE `clans` (
  `ID` int(10) NOT NULL,
  `Owner` varchar(64) NOT NULL,
  `OwnerSQL` int(11) NOT NULL,
  `Name` varchar(64) NOT NULL,
  `Motd` varchar(256) NOT NULL DEFAULT 'Nu este setat.',
  `Tag` varchar(32) NOT NULL,
  `RankName1` varchar(64) NOT NULL DEFAULT 'Rank 1',
  `RankName2` varchar(64) NOT NULL DEFAULT 'Rank 2',
  `RankName3` varchar(64) NOT NULL DEFAULT 'Rank 3',
  `RankName4` varchar(64) NOT NULL DEFAULT 'Rank 4',
  `RankName5` varchar(64) NOT NULL DEFAULT 'Rank 5',
  `RankName6` varchar(64) NOT NULL DEFAULT 'Rank 6',
  `Color` varchar(10) NOT NULL DEFAULT 'FFFFFF',
  `Slots` int(10) NOT NULL,
  `RegisterDate` varchar(64) NOT NULL,
  `Days` int(10) NOT NULL DEFAULT 60,
  `TagType` int(11) NOT NULL,
  `HQ` int(11) NOT NULL,
  `PremiumPoints` int(11) NOT NULL,
  `RankName7` varchar(32) NOT NULL DEFAULT 'Rank 7',
  `Safebox` int(11) NOT NULL,
  `Bonus` int(11) NOT NULL DEFAULT 1,
  `Premium` int(11) NOT NULL,
  `VIP` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `clans`
--

INSERT INTO `clans` (`ID`, `Owner`, `OwnerSQL`, `Name`, `Motd`, `Tag`, `RankName1`, `RankName2`, `RankName3`, `RankName4`, `RankName5`, `RankName6`, `Color`, `Slots`, `RegisterDate`, `Days`, `TagType`, `HQ`, `PremiumPoints`, `RankName7`, `Safebox`, `Bonus`, `Premium`, `VIP`) VALUES
(1, '14', 3, 'tepar', 'Nu este setat.', 'T.E.P.A.R', 'Rank 1', 'Rank 2', 'Rank 3', 'Rank 4', 'Rank 5', 'Rank 6', 'FFFFFF', 30, '18/03/2023 - 21:31:51', 999, 0, 1, 10000000, 'Rank 7', 10560, 1, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `clanvehicle`
--

CREATE TABLE `clanvehicle` (
  `ID` int(11) NOT NULL,
  `Locationx` float NOT NULL,
  `Locationy` float NOT NULL,
  `Locationz` float NOT NULL,
  `Angle` float NOT NULL,
  `ColorOne` int(11) NOT NULL,
  `ColorTwo` int(11) NOT NULL,
  `Value` int(11) NOT NULL,
  `paintjob` int(11) NOT NULL,
  `Fuel` int(11) NOT NULL DEFAULT 100,
  `RainBow` int(11) NOT NULL,
  `Stage` int(11) NOT NULL,
  `Mods` varchar(50) NOT NULL DEFAULT '0|0|0|0|0|0|0|0|0|0|0|0|0|0',
  `ClanID` int(11) NOT NULL,
  `Rank` int(11) NOT NULL,
  `Model` int(11) NOT NULL DEFAULT 400,
  `VIP` int(11) NOT NULL,
  `TimeGoto` int(11) NOT NULL,
  `Neon` int(11) NOT NULL,
  `NeonObj` varchar(33) NOT NULL DEFAULT '-1 -1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `clanvehicle`
--

INSERT INTO `clanvehicle` (`ID`, `Locationx`, `Locationy`, `Locationz`, `Angle`, `ColorOne`, `ColorTwo`, `Value`, `paintjob`, `Fuel`, `RainBow`, `Stage`, `Mods`, `ClanID`, `Rank`, `Model`, `VIP`, `TimeGoto`, `Neon`, `NeonObj`) VALUES
(1, 0, 0, 0, 0, 1, 1, 0, 0, 100, 0, 0, '0|0|0|0|0|0|0|0|0|0|0|0|0|0', 1, 7, 411, 0, 0, 0, '-1 -1');

-- --------------------------------------------------------

--
-- Table structure for table `commands`
--

CREATE TABLE `commands` (
  `ID` int(11) NOT NULL,
  `name` varchar(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dsveh`
--

CREATE TABLE `dsveh` (
  `ID` int(10) NOT NULL,
  `Model` int(11) NOT NULL,
  `Price` int(11) NOT NULL DEFAULT 1,
  `Stock` int(11) NOT NULL DEFAULT 30
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `dsveh`
--

INSERT INTO `dsveh` (`ID`, `Model`, `Price`, `Stock`) VALUES
(1, 509, 1250000, 100),
(2, 510, 2500000, 100),
(3, 404, 3350000, 100),
(4, 600, 3900000, 100),
(5, 413, 4200000, 100),
(6, 543, 4720000, 100),
(7, 478, 5550000, 100),
(8, 422, 6050000, 100),
(9, 401, 6325000, 100),
(10, 466, 6100000, 100),
(11, 474, 5000000, 100),
(12, 471, 6900690, 100),
(13, 546, 7000500, 100),
(14, 436, 7230000, 100),
(15, 526, 9000000, 100),
(16, 517, 8000000, 100),
(17, 550, 7800000, 100),
(18, 458, 7770000, 100),
(19, 500, 5750000, 100),
(20, 551, 13300000, 100),
(21, 400, 8500000, 100),
(22, 542, 9520000, 100),
(23, 549, 9700000, 100),
(24, 439, 10000500, 100),
(25, 496, 13250000, 100),
(26, 561, 10000500, 100),
(27, 507, 14300000, 100),
(28, 567, 17600000, 100),
(29, 535, 16000000, 100),
(30, 554, 18350000, 100),
(31, 405, 19805000, 100),
(32, 555, 20000000, 100),
(33, 534, 20000000, 100),
(34, 489, 21500000, 100),
(35, 426, 23550000, 100),
(36, 589, 24000000, 100),
(37, 603, 27102000, 100),
(38, 475, 28700020, 100),
(39, 533, 29999996, 100),
(40, 587, 32000000, 100),
(41, 602, 35250000, 100),
(42, 565, 30250000, 100),
(43, 579, 39870230, 100),
(44, 480, 43220000, 100),
(45, 506, 57050000, 100),
(46, 402, 69999996, 100),
(47, 477, 77007007, 100),
(48, 495, 162000261, 100),
(49, 562, 61000069, 98),
(50, 415, 66000066, 100),
(51, 429, 196000000, 100),
(52, 451, 285000000, 100),
(53, 560, 390000000, 100),
(54, 541, 430000000, 100),
(55, 411, 555555555, 96),
(56, 522, 475000000, 100),
(57, 463, 10000000, 100),
(58, 462, 3000000, 100),
(59, 461, 25000000, 100);

-- --------------------------------------------------------

--
-- Table structure for table `eat_stand`
--

CREATE TABLE `eat_stand` (
  `ID` int(11) NOT NULL,
  `X` float NOT NULL,
  `Y` float NOT NULL,
  `Z` float NOT NULL,
  `Rot` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `eat_stand`
--

INSERT INTO `eat_stand` (`ID`, `X`, `Y`, `Z`, `Rot`) VALUES
(1, 2086.27, 2038.88, 10.8103, 0),
(2, 2620.54, 1727.37, 10.7503, -177.5),
(3, 1014.76, 1397.79, 10.6719, -177.8),
(4, 1120.14, 1820.4, 10.8019, -91.4),
(5, 2411.88, 1682.21, 10.7903, 0),
(6, 1908.55, 2077.14, 10.8125, 179.8),
(7, 2022.81, 1701.09, 10.7903, 89),
(8, 2198.73, 1523.89, 10.6719, 89.8),
(9, 2280.15, 955.818, 10.7519, 0),
(10, 2369.86, 640.741, 10.7719, 0),
(11, 2679.7, 759.676, 10.8319, 0),
(12, 2787.2, 890.217, 10.75, 0),
(13, 1577.23, 788.017, 11.1, 0),
(14, 1333.09, -915.631, 36.3597, -104.2),
(15, 1233.28, -922.005, 42.7049, -80),
(16, 976.57, -912.87, 45.7656, -167.3),
(17, 754.387, -1043.24, 23.6672, -59.6),
(18, 665.521, -1761.45, 13.5705, 73.7),
(19, 644.743, -1497.6, 14.8223, -178.9),
(20, 613.024, -1307.09, 14.4883, 90.8),
(21, 1170.2, -1130.46, 23.7954, 0),
(22, 1335.55, -1121.22, 23.7914, 0),
(23, 1650.98, -1153.59, 24.0549, -91.7),
(24, 1195.23, -1704.68, 13.5469, -89.3),
(25, 1073.91, -1816.09, 13.6735, -179.3),
(26, 2165.59, 2355.22, 10.8203, -94.1);

-- --------------------------------------------------------

--
-- Table structure for table `emails`
--

CREATE TABLE `emails` (
  `ID` int(10) NOT NULL,
  `Name` varchar(64) NOT NULL,
  `Text` varchar(256) NOT NULL,
  `By` varchar(64) NOT NULL DEFAULT 'AdmBot',
  `Date` varchar(256) NOT NULL,
  `Read` int(10) NOT NULL,
  `Action` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `emails`
--

INSERT INTO `emails` (`ID`, `Name`, `Text`, `By`, `Date`, `Read`, `Action`) VALUES
(1, 'pian', 'Ai pierdut casa #23 deoarece ai avut sub 5 ore jucate in aceasta luna.', 'AdmBot', '19-03-2023 21:28:55', 0, '');

-- --------------------------------------------------------

--
-- Table structure for table `factionlog`
--

CREATE TABLE `factionlog` (
  `ID` int(11) NOT NULL,
  `Faction` int(11) NOT NULL,
  `Text` varchar(256) NOT NULL,
  `Date` varchar(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `factionlog`
--

INSERT INTO `factionlog` (`ID`, `Faction`, `Text`, `Date`) VALUES
(1, 12, 'Madalin31, Madalin31 was uninvited by Madalin31 from faction Taxi Company (rank 7) after 0 days, without FP. Reason: re.', '19-59-2023 22:03:41');

-- --------------------------------------------------------

--
-- Table structure for table `factions`
--

CREATE TABLE `factions` (
  `ID` int(11) NOT NULL,
  `Name` varchar(50) NOT NULL,
  `X` float NOT NULL,
  `Y` float NOT NULL,
  `Z` float NOT NULL,
  `IntX` float NOT NULL,
  `IntY` float NOT NULL,
  `IntZ` float NOT NULL,
  `Interior` int(11) NOT NULL,
  `VW` int(11) NOT NULL,
  `Anunt` varchar(128) NOT NULL DEFAULT 'None',
  `Name1` varchar(64) NOT NULL DEFAULT 'Rank 1',
  `Name2` varchar(64) NOT NULL DEFAULT 'Rank 2',
  `Name3` varchar(64) NOT NULL DEFAULT 'Rank 3',
  `Name4` varchar(64) NOT NULL DEFAULT 'Rank 4',
  `Name5` varchar(64) NOT NULL DEFAULT 'Rank 5',
  `Name6` varchar(64) NOT NULL DEFAULT 'Rank 6',
  `Name7` varchar(64) NOT NULL DEFAULT 'Rank 7',
  `App` int(10) NOT NULL DEFAULT 0,
  `Lock` int(11) NOT NULL DEFAULT 1,
  `MaxMembers` int(3) NOT NULL DEFAULT 0,
  `MinLevel` int(11) NOT NULL DEFAULT 7,
  `sX` float NOT NULL,
  `sY` float NOT NULL,
  `sZ` float NOT NULL,
  `RaportRank1` varchar(30) NOT NULL DEFAULT '0|0|0',
  `RaportRank2` varchar(30) NOT NULL DEFAULT '0|0|0',
  `RaportRank3` varchar(30) NOT NULL DEFAULT '0|0|0',
  `RaportRank4` varchar(30) NOT NULL DEFAULT '0|0|0',
  `RaportRank5` varchar(30) NOT NULL DEFAULT '0|0|0',
  `RaportRank6` varchar(30) NOT NULL DEFAULT '0|0|0',
  `RaportRank7` varchar(30) NOT NULL DEFAULT '0|0|0',
  `vX` float NOT NULL,
  `vY` float NOT NULL,
  `vZ` float NOT NULL,
  `eX` float NOT NULL,
  `eY` float NOT NULL,
  `eZ` float NOT NULL,
  `vRot` float NOT NULL,
  `eRot` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `factions`
--

INSERT INTO `factions` (`ID`, `Name`, `X`, `Y`, `Z`, `IntX`, `IntY`, `IntZ`, `Interior`, `VW`, `Anunt`, `Name1`, `Name2`, `Name3`, `Name4`, `Name5`, `Name6`, `Name7`, `App`, `Lock`, `MaxMembers`, `MinLevel`, `sX`, `sY`, `sZ`, `RaportRank1`, `RaportRank2`, `RaportRank3`, `RaportRank4`, `RaportRank5`, `RaportRank6`, `RaportRank7`, `vX`, `vY`, `vZ`, `eX`, `eY`, `eZ`, `vRot`, `eRot`) VALUES
(1, 'Los Santos Police Department', 1555.1, -1675.62, 16.195, 246.78, 63.3446, 1003.64, 6, 1, 'Salut!', '[1] Officer', 'Sergent', '[3] Sergeant', '[4] Lieutenant', '[5] Captain', 'Chestor', 'Chestor General', 0, 0, 15, 10, 1559.64, -1634.72, 13.5494, '30 12 0', '25 10 8', '20 8 5', '15 5 5', '10 5 3', '0|0|0', '0|0|0', 1559.79, -1627.53, 13.1099, 1566.07, -1653.02, 28.5725, 91.1499, 90.7578),
(2, 'Federal Bureau of Investigation', 626.975, -571.419, 17.9207, 238.567, 139.299, 1003.02, 3, 2, 'sedinta duminica viitoare la ora 20:00', 'Detectiv', '[2] Special Agent', '[3] Charge', '[4] Supervisory', 'Chestor', 'Co-Lider', 'Lider', 0, 1, 15, 10, 620.227, -584.447, 17.233, '30 0 0', '25 0 4', '20 0 3', '15 0 2', '10 0 1', '0|0|0', '0|0|0', 627.231, -596.344, 16.3633, 661.407, -584.13, 16.5124, 274.63, 90.4194),
(3, 'National Guard', 154.818, 1903.26, 18.7252, 288.763, 167.704, 1007.17, 3, 3, 'Salut, sa ai o zi frumoasa! Nu uita de raport.', '[1] Private', '[2] Second Lieutenant', '[3] First Lieutenant', '[4] Captain', '[5] Major', '[6] Colonel', '[7] General', 0, 1, 15, 10, 201.372, 1918.61, 17.6406, '40 0 0', '35 0 0', '30 0 0', '25 0 0', '20 0 0', '0|0|0', '0|0|0', 211.357, 1918.64, 17.3677, 307.847, 1802.47, 17.8185, 178.666, 0.614579),
(4, 'Grove Street', 2495.22, -1690.91, 14.7656, 2544.49, -1304.77, 1054.64, 2, 4, 'Sedinta Duminica , ora 20:00.', '[1] Soldier', '[2] Supplier', '[3] Launderer', '[4] Chief Enforcer', '[5] Councilor', '[6] Advisor', '[7] Supreme Chief', 0, 0, 15, 10, 0, 0, 0, '150000 10000 0', '130000 10000 0', '110000 10000 0', '100000 5000 0', '80000 5000 0', '0|0|0', '0|0|0', 0, 0, 0, 0, 0, 0, 0, 0),
(5, 'Los Aztecas', 1456.52, 2773.59, 10.8203, 2544.49, -1304.77, 1054.64, 2, 5, 'Los Aztecas - Cine nu este ONLINE la war-uri, are FW ! WARURILE SUNT OBLIGATORII !', '[1] Servant', '[2] Minion', '[3] Fighter', '[4] Gangster', '[5] War Gangster', '[6] Count', '[7] Lord', 0, 0, 15, 10, 1668.24, -1325.33, 17.4294, '150000 10000 0', '130000 10000 0', '110000 10000 0', '100000 5000 0', '80000 5000 0', '0|0|0', '0|0|0', 0, 0, 0, 0, 0, 0, 0, 0),
(6, 'Los Vagos', 691.571, -1276.05, 13.5607, 2544.49, -1304.77, 1054.64, 2, 6, 'Sa fim numaru 1 in /top! Forta Los Vagos!', '[1] Recluta', '[2] Cholo', '[3] Solado', '[4] Pandillero', '[5] Vato del Jefe', '[6] Mano Derecha', '[7] El Jefe', 0, 0, 15, 10, 0, 0, 0, '150000 10000 0', '130000 10000 0', '110000 10000 0', '100000 5000 0', '80000 5000 0', '0|0|0', '0|0|0', 0, 0, 0, 0, 0, 0, 0, 0),
(7, 'School Instructors LS', 476.902, -1498.75, 20.4789, 1494.49, 1304.18, 1093.29, 3, 7, 'Nimic', '[1] Trainee', '[2] Instructor', '[3] Senior Instructor', '[4] Supervisor', '[5] Manager', '[6] Under Boss', '[7] Boss', 0, 0, 15, 7, 491.229, -1499.22, 20.4507, '10 0 0', '8 0 0', '6 0 0', '4 0 0', '2 0 0', '0|0|0', '0|0|0', 484.348, -1498.86, 20.0216, 500.682, -1511.38, 39.3322, 355.388, 270.518),
(8, 'Tow Truck Company', 2451.17, -2120.77, 13.5469, 626.835, -12.0344, 1000.92, 1, 8, 'Salut raport-ul vostru este: 25 tractari, 20 refill, 15 repair.', '[1] Trainee', '[2] Mechanic', '[3] Senior Mechanic', '[4] Supervisor', '[5] Manager', '[6] Under Boss', '[7] Owner', 0, 0, 15, 7, 2446.15, -2112.53, 13.553, '20 15 15', '18 13 13', '15 10 10', '13 8 8', '10 5 5', '0|0|0', '0|0|0', 2454.55, -2089.32, 13.4194, 0, 0, 0, 88.9317, 0),
(9, 'News Reporters', -329.801, 1537.04, 76.612, -2026.96, -104.033, 1035.17, 3, 9, 'https://discord.gg/UEHskt5EBP -> Server-ul de discord, intrati pentru a lua CMD-ul.', '[1] Intern', '[2] Local Reporter', '[3] Local Editor', '[4] Network Anchor', '[5] Network Editor', '[6] Network Producer', '[7] Network Director', 0, 0, 15, 7, -312.921, 1538.11, 75.5625, '20 0 0', '18 10 0', '15 8 0', '13 5 0', '10 3 0', '0|0|0', '0|0|0', -317.872, 1514.77, 75.3828, -369.754, 1558.2, 75.7106, 0.202718, 214.531),
(10, 'The Ballas', 1455.48, 750.583, 11.023, 2544.49, -1304.77, 1054.64, 2, 10, 'Sedinta sambata la ora 17:00 cine nu se prezinta primeste UNINVITE ', '(1) Ragazzino -', '(2) Spacciatore -', '(3) Capodecina -', '6', '(5) Fattam -', 'cartoon123', '(7) Capo Di Tutti', 0, 0, 15, 10, 1081.06, -345.265, 73.9836, '150000 10000 0', '130000 10000 0', '110000 10000 0', '100000 5000 0', '80000 5000 0', '0|0|0', '0|0|0', 0, 0, 0, 0, 0, 0, 0, 0),
(11, 'Hitman Agency', 1073.24, -345.586, 73.992, -2158.61, 642.401, 1052.38, 1, 11, 'bun venit', '[1] Freelancer', '[2] Marksman', '[3] Agent', '[4] Special Agent', '[5] Special Agent in Charge', '[6] Vice Director', '[7] Director', 0, 0, 15, 15, 1081.17, -345.285, 73.9786, '25 0 0', '20 0 0', '15 0 0', '10 0 0', '8 0 0', '0|0|0', '0|0|0', 1077.94, -309.984, 73.7193, 1038.64, -355.085, 74.2422, 177.426, 0.000002),
(12, 'Taxi Company', 1752.5, -1894.02, 13.557, 1701.24, -1668.03, 20.2188, 18, 12, 'Fare-ul este 1000$', '[1] Trainee', '[2] Taxi Rookie', '[3] Cabbie', '[4] Dispatcher', '[5] Shift Supervisor', '[6] Taxi Company Manager', '[7] Taxi Company Owner', 0, 0, 15, 7, 1759.92, -1900.19, 13.5634, '20 0 0', '15 0 0', '10 0 0', '10 0 0', '5 0 0', '0|0|0', '0|0|0', 1777.32, -1912.88, 13.1144, 1792.34, -1924.3, 13.6405, 269.663, 0.000073),
(13, 'Paramedic Departament', 1607.19, 1815.25, 10.8203, 1494.46, 1304.12, 1093.29, 3, 13, 'LUNI ORA 21 SEDINTA PE DISCORD', '[1] Candidate Paramedic', '[2] Paramedic', '[3] Paramedic in Charge', '[4] Paramedic Ambulance Commander', '[5] Paramedic Field Chief', '[6] Assistant Chief Paramedic', '[7] Chief Paramedic', 0, 0, 15, 7, 1623.84, 1817.94, 10.8203, '25 0 0', '20 0 0', '15 0 0', '10 0 0', '5 0 0', '0|0|0', '0|0|0', 1606.4, 1839.09, 10.5474, 1607.96, 1768.21, 38.0222, 358.253, 357.821),
(14, 'Las Venturas Police Department', 2287.19, 2431.38, 10.8203, 246.448, 108.555, 1003.22, 10, 14, 'cine nu face raportu are uninvite', '[1] Officer', '[2] Detective', '[3] Sergeant', '[4] Lieutenant', '[5] Captain', '[6] Assistant Chief', '[7] Chief', 0, 0, 15, 10, 2306.17, 2437.61, 10.8203, '30 12 0', '25 10 8', '20 8 5', '15 5 5', '10 5 3', '0|0|0', '20|0|0', 2305.68, 2436.92, 10.5474, 2284.09, 2440.85, 47.1543, 176.846, 180.687),
(15, 'Uber Company', 938.703, 1733.45, 8.852, 1701.24, -1668.03, 20.2188, 18, 15, 'Duminica sedinta , prezenta este obligatorie la ora 20:30 , cine nu vine are FW', '[1] Driver', '[2] Driver Advanced', '[3] Driver Expert', '[4] Supervisor', '[5] Manager', '# Vice-Director', '# Director', 0, 0, 15, 7, 947.677, 1719.29, 8.85543, '20 0 0', '15 0 0', '10 0 0', '10 0 0', '5 0 0', '0|0|0', '0|0|0', 945.808, 1711.35, 8.56875, 0, 0, 0, 270.757, 0),
(16, 'School Instructors LV', 2427.6, 1662.88, 10.8203, 1494.49, 1304.18, 1093.29, 3, 16, 'None', 'Rank1', 'Rank2', 'Rank3', 'Rank4', 'Rank5', 'Rank6', 'Rank7', 0, 0, 15, 7, 2424.1, 1672.07, 10.8203, '10 0 0', '8 0 0', '6 0 0', '4 0 0', '2 0 0', '0|0|0', '0 0 0', 2398.94, 1658.53, 10.5474, 2395.81, 1687.54, 19.523, 179.164, 183.556),
(17, 'Verdant Family', 1122.89, -2037, 69.894, 2544.49, -1304.77, 1054.64, 2, 17, 'None', 'Rank1', 'Rank2', 'Rank3', 'Rank4', 'Rank5', 'Rank6', 'Rank7', 0, 0, 15, 10, 0, 0, 0, '150000 10000 0', '130000 10000 0', '110000 10000 0', '100000 5000 0', '80000 5000 0', '0|0|0', '0|0|0', 0, 0, 0, 0, 0, 0, 0, 0),
(18, 'The Rifa', 2632.32, 2350.61, 10.8203, 2544.49, -1304.77, 1054.64, 2, 18, '0', 'Rank1', 'Rank2', 'Rank3', 'Rank4', 'Rank5', 'Rank6', 'Rank7', 0, 1, 15, 15, 0, 0, 0, '150000 10000 0', '130000 10000 0', '110000 10000 0', '100000 5000 0', '80000 5000 0', '0|0|0', '0|0|0', 0, 0, 0, 0, 0, 0, 0, 0),
(19, 'San Fierro Police Department', -1605.64, 711.33, 13.8672, 246.78, 63.3446, 1003.64, 6, 19, '0', 'Rank1', 'Rank2', 'Rank3', 'Rank4', 'Rank5', 'Rank6', 'Rank7', 0, 0, 15, 10, -1620.62, 684.888, 7.1875, '30 12 0', '25 10 8', '20 8 5', '15 5 5', '10 5 3', '0|0|0', '0|0|0', -1616.74, 651.306, 6.91455, -1681.28, 705.873, 30.7784, 359.312, 270.179),
(20, 'San Fierro Paramedic Departament', -2655.06, 639.121, 14.4531, 1494.46, 1304.12, 1093.29, 3, 19, '0', 'Rank1', 'Rank2', 'Rank3', 'Rank4', 'Rank5', 'Rank6', 'Rank7', 1, 0, 15, 7, -2664.68, 636.717, 14.4531, '25 0 0', '20 0 0', '15 0 0', '10 0 0', '5 0 0', '0|0|0', '0|0|0', -2682.66, 634.186, 14.1806, -2574.74, 642.998, 28.0625, 181.06, 179.732),
(21, 'School Instructors SF', -2065.85, -859.943, 32.1719, 1494.49, 1304.18, 1093.29, 3, 21, 'None', 'Rank1', 'Rank2', 'Rank3', 'Rank4', 'Rank5', 'Rank6', 'Rank7', 0, 0, 15, 7, -2097.71, -860.074, 32.1719, '10 0 0', '8 0 0', '6 0 0', '4 0 0', '2 0 0', '0|0|0', '0|0|0', -2125.46, -837.556, 31.7489, -2026.5, -859.932, 32.4219, 269.493, 269.51),
(22, 'Tow Truck Company SF', -2455.75, 503.971, 30.0781, 626.835, -12.0344, 1000.92, 1, 22, 'None', 'Rank1', 'Rank2', 'Rank3', 'Rank4', 'Rank5', 'Rank6', 'Rank7', 0, 1, 15, 7, -2446.99, 523.174, 30.3015, '20 15 15', '18 13 13', '15 10 10', '13 8 8', '10 5 5', '0|0|0', '0|0|0', -2440.77, 523.337, 29.6372, 0, 0, 0, 180.063, 0),
(23, 'Yango', -2665.65, -5.4771, 6.1328, 1701.24, -1668.03, 20.2188, 18, 23, 'Welcome to faction! Link discord :', 'Rank1', 'Rank2', 'Rank3', 'Rank4', 'Rank5', 'Rank6', '# Director', 0, 0, 15, 7, -2692.51, -35.2311, 4.33594, '20 0 0', '15 0 0', '10 0 0', '10 0 0', '5 0 0', '0|0|0', '0 0 0', -2683.3, -55.323, 4.06306, -2648.48, -30.2745, 6.32195, 0.721721, 179.277),
(24, 'Special Guard', -2281.96, 2288.39, 4.974, 288.763, 167.704, 1007.17, 3, 24, 'cine nu face raportu suge pula', 'Rank1', 'Rank2', 'Rank3', 'Rank4', 'Rank5', 'Rank6', 'Rank7', 0, 0, 15, 15, -2284.72, 2282.29, 4.96712, '0|0|0', '0|0|0', '0|0|0', '0|0|0', '0|0|0', '0|0|0', '0|0|0', -2260.67, 2287.61, 4.81466, 0, 0, 0, 359.563, 0),
(25, 'SF Bikers', -2463.01, 132.31, 35.1719, 2544.49, -1304.77, 1054.64, 2, 25, 'Ares e boss pe sv', 'Rank1', 'Rank2', 'Rank3', 'Rank4', 'Rank5', 'Rank6', 'Rank7', 0, 0, 15, 15, 0, 0, 0, '0|0|0', '0|0|0', '0|0|0', '0|0|0', '0|0|0', '0|0|0', '0|0|0', 0, 0, 0, 0, 0, 0, 0, 0),
(26, 'Camorra Family', -2624.65, 1412.26, 7.0938, 2544.49, -1304.77, 1054.64, 2, 26, 'None', 'Rank1', 'Rank2', 'Rank3', 'Rank4', 'Rank5', 'Rank6', 'Rank7', 0, 0, 15, 15, 0, 0, 0, '0|0|0', '0|0|0', '0|0|0', '0|0|0', '0|0|0', '0|0|0', '0|0|0', 0, 0, 0, 0, 0, 0, 0, 0),
(27, 'Avispa Cartel', -2521.21, -624.953, 132.784, 2544.49, -1304.77, 1054.64, 2, 27, 'none', 'Rank1', 'Rank2', 'Rank3', 'Rank4', 'Rank5', 'Rank6', 'Admin', 0, 0, 15, 15, 0, 0, 0, '0|0|0', '0|0|0', '0|0|0', '0|0|0', '0|0|0', '0|0|0', '0|0|0', 0, 0, 0, 0, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `faction_apply`
--

CREATE TABLE `faction_apply` (
  `ID` int(11) NOT NULL,
  `FactionID` int(11) NOT NULL,
  `Username` text NOT NULL,
  `Status` int(11) NOT NULL DEFAULT 1,
  `I1` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `I2` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `I3` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `I4` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `I5` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `I6` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `I7` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `I8` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `I9` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `I10` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `I11` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `I12` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `I13` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `I14` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `I15` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `faction_logs`
--

CREATE TABLE `faction_logs` (
  `id` int(11) NOT NULL,
  `player` int(11) NOT NULL,
  `leader` int(11) NOT NULL,
  `Text` text NOT NULL,
  `time` varchar(30) NOT NULL DEFAULT '01.01.1999 10:00:00',
  `deleted` int(11) NOT NULL,
  `player_name` varchar(32) NOT NULL DEFAULT 'invalid',
  `leader_name` varchar(32) NOT NULL DEFAULT 'invalid',
  `skin` int(11) NOT NULL,
  `faction` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `faction_logs`
--

INSERT INTO `faction_logs` (`id`, `player`, `leader`, `Text`, `time`, `deleted`, `player_name`, `leader_name`, `skin`, `faction`) VALUES
(1, 2, 2, 'DEIMAN0009 este liderul factiunii Los Santos Police Department.', '19-03-2023 09:56:02', 0, 'DEIMAN0009', 'DEIMAN0009', 60, 0),
(2, 3, 3, 'Madalin31 este liderul factiunii Taxi Company.', '19-03-2023 22:59:02', 0, 'Madalin31', 'Madalin31', 2, 0),
(3, 3, 3, 'Madalin31 was uninvited by Madalin31 from faction Taxi Company (rank 7) after 0 days with 0 FP, reason: re.', '19-03-2023 22:59:41', 0, 'Madalin31', 'Madalin31', 2, 0),
(4, 7, 3, 'HALKFLORIN67 este liderul factiunii Grove Street.', '20-03-2023 10:13:42', 0, 'Madalin31', 'HALKFLORIN67', 2, 0);

-- --------------------------------------------------------

--
-- Table structure for table `friends`
--

CREATE TABLE `friends` (
  `ID` int(11) NOT NULL,
  `friendID` int(11) NOT NULL,
  `friendName` varchar(644) NOT NULL,
  `AddBy` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `garages`
--

CREATE TABLE `garages` (
  `ID` int(11) NOT NULL,
  `EntranceX` float NOT NULL,
  `EntranceY` float NOT NULL,
  `EntranceZ` float NOT NULL,
  `House` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci COMMENT='5';

--
-- Dumping data for table `garages`
--

INSERT INTO `garages` (`ID`, `EntranceX`, `EntranceY`, `EntranceZ`, `House`) VALUES
(1, -58.0712, -1505.76, 1.62162, 1);

-- --------------------------------------------------------

--
-- Table structure for table `graffiti`
--

CREATE TABLE `graffiti` (
  `ID` int(10) NOT NULL,
  `X` float NOT NULL,
  `Y` float NOT NULL,
  `Z` float NOT NULL,
  `Owned` int(10) NOT NULL,
  `RotX` float NOT NULL,
  `RotY` float NOT NULL,
  `RotZ` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `houses`
--

CREATE TABLE `houses` (
  `ID` int(10) NOT NULL,
  `Entrancex` float NOT NULL,
  `Entrancey` float NOT NULL,
  `Entrancez` float NOT NULL,
  `Exitx` float NOT NULL,
  `Exity` float NOT NULL,
  `Exitz` float NOT NULL,
  `Owner` varchar(25) NOT NULL DEFAULT 'The State',
  `Discription` varchar(50) NOT NULL DEFAULT 'Fara descriere.',
  `Value` int(20) NOT NULL,
  `Hel` int(11) NOT NULL,
  `Arm` int(11) NOT NULL,
  `Interior` int(11) NOT NULL,
  `Lockk` int(11) NOT NULL,
  `Owned` int(11) NOT NULL,
  `Rent` int(11) NOT NULL,
  `Rentabil` int(11) NOT NULL,
  `Takings` int(11) NOT NULL,
  `Level` int(11) NOT NULL,
  `Virtual` int(11) NOT NULL,
  `Radio` int(11) NOT NULL DEFAULT -1,
  `Zise` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `houses`
--

INSERT INTO `houses` (`ID`, `Entrancex`, `Entrancey`, `Entrancez`, `Exitx`, `Exity`, `Exitz`, `Owner`, `Discription`, `Value`, `Hel`, `Arm`, `Interior`, `Lockk`, `Owned`, `Rent`, `Rentabil`, `Takings`, `Level`, `Virtual`, `Radio`, `Zise`) VALUES
(1, 860.819, -1255.55, 14.7578, 225.662, 1022.08, 1084.02, 'The State', 'Fara descriere.', 0, 0, 0, 7, 0, 1, 250, 1, 0, 5, 1, 3, 0),
(2, 2012.29, 919.952, 10.8203, 140.182, 1366.47, 1083.86, 'The State', 'Fara descriere.', 0, 0, 0, 5, 0, 1, 250, 1, 0, 5, 2, -1, 0),
(3, 2006.82, 1167.48, 10.8203, 234.203, 1064.15, 1084.21, 'The State', 'Fara descriere.', 0, 0, 0, 6, 0, 1, 250, 1, 0, 5, 3, -1, 0),
(4, 2238.9, 1285.52, 10.8203, 140.182, 1366.47, 1083.86, 'The State', 'Fara descriere.', 0, 0, 0, 5, 0, 1, 250, 1, 0, 5, 4, -1, 0),
(5, 2364.44, 2377.49, 10.8203, 225.662, 1022.08, 1084.02, 'The State', 'Fara descriere.', 0, 0, 0, 7, 0, 1, 250, 1, 0, 5, 5, -1, 0),
(6, 1319.1, 1249.48, 10.8203, 234.203, 1064.15, 1084.21, 'The State', 'Fara descriere.', 0, 0, 0, 6, 0, 1, 250, 1, 0, 5, 6, -1, 0),
(7, 1624.66, 1018.31, 10.8203, 2282.79, -1139.4, 1050.9, 'The State', 'Fara descriere.', 0, 0, 0, 11, 0, 1, 250, 1, 0, 5, 7, -1, 0),
(8, 1845.76, 741.383, 11.4609, 223.08, 1287.74, 1082.14, 'The State', 'Fara descriere.', 0, 0, 0, 1, 0, 1, 250, 1, 0, 5, 8, -1, 0),
(9, 2397.59, 656.107, 11.4609, 223.08, 1287.74, 1082.14, 'The State', 'Fara descriere.', 0, 0, 0, 1, 0, 1, 250, 1, 0, 5, 9, -1, 0),
(10, 2581.27, 1060.55, 11.7815, 300.862, 309.887, 1003.3, 'The State', 'Fara descriere.', 0, 0, 0, 4, 0, 1, 250, 1, 0, 5, 10, -1, 0),
(11, 1497.02, -687.897, 95.5633, 225.662, 1022.08, 1084.02, 'The State', 'Fara descriere.', 0, 0, 0, 7, 0, 1, 250, 1, 0, 5, 11, -1, 0),
(12, 980.489, -677.259, 121.976, 225.662, 1022.08, 1084.02, 'The State', 'Fara descriere.', 0, 0, 0, 7, 0, 1, 250, 1, 0, 5, 12, -1, 0),
(13, 300.277, -1154.49, 81.3905, 225.662, 1022.08, 1084.02, 'The State', 'Fara descriere.', 0, 0, 0, 7, 0, 1, 250, 1, 0, 5, 13, -1, 0),
(14, 416.747, -1154.17, 76.6876, 234.203, 1064.15, 1084.21, 'HALKFLORIN67', 'Fara descriere.', 0, 0, 0, 6, 0, 1, 250, 1, 0, 5, 14, -1, 0),
(15, 2818.31, 2415.34, 11.0625, 223.08, 1287.74, 1082.14, 'The State', 'Fara descriere.', 0, 0, 0, 1, 0, 1, 250, 1, 0, 5, 15, -1, 0),
(16, 2826.76, 2203.61, 11.0234, 223.08, 1287.74, 1082.14, 'The State', 'Fara descriere.', 0, 0, 0, 1, 0, 1, 250, 1, 0, 5, 16, -1, 0),
(17, 2546.57, 1972.64, 10.8203, 328.003, 1478.55, 1084.44, 'The State', 'Fara descriere.', 0, 0, 0, 15, 0, 1, 250, 1, 0, 5, 17, -1, 0),
(18, 2167.16, 2164.57, 10.8203, 223.08, 1287.74, 1082.14, 'The State', 'Fara descriere.', 0, 0, 0, 1, 0, 1, 250, 1, 0, 5, 18, -1, 0),
(19, 168.094, -1769.07, 4.47643, 234.203, 1064.15, 1084.21, 'The State', 'Fara descriere.', 0, 0, 0, 6, 0, 1, 250, 1, 0, 5, 19, -1, 0),
(20, 315.875, -1769.43, 4.62261, 226.705, 1114.25, 1080.99, 'The State', 'Fara descriere.', 0, 0, 0, 5, 0, 1, 250, 1, 0, 5, 20, -1, 0),
(21, 1382.14, -1088.79, 28.2066, 225.662, 1022.08, 1084.02, 'The State', 'Fara descriere.', 0, 0, 0, 7, 0, 1, 250, 1, 0, 5, 21, -1, 0),
(22, 1421.75, -886.227, 50.6861, 223.08, 1287.74, 1082.14, 'The State', 'Fara descriere.', 0, 0, 0, 1, 0, 1, 250, 1, 0, 5, 22, -1, 0),
(23, 1540.47, -851.381, 64.3361, 223.08, 1287.74, 1082.14, 'The State', 'Fara descriere.', 0, 0, 0, 1, 0, 1, 250, 1, 0, 5, 23, -1, 0),
(24, 1045.11, -642.947, 120.117, 235.407, 1187.37, 1080.26, 'The State', 'Fara descriere.', 0, 0, 0, 3, 0, 1, 250, 1, 0, 5, 24, -1, 0),
(25, 848.729, -1817.99, 12.1938, 140.182, 1366.47, 1083.86, 'The State', 'Fara descriere.', 0, 0, 0, 5, 0, 1, 250, 1, 0, 5, 25, -1, 0),
(26, 821.93, -1757.84, 13.6484, 234.203, 1064.15, 1084.21, 'The State', 'Fara descriere.', 0, 0, 0, 6, 0, 1, 250, 0, 0, 5, 26, -1, 0),
(27, 725.797, -1440.45, 13.5391, 490.865, 1399.2, 1080.26, 'The State', 'Fara descriere.', 0, 0, 0, 2, 0, 1, 250, 0, 0, 5, 27, -1, 0),
(28, 1566.66, 23.294, 24.1641, 225.662, 1022.08, 1084.02, 'The State', 'Fara descriere.', 0, 0, 0, 7, 0, 1, 250, 0, 0, 5, 28, -1, 0),
(29, 1685.02, -2099.02, 13.8343, 234.203, 1064.15, 1084.21, 'The State', 'Fara descriere.', 0, 0, 0, 6, 0, 1, 250, 1, 0, 5, 29, -1, 0),
(30, 2177.88, 655.857, 11.4609, 2365.34, -1134.84, 1050.88, 'The State', 'Fara descriere.', 0, 0, 0, 8, 0, 1, 250, 0, 0, 5, 30, -1, 0),
(31, 1305.62, 1622.88, 10.8203, 490.865, 1399.2, 1080.26, 'The State', 'Fara descriere.', 0, 0, 0, 2, 0, 1, 250, 0, 0, 5, 31, 1, 0),
(32, 2019.8, 1007.65, 10.8203, 234.203, 1064.15, 1084.21, 'The State', 'Fara descriere.', 0, 0, 0, 6, 0, 1, 250, 1, 0, 5, 32, 19, 0),
(33, 1280.62, -813.754, 83.6623, 225.662, 1022.08, 1084.02, 'The State', 'Fara descriere.', 0, 0, 0, 7, 0, 1, 250, 0, 0, 5, 33, -1, 0),
(34, 228.305, -1405.21, 51.6094, 2496.02, -1692.68, 1014.74, 'The State', 'Fara descriere.', 0, 0, 0, 3, 0, 1, 250, 0, 0, 5, 34, -1, 0),
(35, 298.699, -1338.18, 53.4415, 2365.34, -1134.84, 1050.88, 'The State', 'Fara descriere.', 0, 0, 0, 8, 0, 1, 250, 0, 0, 5, 35, -1, 0),
(36, 423.864, 2536.45, 16.1484, 2308.81, -1212.24, 1049.02, 'The State', 'Fara descriere.', 0, 0, 0, 6, 0, 1, 250, 1, 0, 5, 36, 1, 0),
(37, 2113.76, 2499.3, 14.839, 226.705, 1114.25, 1080.99, 'The State', 'Fara descriere.', 0, 0, 0, 5, 0, 1, 250, 0, 0, 5, 37, -1, 0),
(38, 2226.73, 1838.22, 10.8203, 140.182, 1366.47, 1083.86, 'The State', 'Fara descriere.', 0, 0, 0, 5, 0, 1, 250, 0, 0, 5, 38, -1, 0),
(39, 839.013, -2152.69, 13.6607, 226.705, 1114.25, 1080.99, 'The State', 'Fara descriere.', 0, 0, 0, 5, 0, 1, 250, 0, 0, 5, 39, -1, 0),
(40, -2721.08, -320.887, 7.84375, 234.203, 1064.15, 1084.21, 'SebiAdv', 'Fara descriere.', 0, 0, 0, 6, 0, 1, 0, 0, 0, 10, 40, -1, 0);

-- --------------------------------------------------------

--
-- Table structure for table `iplogs`
--

CREATE TABLE `iplogs` (
  `ID` int(11) NOT NULL,
  `ip` varchar(64) NOT NULL,
  `playerid` int(24) NOT NULL,
  `time` varchar(32) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `iplogs`
--

INSERT INTO `iplogs` (`ID`, `ip`, `playerid`, `time`) VALUES
(1, '127.0.0.1', 1, '9/2/2023 09:44:46'),
(2, '127.0.0.1', 1, '9/2/2023 09:48:17'),
(3, '213.233.88.42', 2, '18/3/2023 18:56:40'),
(4, '188.27.152.80', 2, '18/3/2023 19:12:41'),
(5, '82.77.76.157', 3, '18/3/2023 19:17:51'),
(6, '188.27.152.80', 2, '18/3/2023 19:17:51'),
(7, '82.77.76.157', 3, '18/3/2023 20:52:24'),
(8, '188.27.152.80', 2, '18/3/2023 20:56:27'),
(9, '82.77.76.157', 3, '18/3/2023 21:25:12'),
(10, '82.77.76.157', 3, '19/3/2023 00:27:09'),
(11, '188.27.152.80', 2, '19/3/2023 09:48:25'),
(12, '188.27.152.80', 2, '19/3/2023 16:08:15'),
(13, '82.77.76.157', 3, '19/3/2023 17:06:42'),
(14, '188.27.152.80', 2, '19/3/2023 17:08:30'),
(15, '82.77.76.157', 3, '19/3/2023 17:09:13'),
(16, '82.77.76.157', 3, '19/3/2023 17:13:09'),
(17, '82.77.245.29', 4, '19/3/2023 17:16:28'),
(18, '82.77.76.157', 3, '19/3/2023 17:22:49'),
(19, '5.14.128.167', 5, '19/3/2023 18:16:18'),
(20, '94.176.5.142', 6, '19/3/2023 18:31:12'),
(21, '178.138.97.180', 3, '19/3/2023 18:32:03'),
(22, '178.138.97.180', 3, '19/3/2023 18:34:16'),
(23, '188.27.152.80', 2, '19/3/2023 18:36:00'),
(24, '178.138.97.180', 3, '19/3/2023 18:57:28'),
(25, '178.138.97.180', 3, '19/3/2023 19:13:21'),
(26, '93.122.249.126', 7, '19/3/2023 19:13:36'),
(27, '82.77.76.157', 3, '19/3/2023 19:32:31'),
(28, '82.77.76.157', 3, '19/3/2023 19:40:01'),
(29, '94.176.5.142', 3, '19/3/2023 21:28:35'),
(30, '82.79.79.218', 8, '19/3/2023 21:31:57'),
(31, '94.176.5.142', 6, '19/3/2023 21:32:10'),
(32, '94.176.5.142', 3, '19/3/2023 21:32:50'),
(33, '82.77.76.157', 3, '19/3/2023 21:36:26'),
(34, '82.77.76.157', 3, '19/3/2023 22:33:38'),
(35, '188.25.23.238', 10, '19/3/2023 22:35:30'),
(36, '178.138.97.180', 3, '20/3/2023 07:49:36'),
(37, '178.138.97.180', 3, '20/3/2023 08:25:37'),
(38, '178.138.97.180', 3, '20/3/2023 08:44:46'),
(39, '93.122.249.126', 7, '20/3/2023 10:05:17'),
(40, '178.138.97.180', 3, '20/3/2023 10:08:10'),
(41, '178.138.97.180', 3, '20/3/2023 10:33:22'),
(42, '188.27.152.80', 2, '20/3/2023 10:42:34'),
(43, '178.138.97.180', 3, '20/3/2023 10:58:13'),
(44, '178.138.97.180', 3, '20/3/2023 11:18:28'),
(45, '188.27.152.172', 11, '20/3/2023 18:53:45'),
(46, '188.27.152.172', 11, '20/3/2023 18:57:02'),
(47, '178.138.97.180', 3, '20/3/2023 19:28:33'),
(48, '178.138.97.180', 3, '20/3/2023 19:31:21'),
(49, '93.122.249.252', 7, '20/3/2023 19:58:42'),
(50, '82.77.76.157', 3, '20/3/2023 19:59:42'),
(51, '188.27.152.172', 11, '20/3/2023 20:07:48'),
(52, '188.27.152.80', 2, '20/3/2023 20:08:53'),
(53, '93.122.249.252', 7, '20/3/2023 20:30:05'),
(54, '82.77.76.157', 3, '20/3/2023 20:30:20'),
(55, '93.122.249.156', 7, '20/3/2023 22:36:34'),
(56, '82.77.76.157', 3, '21/3/2023 06:08:56'),
(57, '178.138.97.180', 3, '21/3/2023 07:56:03'),
(58, '178.138.97.180', 3, '21/3/2023 10:42:44'),
(59, '127.0.0.1', 12, '3/11/2026 01:17:10'),
(60, '127.0.0.1', 12, '3/11/2026 01:22:08'),
(61, '127.0.0.1', 12, '3/11/2026 01:52:30'),
(62, '127.0.0.1', 12, '3/11/2026 01:53:26'),
(63, '127.0.0.1', 12, '3/11/2026 02:03:05'),
(64, '127.0.0.1', 12, '3/11/2026 02:12:57'),
(65, '127.0.0.1', 12, '3/11/2026 02:18:35'),
(66, '127.0.0.1', 12, '3/11/2026 02:21:27'),
(67, '127.0.0.1', 12, '3/11/2026 02:24:08'),
(68, '127.0.0.1', 12, '3/11/2026 02:27:12'),
(69, '127.0.0.1', 12, '3/11/2026 12:43:47'),
(70, '127.0.0.1', 12, '3/11/2026 13:29:59'),
(71, '127.0.0.1', 12, '3/11/2026 13:34:00'),
(72, '127.0.0.1', 12, '3/11/2026 13:42:58'),
(73, '127.0.0.1', 12, '3/11/2026 13:48:22'),
(74, '127.0.0.1', 12, '3/11/2026 13:51:18'),
(75, '127.0.0.1', 12, '3/11/2026 13:53:40'),
(76, '127.0.0.1', 12, '3/11/2026 13:59:27'),
(77, '127.0.0.1', 12, '3/11/2026 15:54:21'),
(78, '127.0.0.1', 12, '3/11/2026 22:01:18'),
(79, '127.0.0.1', 12, '3/11/2026 22:05:51'),
(80, '127.0.0.1', 12, '3/11/2026 22:15:19'),
(81, '127.0.0.1', 12, '3/11/2026 22:20:01'),
(82, '127.0.0.1', 12, '4/11/2026 01:01:22'),
(83, '127.0.0.1', 12, '4/11/2026 01:05:58'),
(84, '127.0.0.1', 12, '4/11/2026 01:09:02'),
(85, '127.0.0.1', 12, '4/11/2026 01:13:40'),
(86, '127.0.0.1', 13, '4/11/2026 01:20:28'),
(87, '127.0.0.1', 13, '4/11/2026 01:25:46'),
(88, '127.0.0.1', 13, '4/11/2026 01:38:18'),
(89, '127.0.0.1', 13, '4/11/2026 01:39:49'),
(90, '127.0.0.1', 13, '4/11/2026 03:10:38'),
(91, '127.0.0.1', 13, '4/11/2026 03:11:43'),
(92, '127.0.0.1', 13, '4/11/2026 03:32:11'),
(93, '127.0.0.1', 13, '4/11/2026 03:39:56'),
(94, '127.0.0.1', 13, '4/11/2026 03:43:48'),
(95, '127.0.0.1', 13, '4/11/2026 03:51:29'),
(96, '127.0.0.1', 13, '4/11/2026 03:54:05'),
(97, '127.0.0.1', 13, '4/11/2026 14:27:40'),
(98, '127.0.0.1', 13, '4/11/2026 14:35:46'),
(99, '127.0.0.1', 13, '4/11/2026 14:38:04'),
(100, '127.0.0.1', 13, '4/11/2026 15:02:51'),
(101, '127.0.0.1', 13, '4/11/2026 15:09:08'),
(102, '127.0.0.1', 13, '4/11/2026 15:17:20'),
(103, '127.0.0.1', 13, '4/11/2026 15:26:02'),
(104, '127.0.0.1', 13, '4/11/2026 15:31:30'),
(105, '127.0.0.1', 13, '4/11/2026 15:37:33'),
(106, '127.0.0.1', 13, '4/11/2026 16:05:11'),
(107, '127.0.0.1', 13, '4/11/2026 17:43:18'),
(108, '127.0.0.1', 13, '4/11/2026 17:46:44'),
(109, '127.0.0.1', 13, '4/11/2026 17:54:07'),
(110, '127.0.0.1', 13, '4/11/2026 17:54:35'),
(111, '127.0.0.1', 13, '4/11/2026 19:22:19'),
(112, '127.0.0.1', 13, '4/11/2026 19:24:22'),
(113, '127.0.0.1', 13, '4/11/2026 21:01:32'),
(114, '127.0.0.1', 13, '4/11/2026 21:53:08');

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `ID` int(10) NOT NULL,
  `Name` varchar(32) NOT NULL DEFAULT 'No name',
  `NeedLevel` int(10) NOT NULL,
  `Legal` int(10) NOT NULL,
  `Skill1Veh` int(10) NOT NULL DEFAULT 400,
  `Skill2Veh` int(10) NOT NULL DEFAULT 400,
  `Skill3Veh` int(10) NOT NULL DEFAULT 400,
  `Skill4Veh` int(10) NOT NULL DEFAULT 400,
  `Skill5Veh` int(10) NOT NULL DEFAULT 400,
  `Skill6Veh` int(10) NOT NULL DEFAULT 400,
  `Owner` varchar(24) NOT NULL DEFAULT 'None',
  `Userid` int(11) NOT NULL,
  `WorkPos` varchar(100) NOT NULL DEFAULT '0.0,0.0,0.0',
  `Pos` varchar(100) NOT NULL DEFAULT '0.0,0.0,0.0',
  `Balance` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `jobs`
--

INSERT INTO `jobs` (`ID`, `Name`, `NeedLevel`, `Legal`, `Skill1Veh`, `Skill2Veh`, `Skill3Veh`, `Skill4Veh`, `Skill5Veh`, `Skill6Veh`, `Owner`, `Userid`, `WorkPos`, `Pos`, `Balance`) VALUES
(1, 'Farmer', 1, 1, 531, 531, 531, 531, 531, 531, 'None', 0, '-84.3012,45.7011,3.1172', '-95.1542,25.3176,3.1172', 50431),
(2, 'Trucker', 1, 1, 515, 515, 515, 515, 515, 515, 'None', 0, '2430.5615,-2207.2661,13.5469', '2415.4604,-2228.9482,13.5469', 2500),
(3, 'Lumberjack', 1, 1, 478, 478, 478, 478, 478, 478, 'None', 0, '-589.4131,-1078.9364,23.4845', '-601.1035,-1065.3776,23.4033', 49974),
(4, 'Garbage Man', 1, 1, 408, 408, 408, 408, 408, 408, 'None', 0, '2521.5334,2793.2646,10.8203', '2502.9802,2778.5674,10.8203', 2500),
(5, 'Arms Dealer', 2, 3, 400, 400, 400, 400, 400, 400, 'None', 0, '2798.1772,1976.6501,10.8203', '2810.8726,1987.0040,10.8203', 2500),
(6, 'Drugs Dealer', 3, 0, 400, 400, 400, 400, 400, 411, 'None', 0, '-807.8198,2430.9902,156.9962', '-797.0580,2439.1462,157.0806', 2500),
(7, 'Quarry Worker', 3, 1, 400, 400, 400, 400, 400, 400, 'None', 0, '839.6926,888.8485,13.3516', '816.6052,856.5006,12.7891', 2500),
(8, 'Detective', 5, 1, 400, 400, 400, 400, 400, 400, 'None', 0, '0.0,0.0,0.0', '-2056.7822,454.7194,35.1719', 0),
(9, 'Pizza Boy', 1, 1, 448, 448, 448, 448, 448, 448, 'None', 0, '2631.8708,1845.4863,10.8203', '2638.7864,1849.7213,11.0234', 2500),
(10, 'Courier', 1, 1, 482, 499, 499, 499, 499, 499, 'None', 0, '2805.2300,967.9019,10.7500', '2814.7793,972.6347,10.7500', 2500),
(11, 'Fisher LV', 1, 1, 400, 400, 400, 400, 400, 400, 'None', 0, '0.0,0.0,0.0', '2325.4380,556.3793,8.4116', 54624),
(12, 'Forklift', 1, 1, 530, 530, 530, 530, 530, 530, 'None', 0, '972.0071,2125.2549,10.8203', '966.9892,2133.0393,10.8203', 9853),
(13, 'Fisher LS', 1, 1, 400, 400, 400, 400, 400, 400, 'None', 0, '0.0,0.0,0.0', '401.6425,-2070.5994,10.7423', 2500),
(14, 'Bus Driver', 1, 1, 437, 437, 437, 437, 437, 437, 'None', 0, '2828.9609,1328.1018,10.7708', '2840.7317,1318.4473,11.3906', 2500),
(15, 'Glovo', 3, 0, 510, 510, 510, 510, 468, 468, 'None', 0, '-2460.2925,741.7111,34.6232', '-2471.6094,756.4418,35.1786', 190966),
(16, 'Fisher SF', 1, 1, 400, 400, 400, 400, 400, 400, 'None', 0, '0.0,0.0,0.0', '-2960.9246,476.9930,5.4050', 21893);

-- --------------------------------------------------------

--
-- Table structure for table `kenny_happs`
--

CREATE TABLE `kenny_happs` (
  `ID` int(11) NOT NULL,
  `UserID` int(11) NOT NULL,
  `UserName` varchar(90) NOT NULL,
  `Type` int(11) NOT NULL,
  `Answers` text NOT NULL,
  `Questions` text NOT NULL,
  `Status` int(11) NOT NULL,
  `Date` varchar(90) NOT NULL,
  `ActionBy` varchar(90) NOT NULL,
  `Reason` text NOT NULL,
  `AnswerDate` varchar(90) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `kenny_happs`
--

INSERT INTO `kenny_happs` (`ID`, `UserID`, `UserName`, `Type`, `Answers`, `Questions`, `Status`, `Date`, `ActionBy`, `Reason`, `AnswerDate`) VALUES
(0, 86, 'Bucsa', 1, 'Cum te numesti si ce varsta ai???:andrei 16', '1', 0, '21.03.2023 11:40', '', '', ''),
(10, 4, 'Hyde.', 1, '1.Numele si varsta ta.:Ma numesc Darius si am 16 ani.|2.Cate ore poti acorda acestui server ?:Minim 3-4, poate mai mult.|3.Care consideri ca sunt lucrurile ce te diferentiaza de ceilalti aplicanti ?:Eu nu cred ca ma diferentiaza nimic fata de alti aplicanti.|4.Ce alte jocuri mai joci ?:Mai joc rocket league, fifa 20, red dead redeption 2 si gta 5.|5. Cate ore ai pe server si ce nivel ai ?:Am momentan 0 ore si level 3 aproape 4.|6.De ce ai ales sa joci pe acest server ?:Deoarece sunt oameni okay aici, si nu \'\'toxici\'\' si cam atat.|7.De ce te consideri potrivit pentru aceasta functie?:Deoarece am mai fost de multe ori.|8. Cum imi iau un job ?:Pentru a lua un job, tasteaza comanda [/jobs] si alege job-ul dorit.|9. Ce fac cu pestele prins ?:Pestele care l-ai prins la job-ul \'\'Fisher\'\', il poti vinde si primesti o suma de bani in schimb.|10.Ce pot face cu materialele ?:Poti sa le vinzi sau sa creezi arme cu ele.|11. Armele raman si daca ies de pe joc ?:Nu, armele nu-ti vor ramane daca iesi de pe joc.|12. Cum opresc un anim ?:Tasteaza comanda [/stopanim] pentru a face acest lucru.|13. Ce fac cu activity points ?:Cu acele puncte poti castiga 100 Premium Points, daca esti pe primul loc in [/activitytop] - Players top.|14. Cum imi pot incuia masina personala sau pe cea de la rent car ?:Poti incuia masina apasand tasta \'\'N\'\' sau tastand comanda [/lock].|15. Cum aflu daca o masina are hidden sau nu ?:Poti vedea aceasta chestie pe [/stats].|16. Cum pot vinde masina ?:Poti vinde o masina, daca te afli la DealerShip. Pentru a o vinde tasteaza comanda [v]-> Masina dorita-> sell car.|17. Cum chem un taxi ?:Foloseste comanda [/service taxi].|18.Cum ma culc in casa ?:Foloseste comanda [/sleep].|19. Cum fac rob points sau respect points ?:Poti face rob points-uri sau respect points-uri din bonusuri, activitate sau poti si din [/getgift].|20. Cum pornesc masina ?:Poti porni masina tastand comanda [/engine] sau poti apasa tasta 2.|:Atat.', '21', 2, '31.05.2020 21:28', 'Biggie1980', '', '31.05.2020 21:54'),
(11, 18, 'Aiden47', 1, '1.Numele si varsta ta.:Ma numesc Robert si am 16 ani.|2.Cate ore poti acorda acestui server ?:Pot acorda 4-6 ore pe zi.|3.Care consideri ca sunt lucrurile ce te diferentiaza de ceilalti aplicanti ?:Atentia mea ,rabdarea si seriozitatea.|4.Ce alte jocuri mai joci ?:Ma joc doar Samp.|5. Cate ore ai pe server si ce nivel ai ?:lvl 1 ,ore 1|6.De ce ai ales sa joci pe acest server ?:Pentru ca este nou si favorizat.|7.De ce te consideri potrivit pentru aceasta functie?:Ma consider potrivit pentru ca stiu foarte bine regulile.|8. Cum imi iau un job ?:/getjobs|9. Ce fac cu pestele prins ?:Te duci si l vinzi.|10.Ce pot face cu materialele ?:Le poti vinde.|11. Armele raman si daca ies de pe joc ?:Nu.|12. Cum opresc un anim ?:/stop|13. Ce fac cu activity points ?:Jucandu te pe server|14. Cum imi pot incuia masina personala sau pe cea de la rent car ?:/lock|15. Cum aflu daca o masina are hidden sau nu ?:dau /v info veh|16. Cum pot vinde masina ?:/trade id|17. Cum chem un taxi ?:/service taxi|18.Cum ma culc in casa ?:/sleep|19. Cum fac rob points sau respect points ?:/getgift sau payday|20. Cum pornesc masina ?:/engine|:Sper ca ma veti accepta|:Sper ca ma veti accepta', '22', 3, '31.05.2020 22:17', 'RAZ3N', 'Te rog sa mai faci o aplicatie (si sa fi mai explicit in raspunsuriile tale).', '31.05.2020 22:21'),
(12, 6, 'Bendeacc', 1, '1.Numele si varsta ta.:Pe mine ma cheama Tureatca Dumitru -Claudiu|2.Cate ore poti acorda acestui server ?:Pot acorda ff mult timp pe sv,deoarece joc foarte mult pe acest sv.|3.Care consideri ca sunt lucrurile ce te diferentiaza de ceilalti aplicanti ?:Un lucru care ma evidentiaza pe mine de alte persoane este ( bunatatea de a ajuta alte persoane).|4.Ce alte jocuri mai joci ?:In afara de Samp, ma joc des Cs:Go cu prietenii.|5. Cate ore ai pe server si ce nivel ai ?:In momentul actual am 2h,si lvl 4.|6.De ce ai ales sa joci pe acest server ?:Deoarece, m-am apucat cu un prieten sa joc pe acest server.|7.De ce te consideri potrivit pentru aceasta functie?:Am vrut sa incerc helper, si ptr ca imi place sa ajut.|8. Cum imi iau un job ?:Pentru a face acest lucru tasteaza comanda [/jobs], si alegeti job-ul dorit iar dupa urmati checkpoint-ul.|9. Ce fac cu pestele prins ?:Tasteaza comanda [/gps], alegeti-va orasul, apoi apsati pe un 24/7 store, ajuns la 24/7 store intra in el, apoi apasa YES, vei primi o suma de bani pentru pestele vandut.|10.Ce pot face cu materialele ?:Materialele le poti vinde cu comanda [/sellmats]  sau poti vinde arme cuiva cu [/sellgun], daca ai job-ul [Arms Dealer]|11. Armele raman si daca ies de pe joc ?:Nu, armele nu-ti raman daca te deconectezi de pe server.|12. Cum opresc un anim ?:Pentru a face acest lucru tasteaza comanda [/stopanim]|13. Ce fac cu activity points ?:Dai [/activitytop] , iar activity points-urile le potii face din job-uri,10km parcursi cu masina, etc.Iar daca tu veii fi pe primul loc in ActivityTop, vei primii 100PP.|14. Cum imi pot incuia masina personala sau pe cea de la rent car ?:Pentru a face acest lucru apasati  pe tasta (N).|15. Cum aflu daca o masina are hidden sau nu ?:Poti afla daca, te urci in masina respectiva , si vezi  la detalile masiniiidaca la Hidden Colors are peste id 133.|16. Cum pot vinde masina ?:Pentru a face acest lucru tasteaza comanda [/sellcar] daca te aflii la DealerShip ( primesti 60% din pretul initial ) sau [/sellcarto] daca vrei sa vinzi masina unui player.|17. Cum chem un taxi ?:Pentru a face acest lucru tasteaza comanda [/service taxi]|18.Cum ma culc in casa ?:Pentru a face acest lucru tasteaza comanda [/sleep], daca te afli intr-o casa.|19. Cum fac rob points sau respect points ?:La fiecare Payday vei primii un rob point si un respect point.|20. Cum pornesc masina ?:Pentru a face acest lucru tasteaza comanda [/engine]|:...|:...', '22', 2, '01.06.2020 00:04', 'RAZ3N', '', '01.06.2020 04:25'),
(13, 10, 'Dennis15', 1, '1.Numele si varsta ta.:Ma numesc Denis Andrei si am 13 ani.|2.Cate ore poti acorda acestui server ?:Pot acorda 5 ore+.|3.Care consideri ca sunt lucrurile ce te diferentiaza de ceilalti aplicanti ?:Consider ca lucrurile care ma deferentiaza de ceilalti este ca in trcut am jucat SAMP si stiu cu ce se ocupa acest joc.|4.Ce alte jocuri mai joci ?:Ma mai joc Multi Theft Auto San Andreeas (MTA).|5. Cate ore ai pe server si ce nivel ai ?:Am 4.83 ore si level 5.|6.De ce ai ales sa joci pe acest server ?:Deoarece am fost vazut ca sa depus munca. De la prima intalnire cu server-ul am vazut ca se merita sa joci pe el.|7.De ce te consideri potrivit pentru aceasta functie?:Ma consider potrivit din faptul ca am jucat SAMP in trecut si stiu cat de cat cu ce se mananca. Nu sunt chiar asa noob,|8. Cum imi iau un job ?:Pentru a face acest lucru, tasteaza comanda [/jobs], alegeti jon-ul si urmeaza checkpoint-ul pentru a ajunge la acesta.|9. Ce fac cu pestele prins ?:Cu peste prins, poti sa-l vinzi la un magazin de tip \'24/7\'. [/gps - Bussines - 24/7].|10.Ce pot face cu materialele ?:Daca deti materiale, poti face arme cu ele sau le poti vinde unu jucator.|11. Armele raman si daca ies de pe joc ?:Nu. Daca iesi de pe joc armele iti vor disparea.|12. Cum opresc un anim ?:Pentru a face acest lucru, tasteaza comanda [/stopanim].|13. Ce fac cu activity points ?:Daca esti cel mai activ la [/activitytop] vrei primi 100 premium points.|14. Cum imi pot incuia masina personala sau pe cea de la rent car ?:Pentru a incuia masina personala / rent, poti apasa tasta \'N\', sau poti tasta comanda [/loockrentcar].|15. Cum aflu daca o masina are hidden sau nu ?:Pentru a afla acest lucru, tasteaza comanda [/v - Vehicle Info].|16. Cum pot vinde masina ?:Poti vinde o masina unui player sau poti sa o vinzi la dealership.|17. Cum chem un taxi ?:Pentru a face acest lucru, tasteaza comanda [/service taxi].|18.Cum ma culc in casa ?:Pentru a te culca intr-o casa, foloseste comanda [/sleep].|19. Cum fac rob points sau respect points ?:Cu rob points poti da jaf [/rob], iar cu respect points poti avansa in level [/buylevel].|20. Cum pornesc masina ?:Pentru a porni o masina, poti apasa tasta \"2\", sau poti tasta comanda [/engine].', '20', 2, '01.06.2020 22:02', 'Biggie1980', '', '01.06.2020 22:28');

-- --------------------------------------------------------

--
-- Table structure for table `kenny_hquestions`
--

CREATE TABLE `kenny_hquestions` (
  `ID` int(11) NOT NULL,
  `Question` text NOT NULL,
  `Type` int(11) NOT NULL,
  `Date` varchar(90) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `kenny_hquestions`
--

INSERT INTO `kenny_hquestions` (`ID`, `Question`, `Type`, `Date`) VALUES
(0, 'Cum te numesti si ce varsta ai???', 1, '');

-- --------------------------------------------------------

--
-- Table structure for table `kenny_lapps`
--

CREATE TABLE `kenny_lapps` (
  `ID` int(11) NOT NULL,
  `UserID` int(11) NOT NULL,
  `UserName` varchar(90) NOT NULL,
  `Type` int(11) NOT NULL,
  `Answers` text NOT NULL,
  `Questions` text NOT NULL,
  `Status` int(11) NOT NULL,
  `Date` varchar(90) NOT NULL,
  `ActionBy` varchar(90) NOT NULL,
  `Reason` text NOT NULL,
  `AnswerDate` varchar(90) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `kenny_lapps`
--

INSERT INTO `kenny_lapps` (`ID`, `UserID`, `UserName`, `Type`, `Answers`, `Questions`, `Status`, `Date`, `ActionBy`, `Reason`, `AnswerDate`) VALUES
(1, 11, 'Bucsa', 1, 'alo?:alo?', '1', 0, '22.03.2023 12:33', '', '', '');

-- --------------------------------------------------------

--
-- Table structure for table `kenny_lquestions`
--

CREATE TABLE `kenny_lquestions` (
  `ID` int(11) NOT NULL,
  `Question` text NOT NULL,
  `Type` int(11) NOT NULL,
  `Date` varchar(90) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `kenny_lquestions`
--

INSERT INTO `kenny_lquestions` (`ID`, `Question`, `Type`, `Date`) VALUES
(1, 'alo?', 1, '');

-- --------------------------------------------------------

--
-- Table structure for table `key`
--

CREATE TABLE `key` (
  `ID` int(11) NOT NULL,
  `code` varchar(128) NOT NULL,
  `valid` int(11) NOT NULL DEFAULT -1,
  `hdwid` varchar(144) NOT NULL DEFAULT '-1',
  `version` varchar(24) NOT NULL DEFAULT '1.0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `logs`
--

CREATE TABLE `logs` (
  `ID` int(10) NOT NULL,
  `Userid` int(10) NOT NULL,
  `Text` varchar(256) NOT NULL,
  `Date` varchar(256) NOT NULL,
  `Type` int(10) NOT NULL,
  `IP` varchar(256) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `logs`
--

INSERT INTO `logs` (`ID`, `Userid`, `Text`, `Date`, `Type`, `IP`) VALUES
(1, 1, '(chat) ms', '09/02/2023 - 09:46:57', 9, '127.0.0.1'),
(2, 1, 'S-a desconectat de pe server cu $19.989.900 / $0.', '09/02/2023 - 09:47:58', 4, '255.255.255.255'),
(3, 1, 'pian a primit $1.000.000.000.000.000.000 de la pian', '09/02/2023 - 09:49:29', 4, '127.0.0.1'),
(4, 1, 'A avansat in level 5 (88/12 RP)', '09/02/2023 - 09:50:50', 7, '127.0.0.1'),
(5, 1, '(chat) hai mane', '09/02/2023 - 09:53:01', 9, '127.0.0.1'),
(6, 1, '(chat) ba dc nu merge', '09/02/2023 - 09:53:06', 9, '127.0.0.1'),
(7, 1, '(chat) ;(', '09/02/2023 - 09:53:08', 9, '127.0.0.1'),
(8, 1, '(chat) ba dami premiu', '09/02/2023 - 09:53:17', 9, '127.0.0.1'),
(9, 1, '(chat) edisoane iesi din groapa', '09/02/2023 - 09:53:23', 9, '127.0.0.1'),
(10, 1, '(chat) buna siua', '09/02/2023 - 09:53:50', 9, '127.0.0.1'),
(11, 1, '(chat) buna', '09/02/2023 - 09:55:25', 9, '127.0.0.1'),
(12, 1, 'S-a desconectat de pe server cu $999.999.999.020.115.268 / $0.', '09/02/2023 - 09:59:44', 4, '255.255.255.255'),
(13, 2, 'S-a desconectat de pe server cu $20.099.900 / $0.', '18/03/2023 - 18:56:54', 4, '255.255.255.255'),
(14, 2, 'S-a desconectat de pe server cu $20.099.800 / $0.', '18/03/2023 - 19:15:50', 4, '255.255.255.255'),
(15, 3, '(chat) re', '18/03/2023 - 19:18:11', 9, '82.77.76.157'),
(16, 3, '(chat) ms', '18/03/2023 - 19:18:22', 9, '82.77.76.157'),
(17, 2, '(chat) npc', '18/03/2023 - 19:18:36', 9, '188.27.152.80'),
(18, 2, '(chat) :D', '18/03/2023 - 19:18:45', 9, '188.27.152.80'),
(19, 3, '(chat) :)', '18/03/2023 - 19:18:49', 9, '82.77.76.157'),
(20, 2, '(chat) poti vb?', '18/03/2023 - 19:19:00', 9, '188.27.152.80'),
(21, 2, '(chat) sa iti zic ceva', '18/03/2023 - 19:19:12', 9, '188.27.152.80'),
(22, 3, '(chat) nu pot ca nus acasa', '18/03/2023 - 19:19:17', 9, '82.77.76.157'),
(23, 3, '(chat) dar hai 2 min ', '18/03/2023 - 19:19:23', 9, '82.77.76.157'),
(24, 2, '(chat) ok', '18/03/2023 - 19:19:27', 9, '188.27.152.80'),
(25, 3, '(chat) pe Nr?', '18/03/2023 - 19:19:28', 9, '82.77.76.157'),
(26, 3, 'S-a desconectat de pe server cu $125.838 / $0.', '18/03/2023 - 19:20:48', 4, '82.77.76.157'),
(27, 2, 'S-a desconectat de pe server cu $20.099.700 / $0.', '18/03/2023 - 19:27:52', 4, '255.255.255.255'),
(28, 3, '(chat) ba', '18/03/2023 - 20:57:35', 9, '82.77.76.157'),
(29, 3, '(chat) nu e magazin de haine pe server', '18/03/2023 - 20:57:47', 9, '82.77.76.157'),
(30, 3, '(chat) gen de schinuri', '18/03/2023 - 20:57:52', 9, '82.77.76.157'),
(31, 3, '(chat) sa iti schimbi schinul', '18/03/2023 - 20:58:01', 9, '82.77.76.157'),
(32, 2, '(chat) e', '18/03/2023 - 20:58:03', 9, '188.27.152.80'),
(33, 3, '(chat) care?', '18/03/2023 - 20:58:08', 9, '82.77.76.157'),
(34, 2, '(chat) imd', '18/03/2023 - 20:58:31', 9, '188.27.152.80'),
(35, 3, '(chat) ok', '18/03/2023 - 20:58:34', 9, '82.77.76.157'),
(36, 2, '(chat) pai e la gps binco', '18/03/2023 - 20:59:17', 9, '188.27.152.80'),
(37, 3, '(chat) ms', '18/03/2023 - 20:59:49', 9, '82.77.76.157'),
(38, 3, '(chat) te trimitea la tutorial aici', '18/03/2023 - 21:00:51', 9, '82.77.76.157'),
(39, 3, '(chat) si nu era', '18/03/2023 - 21:00:55', 9, '82.77.76.157'),
(40, 2, '(chat) ok', '18/03/2023 - 21:01:23', 9, '188.27.152.80'),
(41, 3, '(chat) mai am de adougat cateva chesti', '18/03/2023 - 21:01:37', 9, '82.77.76.157'),
(42, 3, '(chat) vino', '18/03/2023 - 21:01:44', 9, '82.77.76.157'),
(43, 3, '(chat) acum apare', '18/03/2023 - 21:02:17', 9, '82.77.76.157'),
(44, 2, '(chat) fain', '18/03/2023 - 21:02:23', 9, '188.27.152.80'),
(45, 3, '(chat) dap', '18/03/2023 - 21:02:27', 9, '82.77.76.157'),
(46, 3, '(chat) abea astept deschiderea :))', '18/03/2023 - 21:02:52', 9, '82.77.76.157'),
(47, 2, '(chat) :)', '18/03/2023 - 21:02:58', 9, '188.27.152.80'),
(48, 3, '(chat) ba', '18/03/2023 - 21:03:08', 9, '82.77.76.157'),
(49, 3, '(chat) cum shimb preturile din /shop?', '18/03/2023 - 21:03:23', 9, '82.77.76.157'),
(50, 3, '(chat) intreb doar asa', '18/03/2023 - 21:03:28', 9, '82.77.76.157'),
(51, 3, 'Madalin31 a primit $100.000.000.000 de la Madalin31', '18/03/2023 - 21:03:47', 4, '82.77.76.157'),
(52, 2, '(chat) nu cred ca merge', '18/03/2023 - 21:03:49', 9, '188.27.152.80'),
(53, 3, '(chat) aia e :))', '18/03/2023 - 21:03:57', 9, '82.77.76.157'),
(54, 3, '(chat) ori cum e bine', '18/03/2023 - 21:04:08', 9, '82.77.76.157'),
(55, 3, '(chat) sus', '18/03/2023 - 21:06:01', 9, '82.77.76.157'),
(56, 3, '(chat) dam o tura :)', '18/03/2023 - 21:06:08', 9, '82.77.76.157'),
(57, 3, '(chat) ba', '18/03/2023 - 21:07:44', 9, '82.77.76.157'),
(58, 3, '(chat) daca fac o afacere cum fac sa apare si pe mapa?', '18/03/2023 - 21:08:03', 9, '82.77.76.157'),
(59, 3, '(chat) apara*', '18/03/2023 - 21:08:20', 9, '82.77.76.157'),
(60, 2, '(chat) ar trebui sa apara singur ', '18/03/2023 - 21:08:34', 9, '188.27.152.80'),
(61, 3, '(chat) cred ca apare daca dai restart la server ', '18/03/2023 - 21:08:58', 9, '82.77.76.157'),
(62, 3, '(chat) ba', '18/03/2023 - 21:09:32', 9, '82.77.76.157'),
(63, 3, '(chat) oare merge sa bag parcur pe sv?', '18/03/2023 - 21:09:52', 9, '82.77.76.157'),
(64, 2, '(chat) nush', '18/03/2023 - 21:10:05', 9, '188.27.152.80'),
(65, 3, '(chat) a-si incerca cu scripter-ul cand i-au sv de tot poate stie el', '18/03/2023 - 21:10:49', 9, '82.77.76.157'),
(66, 3, '(chat) merge questul?', '18/03/2023 - 21:11:31', 9, '82.77.76.157'),
(67, 3, '(chat) sus', '18/03/2023 - 21:13:07', 9, '82.77.76.157'),
(68, 2, 'S-a desconectat de pe server cu $20.095.600 / $756.303.', '18/03/2023 - 21:16:22', 4, '255.255.255.255'),
(69, 3, 'S-a desconectat de pe server cu $100.009.713.950 / $161.074.', '18/03/2023 - 21:23:13', 4, '82.77.76.157'),
(70, 3, 'Madalin31 si-a achizitionat un clan pentru 300 Premium Points.', '18/03/2023 - 21:31:47', 1, '82.77.76.157'),
(71, 3, 'S-a desconectat de pe server cu $100.009.741.392 / $161.074.', '18/03/2023 - 21:54:13', 4, '82.77.76.157'),
(72, 3, 'Madalin31 si-a achizitionat cont premium pentru 150 Premium Points.', '19/03/2023 - 00:36:52', 1, '82.77.76.157'),
(73, 3, 'S-a desconectat de pe server cu $100.010.301.156 / $161.074.', '19/03/2023 - 00:41:58', 4, '82.77.76.157'),
(74, 2, 'S-a desconectat de pe server cu $20.174.919 / $756.303.', '19/03/2023 - 09:56:37', 4, '255.255.255.255'),
(75, 2, 'S-a desconectat de pe server cu $20.174.819 / $756.303.', '19/03/2023 - 16:09:24', 4, '255.255.255.255'),
(76, 3, 'S-a desconectat de pe server cu $100.010.301.056 / $161.074.', '19/03/2023 - 17:08:45', 4, '82.77.76.157'),
(77, 3, 'S-a desconectat de pe server cu $100.010.300.956 / $161.074.', '19/03/2023 - 17:11:16', 4, '82.77.76.157'),
(78, 3, 'S-a desconectat de pe server cu $100.010.300.856 / $161.074.', '19/03/2023 - 17:14:09', 4, '82.77.76.157'),
(79, 4, '(chat) re', '19/03/2023 - 17:17:10', 9, '82.77.245.29'),
(80, 2, '(chat) re', '19/03/2023 - 17:17:12', 9, '188.27.152.80'),
(81, 2, '(chat) sa termini tutorialul ok', '19/03/2023 - 17:17:16', 9, '188.27.152.80'),
(82, 4, '(chat) a ok', '19/03/2023 - 17:17:20', 9, '82.77.245.29'),
(83, 4, '(chat) duma dmv', '19/03/2023 - 17:17:23', 9, '82.77.245.29'),
(84, 4, '(chat) o bicla', '19/03/2023 - 17:17:26', 9, '82.77.245.29'),
(85, 2, '(chat) poftim', '19/03/2023 - 17:17:33', 9, '188.27.152.80'),
(86, 4, '(chat) n am licenta', '19/03/2023 - 17:17:38', 9, '82.77.245.29'),
(87, 4, '(chat) =_)', '19/03/2023 - 17:17:40', 9, '82.77.245.29'),
(88, 2, '(chat) clar', '19/03/2023 - 17:17:40', 9, '188.27.152.80'),
(89, 4, '(chat)  spawncar 410', '19/03/2023 - 17:17:47', 9, '82.77.245.29'),
(90, 4, '(chat) wa', '19/03/2023 - 17:20:35', 9, '82.77.245.29'),
(91, 2, '(chat) place sv ul?', '19/03/2023 - 17:20:56', 9, '188.27.152.80'),
(92, 4, '(chat) da', '19/03/2023 - 17:20:58', 9, '82.77.245.29'),
(93, 4, '(chat) ba', '19/03/2023 - 17:21:42', 9, '82.77.245.29'),
(94, 2, '(chat) da', '19/03/2023 - 17:21:52', 9, '188.27.152.80'),
(95, 4, '(chat) da fondator madalin sau nu cauta', '19/03/2023 - 17:22:01', 9, '82.77.245.29'),
(96, 2, '(chat) nush', '19/03/2023 - 17:22:24', 9, '188.27.152.80'),
(97, 4, '(chat) da mi dis lui', '19/03/2023 - 17:22:30', 9, '82.77.245.29'),
(98, 4, '(chat) in pv pe dis', '19/03/2023 - 17:22:40', 9, '82.77.245.29'),
(99, 2, '(chat) ok', '19/03/2023 - 17:22:46', 9, '188.27.152.80'),
(100, 4, '(chat) a re', '19/03/2023 - 17:23:08', 9, '82.77.245.29'),
(101, 3, '(chat) ba', '19/03/2023 - 17:23:08', 9, '82.77.76.157'),
(102, 3, '(chat) re', '19/03/2023 - 17:23:10', 9, '82.77.76.157'),
(103, 4, '(chat) da ?', '19/03/2023 - 17:23:11', 9, '82.77.245.29'),
(104, 3, '(chat) pentru admin vom da teste ', '19/03/2023 - 17:23:19', 9, '82.77.76.157'),
(105, 3, '(chat) daca vrei', '19/03/2023 - 17:23:25', 9, '82.77.76.157'),
(106, 4, '(chat) ?', '19/03/2023 - 17:23:25', 9, '82.77.245.29'),
(107, 4, '(chat) eu ?', '19/03/2023 - 17:23:28', 9, '82.77.245.29'),
(108, 3, '(chat) da', '19/03/2023 - 17:23:34', 9, '82.77.76.157'),
(109, 3, '(chat) mi-a zis deiman', '19/03/2023 - 17:23:42', 9, '82.77.76.157'),
(110, 4, '(chat) pai ce adm imi dai ?', '19/03/2023 - 17:23:44', 9, '82.77.245.29'),
(111, 4, '(chat) ca nu inteleg', '19/03/2023 - 17:23:48', 9, '82.77.245.29'),
(112, 4, '(chat) ..', '19/03/2023 - 17:23:50', 9, '82.77.245.29'),
(113, 3, '(chat) pai admin 1 de inceput', '19/03/2023 - 17:23:55', 9, '82.77.76.157'),
(114, 4, '(chat) ok', '19/03/2023 - 17:23:58', 9, '82.77.245.29'),
(115, 3, '(chat) cu un test', '19/03/2023 - 17:24:00', 9, '82.77.76.157'),
(116, 4, '(chat) cum ies ba', '19/03/2023 - 17:24:04', 9, '82.77.245.29'),
(117, 3, '(chat) dar dam mai tz', '19/03/2023 - 17:24:04', 9, '82.77.76.157'),
(118, 3, '(chat) asteapta', '19/03/2023 - 17:24:10', 9, '82.77.76.157'),
(119, 4, '(chat) nu cauti co sau cv ?', '19/03/2023 - 17:24:54', 9, '82.77.245.29'),
(120, 3, '(chat) da', '19/03/2023 - 17:24:54', 9, '82.77.76.157'),
(121, 3, '(chat) momentan nu ', '19/03/2023 - 17:25:05', 9, '82.77.76.157'),
(122, 4, '(chat) a ok', '19/03/2023 - 17:25:09', 9, '82.77.245.29'),
(123, 4, '(chat) ca ma oferam eu', '19/03/2023 - 17:25:13', 9, '82.77.245.29'),
(124, 3, '(chat) abea l-am luat', '19/03/2023 - 17:25:14', 9, '82.77.76.157'),
(125, 3, '(chat) ok', '19/03/2023 - 17:25:16', 9, '82.77.76.157'),
(126, 4, '(chat) daca vr iti pot fi', '19/03/2023 - 17:25:45', 9, '82.77.245.29'),
(127, 2, 'S-a desconectat de pe server cu $20.174.619 / $756.303.', '19/03/2023 - 17:25:56', 4, '255.255.255.255'),
(128, 3, 'S-a desconectat de pe server cu $100.010.300.756 / $161.074.', '19/03/2023 - 17:31:18', 4, '82.77.76.157'),
(129, 4, 'S-a desconectat de pe server cu $20.274.021 / $0.', '19/03/2023 - 17:32:08', 4, '255.255.255.255'),
(130, 5, 'S-a desconectat de pe server cu $99.900 / $0.', '19/03/2023 - 18:16:49', 4, '5.14.128.167'),
(131, 6, '(chat) re', '19/03/2023 - 18:32:12', 9, '94.176.5.142'),
(132, 3, '(chat) re :)', '19/03/2023 - 18:32:15', 9, '178.138.97.180'),
(133, 6, '(chat) ba da asta e sv tau', '19/03/2023 - 18:32:18', 9, '94.176.5.142'),
(134, 6, '(chat) adc doar al tau', '19/03/2023 - 18:32:21', 9, '94.176.5.142'),
(135, 6, '(chat) ?', '19/03/2023 - 18:32:21', 9, '94.176.5.142'),
(136, 3, '(chat) dap', '19/03/2023 - 18:32:38', 9, '178.138.97.180'),
(137, 6, '(chat) :)', '19/03/2023 - 18:32:40', 9, '94.176.5.142'),
(138, 6, '(chat) pai si cn mai e adm 7?', '19/03/2023 - 18:32:45', 9, '94.176.5.142'),
(139, 3, 'S-a desconectat de pe server cu $100.010.300.656 / $161.074.', '19/03/2023 - 18:32:55', 4, '178.138.97.180'),
(140, 6, '(chat) adc ', '19/03/2023 - 18:34:51', 9, '94.176.5.142'),
(141, 6, '(chat) 7-8', '19/03/2023 - 18:34:55', 9, '94.176.5.142'),
(142, 6, '(chat) playeri', '19/03/2023 - 18:34:57', 9, '94.176.5.142'),
(143, 3, '(chat) e bun,e', '19/03/2023 - 18:35:00', 9, '178.138.97.180'),
(144, 6, '(chat) 100', '19/03/2023 - 18:35:01', 9, '94.176.5.142'),
(145, 3, '(chat) bun**', '19/03/2023 - 18:35:03', 9, '178.138.97.180'),
(146, 6, '(chat) g', '19/03/2023 - 18:35:06', 9, '94.176.5.142'),
(147, 3, '(chat) Bug?', '19/03/2023 - 18:35:22', 9, '178.138.97.180'),
(148, 3, '(chat) e Bug sau?', '19/03/2023 - 18:35:28', 9, '178.138.97.180'),
(149, 6, '(chat) nu e surfly', '19/03/2023 - 18:35:35', 9, '94.176.5.142'),
(150, 6, '(chat) mi se proneste', '19/03/2023 - 18:35:38', 9, '94.176.5.142'),
(151, 6, '(chat) singur', '19/03/2023 - 18:35:40', 9, '94.176.5.142'),
(152, 3, '(chat) a', '19/03/2023 - 18:35:49', 9, '178.138.97.180'),
(153, 3, '(chat) k', '19/03/2023 - 18:35:50', 9, '178.138.97.180'),
(154, 6, '(chat) ba da deiman', '19/03/2023 - 18:35:52', 9, '94.176.5.142'),
(155, 3, '(chat) asa ', '19/03/2023 - 18:35:53', 9, '178.138.97.180'),
(156, 6, '(chat) ce face?', '19/03/2023 - 18:35:55', 9, '94.176.5.142'),
(157, 6, '(chat) nu mai are sv', '19/03/2023 - 18:35:57', 9, '94.176.5.142'),
(158, 3, '(chat) are altul', '19/03/2023 - 18:36:01', 9, '178.138.97.180'),
(159, 3, '(chat) uitel:)', '19/03/2023 - 18:36:09', 9, '178.138.97.180'),
(160, 3, '(chat) asa', '19/03/2023 - 18:36:21', 9, '178.138.97.180'),
(161, 6, '(chat) ai cumparat sv?', '19/03/2023 - 18:36:24', 9, '94.176.5.142'),
(162, 3, '(chat) si ce admin vr', '19/03/2023 - 18:36:26', 9, '178.138.97.180'),
(163, 3, '(chat) da', '19/03/2023 - 18:36:29', 9, '178.138.97.180'),
(164, 6, '(chat) pai co', '19/03/2023 - 18:36:30', 9, '94.176.5.142'),
(165, 6, '(chat) dai g', '19/03/2023 - 18:36:34', 9, '94.176.5.142'),
(166, 3, '(chat) ba', '19/03/2023 - 18:36:37', 9, '178.138.97.180'),
(167, 3, '(chat) iti dau 5 de inceput e bine?', '19/03/2023 - 18:36:45', 9, '178.138.97.180'),
(168, 6, '(chat) e ok', '19/03/2023 - 18:36:50', 9, '94.176.5.142'),
(169, 3, '(chat) pe viitor mai vedem ', '19/03/2023 - 18:36:55', 9, '178.138.97.180'),
(170, 6, '(chat) ms', '19/03/2023 - 18:37:26', 9, '94.176.5.142'),
(171, 3, '(chat) bug', '19/03/2023 - 18:37:36', 9, '178.138.97.180'),
(172, 6, '(chat) te superi daca dau cu surfly pana la job?', '19/03/2023 - 18:37:38', 9, '94.176.5.142'),
(173, 3, '(chat) nup', '19/03/2023 - 18:37:44', 9, '178.138.97.180'),
(174, 3, '(chat) e hack?', '19/03/2023 - 18:38:01', 9, '178.138.97.180'),
(175, 3, '(chat) sau', '19/03/2023 - 18:38:03', 9, '178.138.97.180'),
(176, 6, '(chat) dao', '19/03/2023 - 18:38:04', 9, '94.176.5.142'),
(177, 6, '(chat) dap', '19/03/2023 - 18:38:05', 9, '94.176.5.142'),
(178, 3, '(chat) ba', '19/03/2023 - 18:38:08', 9, '178.138.97.180'),
(179, 6, '(chat) ?', '19/03/2023 - 18:38:10', 9, '94.176.5.142'),
(180, 3, '(chat) cand deschid sv sa nu mai dai ok?', '19/03/2023 - 18:38:24', 9, '178.138.97.180'),
(181, 6, '(chat) ok', '19/03/2023 - 18:38:28', 9, '94.176.5.142'),
(182, 3, '(chat) pana una alta ai voie', '19/03/2023 - 18:38:29', 9, '178.138.97.180'),
(183, 6, '(chat) da cand deschizi', '19/03/2023 - 18:38:31', 9, '94.176.5.142'),
(184, 3, '(chat) pana la deschidere', '19/03/2023 - 18:38:36', 9, '178.138.97.180'),
(185, 3, '(chat) saptamana asta', '19/03/2023 - 18:38:44', 9, '178.138.97.180'),
(186, 6, '(chat) ok', '19/03/2023 - 18:38:51', 9, '94.176.5.142'),
(187, 3, '(chat) gen vineri cred', '19/03/2023 - 18:38:55', 9, '178.138.97.180'),
(188, 3, 'S-a desconectat de pe server cu $100.010.300.556 / $161.074.', '19/03/2023 - 18:39:18', 4, '178.138.97.180'),
(189, 2, 'S-a desconectat de pe server cu $20.164.519 / $756.303.', '19/03/2023 - 18:46:37', 4, '255.255.255.255'),
(190, 6, 'S-a desconectat de pe server cu $20.133.380 / $0.', '19/03/2023 - 18:46:52', 4, '255.255.255.255'),
(191, 3, 'S-a desconectat de pe server cu $100.010.296.456 / $4.669.033.', '19/03/2023 - 19:02:07', 4, '178.138.97.180'),
(192, 7, '(chat) re', '19/03/2023 - 19:16:41', 9, '93.122.249.126'),
(193, 3, '(chat) hau mailu', '19/03/2023 - 19:16:41', 9, '178.138.97.180'),
(194, 3, '(chat) hau mau* :)', '19/03/2023 - 19:16:49', 9, '178.138.97.180'),
(195, 3, '(chat) ba', '19/03/2023 - 19:17:33', 9, '178.138.97.180'),
(196, 7, '(chat) da', '19/03/2023 - 19:17:43', 9, '93.122.249.126'),
(197, 3, '(chat) nmk 1-0 :))', '19/03/2023 - 19:17:51', 9, '178.138.97.180'),
(198, 7, '(chat) ba', '19/03/2023 - 19:17:59', 9, '93.122.249.126'),
(199, 3, '(chat) nmk 2-0 :)', '19/03/2023 - 19:18:08', 9, '178.138.97.180'),
(200, 7, '(chat) ba', '19/03/2023 - 19:18:13', 9, '93.122.249.126'),
(201, 7, '(chat) acum serios ba', '19/03/2023 - 19:18:25', 9, '93.122.249.126'),
(202, 3, '(chat) nmk 3-0 :)', '19/03/2023 - 19:18:26', 9, '178.138.97.180'),
(203, 3, '(chat) e', '19/03/2023 - 19:18:28', 9, '178.138.97.180'),
(204, 7, '(chat) acum serios ba', '19/03/2023 - 19:18:28', 9, '93.122.249.126'),
(205, 7, '(chat) 3-3 ha', '19/03/2023 - 19:18:35', 9, '93.122.249.126'),
(206, 3, '(chat) :))))', '19/03/2023 - 19:18:43', 9, '178.138.97.180'),
(207, 3, '(chat) ba urca', '19/03/2023 - 19:19:00', 9, '178.138.97.180'),
(208, 7, '(chat) gt', '19/03/2023 - 19:19:01', 9, '93.122.249.126'),
(209, 3, '(chat) asa', '19/03/2023 - 19:19:02', 9, '178.138.97.180'),
(210, 7, '(chat) dami lvl3', '19/03/2023 - 19:19:07', 9, '93.122.249.126'),
(211, 3, '(chat) pune un cp pe mapa :)', '19/03/2023 - 19:19:08', 9, '178.138.97.180'),
(212, 7, '(chat) dami lvl3', '19/03/2023 - 19:19:11', 9, '93.122.249.126'),
(213, 7, '(chat) dami lvl 3', '19/03/2023 - 19:19:30', 9, '93.122.249.126'),
(214, 3, '(chat) hooo', '19/03/2023 - 19:19:37', 9, '178.138.97.180'),
(215, 7, '(chat) hade', '19/03/2023 - 19:20:00', 9, '93.122.249.126'),
(216, 7, '(chat) hai ama', '19/03/2023 - 19:20:18', 9, '93.122.249.126'),
(217, 7, '(chat) ms', '19/03/2023 - 19:20:35', 9, '93.122.249.126'),
(218, 3, '(chat) ba', '19/03/2023 - 19:20:42', 9, '178.138.97.180'),
(219, 3, '(chat) b@', '19/03/2023 - 19:23:35', 9, '178.138.97.180'),
(220, 3, '(chat) ba', '19/03/2023 - 19:23:36', 9, '178.138.97.180'),
(221, 7, '(chat) cum dau teleport', '19/03/2023 - 19:23:37', 9, '93.122.249.126'),
(222, 3, '(chat) ./goto id', '19/03/2023 - 19:23:48', 9, '178.138.97.180'),
(223, 7, '(chat) ba cum merg pe sus', '19/03/2023 - 19:23:49', 9, '93.122.249.126'),
(224, 3, '(chat) doar pe PC poti', '19/03/2023 - 19:23:57', 9, '178.138.97.180'),
(225, 3, '(chat) cu /fly', '19/03/2023 - 19:24:00', 9, '178.138.97.180'),
(226, 7, '(chat) e pula', '19/03/2023 - 19:24:01', 9, '93.122.249.126'),
(227, 3, '(chat) ./fly sa te opresti', '19/03/2023 - 19:24:18', 9, '178.138.97.180'),
(228, 7, '(chat) ma duc sa I fac sampu', '19/03/2023 - 19:24:29', 9, '93.122.249.126'),
(229, 3, '(chat) k', '19/03/2023 - 19:24:38', 9, '178.138.97.180'),
(230, 7, 'S-a desconectat de pe server cu $140.659 / $0.', '19/03/2023 - 19:24:43', 4, '93.122.249.126'),
(231, 3, '(chat) gotocp', '19/03/2023 - 19:27:29', 9, '178.138.97.180'),
(232, 3, 'S-a desconectat de pe server cu $100.010.362.252 / $4.669.033.', '19/03/2023 - 19:28:24', 4, '178.138.97.180'),
(233, 3, 'S-a desconectat de pe server cu $100.010.923.541 / $4.669.033.', '19/03/2023 - 19:37:41', 4, '82.77.76.157'),
(234, 3, 'S-a desconectat de pe server cu $100.010.913.441 / $4.669.033.', '19/03/2023 - 19:45:36', 4, '82.77.76.157'),
(235, 3, 'S-a desconectat de pe server cu $100.010.913.341 / $4.669.033.', '19/03/2023 - 21:31:38', 4, '94.176.5.142'),
(236, 8, '(chat) admins', '19/03/2023 - 21:33:59', 9, '82.79.79.218'),
(237, 3, 'S-a desconectat de pe server cu $100.010.913.241 / $4.669.033.', '19/03/2023 - 21:36:09', 4, '255.255.255.255'),
(238, 6, 'S-a desconectat de pe server cu $20.133.280 / $0.', '19/03/2023 - 21:36:09', 4, '255.255.255.255'),
(239, 3, '(chat)  ba', '19/03/2023 - 21:36:43', 9, '82.77.76.157'),
(240, 8, '(chat) da', '19/03/2023 - 21:36:53', 9, '82.79.79.218'),
(241, 3, '(chat) de unde ai tu Rank 7?', '19/03/2023 - 21:36:56', 9, '82.77.76.157'),
(242, 3, '(chat) zi', '19/03/2023 - 21:37:16', 9, '82.77.76.157'),
(243, 8, '(chat) stai', '19/03/2023 - 21:37:29', 9, '82.79.79.218'),
(244, 3, '(chat) ziiiii', '19/03/2023 - 21:38:06', 9, '82.77.76.157'),
(245, 3, '(chat) ca iti dau ban', '19/03/2023 - 21:38:12', 9, '82.77.76.157'),
(246, 8, '(chat) de l', '19/03/2023 - 21:38:17', 9, '82.79.79.218'),
(247, 8, '(chat) Nush', '19/03/2023 - 21:38:20', 9, '82.79.79.218'),
(248, 8, '(chat) sa spart sv', '19/03/2023 - 21:38:24', 9, '82.79.79.218'),
(249, 8, '(chat) si mi a dat adm', '19/03/2023 - 21:38:28', 9, '82.79.79.218'),
(250, 3, '(chat) cum nu sti??', '19/03/2023 - 21:38:28', 9, '82.77.76.157'),
(251, 3, '(chat) da da ', '19/03/2023 - 21:38:37', 9, '82.77.76.157'),
(252, 3, '(chat) hai sall', '19/03/2023 - 21:38:43', 9, '82.77.76.157'),
(253, 8, '(chat) da eu faceam rutorial', '19/03/2023 - 21:38:45', 9, '82.79.79.218'),
(254, 8, '(chat) tutorial', '19/03/2023 - 21:38:48', 9, '82.79.79.218'),
(255, 3, '(chat) ba', '19/03/2023 - 21:38:49', 9, '82.77.76.157'),
(256, 3, '(chat) dai /set', '19/03/2023 - 21:38:56', 9, '82.77.76.157'),
(257, 3, '(chat) .setadmin 1 0', '19/03/2023 - 21:39:06', 9, '82.77.76.157'),
(258, 3, '(chat) .setadmin 1 0 asa', '19/03/2023 - 21:39:09', 9, '82.77.76.157'),
(259, 3, '(chat) asa', '19/03/2023 - 21:39:27', 9, '82.77.76.157'),
(260, 3, '(chat) bun', '19/03/2023 - 21:39:55', 9, '82.77.76.157'),
(261, 3, '(chat) ba', '19/03/2023 - 21:40:17', 9, '82.77.76.157'),
(262, 8, '(chat) da', '19/03/2023 - 21:40:21', 9, '82.79.79.218'),
(263, 3, '(chat) cum avea ala numele', '19/03/2023 - 21:40:26', 9, '82.77.76.157'),
(264, 8, '(chat) cine', '19/03/2023 - 21:40:29', 9, '82.79.79.218'),
(265, 3, '(chat) de Tia dat admin', '19/03/2023 - 21:40:32', 9, '82.77.76.157'),
(266, 8, '(chat) nush eu faceam tutorialul si vad ca am adm 7', '19/03/2023 - 21:40:41', 9, '82.79.79.218'),
(267, 3, '(chat) cred ca e un bug', '19/03/2023 - 21:41:00', 9, '82.77.76.157'),
(268, 3, '(chat) am sa verific', '19/03/2023 - 21:41:04', 9, '82.77.76.157'),
(269, 8, '(chat) ok', '19/03/2023 - 21:41:09', 9, '82.79.79.218'),
(270, 8, '(chat) ms', '19/03/2023 - 21:41:34', 9, '82.79.79.218'),
(271, 3, '(chat) set', '19/03/2023 - 21:43:33', 9, '82.77.76.157'),
(272, 3, '(chat) poti sa te joci re', '19/03/2023 - 21:44:37', 9, '82.77.76.157'),
(273, 8, '(chat) re', '19/03/2023 - 21:44:45', 9, '82.79.79.218'),
(274, 8, '(chat) poti sami aduci o masina', '19/03/2023 - 21:44:57', 9, '82.79.79.218'),
(275, 3, '(chat) :))', '19/03/2023 - 21:45:01', 9, '82.77.76.157'),
(276, 3, '(chat) pwp', '19/03/2023 - 21:45:03', 9, '82.77.76.157'),
(277, 8, '(chat) :)', '19/03/2023 - 21:45:04', 9, '82.79.79.218'),
(278, 8, '(chat) si eu', '19/03/2023 - 21:45:07', 9, '82.79.79.218'),
(279, 3, '(chat) st', '19/03/2023 - 21:45:09', 9, '82.77.76.157'),
(280, 8, '(chat) urci', '19/03/2023 - 21:45:10', 9, '82.79.79.218'),
(281, 8, '(chat) ok', '19/03/2023 - 21:45:13', 9, '82.79.79.218'),
(282, 3, '(chat) vineri deschid sv sa iti aduci prieteni da? :)', '19/03/2023 - 21:45:29', 9, '82.77.76.157'),
(283, 8, '(chat) da', '19/03/2023 - 21:45:35', 9, '82.79.79.218'),
(284, 3, '(chat) hai sa dam o tura', '19/03/2023 - 21:45:44', 9, '82.77.76.157'),
(285, 8, '(chat) si pe dadu nu :))))', '19/03/2023 - 21:45:45', 9, '82.79.79.218'),
(286, 3, '(chat) ba', '19/03/2023 - 21:45:48', 9, '82.77.76.157'),
(287, 8, '(chat) da', '19/03/2023 - 21:45:52', 9, '82.79.79.218'),
(288, 3, '(chat) vr sa dai un test pentru helper?', '19/03/2023 - 21:45:58', 9, '82.77.76.157'),
(289, 3, '(chat) am nev de helperi', '19/03/2023 - 21:46:03', 9, '82.77.76.157'),
(290, 8, '(chat) si ce primesc', '19/03/2023 - 21:46:13', 9, '82.79.79.218'),
(291, 3, '(chat) pai helper 1 ', '19/03/2023 - 21:46:22', 9, '82.77.76.157'),
(292, 8, '(chat) ba', '19/03/2023 - 21:46:29', 9, '82.79.79.218'),
(293, 3, '(chat) ?', '19/03/2023 - 21:46:35', 9, '82.77.76.157'),
(294, 8, '(chat) dc iai dat ban lui dadu', '19/03/2023 - 21:46:37', 9, '82.79.79.218'),
(295, 3, '(chat) nu i-am dat', '19/03/2023 - 21:46:47', 9, '82.77.76.157'),
(296, 8, '(chat) poti sai dai unban', '19/03/2023 - 21:46:48', 9, '82.79.79.218'),
(297, 8, '(chat) a', '19/03/2023 - 21:46:54', 9, '82.79.79.218'),
(298, 3, '(chat) cum are numele?', '19/03/2023 - 21:46:55', 9, '82.77.76.157'),
(299, 8, '(chat) DaduAdv', '19/03/2023 - 21:47:01', 9, '82.79.79.218'),
(300, 3, '(chat) nu e banat', '19/03/2023 - 21:47:23', 9, '82.77.76.157'),
(301, 3, '(chat) spune-i sa intre', '19/03/2023 - 21:47:27', 9, '82.77.76.157'),
(302, 3, '(chat) esti gata sa dai testul?', '19/03/2023 - 21:47:58', 9, '82.77.76.157'),
(303, 8, '(chat) iam spus', '19/03/2023 - 21:47:59', 9, '82.79.79.218'),
(304, 8, '(chat) da', '19/03/2023 - 21:48:02', 9, '82.79.79.218'),
(305, 3, '(chat) bun ', '19/03/2023 - 21:48:08', 9, '82.77.76.157'),
(306, 3, '(chat) 3/3 picat ', '19/03/2023 - 21:48:12', 9, '82.77.76.157'),
(307, 3, '(chat) crash 5 min sa revi', '19/03/2023 - 21:48:18', 9, '82.77.76.157'),
(308, 8, '(chat) stiu', '19/03/2023 - 21:48:20', 9, '82.79.79.218'),
(309, 3, '(chat) ok', '19/03/2023 - 21:48:23', 9, '82.77.76.157'),
(310, 3, '(chat) 1 cu ce se ocupa un helper?', '19/03/2023 - 21:48:31', 9, '82.77.76.157'),
(311, 8, '(chat) cu intrebarile de pe /n', '19/03/2023 - 21:48:44', 9, '82.79.79.218'),
(312, 3, 'Madalin31 si-a achizitionat un MP3 pentru 55 Premium Points.', '19/03/2023 - 21:48:46', 1, '82.77.76.157'),
(313, 3, '(chat) ok', '19/03/2023 - 21:48:50', 9, '82.77.76.157'),
(314, 8, '(chat) dai unban all', '19/03/2023 - 21:49:04', 9, '82.79.79.218'),
(315, 8, '(chat) ca are un bug', '19/03/2023 - 21:49:09', 9, '82.79.79.218'),
(316, 3, '(chat) 2 daca doi membri se cearta ce faci?', '19/03/2023 - 21:49:09', 9, '82.77.76.157'),
(317, 3, '(chat) am dat', '19/03/2023 - 21:49:11', 9, '82.77.76.157'),
(318, 3, '(chat) am dat din nou', '19/03/2023 - 21:49:24', 9, '82.77.76.157'),
(319, 8, '(chat) fac poza si ii trimit lui baiatu de a facut sv de exemplu tu', '19/03/2023 - 21:49:44', 9, '82.79.79.218'),
(320, 3, '(chat) bun', '19/03/2023 - 21:49:57', 9, '82.77.76.157'),
(321, 3, '(chat) 3 daca un jucator are hack ce faci?', '19/03/2023 - 21:50:12', 9, '82.77.76.157'),
(322, 8, '(chat) ii fac poza si anunt un admin', '19/03/2023 - 21:50:25', 9, '82.79.79.218'),
(323, 3, '(chat) bunn', '19/03/2023 - 21:50:33', 9, '82.77.76.157'),
(324, 3, '(chat) daca un admin de Rank 1/3 da  ban aiurea unui jucator si tu vezi asta ce vei face?', '19/03/2023 - 21:51:11', 9, '82.77.76.157'),
(325, 8, '(chat) ii fac post si ii trmit fondatorului', '19/03/2023 - 21:51:50', 9, '82.79.79.218'),
(326, 3, '(chat) bun', '19/03/2023 - 21:52:01', 9, '82.77.76.157'),
(327, 3, '(chat) ai voie sa faci  TAB HACK ?', '19/03/2023 - 21:52:39', 9, '82.77.76.157'),
(328, 8, '(chat) adica asa', '19/03/2023 - 21:52:49', 9, '82.79.79.218'),
(329, 3, '(chat) da', '19/03/2023 - 21:52:54', 9, '82.77.76.157'),
(330, 8, '(chat) nu', '19/03/2023 - 21:53:01', 9, '82.79.79.218'),
(331, 3, '(chat) cu ce vei fi sanctionat?', '19/03/2023 - 21:53:13', 9, '82.77.76.157'),
(332, 8, '(chat) cu scoateres helperului', '19/03/2023 - 21:53:25', 9, '82.79.79.218'),
(333, 3, '(chat) doar atat?', '19/03/2023 - 21:53:31', 9, '82.77.76.157'),
(334, 8, '(chat) si ban', '19/03/2023 - 21:53:35', 9, '82.79.79.218'),
(335, 3, '(chat) cate zile?', '19/03/2023 - 21:53:41', 9, '82.77.76.157'),
(336, 8, '(chat) 300', '19/03/2023 - 21:53:46', 9, '82.79.79.218'),
(337, 8, '(chat) 30', '19/03/2023 - 21:53:48', 9, '82.79.79.218'),
(338, 3, '(chat) mai gandestete', '19/03/2023 - 21:53:54', 9, '82.77.76.157'),
(339, 3, '(chat) :)', '19/03/2023 - 21:53:56', 9, '82.77.76.157'),
(340, 8, '(chat) permanent', '19/03/2023 - 21:53:59', 9, '82.79.79.218'),
(341, 3, '(chat) e mult rauu', '19/03/2023 - 21:54:00', 9, '82.77.76.157'),
(342, 3, '(chat) sigur?', '19/03/2023 - 21:54:06', 9, '82.77.76.157'),
(343, 8, '(chat) da', '19/03/2023 - 21:54:09', 9, '82.79.79.218'),
(344, 3, '(chat) scz dar nu', '19/03/2023 - 21:54:14', 9, '82.77.76.157'),
(345, 8, '(chat) da cate zile', '19/03/2023 - 21:54:20', 9, '82.79.79.218'),
(346, 3, '(chat) 0.50/3', '19/03/2023 - 21:54:20', 9, '82.77.76.157'),
(347, 3, '(chat) 3 sile', '19/03/2023 - 21:54:23', 9, '82.77.76.157'),
(348, 3, '(chat) zile*', '19/03/2023 - 21:54:27', 9, '82.77.76.157'),
(349, 3, '(chat) acum vom trece la cateva intrebari legate de server', '19/03/2023 - 21:55:16', 9, '82.77.76.157'),
(350, 3, '(chat) vi raspunde cu nre', '19/03/2023 - 21:55:33', 9, '82.77.76.157'),
(351, 8, '(chat) ok', '19/03/2023 - 21:55:47', 9, '82.79.79.218'),
(352, 3, '(chat) cum pun vip pe o masina?', '19/03/2023 - 21:56:00', 9, '82.77.76.157'),
(353, 8, '(chat) scz', '19/03/2023 - 21:56:01', 9, '82.79.79.218'),
(354, 3, '(chat) st', '19/03/2023 - 21:56:03', 9, '82.77.76.157'),
(355, 8, '(chat)  /nre Pentru a face accest lucru foloseste comanda /v si acolo va aparea', '19/03/2023 - 21:56:27', 9, '82.79.79.218'),
(356, 3, '(chat) e bine dar trebe mai explicit', '19/03/2023 - 21:56:58', 9, '82.77.76.157'),
(357, 3, '(chat) gen', '19/03/2023 - 21:57:00', 9, '82.77.76.157'),
(358, 8, '(chat) okey', '19/03/2023 - 21:57:24', 9, '82.79.79.218'),
(359, 3, '(chat)  /ner salut! pentru a face acest lucru folositi comanda /v-vehiculul ales si apasati pe \"wpgrate to vehicle vip', '19/03/2023 - 21:57:59', 9, '82.77.76.157'),
(360, 8, 'S-a desconectat de pe server cu $1.215.752.192 / $0.', '19/03/2023 - 21:58:05', 4, '82.79.79.218'),
(361, 3, '(chat) cam asa', '19/03/2023 - 21:58:05', 9, '82.77.76.157'),
(362, 3, '(chat) ah', '19/03/2023 - 22:00:08', 9, '82.77.76.157'),
(363, 3, '(chat) s', '19/03/2023 - 22:15:03', 9, '82.77.76.157'),
(364, 3, 'S-a desconectat de pe server cu $100.010.879.141 / $9.204.454.', '19/03/2023 - 22:15:24', 4, '82.77.76.157'),
(365, 3, '(chat) cf wa', '19/03/2023 - 22:40:07', 9, '82.77.76.157'),
(366, 10, '(chat) done', '19/03/2023 - 22:41:08', 9, '188.25.23.238'),
(367, 3, '(chat) cum e sv? :)', '19/03/2023 - 22:41:23', 9, '82.77.76.157'),
(368, 10, '(chat) bun', '19/03/2023 - 22:41:32', 9, '188.25.23.238'),
(369, 3, '(chat) sus', '19/03/2023 - 22:41:56', 9, '82.77.76.157'),
(370, 3, '(chat) ba', '19/03/2023 - 22:42:28', 9, '82.77.76.157'),
(371, 10, '(chat) ?', '19/03/2023 - 22:42:33', 9, '188.25.23.238'),
(372, 3, '(chat) tu cand deschizi sv?', '19/03/2023 - 22:42:36', 9, '82.77.76.157'),
(373, 10, '(chat) maine la 2', '19/03/2023 - 22:42:42', 9, '188.25.23.238'),
(374, 10, '(chat) :)))) nusj ', '19/03/2023 - 22:42:59', 9, '188.25.23.238'),
(375, 3, '(chat) eu il deschid pe 24 pe la 4', '19/03/2023 - 22:43:12', 9, '82.77.76.157'),
(376, 10, '(chat) nu deschid frt nici un sv ce ai', '19/03/2023 - 22:43:23', 9, '188.25.23.238'),
(377, 3, '(chat) pai?', '19/03/2023 - 22:43:31', 9, '82.77.76.157'),
(378, 10, '(chat) daca te referi la ala lu ronni', '19/03/2023 - 22:43:35', 9, '188.25.23.238'),
(379, 10, '(chat) oe 25 ', '19/03/2023 - 22:43:39', 9, '188.25.23.238'),
(380, 10, '(chat) pe*', '19/03/2023 - 22:43:41', 9, '188.25.23.238'),
(381, 3, '(chat) pai nu era al tau?', '19/03/2023 - 22:43:45', 9, '82.77.76.157'),
(382, 10, '(chat) nu drk', '19/03/2023 - 22:43:49', 9, '188.25.23.238'),
(383, 3, '(chat) :)', '19/03/2023 - 22:43:54', 9, '82.77.76.157'),
(384, 3, '(chat) pai si tu o sa fi admin?', '19/03/2023 - 22:44:19', 9, '82.77.76.157'),
(385, 10, '(chat) owner', '19/03/2023 - 22:44:24', 9, '188.25.23.238'),
(386, 10, '(chat) acum nusj', '19/03/2023 - 22:44:30', 9, '188.25.23.238'),
(387, 3, '(chat) :))', '19/03/2023 - 22:44:52', 9, '82.77.76.157'),
(388, 3, '(chat) ba', '19/03/2023 - 22:46:05', 9, '82.77.76.157'),
(389, 10, '(chat) ?', '19/03/2023 - 22:46:11', 9, '188.25.23.238'),
(390, 3, '(chat) am rezolvat bug-ul ala de zicea ca au playeri hack', '19/03/2023 - 22:46:22', 9, '82.77.76.157'),
(391, 10, '(chat) bub', '19/03/2023 - 22:46:27', 9, '188.25.23.238'),
(392, 10, '(chat) n', '19/03/2023 - 22:46:28', 9, '188.25.23.238'),
(393, 3, '(chat) gen de spama pe chat la admin', '19/03/2023 - 22:46:30', 9, '82.77.76.157'),
(394, 3, '(chat) gen de spama pe chat la admini*', '19/03/2023 - 22:46:35', 9, '82.77.76.157'),
(395, 10, '(chat) da cine e scripter?', '19/03/2023 - 22:46:50', 9, '188.25.23.238'),
(396, 3, '(chat) daca iti spun nu ma crezi :)', '19/03/2023 - 22:47:06', 9, '82.77.76.157'),
(397, 10, '(chat) zi', '19/03/2023 - 22:47:10', 9, '188.25.23.238'),
(398, 3, '(chat) imogen:)', '19/03/2023 - 22:47:16', 9, '82.77.76.157'),
(399, 10, '(chat) stie ala sa scripteze?', '19/03/2023 - 22:47:29', 9, '188.25.23.238'),
(400, 3, '(chat) da', '19/03/2023 - 22:47:33', 9, '82.77.76.157'),
(401, 10, '(chat) eu cand o sa deschid sv meu RPG.REDDevills.ro o sa fie inaugurare mare', '19/03/2023 - 22:48:30', 9, '188.25.23.238'),
(402, 3, '(chat) :)', '19/03/2023 - 22:48:45', 9, '82.77.76.157'),
(403, 3, '(chat) e bine ', '19/03/2023 - 22:48:51', 9, '82.77.76.157'),
(404, 10, '(chat) cel putin 7 youtuberi vor face live', '19/03/2023 - 22:48:51', 9, '188.25.23.238'),
(405, 3, '(chat) ohoo', '19/03/2023 - 22:48:57', 9, '82.77.76.157'),
(406, 3, '(chat) e bine rau', '19/03/2023 - 22:49:02', 9, '82.77.76.157'),
(407, 10, '(chat) gm de la 0 de la prima linie', '19/03/2023 - 22:49:16', 9, '188.25.23.238'),
(408, 3, '(chat) trb sa gasesc si eu 2 yutuberi ', '19/03/2023 - 22:49:21', 9, '82.77.76.157'),
(409, 10, '(chat) totu original', '19/03/2023 - 22:49:24', 9, '188.25.23.238'),
(410, 3, '(chat) sa faca live', '19/03/2023 - 22:49:27', 9, '82.77.76.157'),
(411, 10, '(chat) da m ai e pana atunci', '19/03/2023 - 22:49:31', 9, '188.25.23.238'),
(412, 3, '(chat) e bine', '19/03/2023 - 22:49:32', 9, '82.77.76.157'),
(413, 10, '(chat) auzi sv lu shift de unde are gm?', '19/03/2023 - 22:50:36', 9, '188.25.23.238'),
(414, 3, '(chat) trebe sa invat si eu sa scriptezi :)', '19/03/2023 - 22:50:40', 9, '82.77.76.157'),
(415, 3, '(chat) nuj', '19/03/2023 - 22:50:45', 9, '82.77.76.157'),
(416, 10, '(chat) al stiu gm ala', '19/03/2023 - 22:50:51', 9, '188.25.23.238'),
(417, 3, '(chat) iti place?', '19/03/2023 - 22:50:52', 9, '82.77.76.157'),
(418, 10, '(chat) e gm de la oldtike', '19/03/2023 - 22:50:56', 9, '188.25.23.238'),
(419, 10, '(chat) oldtime', '19/03/2023 - 22:50:59', 9, '188.25.23.238'),
(420, 10, '(chat) alu lycser', '19/03/2023 - 22:51:04', 9, '188.25.23.238'),
(421, 3, '(chat) habar n-am ', '19/03/2023 - 22:51:05', 9, '82.77.76.157'),
(422, 3, '(chat) e fain sau?', '19/03/2023 - 22:51:13', 9, '82.77.76.157'),
(423, 10, '(chat) este', '19/03/2023 - 22:51:18', 9, '188.25.23.238'),
(424, 3, '(chat) daca vr incerc sa fac rost de el', '19/03/2023 - 22:51:32', 9, '82.77.76.157'),
(425, 3, '(chat) daca ai nevoie', '19/03/2023 - 22:51:36', 9, '82.77.76.157'),
(426, 10, '(chat) nu am nv eu ti am zis o sa am de la 0 tot', '19/03/2023 - 22:51:55', 9, '188.25.23.238'),
(427, 3, '(chat) ba', '19/03/2023 - 22:52:07', 9, '82.77.76.157'),
(428, 10, '(chat) o sa fac cv unic in lumea sampului', '19/03/2023 - 22:52:13', 9, '188.25.23.238'),
(429, 3, '(chat) eu incerc sa fac rost de gm-ul de pe mare.oglife', '19/03/2023 - 22:52:25', 9, '82.77.76.157'),
(430, 3, '(chat) :)', '19/03/2023 - 22:52:33', 9, '82.77.76.157'),
(431, 10, '(chat) ba ar merge gm de la crowland', '19/03/2023 - 22:52:56', 9, '188.25.23.238'),
(432, 3, '(chat) jade.oglife*', '19/03/2023 - 22:52:59', 9, '82.77.76.157'),
(433, 10, '(chat) e urat rau jade', '19/03/2023 - 22:53:11', 9, '188.25.23.238'),
(434, 3, '(chat) mi-e imi place sistemul ala de parkur', '19/03/2023 - 22:53:36', 9, '82.77.76.157'),
(435, 10, '(chat) gm moon eclipsed  bun rau ', '19/03/2023 - 22:54:21', 9, '188.25.23.238'),
(436, 10, '(chat) ca ala e gm de la crowland', '19/03/2023 - 22:54:29', 9, '188.25.23.238'),
(437, 3, '(chat) pai si de unde fac rost de el?', '19/03/2023 - 22:54:44', 9, '82.77.76.157'),
(438, 10, '(chat) dupa net', '19/03/2023 - 22:54:50', 9, '188.25.23.238'),
(439, 3, '(chat) poate incerc sa il bag', '19/03/2023 - 22:54:51', 9, '82.77.76.157'),
(440, 3, '(chat) dar momentan il tin pe asta', '19/03/2023 - 22:55:24', 9, '82.77.76.157'),
(441, 3, '(chat) sa vad cum merge ', '19/03/2023 - 22:55:31', 9, '82.77.76.157'),
(442, 3, '(chat) asta', '19/03/2023 - 22:55:38', 9, '82.77.76.157'),
(443, 10, '(chat) vi apel?', '19/03/2023 - 22:55:55', 9, '188.25.23.238'),
(444, 3, '(chat) ba nu pot acum ca sunt la Varu-miu ', '19/03/2023 - 22:56:24', 9, '82.77.76.157'),
(445, 3, '(chat) intram maine seata', '19/03/2023 - 22:56:32', 9, '82.77.76.157'),
(446, 3, '(chat) seara*', '19/03/2023 - 22:56:40', 9, '82.77.76.157'),
(447, 10, '(chat) revin', '19/03/2023 - 22:56:53', 9, '188.25.23.238'),
(448, 10, 'S-a desconectat de pe server cu $203.639 / $0.', '19/03/2023 - 22:56:55', 4, '255.255.255.255'),
(449, 3, '(chat) k', '19/03/2023 - 22:56:55', 9, '82.77.76.157'),
(450, 3, 'S-a desconectat de pe server cu $100.010.927.150 / $13.767.154.', '19/03/2023 - 23:00:00', 4, '82.77.76.157'),
(451, 3, 'S-a desconectat de pe server cu $100.010.927.050 / $13.767.154.', '20/03/2023 - 07:51:01', 4, '178.138.97.180'),
(452, 3, 'S-a desconectat de pe server cu $100.010.926.950 / $13.767.154.', '20/03/2023 - 08:36:05', 4, '178.138.97.180'),
(453, 3, 'S-a desconectat de pe server cu $100.010.946.706 / $18.354.264.', '20/03/2023 - 09:00:09', 4, '178.138.97.180'),
(454, 3, 'Madalin31 si-a cumparat un Bullet[2], (last money: $10.100.010.999.365 / new money: $10.099.580.999.365)', '20/03/2023 - 10:09:38', 5, '178.138.97.180'),
(455, 7, 'HALKFLORIN67 si-a upgradat vehiculul Infernus[id: 0] la unul RainBow pentru 200 Premium Points.', '20/03/2023 - 10:10:10', 1, '93.122.249.126'),
(456, 3, '(chat) :)', '20/03/2023 - 10:19:45', 9, '178.138.97.180'),
(457, 3, '(chat) se aude?', '20/03/2023 - 10:19:52', 9, '178.138.97.180'),
(458, 7, '(chat) nu', '20/03/2023 - 10:19:56', 9, '93.122.249.126'),
(459, 3, '(chat) pl', '20/03/2023 - 10:20:02', 9, '178.138.97.180'),
(460, 3, 'S-a desconectat de pe server cu $10.099.580.999.265 / $18.354.264.', '20/03/2023 - 10:28:32', 4, '178.138.97.180'),
(461, 3, '(chat) sall', '20/03/2023 - 10:38:07', 9, '178.138.97.180'),
(462, 3, '(chat) :))', '20/03/2023 - 10:38:10', 9, '178.138.97.180'),
(463, 3, '(chat) va astept in numar cat mai mare pe server ', '20/03/2023 - 10:39:44', 9, '178.138.97.180'),
(464, 7, '(chat) s-o postez', '20/03/2023 - 10:40:04', 9, '93.122.249.126'),
(465, 7, '(chat) vino', '20/03/2023 - 10:40:09', 9, '93.122.249.126'),
(466, 3, '(chat) da', '20/03/2023 - 10:40:10', 9, '178.138.97.180'),
(467, 7, '(chat) sterge pin /cmc', '20/03/2023 - 10:40:32', 9, '93.122.249.126'),
(468, 7, '(chat) pula', '20/03/2023 - 10:40:42', 9, '93.122.249.126'),
(469, 7, '(chat) ai pus dala warning', '20/03/2023 - 10:40:49', 9, '93.122.249.126'),
(470, 7, '(chat) sterge warnigun', '20/03/2023 - 10:41:00', 9, '93.122.249.126'),
(471, 3, '(chat) hai ', '20/03/2023 - 10:41:01', 9, '178.138.97.180'),
(472, 3, '(chat) cum? :)', '20/03/2023 - 10:41:07', 9, '178.138.97.180'),
(473, 7, '(chat) nus stii', '20/03/2023 - 10:41:14', 9, '93.122.249.126'),
(474, 3, '(chat) ba', '20/03/2023 - 10:41:16', 9, '178.138.97.180'),
(475, 7, '(chat) nu stiu', '20/03/2023 - 10:41:17', 9, '93.122.249.126'),
(476, 3, '(chat) fa asa', '20/03/2023 - 10:41:19', 9, '178.138.97.180'),
(477, 7, '(chat) ba', '20/03/2023 - 10:41:20', 9, '93.122.249.126'),
(478, 3, '(chat) dai /salute', '20/03/2023 - 10:41:26', 9, '178.138.97.180'),
(479, 7, '(chat) scoatema din admin ', '20/03/2023 - 10:41:29', 9, '93.122.249.126'),
(480, 7, '(chat) si', '20/03/2023 - 10:41:34', 9, '93.122.249.126'),
(481, 3, '(chat) ok', '20/03/2023 - 10:41:36', 9, '178.138.97.180'),
(482, 7, '(chat) stergi', '20/03/2023 - 10:41:36', 9, '93.122.249.126'),
(483, 7, '(chat) \Zi dupa ma bagi', '20/03/2023 - 10:41:39', 9, '93.122.249.126'),
(484, 3, '(chat) da', '20/03/2023 - 10:41:47', 9, '178.138.97.180'),
(485, 7, '(chat) dai /cmc', '20/03/2023 - 10:41:51', 9, '93.122.249.126'),
(486, 3, '(chat)  dai /salut', '20/03/2023 - 10:42:00', 9, '178.138.97.180'),
(487, 7, '(chat) dai /cmc', '20/03/2023 - 10:42:04', 9, '93.122.249.126'),
(488, 7, '(chat) eu stau /sit', '20/03/2023 - 10:42:12', 9, '93.122.249.126'),
(489, 3, '(chat) k', '20/03/2023 - 10:42:21', 9, '178.138.97.180'),
(490, 7, '(chat) dai /cm', '20/03/2023 - 10:42:27', 9, '93.122.249.126'),
(491, 7, '(chat) dai /cmc', '20/03/2023 - 10:42:28', 9, '93.122.249.126'),
(492, 3, '(chat) am dat ', '20/03/2023 - 10:42:34', 9, '178.138.97.180'),
(493, 7, '(chat) pula', '20/03/2023 - 10:42:39', 9, '93.122.249.126'),
(494, 7, '(chat) bagama ia', '20/03/2023 - 10:42:44', 9, '93.122.249.126'),
(495, 7, '(chat) bagama iar', '20/03/2023 - 10:42:46', 9, '93.122.249.126'),
(496, 7, '(chat)  ', '20/03/2023 - 10:42:59', 9, '93.122.249.126'),
(497, 3, '(chat) fa asa', '20/03/2023 - 10:43:01', 9, '178.138.97.180'),
(498, 7, '(chat) bn', '20/03/2023 - 10:43:04', 9, '93.122.249.126'),
(499, 3, '(chat) nu conteaza', '20/03/2023 - 10:43:05', 9, '178.138.97.180'),
(500, 7, '(chat) ba', '20/03/2023 - 10:43:06', 9, '93.122.249.126'),
(501, 7, '(chat) ba', '20/03/2023 - 10:43:07', 9, '93.122.249.126'),
(502, 7, '(chat) ba', '20/03/2023 - 10:43:09', 9, '93.122.249.126'),
(503, 7, '(chat) ba', '20/03/2023 - 10:43:10', 9, '93.122.249.126'),
(504, 3, '(chat) da', '20/03/2023 - 10:43:11', 9, '178.138.97.180'),
(505, 7, '(chat) ba', '20/03/2023 - 10:43:12', 9, '93.122.249.126'),
(506, 7, '(chat) ba', '20/03/2023 - 10:43:13', 9, '93.122.249.126'),
(507, 3, '(chat) daaaaa', '20/03/2023 - 10:43:17', 9, '178.138.97.180'),
(508, 7, '(chat) nmk 1-0', '20/03/2023 - 10:43:25', 9, '93.122.249.126'),
(509, 7, '(chat) salut ', '20/03/2023 - 10:43:39', 9, '93.122.249.126'),
(510, 3, '(chat) d', '20/03/2023 - 10:43:47', 9, '178.138.97.180'),
(511, 7, '(chat) ma duc postez videou', '20/03/2023 - 10:44:36', 9, '93.122.249.126'),
(512, 3, '(chat) ok', '20/03/2023 - 10:44:40', 9, '178.138.97.180'),
(513, 3, '(chat) deiman hai pe apel', '20/03/2023 - 10:44:45', 9, '178.138.97.180'),
(514, 2, '(chat) da', '20/03/2023 - 10:44:48', 9, '188.27.152.80'),
(515, 7, 'S-a desconectat de pe server cu $20.000.513.116.529 / $0.', '20/03/2023 - 10:44:55', 4, '93.122.249.126'),
(516, 3, 'S-a desconectat de pe server cu $10.099.580.989.165 / $18.354.264.', '20/03/2023 - 10:52:20', 4, '178.138.97.180'),
(517, 2, 'S-a desconectat de pe server cu $20.154.419 / $756.303.', '20/03/2023 - 10:53:13', 4, '255.255.255.255'),
(518, 3, 'Madalin31 si-a cumparat un Pony[2], (last money: $10.099.580.985.065 / new money: $10.099.576.785.065)', '20/03/2023 - 11:02:15', 5, '178.138.97.180'),
(519, 3, 'Madalin31 si-a cumparat un Bullet[3], (last money: $10.099.576.785.065 / new money: $10.099.146.785.065)', '20/03/2023 - 11:06:14', 5, '178.138.97.180'),
(520, 3, 'S-a desconectat de pe server cu $10.099.146.785.065 / $22.972.753.', '20/03/2023 - 11:07:40', 4, '178.138.97.180'),
(521, 3, 'S-a desconectat de pe server cu $10.099.146.784.965 / $22.972.753.', '20/03/2023 - 11:21:59', 4, '178.138.97.180'),
(522, 11, 'S-a desconectat de pe server cu $99.900 / $0.', '20/03/2023 - 18:54:10', 4, '255.255.255.255'),
(523, 3, 'S-a desconectat de pe server cu $10.099.146.784.865 / $22.972.753.', '20/03/2023 - 19:29:00', 4, '178.138.97.180'),
(524, 3, 'S-a desconectat de pe server cu $10.099.146.784.765 / $22.972.753.', '20/03/2023 - 19:34:10', 4, '178.138.97.180'),
(525, 3, '(chat) ba', '20/03/2023 - 19:59:55', 9, '82.77.76.157'),
(526, 7, '(chat) da frt', '20/03/2023 - 20:00:08', 9, '93.122.249.252'),
(527, 3, '(chat) ai vazut ca am modificat ', '20/03/2023 - 20:00:11', 9, '82.77.76.157'),
(528, 7, '(chat) nu', '20/03/2023 - 20:00:17', 9, '93.122.249.252'),
(529, 3, '(chat) spawnul', '20/03/2023 - 20:00:26', 9, '82.77.76.157'),
(530, 7, '(chat) a', '20/03/2023 - 20:00:29', 9, '93.122.249.252'),
(531, 3, '(chat) dai /bo', '20/03/2023 - 20:00:30', 9, '82.77.76.157'),
(532, 3, '(chat) dai /bo', '20/03/2023 - 20:00:32', 9, '82.77.76.157'),
(533, 7, '(chat) nu', '20/03/2023 - 20:00:32', 9, '93.122.249.252'),
(534, 3, '(chat) ./bp #*', '20/03/2023 - 20:00:37', 9, '82.77.76.157'),
(535, 7, '(chat) nu mere', '20/03/2023 - 20:00:39', 9, '93.122.249.252'),
(536, 7, '(chat) meam', '20/03/2023 - 20:00:53', 9, '93.122.249.252'),
(537, 3, '(chat) :)', '20/03/2023 - 20:00:59', 9, '82.77.76.157'),
(538, 7, '(chat) filmam faceam video', '20/03/2023 - 20:01:01', 9, '93.122.249.252'),
(539, 3, '(chat) am scripter nou', '20/03/2023 - 20:01:10', 9, '82.77.76.157'),
(540, 7, '(chat) pa cine', '20/03/2023 - 20:01:17', 9, '93.122.249.252'),
(541, 3, '(chat) unu florin', '20/03/2023 - 20:01:27', 9, '82.77.76.157'),
(542, 7, '(chat) a eu', '20/03/2023 - 20:01:32', 9, '93.122.249.252'),
(543, 3, '(chat) nu tu ba :))', '20/03/2023 - 20:01:46', 9, '82.77.76.157'),
(544, 7, '(chat) plang', '20/03/2023 - 20:01:53', 9, '93.122.249.252'),
(545, 3, '(chat) tu sti sa scriptezi? :)', '20/03/2023 - 20:02:03', 9, '82.77.76.157'),
(546, 7, '(chat) nu stiu  dastea', '20/03/2023 - 20:02:13', 9, '93.122.249.252'),
(547, 3, '(chat) :)))', '20/03/2023 - 20:02:19', 9, '82.77.76.157'),
(548, 7, '(chat) ba cum loam vip accuont', '20/03/2023 - 20:02:25', 9, '93.122.249.252'),
(549, 3, '(chat) tu esti co owner :)', '20/03/2023 - 20:02:30', 9, '82.77.76.157'),
(550, 3, '(chat)  /shop', '20/03/2023 - 20:02:37', 9, '82.77.76.157'),
(551, 3, '(chat) acconuf upgrade', '20/03/2023 - 20:02:52', 9, '82.77.76.157'),
(552, 7, 'HALKFLORIN67 si-a achizitionat cont premium pentru 150 Premium Points.', '20/03/2023 - 20:02:55', 1, '93.122.249.252'),
(553, 3, '(chat) accont upgrade', '20/03/2023 - 20:03:00', 9, '82.77.76.157'),
(554, 7, 'HALKFLORIN67 si-a achizitionat un cont VIP pentru 800 Premium Points.', '20/03/2023 - 20:03:12', 1, '93.122.249.252'),
(555, 7, 'HALKFLORIN67 si-a achizitionat un cont VIP Plus pentru 500 Premium Points.', '20/03/2023 - 20:03:20', 1, '93.122.249.252'),
(556, 3, 'Madalin31 si-a achizitionat un Infernus Premium pentru 2500 Premium Points.', '20/03/2023 - 20:03:28', 1, '82.77.76.157'),
(557, 3, '(chat) ba', '20/03/2023 - 20:03:48', 9, '82.77.76.157'),
(558, 7, 'HALKFLORIN67 si-a achizitionat un cont Legend pentru 1337 Premium Points.', '20/03/2023 - 20:03:48', 1, '93.122.249.252'),
(559, 7, '(chat) e', '20/03/2023 - 20:03:53', 9, '93.122.249.252'),
(560, 3, '(chat) st ca trb sa vb cu scripter-ul ca e un bug', '20/03/2023 - 20:04:03', 9, '82.77.76.157'),
(561, 7, '(chat) zi rpd ca fac video', '20/03/2023 - 20:04:04', 9, '93.122.249.252'),
(562, 3, '(chat) nu se salveaza km', '20/03/2023 - 20:04:15', 9, '82.77.76.157'),
(563, 3, '(chat) la masina', '20/03/2023 - 20:04:19', 9, '82.77.76.157'),
(564, 7, '(chat) a', '20/03/2023 - 20:04:35', 9, '93.122.249.252'),
(565, 3, '(chat) filmezi?', '20/03/2023 - 20:06:15', 9, '82.77.76.157'),
(566, 7, '(chat) da', '20/03/2023 - 20:06:22', 9, '93.122.249.252'),
(567, 3, '(chat) sall :)))', '20/03/2023 - 20:06:26', 9, '82.77.76.157'),
(568, 3, '(chat) el e scripter-ul ', '20/03/2023 - 20:08:12', 9, '82.77.76.157'),
(569, 7, '(chat) a', '20/03/2023 - 20:08:15', 9, '93.122.249.252'),
(570, 3, '(chat) e forta rau ', '20/03/2023 - 20:08:25', 9, '82.77.76.157'),
(571, 7, '(chat) ba', '20/03/2023 - 20:08:27', 9, '93.122.249.252'),
(572, 7, '(chat) am vrut sa fac romaneasca si zice nu ai voie sa fa abuz de fucntie', '20/03/2023 - 20:09:01', 9, '93.122.249.252'),
(573, 3, '(chat) :)', '20/03/2023 - 20:09:21', 9, '82.77.76.157'),
(574, 3, '(chat) a schimbat spawn-ul ', '20/03/2023 - 20:09:51', 9, '82.77.76.157'),
(575, 2, '(chat) d', '20/03/2023 - 20:09:57', 9, '188.27.152.80'),
(576, 3, '(chat) dar e un bug pe server ', '20/03/2023 - 20:10:00', 9, '82.77.76.157'),
(577, 2, '(chat) ce bug', '20/03/2023 - 20:10:15', 9, '188.27.152.80'),
(578, 2, '(chat) acum merge si /bp', '20/03/2023 - 20:10:21', 9, '188.27.152.80'),
(579, 3, '(chat) nu se salveaza km la masina ', '20/03/2023 - 20:10:25', 9, '82.77.76.157'),
(580, 2, '(chat) mda', '20/03/2023 - 20:10:30', 9, '188.27.152.80'),
(581, 3, '(chat) am vazut: :)))', '20/03/2023 - 20:10:35', 9, '82.77.76.157'),
(582, 2, '(chat) maine o sa iau panel pentru sv', '20/03/2023 - 20:10:41', 9, '188.27.152.80'),
(583, 3, '(chat) pentru care?', '20/03/2023 - 20:10:49', 9, '82.77.76.157'),
(584, 2, '(chat) asta', '20/03/2023 - 20:10:53', 9, '188.27.152.80'),
(585, 3, '(chat) chiar??', '20/03/2023 - 20:11:00', 9, '82.77.76.157'),
(586, 2, '(chat) dau 10 euro da', '20/03/2023 - 20:11:04', 9, '188.27.152.80'),
(587, 3, '(chat) pai vr sa il tinem amandoi?', '20/03/2023 - 20:11:17', 9, '82.77.76.157'),
(588, 2, '(chat) ma ocup si de a lui ronni', '20/03/2023 - 20:11:27', 9, '188.27.152.80'),
(589, 2, '(chat) da cumpar panel sa fi fericit', '20/03/2023 - 20:11:32', 9, '188.27.152.80'),
(590, 3, '(chat) ok mss :)))))))', '20/03/2023 - 20:11:42', 9, '82.77.76.157'),
(591, 2, '(chat) <#', '20/03/2023 - 20:11:46', 9, '188.27.152.80'),
(592, 2, '(chat) <3', '20/03/2023 - 20:11:47', 9, '188.27.152.80'),
(593, 2, 'S-a desconectat de pe server cu $20.154.319 / $756.303.', '20/03/2023 - 20:11:56', 4, '255.255.255.255'),
(594, 3, '(chat) re :)', '20/03/2023 - 20:11:56', 9, '82.77.76.157'),
(595, 7, '(chat) g', '20/03/2023 - 20:12:20', 9, '93.122.249.252'),
(596, 7, '(chat) poti?', '20/03/2023 - 20:12:28', 9, '93.122.249.252'),
(597, 3, '(chat) nu merge :)', '20/03/2023 - 20:12:33', 9, '82.77.76.157'),
(598, 7, '(chat) g', '20/03/2023 - 20:12:33', 9, '93.122.249.252'),
(599, 7, '(chat) a', '20/03/2023 - 20:12:36', 9, '93.122.249.252'),
(600, 3, '(chat) st', '20/03/2023 - 20:12:36', 9, '82.77.76.157'),
(601, 3, '(chat) dai', '20/03/2023 - 20:12:45', 9, '82.77.76.157'),
(602, 11, 'FARCRY3 si-a achizitionat un Infernus Premium pentru 2500 Premium Points.', '20/03/2023 - 20:13:04', 1, '188.27.152.172'),
(603, 3, '(chat) :))', '20/03/2023 - 20:13:55', 9, '82.77.76.157'),
(604, 7, '(chat) baa', '20/03/2023 - 20:13:56', 9, '93.122.249.252'),
(605, 7, '(chat) bulangiuu', '20/03/2023 - 20:14:00', 9, '93.122.249.252'),
(606, 11, 'FARCRY3 si-a upgradat vehiculul Infernus[id: 8] la unul VIP pentru 300 Premium Points.', '20/03/2023 - 20:14:03', 1, '188.27.152.172'),
(607, 11, 'FARCRY3 si-a upgradat vehiculul Infernus[id: 8] la unul VIP Plus pentru 500 Premium Points.', '20/03/2023 - 20:14:05', 1, '188.27.152.172'),
(608, 7, '(chat) baa', '20/03/2023 - 20:14:08', 9, '93.122.249.252'),
(609, 11, 'FARCRY3 si-a upgradat vehiculul Infernus[id: 8] la unul RainBow pentru 200 Premium Points.', '20/03/2023 - 20:14:08', 1, '188.27.152.172'),
(610, 3, '(chat) e', '20/03/2023 - 20:14:10', 9, '82.77.76.157'),
(611, 11, 'FARCRY3 si-a achizitionat un cont VIP pentru 800 Premium Points.', '20/03/2023 - 20:15:03', 1, '188.27.152.172'),
(612, 11, 'FARCRY3 si-a achizitionat un cont VIP Plus pentru 500 Premium Points.', '20/03/2023 - 20:15:04', 1, '188.27.152.172'),
(613, 11, 'FARCRY3 si-a achizitionat un cont Legend pentru 1337 Premium Points.', '20/03/2023 - 20:15:09', 1, '188.27.152.172'),
(614, 11, '(chat) kf', '20/03/2023 - 20:15:10', 9, '188.27.152.172'),
(615, 3, '(chat) ba', '20/03/2023 - 20:15:39', 9, '82.77.76.157'),
(616, 11, '(chat) da', '20/03/2023 - 20:15:41', 9, '188.27.152.172'),
(617, 11, 'FARCRY3 si-a achizitionat cont premium pentru 150 Premium Points.', '20/03/2023 - 20:15:49', 1, '188.27.152.172'),
(618, 3, '(chat) ai rezolvat bug-ul?', '20/03/2023 - 20:15:58', 9, '82.77.76.157'),
(619, 11, '(chat) la mn se pun km', '20/03/2023 - 20:16:06', 9, '188.27.152.172'),
(620, 3, '(chat) a', '20/03/2023 - 20:16:12', 9, '82.77.76.157'),
(621, 3, '(chat) k', '20/03/2023 - 20:16:14', 9, '82.77.76.157'),
(622, 3, '(chat) doar pe tell cred ca e', '20/03/2023 - 20:16:26', 9, '82.77.76.157'),
(623, 3, '(chat) bug-ul ', '20/03/2023 - 20:16:30', 9, '82.77.76.157'),
(624, 11, '(chat) mhm posibil o sa verfic', '20/03/2023 - 20:16:43', 9, '188.27.152.172');
INSERT INTO `logs` (`ID`, `Userid`, `Text`, `Date`, `Type`, `IP`) VALUES
(625, 3, '(chat) ok ms', '20/03/2023 - 20:16:51', 9, '82.77.76.157'),
(626, 7, '(chat) dudhd', '20/03/2023 - 20:17:03', 9, '93.122.249.252'),
(627, 7, '(chat) djd', '20/03/2023 - 20:17:05', 9, '93.122.249.252'),
(628, 7, '(chat) ddi', '20/03/2023 - 20:17:07', 9, '93.122.249.252'),
(629, 7, '(chat) djdi', '20/03/2023 - 20:17:08', 9, '93.122.249.252'),
(630, 7, '(chat) dkdk', '20/03/2023 - 20:17:10', 9, '93.122.249.252'),
(631, 3, '(chat) si mai am un bug dar nuj daca poti sa il faci', '20/03/2023 - 20:17:11', 9, '82.77.76.157'),
(632, 7, '(chat) dkdk', '20/03/2023 - 20:17:12', 9, '93.122.249.252'),
(633, 7, '(chat) a', '20/03/2023 - 20:17:14', 9, '93.122.249.252'),
(634, 11, '(chat) care', '20/03/2023 - 20:17:15', 9, '188.27.152.172'),
(635, 7, '(chat) a', '20/03/2023 - 20:17:16', 9, '93.122.249.252'),
(636, 7, '(chat) a', '20/03/2023 - 20:17:17', 9, '93.122.249.252'),
(637, 7, '(chat) a', '20/03/2023 - 20:17:19', 9, '93.122.249.252'),
(638, 7, '(chat) a', '20/03/2023 - 20:17:20', 9, '93.122.249.252'),
(639, 7, '(chat) .', '20/03/2023 - 20:17:26', 9, '93.122.249.252'),
(640, 7, '(chat) .', '20/03/2023 - 20:17:28', 9, '93.122.249.252'),
(641, 7, '(chat) .', '20/03/2023 - 20:17:30', 9, '93.122.249.252'),
(642, 7, '(chat) m', '20/03/2023 - 20:17:31', 9, '93.122.249.252'),
(643, 7, '(chat) .', '20/03/2023 - 20:17:33', 9, '93.122.249.252'),
(644, 3, '(chat) pai pe tell la /carradio nu merg toate melodiile ', '20/03/2023 - 20:17:33', 9, '82.77.76.157'),
(645, 7, '(chat) m', '20/03/2023 - 20:17:34', 9, '93.122.249.252'),
(646, 7, '(chat)  ', '20/03/2023 - 20:17:36', 9, '93.122.249.252'),
(647, 7, '(chat)  ', '20/03/2023 - 20:17:37', 9, '93.122.249.252'),
(648, 7, '(chat)  ', '20/03/2023 - 20:17:39', 9, '93.122.249.252'),
(649, 7, '(chat)  ', '20/03/2023 - 20:17:41', 9, '93.122.249.252'),
(650, 7, '(chat)  ', '20/03/2023 - 20:17:43', 9, '93.122.249.252'),
(651, 7, '(chat)  ', '20/03/2023 - 20:17:45', 9, '93.122.249.252'),
(652, 7, '(chat)  ', '20/03/2023 - 20:17:47', 9, '93.122.249.252'),
(653, 7, '(chat)  ', '20/03/2023 - 20:17:49', 9, '93.122.249.252'),
(654, 7, '(chat)  ', '20/03/2023 - 20:17:50', 9, '93.122.249.252'),
(655, 7, '(chat)  ', '20/03/2023 - 20:17:52', 9, '93.122.249.252'),
(656, 7, '(chat)  ', '20/03/2023 - 20:17:54', 9, '93.122.249.252'),
(657, 11, '(chat) mhm ', '20/03/2023 - 20:18:22', 9, '188.27.152.172'),
(658, 3, '(chat) poti sa faci sa mearga si pe tell toate?', '20/03/2023 - 20:18:22', 9, '82.77.76.157'),
(659, 7, 'S-a desconectat de pe server cu $20.000.513.645.409 / $4.490.191.', '20/03/2023 - 20:18:27', 4, '93.122.249.252'),
(660, 11, '(chat) posibil e de la sampu de pe tel', '20/03/2023 - 20:18:31', 9, '188.27.152.172'),
(661, 11, '(chat) o sa verific ca imi bag sampu pe tel', '20/03/2023 - 20:18:36', 9, '188.27.152.172'),
(662, 3, '(chat) ok', '20/03/2023 - 20:18:41', 9, '82.77.76.157'),
(663, 3, '(chat) lasama sa dau f sa vad daca merg km', '20/03/2023 - 20:19:04', 9, '82.77.76.157'),
(664, 11, '(chat) :P ma duc sa mai fac niste comenzi cv si sa verific chestii', '20/03/2023 - 20:20:05', 9, '188.27.152.172'),
(665, 3, '(chat) gata', '20/03/2023 - 20:20:06', 9, '82.77.76.157'),
(666, 3, '(chat) merge', '20/03/2023 - 20:20:09', 9, '82.77.76.157'),
(667, 3, '(chat) ok', '20/03/2023 - 20:20:17', 9, '82.77.76.157'),
(668, 3, '(chat) daca mai e cv ne auzim', '20/03/2023 - 20:20:25', 9, '82.77.76.157'),
(669, 11, '(chat) lasami cv sugestii pe discord daca te gandesti la cv', '20/03/2023 - 20:20:27', 9, '188.27.152.172'),
(670, 11, '(chat) oky<3', '20/03/2023 - 20:20:28', 9, '188.27.152.172'),
(671, 11, 'S-a desconectat de pe server cu $154.329 / $0.', '20/03/2023 - 20:20:28', 4, '255.255.255.255'),
(672, 3, 'S-a desconectat de pe server cu $10.099.147.331.429 / $27.548.065.', '20/03/2023 - 20:20:47', 4, '82.77.76.157'),
(673, 3, '(chat) noul Spawn ', '20/03/2023 - 20:30:38', 9, '82.77.76.157'),
(674, 7, '(chat) waw', '20/03/2023 - 20:30:44', 9, '93.122.249.252'),
(675, 7, '(chat) bagam safe zone', '20/03/2023 - 20:30:49', 9, '93.122.249.252'),
(676, 3, '(chat) vino', '20/03/2023 - 20:30:50', 9, '82.77.76.157'),
(677, 3, '(chat) am bagat', '20/03/2023 - 20:30:55', 9, '82.77.76.157'),
(678, 3, '(chat) scrie sus ', '20/03/2023 - 20:31:04', 9, '82.77.76.157'),
(679, 3, '(chat) de tot ', '20/03/2023 - 20:31:08', 9, '82.77.76.157'),
(680, 3, '(chat) ba', '20/03/2023 - 20:31:21', 9, '82.77.76.157'),
(681, 7, '(chat) e', '20/03/2023 - 20:31:24', 9, '93.122.249.252'),
(682, 3, '(chat) aici punem', '20/03/2023 - 20:31:27', 9, '82.77.76.157'),
(683, 7, '(chat) biciclete', '20/03/2023 - 20:31:32', 9, '93.122.249.252'),
(684, 7, '(chat) biciclete', '20/03/2023 - 20:31:41', 9, '93.122.249.252'),
(685, 3, '(chat) numele owneru-lui co-owneru-lui si al scripter-ul ', '20/03/2023 - 20:32:11', 9, '82.77.76.157'),
(686, 3, '(chat) numele owneru-lui co-owneru-lui si al scripter-uli', '20/03/2023 - 20:32:15', 9, '82.77.76.157'),
(687, 3, '(chat) numele owneru-lui co-owneru-lui si al scripter-lui*', '20/03/2023 - 20:32:19', 9, '82.77.76.157'),
(688, 7, '(chat) biciclete nu bagi?', '20/03/2023 - 20:32:30', 9, '93.122.249.252'),
(689, 3, '(chat) sunt', '20/03/2023 - 20:32:37', 9, '82.77.76.157'),
(690, 7, '(chat) un', '20/03/2023 - 20:32:40', 9, '93.122.249.252'),
(691, 3, '(chat) vino', '20/03/2023 - 20:32:44', 9, '82.77.76.157'),
(692, 3, '(chat) ete', '20/03/2023 - 20:33:01', 9, '82.77.76.157'),
(693, 3, '(chat) :(', '20/03/2023 - 20:33:03', 9, '82.77.76.157'),
(694, 7, '(chat) e cirodtia asta', '20/03/2023 - 20:33:05', 9, '93.122.249.252'),
(695, 3, '(chat) :))*', '20/03/2023 - 20:33:05', 9, '82.77.76.157'),
(696, 3, '(chat) care?', '20/03/2023 - 20:33:13', 9, '82.77.76.157'),
(697, 7, '(chat) vr sa vezi cv', '20/03/2023 - 20:33:30', 9, '93.122.249.252'),
(698, 3, '(chat) da', '20/03/2023 - 20:33:40', 9, '82.77.76.157'),
(699, 3, '(chat) slao ', '20/03/2023 - 20:33:51', 9, '82.77.76.157'),
(700, 3, '(chat) slao', '20/03/2023 - 20:33:53', 9, '82.77.76.157'),
(701, 3, '(chat) slappp', '20/03/2023 - 20:33:55', 9, '82.77.76.157'),
(702, 7, '(chat) haha', '20/03/2023 - 20:34:08', 9, '93.122.249.252'),
(703, 3, '(chat) te drq', '20/03/2023 - 20:34:36', 9, '82.77.76.157'),
(704, 7, '(chat) haha', '20/03/2023 - 20:34:39', 9, '93.122.249.252'),
(705, 3, '(chat) cu vw tau', '20/03/2023 - 20:34:41', 9, '82.77.76.157'),
(706, 7, '(chat) eram spec pa tine daia nu merea', '20/03/2023 - 20:35:21', 9, '93.122.249.252'),
(707, 3, '(chat) aaaa', '20/03/2023 - 20:35:40', 9, '82.77.76.157'),
(708, 3, '(chat) ba', '20/03/2023 - 20:35:41', 9, '82.77.76.157'),
(709, 3, '(chat) ii zic sa bage tigari?', '20/03/2023 - 20:35:51', 9, '82.77.76.157'),
(710, 7, '(chat) e', '20/03/2023 - 20:35:52', 9, '93.122.249.252'),
(711, 7, '(chat) daaaa', '20/03/2023 - 20:35:55', 9, '93.122.249.252'),
(712, 7, '(chat) ca ma arde ', '20/03/2023 - 20:36:00', 9, '93.122.249.252'),
(713, 3, '(chat) ok :))', '20/03/2023 - 20:36:04', 9, '82.77.76.157'),
(714, 3, '(chat) ba', '20/03/2023 - 20:36:17', 9, '82.77.76.157'),
(715, 7, '(chat) \Zi femei', '20/03/2023 - 20:36:20', 9, '93.122.249.252'),
(716, 3, '(chat) am o intrebare ', '20/03/2023 - 20:36:26', 9, '82.77.76.157'),
(717, 7, '(chat) e', '20/03/2023 - 20:36:31', 9, '93.122.249.252'),
(718, 3, '(chat) nuj daca poate femei', '20/03/2023 - 20:36:34', 9, '82.77.76.157'),
(719, 3, '(chat) asa', '20/03/2023 - 20:36:37', 9, '82.77.76.157'),
(720, 7, '(chat) poate', '20/03/2023 - 20:36:38', 9, '93.122.249.252'),
(721, 3, '(chat) sa schimb gm?', '20/03/2023 - 20:36:45', 9, '82.77.76.157'),
(722, 7, '(chat) mergem la curve impreuna pa samp', '20/03/2023 - 20:36:53', 9, '93.122.249.252'),
(723, 7, '(chat) nuuuu', '20/03/2023 - 20:36:56', 9, '93.122.249.252'),
(724, 3, '(chat) sa il bag pe ala de pe oglife?', '20/03/2023 - 20:37:05', 9, '82.77.76.157'),
(725, 7, '(chat) nu', '20/03/2023 - 20:37:08', 9, '93.122.249.252'),
(726, 7, '(chat) nah', '20/03/2023 - 20:37:10', 9, '93.122.249.252'),
(727, 7, '(chat) nah', '20/03/2023 - 20:37:12', 9, '93.122.249.252'),
(728, 3, '(chat) ok', '20/03/2023 - 20:37:14', 9, '82.77.76.157'),
(729, 3, '(chat) nici deiman nu vrea ', '20/03/2023 - 20:37:23', 9, '82.77.76.157'),
(730, 7, '(chat) baga femei sa dam la bucii', '20/03/2023 - 20:37:24', 9, '93.122.249.252'),
(731, 3, '(chat) st ca ii zic', '20/03/2023 - 20:37:34', 9, '82.77.76.157'),
(732, 3, '(chat) ba', '20/03/2023 - 20:37:43', 9, '82.77.76.157'),
(733, 7, '(chat) e', '20/03/2023 - 20:37:48', 9, '93.122.249.252'),
(734, 3, '(chat) dar scrie si tu pe diss dai /everoni si scri acolo ce vrei sa bage', '20/03/2023 - 20:38:14', 9, '82.77.76.157'),
(735, 3, '(chat) la anunturi', '20/03/2023 - 20:38:24', 9, '82.77.76.157'),
(736, 7, '(chat) nu', '20/03/2023 - 20:38:32', 9, '93.122.249.252'),
(737, 7, '(chat) zi tu', '20/03/2023 - 20:38:34', 9, '93.122.249.252'),
(738, 3, '(chat) HALKFLORIN67 E GAY', '20/03/2023 - 20:38:41', 9, '82.77.76.157'),
(739, 3, '(chat) ok', '20/03/2023 - 20:38:47', 9, '82.77.76.157'),
(740, 7, '(chat) haha', '20/03/2023 - 20:38:48', 9, '93.122.249.252'),
(741, 7, '(chat) SUGI', '20/03/2023 - 20:38:53', 9, '93.122.249.252'),
(742, 3, '(chat) ./o', '20/03/2023 - 20:38:54', 9, '82.77.76.157'),
(743, 3, '(chat) pui anunt la admini', '20/03/2023 - 20:39:02', 9, '82.77.76.157'),
(744, 3, '(chat) vede toata lumea', '20/03/2023 - 20:39:09', 9, '82.77.76.157'),
(745, 3, '(chat) :))', '20/03/2023 - 20:39:34', 9, '82.77.76.157'),
(746, 7, '(chat) a da', '20/03/2023 - 20:39:39', 9, '93.122.249.252'),
(747, 7, '(chat) ./q', '20/03/2023 - 20:39:42', 9, '93.122.249.252'),
(748, 7, '(chat)  /q', '20/03/2023 - 20:39:47', 9, '93.122.249.252'),
(749, 7, '(chat) pa', '20/03/2023 - 20:39:58', 9, '93.122.249.252'),
(750, 3, '(chat) :)', '20/03/2023 - 20:40:01', 9, '82.77.76.157'),
(751, 3, '(chat) :))', '20/03/2023 - 20:40:24', 9, '82.77.76.157'),
(752, 3, '(chat) ba', '20/03/2023 - 20:41:02', 9, '82.77.76.157'),
(753, 3, '(chat) prea bun scripter-ul asta :))', '20/03/2023 - 20:41:17', 9, '82.77.76.157'),
(754, 7, '(chat) da', '20/03/2023 - 20:41:37', 9, '93.122.249.252'),
(755, 7, '(chat) intru mai tarziu re', '20/03/2023 - 20:41:48', 9, '93.122.249.252'),
(756, 3, '(chat) re', '20/03/2023 - 20:41:53', 9, '82.77.76.157'),
(757, 7, '(chat) fac teme', '20/03/2023 - 20:41:53', 9, '93.122.249.252'),
(758, 3, '(chat) ba', '20/03/2023 - 20:42:00', 9, '82.77.76.157'),
(759, 3, '(chat) st', '20/03/2023 - 20:42:02', 9, '82.77.76.157'),
(760, 3, '(chat) vino', '20/03/2023 - 20:42:05', 9, '82.77.76.157'),
(761, 7, '(chat) ?', '20/03/2023 - 20:42:13', 9, '93.122.249.252'),
(762, 7, '(chat) ?', '20/03/2023 - 20:42:36', 9, '93.122.249.252'),
(763, 7, 'S-a desconectat de pe server cu $20.000.513.643.209 / $4.490.191.', '20/03/2023 - 20:43:17', 4, '93.122.249.252'),
(764, 3, 'S-a desconectat de pe server cu $10.099.147.331.329 / $27.548.065.', '20/03/2023 - 20:45:43', 4, '82.77.76.157'),
(765, 7, 'S-a desconectat de pe server cu $20.000.513.640.909 / $4.490.191.', '20/03/2023 - 22:43:09', 4, '93.122.249.156'),
(766, 3, 'S-a desconectat de pe server cu $10.099.147.331.229 / $27.548.065.', '21/03/2023 - 06:15:11', 4, '82.77.76.157'),
(767, 3, 'Madalin31 si-a upgradat vehiculul Infernus[id: 0] la unul RainBow pentru 200 Premium Points.', '21/03/2023 - 08:10:10', 1, '178.138.97.180'),
(768, 3, 'S-a desconectat de pe server cu $10.099.147.336.217 / $32.217.661.', '21/03/2023 - 08:26:19', 4, '178.138.97.180'),
(769, 3, 'S-a desconectat de pe server cu $10.099.147.322.117 / $36.920.037.', '21/03/2023 - 11:00:26', 4, '178.138.97.180'),
(770, 12, 'S-a desconectat de pe server cu $126.091 / $0.', '03/11/2026 - 01:19:53', 4, '127.0.0.1'),
(771, 12, 'S-a desconectat de pe server cu $125.991 / $0.', '03/11/2026 - 01:22:25', 4, '127.0.0.1'),
(772, 12, 'S-a desconectat de pe server cu $125.891 / $0.', '03/11/2026 - 01:52:58', 4, '127.0.0.1'),
(773, 12, 'S-a desconectat de pe server cu $125.791 / $0.', '03/11/2026 - 01:54:02', 4, '127.0.0.1'),
(774, 12, 'S-a desconectat de pe server cu $125.691 / $0.', '03/11/2026 - 02:05:45', 4, '127.0.0.1'),
(775, 12, 'S-a desconectat de pe server cu $125.591 / $0.', '03/11/2026 - 02:13:52', 4, '127.0.0.1'),
(776, 12, 'S-a desconectat de pe server cu $125.491 / $0.', '03/11/2026 - 02:19:31', 4, '127.0.0.1'),
(777, 12, 'S-a desconectat de pe server cu $125.391 / $0.', '03/11/2026 - 02:21:57', 4, '127.0.0.1'),
(778, 12, 'S-a desconectat de pe server cu $125.291 / $0.', '03/11/2026 - 02:24:54', 4, '127.0.0.1'),
(779, 12, 'S-a desconectat de pe server cu $125.191 / $0.', '03/11/2026 - 02:29:22', 4, '127.0.0.1'),
(780, 12, 'Mr.Rares a primit $999.999.999 de la Mr.Rares', '03/11/2026 - 12:44:29', 4, '127.0.0.1'),
(781, 12, 'Mr.Rares si-a cumparat un Elegy[1], (last money: $1.000.184.884 / new money: $939.184.815)', '03/11/2026 - 12:44:52', 5, '127.0.0.1'),
(782, 12, 'S-a desconectat de pe server cu $939.174.815 / $0.', '03/11/2026 - 12:52:26', 4, '127.0.0.1'),
(783, 12, 'S-a desconectat de pe server cu $939.174.715 / $0.', '03/11/2026 - 13:31:35', 4, '127.0.0.1'),
(784, 12, 'S-a desconectat de pe server cu $939.174.615 / $0.', '03/11/2026 - 13:35:15', 4, '127.0.0.1'),
(785, 12, 'S-a desconectat de pe server cu $939.174.515 / $0.', '03/11/2026 - 13:43:33', 4, '127.0.0.1'),
(786, 12, 'S-a desconectat de pe server cu $939.174.415 / $0.', '03/11/2026 - 13:49:01', 4, '127.0.0.1'),
(787, 12, 'S-a desconectat de pe server cu $939.174.315 / $0.', '03/11/2026 - 13:51:51', 4, '127.0.0.1'),
(788, 12, 'S-a desconectat de pe server cu $939.174.215 / $0.', '03/11/2026 - 13:55:15', 4, '127.0.0.1'),
(789, 12, 'Mr.Rares si-a upgradat vehiculul Elegy[id: 1] la unul VIP pentru 300 Premium Points.', '03/11/2026 - 14:30:17', 1, '127.0.0.1'),
(790, 12, 'Mr.Rares si-a upgradat vehiculul Elegy[id: 1] la unul VIP Plus pentru 500 Premium Points.', '03/11/2026 - 14:30:20', 1, '127.0.0.1'),
(791, 12, 'Mr.Rares si-a upgradat vehiculul Elegy[id: 1] la unul RainBow pentru 200 Premium Points.', '03/11/2026 - 14:30:22', 1, '127.0.0.1'),
(792, 12, 'S-a desconectat de pe server cu $939.216.678 / $10.358.446.', '03/11/2026 - 14:30:59', 4, '127.0.0.1'),
(793, 12, 'S-a desconectat de pe server cu $939.208.578 / $22.874.648.', '03/11/2026 - 21:58:05', 4, '127.0.0.1'),
(794, 12, 'S-a desconectat de pe server cu $939.208.478 / $22.874.648.', '03/11/2026 - 22:02:24', 4, '127.0.0.1'),
(795, 12, '(chat) Q', '03/11/2026 - 22:06:46', 9, '127.0.0.1'),
(796, 12, 'S-a desconectat de pe server cu $939.208.378 / $22.874.648.', '03/11/2026 - 22:06:47', 4, '127.0.0.1'),
(797, 12, 'S-a desconectat de pe server cu $939.983.241 / $22.874.648.', '03/11/2026 - 22:17:40', 4, '127.0.0.1'),
(798, 12, 'Mr.Rares si-a achizitionat un slot (vehicul) pentru 40 Premium Points.', '03/11/2026 - 22:20:25', 1, '127.0.0.1'),
(799, 12, 'Mr.Rares si-a achizitionat un slot (vehicul) pentru 40 Premium Points.', '03/11/2026 - 22:20:28', 1, '127.0.0.1'),
(800, 12, 'Mr.Rares si-a achizitionat un slot (vehicul) pentru 40 Premium Points.', '03/11/2026 - 22:20:30', 1, '127.0.0.1'),
(801, 12, 'Mr.Rares si-a achizitionat un slot (vehicul) pentru 40 Premium Points.', '03/11/2026 - 22:20:31', 1, '127.0.0.1'),
(802, 12, 'Mr.Rares si-a achizitionat un slot (vehicul) pentru 40 Premium Points.', '03/11/2026 - 22:20:33', 1, '127.0.0.1'),
(803, 12, 'Mr.Rares si-a achizitionat un slot (vehicul) pentru 40 Premium Points.', '03/11/2026 - 22:20:35', 1, '127.0.0.1'),
(804, 12, 'Mr.Rares si-a achizitionat un slot (vehicul) pentru 40 Premium Points.', '03/11/2026 - 22:20:37', 1, '127.0.0.1'),
(805, 12, 'Mr.Rares si-a achizitionat un slot (vehicul) pentru 40 Premium Points.', '03/11/2026 - 22:20:38', 1, '127.0.0.1'),
(806, 12, 'Mr.Rares si-a achizitionat un slot (vehicul) pentru 40 Premium Points.', '03/11/2026 - 22:20:40', 1, '127.0.0.1'),
(807, 12, 'Mr.Rares si-a achizitionat un slot (vehicul) pentru 40 Premium Points.', '03/11/2026 - 22:20:41', 1, '127.0.0.1'),
(808, 12, 'S-a desconectat de pe server cu $940.011.587 / $22.874.648.', '03/11/2026 - 22:25:07', 4, '127.0.0.1'),
(809, 12, 'S-a desconectat de pe server cu $940.011.487 / $22.874.648.', '04/11/2026 - 01:02:07', 4, '127.0.0.1'),
(810, 12, 'S-a desconectat de pe server cu $940.011.387 / $22.874.648.', '04/11/2026 - 01:06:10', 4, '127.0.0.1'),
(811, 12, 'Mr.Rares si-a cumparat un Infernus[2], (last money: $940.011.287 / new money: $384.455.732)', '04/11/2026 - 01:09:44', 5, '127.0.0.1'),
(812, 12, 'S-a desconectat de pe server cu $384.455.732 / $22.874.648.', '04/11/2026 - 01:10:09', 4, '127.0.0.1'),
(813, 12, 'S-a desconectat de pe server cu $384.455.632 / $22.874.648.', '04/11/2026 - 01:13:55', 4, '127.0.0.1'),
(814, 13, 'MrxRares a primit $9.999.999.999 de la MrxRares', '04/11/2026 - 01:21:04', 4, '127.0.0.1'),
(815, 13, 'MrxRares si-a cumparat un Infernus[1], (last money: $10.000.182.744 / new money: $9.444.627.189)', '04/11/2026 - 01:21:49', 5, '127.0.0.1'),
(816, 13, 'S-a desconectat de pe server cu $9.444.627.189 / $0.', '04/11/2026 - 01:22:07', 4, '127.0.0.1'),
(817, 13, 'S-a desconectat de pe server cu $9.444.627.089 / $0.', '04/11/2026 - 01:26:08', 4, '127.0.0.1'),
(818, 13, 'S-a desconectat de pe server cu $9.444.626.989 / $0.', '04/11/2026 - 01:38:29', 4, '127.0.0.1'),
(819, 13, 'S-a desconectat de pe server cu $9.444.626.889 / $0.', '04/11/2026 - 01:40:21', 4, '127.0.0.1'),
(820, 13, 'S-a desconectat de pe server cu $9.444.626.789 / $0.', '04/11/2026 - 03:10:54', 4, '127.0.0.1'),
(821, 13, 'MrxRares si-a cumparat un Infernus[2], (last money: $9.444.626.689 / new money: $8.889.071.134)', '04/11/2026 - 03:12:17', 5, '127.0.0.1'),
(822, 13, 'MrxRares si-a cumparat un Infernus[3], (last money: $8.889.071.134 / new money: $8.333.515.579)', '04/11/2026 - 03:12:22', 5, '127.0.0.1'),
(823, 13, 'S-a desconectat de pe server cu $8.333.515.579 / $0.', '04/11/2026 - 03:12:40', 4, '127.0.0.1'),
(824, 13, 'MrxRares si-a upgradat vehiculul Infernus[id: 1] la unul VIP pentru 300 Premium Points.', '04/11/2026 - 03:32:55', 1, '127.0.0.1'),
(825, 13, 'MrxRares si-a upgradat vehiculul Infernus[id: 1] la unul VIP Plus pentru 500 Premium Points.', '04/11/2026 - 03:32:59', 1, '127.0.0.1'),
(826, 13, 'MrxRares si-a upgradat vehiculul Infernus[id: 1] la unul RainBow pentru 200 Premium Points.', '04/11/2026 - 03:33:03', 1, '127.0.0.1'),
(827, 13, 'S-a desconectat de pe server cu $8.333.569.688 / $0.', '04/11/2026 - 03:33:54', 4, '127.0.0.1'),
(828, 13, 'S-a desconectat de pe server cu $8.333.569.588 / $0.', '04/11/2026 - 03:40:51', 4, '127.0.0.1'),
(829, 13, 'S-a desconectat de pe server cu $8.333.569.488 / $0.', '04/11/2026 - 03:44:30', 4, '127.0.0.1'),
(830, 13, 'S-a desconectat de pe server cu $8.333.569.388 / $0.', '04/11/2026 - 03:51:52', 4, '127.0.0.1'),
(831, 13, '(chat) asd', '04/11/2026 - 03:54:10', 9, '127.0.0.1'),
(832, 13, 'S-a desconectat de pe server cu $8.333.564.288 / $0.', '04/11/2026 - 03:58:21', 4, '127.0.0.1'),
(833, 13, 'S-a desconectat de pe server cu $8.333.564.188 / $0.', '04/11/2026 - 14:29:20', 4, '127.0.0.1'),
(834, 13, 'S-a desconectat de pe server cu $8.333.564.088 / $0.', '04/11/2026 - 14:36:35', 4, '127.0.0.1'),
(835, 13, '(chat) .v', '04/11/2026 - 14:38:11', 9, '127.0.0.1'),
(836, 13, 'MrxRares si-a achizitionat un slot (vehicul) pentru 40 Premium Points.', '04/11/2026 - 14:39:42', 1, '127.0.0.1'),
(837, 13, 'MrxRares si-a cumparat un Elegy[4], (last money: $8.333.591.535 / new money: $8.272.591.466)', '04/11/2026 - 14:39:51', 5, '127.0.0.1'),
(838, 13, 'MrxRares si-a upgradat vehiculul Elegy[id: 4] la unul VIP pentru 300 Premium Points.', '04/11/2026 - 14:41:42', 1, '127.0.0.1'),
(839, 13, 'MrxRares si-a upgradat vehiculul Elegy[id: 4] la unul VIP Plus pentru 500 Premium Points.', '04/11/2026 - 14:41:45', 1, '127.0.0.1'),
(840, 13, 'MrxRares si-a upgradat vehiculul Elegy[id: 4] la unul RainBow pentru 200 Premium Points.', '04/11/2026 - 14:41:48', 1, '127.0.0.1'),
(841, 13, 'S-a desconectat de pe server cu $8.272.591.366 / $0.', '04/11/2026 - 14:50:54', 4, '127.0.0.1'),
(842, 13, 'S-a desconectat de pe server cu $8.272.591.266 / $0.', '04/11/2026 - 15:03:30', 4, '127.0.0.1'),
(843, 13, 'S-a desconectat de pe server cu $8.272.581.129 / $0.', '04/11/2026 - 15:11:17', 4, '127.0.0.1'),
(844, 13, 'S-a desconectat de pe server cu $8.272.581.029 / $0.', '04/11/2026 - 15:18:28', 4, '127.0.0.1'),
(845, 13, 'S-a desconectat de pe server cu $8.550.358.706 / $0.', '04/11/2026 - 15:27:43', 4, '127.0.0.1'),
(846, 13, 'S-a desconectat de pe server cu $8.828.136.383 / $0.', '04/11/2026 - 15:32:29', 4, '127.0.0.1'),
(847, 13, 'S-a desconectat de pe server cu $8.828.136.183 / $0.', '04/11/2026 - 15:37:52', 4, '127.0.0.1'),
(848, 13, 'S-a desconectat de pe server cu $8.828.126.083 / $0.', '04/11/2026 - 16:44:14', 4, '127.0.0.1'),
(849, 13, 'S-a desconectat de pe server cu $8.828.125.983 / $0.', '04/11/2026 - 17:44:06', 4, '127.0.0.1'),
(850, 13, 'S-a desconectat de pe server cu $8.828.125.883 / $0.', '04/11/2026 - 17:47:45', 4, '127.0.0.1'),
(851, 13, 'S-a desconectat de pe server cu $8.828.125.783 / $0.', '04/11/2026 - 17:54:18', 4, '127.0.0.1'),
(852, 13, 'S-a desconectat de pe server cu $8.828.125.683 / $0.', '04/11/2026 - 19:22:31', 4, '127.0.0.1'),
(853, 13, 'S-a desconectat de pe server cu $8.828.660.298 / $0.', '04/11/2026 - 19:27:36', 4, '127.0.0.1'),
(854, 13, 'S-a desconectat de pe server cu $8.828.650.198 / $0.', '04/11/2026 - 21:58:06', 4, '127.0.0.1');

-- --------------------------------------------------------

--
-- Table structure for table `money_logs`
--

CREATE TABLE `money_logs` (
  `ID` int(11) NOT NULL,
  `Name` int(11) NOT NULL,
  `Userid` int(11) NOT NULL,
  `reasonAction` varchar(128) DEFAULT NULL,
  `Time` varchar(64) NOT NULL DEFAULT '1999-1-1 10:00'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `panel_answers`
--

CREATE TABLE `panel_answers` (
  `ID` int(11) NOT NULL,
  `ApplicationID` varchar(15) NOT NULL,
  `question` varchar(256) NOT NULL,
  `answer` varchar(1024) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `panel_applications`
--

CREATE TABLE `panel_applications` (
  `ID` int(11) NOT NULL,
  `Username` varchar(32) NOT NULL,
  `Userid` int(11) NOT NULL,
  `Type` varchar(32) NOT NULL,
  `Status` int(11) NOT NULL,
  `unque` varchar(10) NOT NULL,
  `Group` int(11) NOT NULL,
  `Date` varchar(32) NOT NULL,
  `Reason` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `panel_badge`
--

CREATE TABLE `panel_badge` (
  `ID` int(11) NOT NULL,
  `Name` varchar(32) NOT NULL,
  `Icon` varchar(144) NOT NULL,
  `Color` varchar(32) NOT NULL,
  `Userid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `panel_comment`
--

CREATE TABLE `panel_comment` (
  `ID` int(11) NOT NULL,
  `Name` varchar(32) NOT NULL,
  `Text` varchar(144) NOT NULL,
  `time` varchar(32) NOT NULL,
  `BanID` varchar(32) NOT NULL,
  `Skin` int(11) NOT NULL,
  `Userid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `panel_comment_complaints`
--

CREATE TABLE `panel_comment_complaints` (
  `ID` int(11) NOT NULL,
  `Username` varchar(32) NOT NULL,
  `Model` int(11) NOT NULL,
  `Time` varchar(32) NOT NULL,
  `CommentID` varchar(10) NOT NULL,
  `Userid` int(11) NOT NULL,
  `badge` int(11) NOT NULL,
  `Text` varchar(256) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `panel_comment_tickets`
--

CREATE TABLE `panel_comment_tickets` (
  `ID` int(11) NOT NULL,
  `Username` varchar(32) NOT NULL,
  `Model` int(11) NOT NULL,
  `Time` varchar(32) NOT NULL,
  `CommentID` varchar(15) NOT NULL,
  `Userid` int(11) NOT NULL,
  `Text` varchar(256) NOT NULL,
  `badge` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `panel_complaints`
--

CREATE TABLE `panel_complaints` (
  `ID` int(11) NOT NULL,
  `Against` varchar(32) NOT NULL,
  `Creator` varchar(32) NOT NULL,
  `Date` varchar(32) NOT NULL,
  `Status` int(11) NOT NULL,
  `unque` varchar(10) NOT NULL,
  `Reason` varchar(64) NOT NULL,
  `Link` varchar(256) NOT NULL,
  `Description` varchar(1024) NOT NULL,
  `Admin` int(11) NOT NULL,
  `Type` int(11) NOT NULL,
  `Member` int(11) NOT NULL,
  `Userid` int(11) NOT NULL,
  `ByUserid` int(11) NOT NULL,
  `Action` varchar(32) NOT NULL,
  `Grad` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `panel_question`
--

CREATE TABLE `panel_question` (
  `ID` int(11) NOT NULL,
  `Text` varchar(256) NOT NULL,
  `Type` int(11) NOT NULL,
  `Group` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `panel_queue`
--

CREATE TABLE `panel_queue` (
  `ID` int(11) NOT NULL,
  `Username` varchar(32) NOT NULL DEFAULT '',
  `AdminName` varchar(32) NOT NULL DEFAULT '',
  `playerid` int(11) NOT NULL,
  `Type` int(11) NOT NULL,
  `Userid` int(11) NOT NULL,
  `Reason` varchar(64) NOT NULL,
  `Amount` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `panel_recovery`
--

CREATE TABLE `panel_recovery` (
  `ID` int(11) NOT NULL,
  `Name` varchar(32) NOT NULL,
  `Email` varchar(64) NOT NULL,
  `Code` varchar(50) NOT NULL,
  `Time` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `panel_suspend`
--

CREATE TABLE `panel_suspend` (
  `ID` int(11) NOT NULL,
  `Userid` int(11) NOT NULL,
  `IP` varchar(32) NOT NULL,
  `Reason` varchar(128) NOT NULL,
  `Admin` varchar(32) NOT NULL,
  `Date` varchar(32) NOT NULL,
  `Name` varchar(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `panel_tickets`
--

CREATE TABLE `panel_tickets` (
  `ID` int(11) NOT NULL,
  `Username` varchar(32) NOT NULL,
  `Type` int(11) NOT NULL,
  `Priority` int(11) NOT NULL,
  `Status` int(11) NOT NULL,
  `Date` varchar(32) NOT NULL,
  `Description` varchar(3000) NOT NULL,
  `Code` varchar(14) NOT NULL,
  `Model` int(11) NOT NULL,
  `Userid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `panel_unban`
--

CREATE TABLE `panel_unban` (
  `ID` int(11) NOT NULL,
  `Username` varchar(32) NOT NULL DEFAULT 'Invalid',
  `Userid` int(11) NOT NULL,
  `Status` int(11) NOT NULL,
  `unque` varchar(14) NOT NULL DEFAULT 'invalid',
  `Reason` varchar(256) NOT NULL,
  `Photo` varchar(144) NOT NULL,
  `Others` varchar(256) NOT NULL,
  `time` varchar(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `safezones`
--

CREATE TABLE `safezones` (
  `ID` int(10) NOT NULL,
  `X` float NOT NULL,
  `Y` float NOT NULL,
  `Z` float NOT NULL,
  `Range` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `safezones`
--

INSERT INTO `safezones` (`ID`, `X`, `Y`, `Z`, `Range`) VALUES
(1, -1972.45, 136.23, 27.6875, 15),
(2, 1221.84, -1693.78, 19.7344, 50),
(3, 1228.21, -1692.59, 18.5222, 20);

-- --------------------------------------------------------

--
-- Table structure for table `sanctions`
--

CREATE TABLE `sanctions` (
  `ID` int(10) NOT NULL,
  `Player` varchar(256) NOT NULL,
  `By` varchar(256) NOT NULL,
  `Time` varchar(256) NOT NULL,
  `Userid` int(10) NOT NULL,
  `Type` int(10) NOT NULL,
  `Reason` varchar(256) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `seif`
--

CREATE TABLE `seif` (
  `sID` int(10) NOT NULL,
  `sFactionID` int(10) NOT NULL,
  `sPosX` float NOT NULL,
  `sPosY` float NOT NULL,
  `sPosZ` float NOT NULL,
  `sMoney` int(10) NOT NULL DEFAULT 500000,
  `sDrugs` int(10) NOT NULL DEFAULT 1000,
  `sMaterials` int(10) NOT NULL DEFAULT 100000,
  `sVirtualID` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `seif`
--

INSERT INTO `seif` (`sID`, `sFactionID`, `sPosX`, `sPosY`, `sPosZ`, `sMoney`, `sDrugs`, `sMaterials`, `sVirtualID`) VALUES
(1, 1, 240.683, 71.1112, 1005.04, 1000000, 1000, 1000, 1),
(2, 2, 228.863, 169.008, 1003.02, 1000000, 1000, 1000, 2),
(3, 3, 301.576, 187.933, 1007.17, 100000, 1000, 1000, 3),
(4, 4, 2550.15, -1287.49, 1054.64, 100000, 1000, 1000, 4),
(5, 5, 2550.15, -1287.49, 1054.64, 100000, 1000, 1000, 5),
(6, 6, 2550.15, -1287.49, 1054.64, 100000, 1000, 1000, 6),
(7, 7, 1502.14, 1308.88, 1093.29, 100000, 1000, 1000, 7),
(8, 8, 604.763, -26.5193, 1004.78, 100000, 1000, 1000, 8),
(9, 9, -2034.81, -114.67, 1035.17, 100000, 1000, 1000, 9),
(10, 10, 2550.15, -1287.49, 1054.64, 100000, 1000, 1000, 10),
(11, 11, -2165.66, 646.313, 1052.38, 100000, 1000, 1000, 11),
(12, 12, 1723.13, -1673.03, 20.2233, 100000, 1000, 1000, 12),
(13, 13, 1501.94, 1309.4, 1093.29, 100000, 1000, 1000, 13),
(14, 14, 259.444, 107.849, 1003.22, 100000, 1000, 1000, 14),
(15, 15, 1722.87, -1673.41, 20.2231, 100000, 1000, 1000, 15),
(16, 16, 1502.14, 1308.88, 1093.29, 100000, 1000, 1000, 16),
(17, 17, 2550.15, -1287.49, 1054.64, 100000, 1000, 1000, 17),
(18, 18, 2550.15, -1287.49, 1054.64, 100000, 1000, 1000, 18),
(19, 19, 240.683, 71.1112, 1005.04, 100000, 1000, 1000, 19),
(20, 20, 1501.94, 1309.4, 1093.29, 100000, 1000, 1000, 20),
(21, 21, 1502.14, 1308.88, 1093.29, 100000, 1000, 1000, 21),
(22, 22, 604.763, -26.5193, 1004.78, 100000, 1000, 1000, 22),
(23, 23, 1722.87, -1673.41, 20.2231, 100000, 1000, 1000, 23),
(24, 24, 280.831, 188.109, 1007.17, 100000, 1000, 1000, 24),
(25, 25, 2550.15, -1287.49, 1054.64, 100000, 1000, 1000, 25),
(26, 26, 2550.15, -1287.49, 1054.64, 100000, 1000, 1000, 26),
(27, 27, 2550.15, -1287.49, 1054.64, 100000, 1000, 1000, 27);

-- --------------------------------------------------------

--
-- Table structure for table `stuff`
--

CREATE TABLE `stuff` (
  `ID` int(11) NOT NULL,
  `Tax` int(20) NOT NULL,
  `TaxValue` int(20) NOT NULL,
  `ServerStock` varchar(50) NOT NULL DEFAULT '0|0|0|0|0|0|0|0|0|0|',
  `goal` int(11) NOT NULL,
  `mgoal` int(11) NOT NULL,
  `nickname` varchar(128) NOT NULL,
  `password` varchar(32) NOT NULL DEFAULT '0',
  `AdminRaport` int(11) NOT NULL,
  `HelperRaport` int(11) NOT NULL,
  `App` int(11) NOT NULL,
  `AppLeader` int(11) NOT NULL,
  `Payday` int(11) NOT NULL,
  `chapter` int(11) NOT NULL,
  `bpTime` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `stuff`
--

INSERT INTO `stuff` (`ID`, `Tax`, `TaxValue`, `ServerStock`, `goal`, `mgoal`, `nickname`, `password`, `AdminRaport`, `HelperRaport`, `App`, `AppLeader`, `Payday`, `chapter`, `bpTime`) VALUES
(1, 0, 0, '100 100 100 100 100 100 100 100 100', 626809, 0, 'RPG.ELYSIUM.RO | DESCHIDEREA 24.03.2023', 'madalin123', 50, 25, 0, 0, 2, 1, 1684515461);

-- --------------------------------------------------------

--
-- Table structure for table `svehicles`
--

CREATE TABLE `svehicles` (
  `vID` int(11) NOT NULL,
  `vModel` int(10) NOT NULL,
  `LocationX` float NOT NULL,
  `LocationY` float NOT NULL,
  `LocationZ` float NOT NULL,
  `Angle` float NOT NULL,
  `Color1` int(10) NOT NULL,
  `Color2` int(10) NOT NULL,
  `Faction` int(10) NOT NULL,
  `Rank` int(10) NOT NULL,
  `NumberPlate` varchar(64) NOT NULL DEFAULT 'NewCar'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `svehicles`
--

INSERT INTO `svehicles` (`vID`, `vModel`, `LocationX`, `LocationY`, `LocationZ`, `Angle`, `Color1`, `Color2`, `Faction`, `Rank`, `NumberPlate`) VALUES
(8, 521, 2498.72, -1685.79, 13.021, 1.342, 234, 234, 4, 0, 'NewCar'),
(9, 521, 2497, -1685.85, 13.005, 2.478, 234, 234, 4, 0, 'NewCar'),
(10, 521, 2491.37, -1686.05, 13.08, 359.63, 234, 234, 4, 0, 'NewCar'),
(11, 521, 2493.23, -1685.99, 13.08, 0.537, 234, 234, 4, 0, 'NewCar'),
(12, 409, 2473.25, -1694.45, 13.316, 0.469, 234, 234, 4, 0, 'NewCar'),
(13, 487, 2531.51, -1677.05, 19.93, 89.792, 234, 234, 4, 0, 'NewCar'),
(14, 518, 2482.11, -1692.78, 13.191, 354.135, 234, 234, 4, 0, 'NewCar'),
(15, 579, 2501.76, -1655.58, 13.389, 58.75, 234, 234, 4, 0, 'NewCar'),
(16, 579, 2504.07, -1681.12, 13.387, 298.51, 234, 234, 4, 0, 'NewCar'),
(17, 579, 2508.74, -1674.69, 13.356, 343.662, 234, 234, 4, 0, 'NewCar'),
(18, 579, 2509.69, -1666.5, 13.415, 7.776, 234, 234, 4, 0, 'NewCar'),
(19, 551, 2471.61, -1677.58, 13.191, 211.529, 234, 234, 4, 0, 'NewCar'),
(20, 551, 2468.37, -1670.22, 13.193, 194.4, 234, 234, 4, 0, 'NewCar'),
(21, 560, 2486.38, -1653.47, 13.103, 86.734, 234, 234, 4, 0, 'NewCar'),
(22, 560, 2479.78, -1653.79, 13.094, 89.889, 234, 234, 4, 0, 'NewCar'),
(24, 480, 2479.91, -1683.32, 13.18, 249.715, 234, 234, 4, 0, 'NewCar'),
(25, 480, 2471.47, -1653.61, 13.176, 90.528, 234, 234, 4, 0, 'NewCar'),
(26, 521, 2635.23, 2350.97, 10.346, 201.6, 125, 125, 18, 0, 'NewCar'),
(27, 521, 2636.99, 2351.16, 10.346, 202.602, 125, 125, 18, 0, 'NewCar'),
(28, 521, 2629.35, 2349, 10.348, 209.617, 125, 125, 18, 0, 'NewCar'),
(29, 521, 2627.98, 2348.34, 10.348, 210.915, 125, 125, 18, 0, 'NewCar'),
(30, 560, 2611.07, 2279.53, 10.526, 88.034, 125, 125, 18, 0, 'NewCar'),
(31, 560, 2611.25, 2275.3, 10.525, 89.75, 125, 125, 18, 0, 'NewCar'),
(32, 409, 2611, 2271.08, 10.62, 90.889, 125, 125, 18, 0, 'NewCar'),
(33, 518, 2611.33, 2267.02, 10.491, 90.483, 125, 125, 18, 0, 'NewCar'),
(34, 480, 2611.18, 2262.76, 10.594, 89.362, 125, 125, 18, 0, 'NewCar'),
(35, 480, 2611.21, 2258.52, 10.589, 90.945, 125, 125, 18, 0, 'NewCar'),
(36, 579, 2593.08, 2279.04, 10.748, 270.527, 125, 125, 18, 0, 'NewCar'),
(37, 579, 2593.07, 2275.33, 10.752, 269.318, 125, 125, 18, 0, 'NewCar'),
(38, 579, 2593.1, 2271.67, 10.756, 270.725, 125, 125, 18, 0, 'NewCar'),
(39, 579, 2593.11, 2267.86, 10.7531, 269.926, 125, 125, 18, 0, 'NewCar'),
(40, 551, 2594.21, 2250.99, 10.621, 0.777, 125, 125, 18, 0, 'NewCar'),
(41, 551, 2589.98, 2251, 10.621, 359.582, 125, 125, 18, 0, 'NewCar'),
(42, 551, 2585.19, 2250.98, 10.621, 1.458, 125, 125, 18, 0, 'NewCar'),
(43, 551, 2580.47, 2250.81, 10.621, 359.89, 125, 125, 18, 0, 'NewCar'),
(44, 487, 2577.3, 2307.65, 17.98, 256.322, 125, 125, 18, 0, 'NewCar'),
(45, 579, 657.18, -1274.67, 13.5669, 270.422, 228, 228, 6, 0, 'NewCar'),
(46, 579, 657.079, -1262.9, 13.5052, 270.278, 228, 228, 6, 0, 'NewCar'),
(47, 579, 672.779, -1295.38, 13.5661, 88.8371, 228, 228, 6, 0, 'NewCar'),
(48, 579, 672.558, -1291.24, 13.5085, 90.6385, 228, 228, 6, 0, 'NewCar'),
(49, 487, 726.274, -1244.87, 13.6376, 87.5075, 228, 228, 6, 0, 'NewCar'),
(50, 518, 657.172, -1266.95, 13.3188, 268.877, 228, 228, 6, 0, 'NewCar'),
(51, 521, 687.373, -1262.63, 13.0955, 83.7724, 228, 228, 6, 0, 'NewCar'),
(52, 521, 687.223, -1251.96, 13.1993, 89.5486, 228, 228, 6, 0, 'NewCar'),
(53, 521, 687.406, -1258.63, 13.1033, 88.2548, 228, 228, 6, 0, 'NewCar'),
(54, 521, 687.429, -1254.68, 13.1536, 85.8223, 228, 228, 6, 0, 'NewCar'),
(55, 409, 657.231, -1283.66, 13.4353, 0.396389, 228, 228, 6, 0, 'NewCar'),
(56, 560, 672.858, -1262.46, 13.2993, 89.545, 228, 228, 6, 0, 'NewCar'),
(57, 560, 672.98, -1256.58, 13.2969, 90.0246, 228, 228, 6, 0, 'NewCar'),
(58, 480, 672.788, -1286.69, 13.3835, 88.2666, 228, 228, 6, 0, 'NewCar'),
(59, 480, 672.553, -1267.29, 13.3726, 89.6505, 228, 228, 6, 0, 'NewCar'),
(60, 579, 1413.22, 743.065, 10.753, 269.491, 167, 167, 10, 0, 'NewCar'),
(61, 579, 1413.19, 749.366, 10.755, 269.711, 167, 167, 10, 0, 'NewCar'),
(62, 579, 1413.19, 755.97, 10.754, 269.925, 167, 167, 10, 0, 'NewCar'),
(63, 579, 1413.12, 762.375, 10.754, 271.091, 167, 167, 10, 0, 'NewCar'),
(64, 521, 1453.75, 745.125, 10.592, 91.789, 167, 167, 10, 0, 'NewCar'),
(65, 521, 1453.75, 743.451, 10.592, 88.332, 167, 167, 10, 0, 'NewCar'),
(66, 521, 1453.55, 756.663, 10.592, 91.525, 167, 167, 10, 0, 'NewCar'),
(67, 521, 1453.55, 758.185, 10.592, 91.046, 167, 167, 10, 0, 'NewCar'),
(68, 560, 1412.92, 768.592, 10.526, 270.608, 167, 167, 10, 0, 'NewCar'),
(69, 560, 1412.9, 775.013, 10.526, 270.097, 167, 167, 10, 0, 'NewCar'),
(70, 480, 1413.04, 781.519, 10.594, 270.572, 167, 167, 10, 0, 'NewCar'),
(71, 480, 1412.97, 787.853, 10.593, 269.968, 167, 167, 10, 0, 'NewCar'),
(72, 409, 1429.05, 795.801, 10.62, 89.267, 167, 167, 10, 0, 'NewCar'),
(73, 518, 1445.52, 787.53, 10.491, 180.513, 167, 167, 10, 0, 'NewCar'),
(74, 487, 1412.91, 730.831, 11.018, 269.52, 167, 167, 10, 0, 'NewCar'),
(75, 461, 1459.32, 2778.99, 10.4033, 269.106, 155, 155, 5, 0, 'NewCar'),
(76, 461, 1459.33, 2781.1, 10.3988, 270.116, 155, 155, 5, 0, 'NewCar'),
(77, 521, 1459.35, 2783.44, 10.3823, 268.396, 155, 155, 5, 0, 'NewCar'),
(78, 521, 1459.53, 2785.76, 10.3861, 262.024, 155, 155, 5, 0, 'NewCar'),
(79, 560, 1468.45, 2798.29, 10.4471, 312.972, 155, 155, 5, 0, 'NewCar'),
(80, 426, 1479.64, 2843.01, 10.5636, 180.306, 155, 155, 5, 0, 'NewCar'),
(81, 426, 1484.27, 2843.11, 10.5632, 180.781, 155, 155, 5, 0, 'NewCar'),
(82, 426, 1489.48, 2843.25, 10.5635, 181.177, 155, 155, 5, 0, 'NewCar'),
(83, 480, 1494.49, 2843.36, 10.5941, 180.564, 155, 155, 5, 0, 'NewCar'),
(84, 567, 1484.7, 2791.26, 10.689, 269.544, 155, 155, 5, 0, 'NewCar'),
(85, 409, 1505.21, 2793.41, 10.5407, 204.986, 155, 155, 5, 0, 'NewCar'),
(86, 409, 1505.52, 2753.03, 10.5423, 334.401, 155, 155, 5, 0, 'NewCar'),
(87, 567, 1485.26, 2754.4, 10.6918, 269.442, 155, 155, 5, 0, 'NewCar'),
(88, 560, 1472.59, 2745.6, 10.4489, 236.339, 155, 155, 5, 0, 'NewCar'),
(89, 579, 1492.57, 2742.29, 10.6722, 287.2, 155, 155, 5, 0, 'NewCar'),
(90, 487, 1521.54, 2731.9, 10.9945, 88.6134, 155, 155, 5, 0, 'NewCar'),
(91, 521, 1132.77, -2048.26, 68.5737, 267.791, 36, 36, 17, 0, 'NewCar'),
(92, 521, 1132.84, -2050.08, 68.5786, 272.529, 36, 36, 17, 0, 'NewCar'),
(93, 461, 1132.38, -2025.48, 68.583, 271.61, 36, 36, 17, 0, 'NewCar'),
(94, 461, 1132.36, -2023.35, 68.5835, 269.968, 36, 36, 17, 0, 'NewCar'),
(95, 480, 1145.39, -2005.22, 68.7818, 270.55, 36, 36, 17, 0, 'NewCar'),
(96, 487, 1116.09, -2017.79, 74.607, 271.309, 36, 36, 17, 0, 'NewCar'),
(97, 560, 1164.56, -2005.32, 68.7127, 269.756, 36, 36, 17, 0, 'NewCar'),
(98, 426, 1174.99, -2031.06, 68.751, 0.358274, 36, 36, 17, 0, 'NewCar'),
(99, 579, 1167.78, -2036.93, 68.9355, 89.9587, 36, 36, 17, 0, 'NewCar'),
(100, 402, 1181.41, -2037.07, 68.8395, 269.746, 36, 36, 17, 0, 'NewCar'),
(101, 426, 1175.24, -2044.53, 68.7508, 181.482, 36, 36, 17, 0, 'NewCar'),
(102, 480, 1142.43, -2068.79, 68.6994, 271.187, 36, 36, 17, 0, 'NewCar'),
(103, 560, 1166.38, -2068.87, 68.7127, 270.876, 36, 36, 17, 0, 'NewCar'),
(104, 409, 1150.88, -2047.01, 68.8006, 328.206, 36, 36, 17, 0, 'NewCar'),
(105, 409, 1149.22, -2026.93, 68.8042, 226.039, 36, 36, 17, 0, 'NewCar'),
(106, 567, 1274.8, -2010.01, 58.867, 90.0461, 36, 36, 17, 0, 'NewCar'),
(107, 567, 1274.71, -2015.15, 58.8633, 89.299, 36, 36, 17, 0, 'NewCar'),
(108, 412, 1249.33, -2042.08, 59.5671, 269.475, 36, 36, 17, 0, 'NewCar'),
(109, 579, -2641.02, 1329.58, 7.12377, 269.276, 226, 226, 26, 0, 'NewCar'),
(110, 579, -2632.1, 1329.54, 7.12849, 270.012, 226, 226, 26, 0, 'NewCar'),
(111, 567, -2622.94, 1333.78, 7.06296, 315.53, 226, 226, 26, 0, 'NewCar'),
(112, 567, -2614.75, 1348.19, 7.06473, 359.124, 226, 226, 26, 0, 'NewCar'),
(113, 426, -2646.97, 1377.86, 6.91499, 180.131, 226, 226, 26, 0, 'NewCar'),
(114, 426, -2642.47, 1377.83, 6.89713, 179.498, 226, 226, 26, 0, 'NewCar'),
(115, 480, -2637.96, 1378.09, 6.9161, 181.139, 226, 1, 26, 0, 'NewCar'),
(116, 480, -2633.28, 1378.07, 6.91346, 179.36, 226, 1, 26, 0, 'NewCar'),
(117, 409, -2628.9, 1377.87, 6.93828, 180.736, 226, 1, 26, 0, 'NewCar'),
(118, 409, -2624.28, 1377.9, 6.93854, 179.54, 226, 1, 26, 0, 'NewCar'),
(119, 461, -2632.75, 1398.24, 6.67409, 185.786, 226, 226, 26, 0, 'NewCar'),
(120, 461, -2636.94, 1397.06, 6.67789, 191.746, 226, 226, 26, 0, 'NewCar'),
(121, 461, -2639.95, 1396.23, 6.67778, 194.73, 226, 226, 26, 0, 'NewCar'),
(122, 461, -2643.15, 1395.4, 6.67643, 194.266, 226, 226, 26, 0, 'NewCar'),
(123, 461, -2646.66, 1394.39, 6.67849, 197.105, 226, 226, 26, 0, 'NewCar'),
(124, 560, -2620.84, 1378.11, 6.84541, 180, 226, 226, 26, 0, 'NewCar'),
(125, 560, -2617.1, 1378.09, 6.84518, 179.676, 226, 226, 26, 0, 'NewCar'),
(126, 487, -2595, 1377.36, 7.29607, 157.663, 226, 1, 26, 0, 'NewCar'),
(127, 461, -2528.66, -622.714, 132.331, 358.731, 158, 158, 27, 0, 'NewCar'),
(128, 461, -2530.33, -622.713, 132.329, 1.20648, 158, 158, 27, 0, 'NewCar'),
(129, 461, -2532.14, -622.67, 132.321, 2.21691, 158, 158, 27, 0, 'NewCar'),
(130, 461, -2533.83, -622.63, 132.319, 4.15496, 158, 158, 27, 0, 'NewCar'),
(131, 461, -2535.79, -622.639, 132.312, 358.237, 158, 158, 27, 0, 'NewCar'),
(132, 560, -2535.46, -602, 132.267, 180.268, 158, 158, 27, 0, 'NewCar'),
(133, 560, -2531.79, -601.938, 132.268, 181.605, 158, 158, 27, 0, 'NewCar'),
(134, 409, -2528.14, -602.292, 132.362, 179.852, 158, 1, 27, 0, 'NewCar'),
(135, 409, -2524.29, -602.37, 132.362, 180.069, 158, 1, 27, 0, 'NewCar'),
(136, 480, -2520.61, -602.04, 132.336, 180.131, 158, 1, 27, 0, 'NewCar'),
(137, 480, -2516.93, -601.915, 132.335, 179.655, 158, 1, 27, 0, 'NewCar'),
(138, 426, -2513.28, -602.273, 132.306, 180.639, 158, 1, 27, 0, 'NewCar'),
(139, 426, -2509.33, -602.21, 132.306, 180.473, 158, 1, 27, 0, 'NewCar'),
(141, 567, -2505.71, -602.153, 132.433, 179.416, 158, 1, 27, 0, 'NewCar'),
(142, 567, -2501.86, -602.004, 132.43, 180.899, 158, 1, 27, 0, 'NewCar'),
(143, 579, -2498.23, -602.112, 132.494, 180.511, 158, 158, 27, 0, 'NewCar'),
(144, 579, -2494.54, -602.103, 132.493, 179.635, 158, 158, 27, 0, 'NewCar'),
(145, 487, -2466.89, -597.716, 132.589, 96.7495, 158, 1, 27, 0, 'NewCar'),
(146, 560, -2462.87, 156.383, 34.7677, 359.362, 168, 168, 25, 0, 'NewCar'),
(147, 560, -2462.82, 148.355, 34.7698, 0.642166, 168, 168, 25, 0, 'NewCar'),
(148, 480, -2445.21, 142.455, 34.8047, 270.927, 168, 1, 25, 0, 'NewCar'),
(149, 480, -2437.13, 142.491, 34.8044, 270.287, 168, 1, 25, 0, 'NewCar'),
(150, 461, -2449.63, 129.804, 34.7519, 359.406, 168, 1, 25, 0, 'NewCar'),
(151, 461, -2437.57, 129.935, 34.7491, 358.317, 168, 1, 25, 0, 'NewCar'),
(152, 461, -2447.11, 129.692, 34.7555, 359.018, 168, 1, 25, 0, 'NewCar'),
(153, 461, -2440.54, 129.925, 34.7513, 1.23639, 168, 1, 25, 0, 'NewCar'),
(154, 461, -2443.78, 129.694, 34.7523, 1.99344, 168, 1, 25, 0, 'NewCar'),
(155, 409, -2435.36, 174.096, 34.8464, 269.504, 168, 1, 25, 0, 'NewCar'),
(156, 575, -2444.47, 174.021, 34.6339, 269.378, 168, 1, 25, 0, 'NewCar'),
(158, 579, -2462.76, 166.758, 34.9598, 0.262681, 168, 1, 25, 0, 'NewCar'),
(159, 579, -2456.73, 181.601, 34.9659, 314.861, 168, 1, 25, 0, 'NewCar'),
(160, 487, -2395.54, 182.378, 35.4882, 104.948, 168, 1, 25, 0, 'NewCar'),
(161, 426, -2440.73, 185.392, 34.7705, 270.041, 168, 1, 25, 0, 'NewCar'),
(162, 510, 2146.84, 2337, 10.4201, 91.9623, -1, -1, 0, 0, 'NewCar'),
(163, 510, 2140.65, 2336.95, 10.4278, 88.4746, -1, -1, 0, 0, 'NewCar'),
(164, 510, 2149.79, 2337.01, 10.42, 89.5296, -1, -1, 0, 0, 'NewCar'),
(165, 510, 2167.42, 2337.13, 10.4201, 91.3602, -1, -1, 0, 0, 'NewCar'),
(166, 510, 2164, 2337.03, 10.4201, 89.9928, -1, -1, 0, 0, 'NewCar'),
(167, 510, 2160.16, 2337.02, 10.4201, 90.057, -1, -1, 0, 0, 'NewCar'),
(168, 510, 2153.29, 2336.96, 10.42, 91.4542, -1, -1, 0, 0, 'NewCar'),
(169, 510, 2156.5, 2337.11, 10.4201, 90.9557, -1, -1, 0, 0, 'NewCar'),
(170, 510, 2118.18, 2337.02, 10.4279, 88.0908, -1, -1, 0, 0, 'NewCar'),
(171, 510, 2171.07, 2337.1, 10.4201, 92.5655, -1, -1, 0, 0, 'NewCar'),
(172, 510, 2177.46, 2337.13, 10.4201, 90.0531, -1, -1, 0, 0, 'NewCar'),
(173, 510, 2174.32, 2336.98, 10.4201, 91.0418, -1, -1, 0, 0, 'NewCar'),
(174, 510, 2143.84, 2337.03, 10.4201, 89.8831, -1, -1, 0, 0, 'NewCar'),
(175, 510, 2121.36, 2337.11, 10.4279, 91.0577, -1, -1, 0, 0, 'NewCar'),
(176, 510, 1195.73, -1728.44, 13.1758, 180.804, -1, -1, 0, 0, 'NewCar'),
(177, 510, 1207.02, -1728.19, 13.178, 179.303, -1, -1, 0, 0, 'NewCar'),
(178, 510, 1197.64, -1728.32, 13.1757, 179.237, -1, -1, 0, 0, 'NewCar'),
(179, 510, 1204.68, -1728.23, 13.1756, 179.179, -1, -1, 0, 0, 'NewCar'),
(180, 510, 1202.74, -1728.25, 13.1756, 177.481, -1, -1, 0, 0, 'NewCar'),
(181, 510, 1199.7, -1728.31, 13.1757, 180.746, -1, -1, 0, 0, 'NewCar'),
(182, 510, 1201.19, -1728.32, 13.1757, 185.869, -1, -1, 0, 0, 'NewCar'),
(183, 510, -2412.29, 352.244, 34.7795, 232.866, -1, -1, 0, 0, 'NewCar'),
(184, 510, -2413.21, 350.935, 34.7794, 233.27, -1, -1, 0, 0, 'NewCar'),
(185, 510, -2414.12, 349.631, 34.7794, 237.222, -1, -1, 0, 0, 'NewCar'),
(186, 510, -2415.06, 348.406, 34.7794, 232.334, -1, -1, 0, 0, 'NewCar'),
(187, 510, -2415.97, 347.081, 34.7862, 238.674, -1, -1, 0, 0, 'NewCar'),
(188, 510, -2431.28, 318.569, 34.7794, 247.041, -1, -1, 0, 0, 'NewCar'),
(189, 510, -2430.74, 319.804, 34.7794, 243.33, -1, -1, 0, 0, 'NewCar'),
(190, 510, -2430.16, 320.952, 34.7794, 242.732, -1, -1, 0, 0, 'NewCar'),
(191, 510, -2429.61, 322.245, 34.7794, 241.391, -1, -1, 0, 0, 'NewCar'),
(192, 510, -2428.99, 323.606, 34.7794, 240.735, -1, -1, 0, 0, 'NewCar'),
(193, 519, 1288.18, 1361.32, 11.715, 269.125, 6, 6, 0, 0, 'NewCar'),
(194, 452, 727.349, -1493.95, -0.453706, 182.23, 0, 0, 0, 0, 'NewCar'),
(196, 487, 1337.39, 1686.72, 10.8203, 268.64, 69, 1, 0, 0, 'NewCar'),
(197, 487, 1565.11, 1416.37, 11.1591, 89.7476, 69, 1, 0, 0, 'NewCar'),
(198, 487, 1560.44, 1492.1, 10.9938, 88.59, 69, 1, 0, 0, 'NewCar'),
(199, 487, 1628.59, 1359.39, 10.8038, 135.561, 69, 1, 0, 0, 'NewCar'),
(200, 509, 2104.96, 2336.85, 10.3304, 89.6105, -1, -1, 0, 0, 'NewCar'),
(201, 509, 2107.44, 2336.86, 10.3322, 90.4862, -1, -1, 0, 0, 'NewCar'),
(202, 509, 2109.73, 2336.95, 10.3322, 91.6987, -1, -1, 0, 0, 'NewCar'),
(203, 509, 2112.51, 2337.01, 10.3322, 90.4219, -1, -1, 0, 0, 'NewCar'),
(204, 509, 2115.63, 2336.99, 10.3322, 90.5748, -1, -1, 0, 0, 'NewCar'),
(205, 510, 2124.46, 2336.92, 10.4279, 89.0498, -1, -1, 0, 0, 'NewCar'),
(206, 510, 2127.32, 2337, 10.4279, 90.7012, -1, -1, 0, 0, 'NewCar'),
(207, 510, 2130.61, 2337.05, 10.4279, 90.2094, -1, -1, 0, 0, 'NewCar'),
(208, 510, 2137.49, 2336.93, 10.4279, 88.3521, -1, -1, 0, 0, 'NewCar'),
(209, 510, 2133.82, 2337.08, 10.4279, 88.8409, -1, -1, 0, 0, 'NewCar'),
(223, 487, 1939.14, -2648.35, 13.5469, 358.001, 211, 226, 0, 0, 'NewCar'),
(224, 487, 1952.91, -2648.22, 13.7362, 355.266, 211, 226, 0, 0, 'NewCar'),
(225, 487, 1966.54, -2647.19, 13.7322, 359.022, 226, 211, 0, 0, 'NewCar'),
(226, 487, 1979.19, -2647.93, 13.74, 358.341, 226, 211, 0, 0, 'NewCar'),
(227, 487, 1994.34, -2646.78, 13.8481, 4.66419, 205, 226, 0, 0, 'NewCar'),
(228, 487, 2007.78, -2646.62, 13.7339, 356.209, 205, 226, 0, 0, 'NewCar'),
(229, 519, 1902.2, -2629.27, 14.4657, 359.1, 205, 226, 0, 0, 'NewCar'),
(230, 519, 1875.08, -2629, 14.4666, 358.408, 205, 226, 0, 0, 'NewCar'),
(231, 487, 2021.45, -2418.79, 13.7364, 88.0069, 205, 226, 0, 0, 'NewCar'),
(232, 487, 1561.18, 1471.41, 11.0104, 89.0722, 211, 226, 0, 0, 'NewCar'),
(233, 487, 1563.03, 1453.71, 11.0299, 92.2322, 211, 226, 0, 0, 'NewCar'),
(234, 487, 1563.48, 1435.56, 11.0109, 90.6671, 211, 226, 0, 0, 'NewCar'),
(235, 487, -1555.1, -225.836, 14.3655, 42.8927, 211, 226, 0, 0, 'NewCar'),
(236, 487, -1562.96, -233.924, 14.3302, 43.6249, 211, 226, 0, 0, 'NewCar'),
(237, 487, -1571.41, -242.994, 14.3243, 42.5896, 211, 226, 0, 0, 'NewCar'),
(238, 487, -1578.91, -251.836, 14.3325, 42.0404, 211, 226, 0, 0, 'NewCar'),
(239, 487, -1547.93, -217.827, 14.327, 39.8444, 211, 226, 0, 0, 'NewCar'),
(240, 519, -1284.77, 28.7138, 15.067, 134.831, 211, 226, 0, 0, 'NewCar'),
(241, 519, -1264.29, 7.99412, 15.0707, 133.567, 211, 226, 0, 0, 'NewCar'),
(242, 452, 733.655, -1496.19, -0.52491, 181.772, 226, 211, 0, 0, 'NewCar'),
(243, 452, 718.816, -1493.88, -0.439052, 182.641, 226, 211, 0, 0, 'NewCar'),
(244, 452, 1628.67, 572.255, -0.464026, 91.0879, 226, 211, 0, 0, 'NewCar'),
(245, 473, 1636.79, 587.062, -0.293964, 178.554, 226, 211, 0, 0, 'NewCar'),
(246, 473, 1636.92, 596.099, -0.405819, 185.281, 226, 211, 0, 0, 'NewCar'),
(247, 473, 1636.76, 579.707, -0.189769, 180.342, 205, 211, 0, 0, 'NewCar'),
(248, 473, 1619.74, 596.352, -0.276705, 182.294, 211, 226, 0, 0, 'NewCar'),
(249, 473, 1619.75, 586.725, -0.221683, 178.899, 211, 226, 0, 0, 'NewCar'),
(250, 473, 1619.77, 578.531, -0.27762, 179.187, 211, 226, 0, 0, 'NewCar'),
(251, 411, -1938.55, 228.96, 34.1562, 123.84, 0, 0, 0, 0, 'NewCar');

-- --------------------------------------------------------

--
-- Table structure for table `svf`
--

CREATE TABLE `svf` (
  `ID` int(11) NOT NULL,
  `Faction` int(11) NOT NULL,
  `Model` int(11) NOT NULL,
  `Rank` int(11) NOT NULL,
  `Stock` int(11) NOT NULL,
  `Color1` int(11) NOT NULL,
  `Color2` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `svf`
--

INSERT INTO `svf` (`ID`, `Faction`, `Model`, `Rank`, `Stock`, `Color1`, `Color2`) VALUES
(1, 1, 411, 3, 10, 1, 1),
(2, 1, 523, 1, 15, 1, 0),
(3, 1, 522, 3, 15, 1, 0),
(5, 1, 598, 1, 15, 1, 0),
(6, 1, 599, 2, 15, 1, 0),
(7, 1, 497, 3, 15, 1, 0),
(8, 1, 427, 2, 15, 1, 0),
(11, 2, 490, 1, 15, 0, 0),
(12, 2, 601, 2, 15, 0, 0),
(13, 2, 541, 2, 15, 0, 0),
(14, 2, 522, 3, 15, 0, 0),
(15, 2, 528, 1, 15, 0, 0),
(16, 2, 497, 3, 15, 0, 0),
(17, 3, 425, 3, 15, 42, 42),
(18, 3, 522, 2, 15, 42, 42),
(19, 3, 598, 1, 15, 42, 42),
(20, 3, 520, 3, 15, 1, 1),
(22, 3, 451, 3, 15, 42, 42),
(23, 3, 470, 1, 20, 42, 42),
(24, 3, 476, 2, 15, 42, 42),
(25, 3, 433, 3, 15, 42, 42),
(26, 7, 551, 1, 15, 128, 128),
(27, 7, 560, 2, 15, 128, 128),
(28, 7, 487, 3, 15, 128, 128),
(29, 8, 525, 1, 15, 1, 102),
(31, 8, 552, 2, 15, 1, 102),
(36, 11, 469, 1, 40, 0, 0),
(37, 11, 402, 1, 15, 0, 0),
(38, 11, 560, 3, 15, 0, 0),
(39, 11, 487, 3, 15, 0, 0),
(40, 11, 521, 3, 15, 0, 0),
(41, 12, 420, 1, 20, 6, 6),
(43, 12, 438, 1, 15, 6, 6),
(44, 12, 560, 3, 15, 6, 6),
(45, 12, 487, 3, 15, 6, 6),
(47, 12, 602, 2, 15, 6, 6),
(48, 12, 506, 2, 15, 6, 6),
(49, 12, 566, 2, 15, 6, 6),
(50, 13, 416, 1, 25, 1, 3),
(51, 13, 599, 2, 15, 1, 3),
(52, 13, 563, 3, 15, 1, 3),
(61, 15, 409, 1, 15, 128, 0),
(62, 15, 411, 4, 15, 128, 0),
(63, 15, 541, 3, 15, 128, 0),
(64, 15, 560, 3, 15, 128, 0),
(65, 15, 415, 2, 15, 128, 0),
(66, 15, 579, 2, 15, 128, 0),
(67, 8, 443, 3, 15, 65, 65),
(68, 16, 551, 1, 15, 128, 128),
(69, 16, 560, 2, 15, 128, 128),
(70, 16, 487, 1, 15, 128, 128),
(76, 19, 599, 1, 15, 1, 0),
(77, 19, 497, 1, 15, 1, 0),
(78, 19, 597, 1, 15, 1, 0),
(79, 19, 523, 1, 15, 1, 0),
(81, 19, 522, 2, 15, 0, 0),
(82, 19, 411, 2, 15, 1, 1),
(83, 19, 411, 3, 15, 1, 1),
(86, 20, 416, 1, 25, 3, 1),
(87, 20, 544, 1, 15, 3, 1),
(88, 20, 505, 3, 15, 3, 1),
(89, 21, 551, 1, 15, 128, 128),
(92, 21, 560, 2, 15, 128, 128),
(93, 21, 487, 1, 15, 128, 128),
(94, 19, 411, 4, 15, 1, 1),
(95, 22, 525, 1, 15, 1, 102),
(96, 22, 552, 1, 15, 1, 102),
(97, 22, 443, 3, 15, 1, 102),
(98, 23, 487, 4, 15, 117, 117),
(99, 23, 411, 3, 15, 117, 117),
(100, 23, 411, 1, 15, 117, 117),
(102, 23, 541, 2, 15, 117, 0),
(103, 23, 522, 1, 15, 117, 117),
(104, 23, 522, 2, 15, 117, 117),
(105, 0, 488, 1, 10, 126, 1),
(106, 9, 582, 1, 15, 126, 1),
(107, 9, 522, 3, 15, 126, 1),
(108, 9, 560, 4, 15, 126, 1),
(109, 0, 487, 5, 15, 126, 1),
(116, 14, 598, 1, 20, 127, 1),
(117, 14, 523, 1, 20, 127, 1),
(118, 14, 497, 1, 15, 127, 1),
(119, 14, 522, 2, 15, 127, 1),
(120, 14, 411, 3, 15, 1, 127),
(121, 24, 432, 5, 15, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `tickets`
--

CREATE TABLE `tickets` (
  `ID` int(11) NOT NULL,
  `Username` text NOT NULL,
  `Type` text NOT NULL,
  `Status` int(11) NOT NULL,
  `Priority` text NOT NULL,
  `Description` text NOT NULL,
  `Date` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `transferlog`
--

CREATE TABLE `transferlog` (
  `ID` int(11) NOT NULL,
  `Name` varchar(64) NOT NULL,
  `Name2` varchar(64) NOT NULL,
  `psql1` int(11) NOT NULL,
  `psql2` int(11) NOT NULL,
  `money` int(11) NOT NULL,
  `time` varchar(64) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `turfs`
--

CREATE TABLE `turfs` (
  `ID` int(11) NOT NULL,
  `Name` varchar(64) NOT NULL,
  `Owned` int(11) NOT NULL,
  `Time` int(11) NOT NULL,
  `MinX` float NOT NULL,
  `MinY` float NOT NULL,
  `MaxX` float NOT NULL,
  `MaxY` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `turfs`
--

INSERT INTO `turfs` (`ID`, `Name`, `Owned`, `Time`, `MinX`, `MinY`, `MaxX`, `MaxY`) VALUES
(1, '', 4, 0, 90.8647, -1353.89, 516.865, -925.885),
(2, '', 4, 0, 517.875, -1353.89, 943.875, -925.886),
(3, '', 4, 0, 943.865, -1314.89, 1371.86, -925.885),
(4, '', 4, 24, 1370.85, -1353.89, 1796.85, -925.886),
(5, '', 4, 24, 1798.85, -1353.89, 2224.85, -925.886),
(6, '', 4, 24, 2224.84, -1354.89, 2573.84, -925.886),
(7, '', 4, 24, 2573.83, -1298.89, 2923.83, -925.886),
(8, '', 4, 24, 91.8508, -1781.89, 517.851, -1353.89),
(9, '', 4, 0, 517.851, -1781.89, 943.851, -1353.89),
(10, '', 4, 24, 943.865, -1704.89, 1371.86, -1314.89),
(11, '', 4, 24, 1370.84, -1782.88, 1798.84, -1353.88),
(12, '', 4, 24, 1798.85, -1781.89, 2224.85, -1353.89),
(13, '', 4, 24, 2224.84, -1782.89, 2573.84, -1353.89),
(14, '', 4, 24, 2573.83, -1671.89, 2923.83, -1298.89),
(15, '', 4, 24, 943.832, -2133.88, 1370.83, -1704.88),
(16, '', 4, 24, 943.828, -2561.87, 1369.83, -2131.87),
(17, '', 4, 24, 1372.84, -2210.87, 1798.84, -1782.87),
(18, '', 4, 24, 1798.83, -2210.87, 2224.83, -1782.87),
(19, '', 4, 24, 2224.85, -2210.87, 2573.85, -1781.87),
(20, '', 4, 24, 2573.82, -2100.87, 2922.82, -1671.87),
(21, '', 4, 24, 1372.83, -2639.85, 1798.83, -2211.85),
(22, '', 4, 24, 1798.83, -2639.85, 2224.83, -2211.85),
(23, '', 4, 24, 2224.83, -2640.85, 2573.83, -2211.85),
(24, '', 4, 24, 2573.81, -2530.86, 2922.81, -2101.86),
(25, '', 5, 24, 1108.68, 2464.21, 1484.68, 2894.21),
(26, '', 6, 0, 1484.67, 2464.22, 1860.67, 2894.22),
(27, '', 6, 0, 1860.67, 2464.22, 2236.67, 2894.22),
(28, '', 6, 0, 2235.66, 2464.22, 2611.66, 2894.22),
(29, '', 6, 0, 2610.66, 2464.22, 2986.66, 2894.22),
(30, '', 6, 24, 888.793, 2034.22, 1282.79, 2464.22),
(31, '', 6, 24, 1282.79, 2034.22, 1676.79, 2464.22),
(32, '', 4, 24, 1676.77, 2034.22, 2070.77, 2464.22),
(33, '', 4, 24, 2071.76, 2034.22, 2465.76, 2464.22),
(34, '', 18, 24, 2465.66, 2034.22, 2985.66, 2464.22),
(35, '', 4, 24, 888.789, 1604.22, 1282.79, 2034.22),
(36, '', 4, 24, 1282.79, 1604.22, 1676.79, 2034.22),
(37, '', 4, 24, 1676.77, 1604.22, 2070.77, 2034.22),
(38, '', 4, 24, 2071.76, 1604.22, 2465.76, 2034.22),
(39, '', 4, 24, 2466.76, 1604.22, 2986.76, 2034.22),
(40, '', 4, 24, 887.789, 1174.22, 1281.79, 1604.22),
(41, '', 4, 24, 1282.79, 1174.22, 1676.79, 1604.22),
(42, '', 4, 24, 1676.77, 1174.22, 2070.77, 1604.22),
(43, '', 4, 24, 2071.76, 1174.22, 2465.76, 1604.22),
(44, '', 4, 24, 2466.76, 1174.22, 2986.76, 1604.22),
(45, '', 4, 24, 1282.77, 744.219, 1676.77, 1174.22),
(46, '', 4, 24, 1676.77, 744.219, 2070.77, 1174.22),
(47, '', 4, 24, 2071.76, 744.219, 2465.76, 1174.22),
(48, '', 4, 24, 2466.76, 744.219, 2986.76, 1174.22),
(49, '', 4, 24, -2877.02, -521.938, -2561.02, -208.938),
(50, '', 4, 24, -2561.02, -521.938, -2245.02, -208.938),
(51, '', 4, 24, -2245.02, -521.938, -1929.02, -208.938),
(52, '', 4, 24, -1929.02, -521.938, -1613.02, -208.938),
(53, '', 4, 24, -1929.02, -209.938, -1613.02, 103.062),
(54, '', 4, 24, -2245.02, -209.938, -1929.02, 103.062),
(55, '', 4, 24, -2561.02, -209.938, -2245.02, 103.062),
(56, '', 4, 24, -2877.02, -209.938, -2561.02, 103.062),
(57, '', 4, 24, -2877.02, 102.062, -2561.02, 415.062),
(58, '', 25, 24, -2561.02, 102.062, -2245.02, 415.062),
(59, '', 4, 24, -2245.02, 102.062, -1929.02, 415.062),
(60, '', 25, 24, -1929.02, 102.062, -1613.02, 415.062),
(61, '', 25, 0, -2877.02, 414.062, -2561.02, 727.062),
(62, '', 25, 24, -2561.02, 414.062, -2245.02, 727.062),
(63, '', 25, 24, -2245.02, 414.062, -1929.02, 727.062),
(64, '', 25, 0, -1929.02, 414.062, -1613.02, 727.062),
(65, '', 25, 0, -1805.02, 726.062, -1489.02, 1039.06),
(66, '', 25, 0, -2121.02, 726.062, -1805.02, 1039.06),
(67, '', 25, 0, -2437.02, 726.062, -2121.02, 1039.06),
(68, '', 25, 0, -2753.02, 726.062, -2437.02, 1039.06),
(69, '', 25, 24, -2837.02, 1038.06, -2521.02, 1351.06),
(70, '', 25, 24, -2521.02, 1038.06, -2205.02, 1351.06),
(71, '', 25, 24, -2205.02, 1038.06, -1889.02, 1351.06),
(72, '', 25, 24, -1889.02, 1038.06, -1573.02, 1351.06);

-- --------------------------------------------------------

--
-- Table structure for table `unban-comments`
--

CREATE TABLE `unban-comments` (
  `ID` int(11) NOT NULL,
  `Username` text NOT NULL,
  `Text` text NOT NULL,
  `UnbanID` int(11) NOT NULL,
  `Date` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `unban-panel`
--

CREATE TABLE `unban-panel` (
  `ID` int(11) NOT NULL,
  `Username` text NOT NULL,
  `Status` int(11) NOT NULL DEFAULT 0,
  `Reason` text NOT NULL,
  `Poza` text NOT NULL,
  `Description` text NOT NULL,
  `Date` text NOT NULL,
  `Now` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `updates`
--

CREATE TABLE `updates` (
  `id` int(11) NOT NULL,
  `text` text NOT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp(),
  `byAdmin` text NOT NULL,
  `name` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(25) NOT NULL,
  `password` varchar(128) NOT NULL,
  `IP` varchar(16) NOT NULL DEFAULT 'Not logged',
  `Level` int(3) NOT NULL DEFAULT 1,
  `Admin` int(2) NOT NULL DEFAULT 0,
  `Helper` int(2) NOT NULL DEFAULT 0,
  `Premium` int(2) NOT NULL DEFAULT 0,
  `ConnectedTime` float NOT NULL DEFAULT 0,
  `Registered` int(2) NOT NULL DEFAULT 0,
  `Sex` int(2) NOT NULL DEFAULT 0,
  `Age` int(3) NOT NULL DEFAULT 0,
  `Muted` int(2) NOT NULL DEFAULT 0,
  `MuteTime` int(11) NOT NULL DEFAULT 0,
  `Respect` int(11) NOT NULL DEFAULT 0,
  `Money` bigint(20) NOT NULL DEFAULT 0,
  `Bank` bigint(20) NOT NULL DEFAULT 0,
  `Phonebook` int(2) NOT NULL DEFAULT 0,
  `WantedLevel` int(11) NOT NULL DEFAULT 0,
  `Job` int(3) NOT NULL DEFAULT 0,
  `Jailed` int(2) NOT NULL DEFAULT 0,
  `JailTime` int(11) NOT NULL DEFAULT 0,
  `Materials` int(11) NOT NULL DEFAULT 0,
  `Drugs` int(11) NOT NULL DEFAULT 0,
  `Leader` int(3) NOT NULL DEFAULT 0,
  `Member` int(3) NOT NULL DEFAULT 0,
  `Rank` int(2) NOT NULL DEFAULT 0,
  `FWarn` int(2) NOT NULL DEFAULT 0,
  `FPunish` int(4) NOT NULL DEFAULT 0,
  `Model` int(11) NOT NULL,
  `PhoneNr` varchar(15) NOT NULL DEFAULT '0',
  `PhoneCredits` int(4) NOT NULL DEFAULT 0,
  `House` int(11) NOT NULL DEFAULT 999,
  `Bizz` int(11) NOT NULL DEFAULT 255,
  `Rob` int(11) NOT NULL DEFAULT 0,
  `CarLicT` int(11) NOT NULL DEFAULT 0,
  `CarLic` int(2) NOT NULL DEFAULT 0,
  `FlyLicT` int(11) NOT NULL DEFAULT 0,
  `FlyLic` int(2) NOT NULL DEFAULT 0,
  `BoatLicT` int(11) NOT NULL DEFAULT 0,
  `BoatLic` int(2) NOT NULL DEFAULT 0,
  `FishLicT` int(11) NOT NULL DEFAULT 0,
  `FishLic` int(2) NOT NULL DEFAULT 0,
  `GunLicT` int(11) NOT NULL DEFAULT 0,
  `GunLic` int(2) NOT NULL DEFAULT 0,
  `Tutorial` int(2) NOT NULL DEFAULT 0,
  `Warnings` int(2) NOT NULL DEFAULT 0,
  `Rented` int(111) NOT NULL DEFAULT -1,
  `Fuel` int(11) NOT NULL DEFAULT 0,
  `WTalkie` int(2) NOT NULL DEFAULT 0,
  `Lighter` int(2) NOT NULL DEFAULT 0,
  `Cigarettes` int(2) NOT NULL DEFAULT 0,
  `Email` varchar(50) NOT NULL DEFAULT 'email@yahoo.com',
  `RegisterDate` varchar(50) NOT NULL DEFAULT 'Nu exista',
  `lastOn` varchar(50) NOT NULL DEFAULT 'Nu exista',
  `Radio2` int(2) NOT NULL DEFAULT 0,
  `Status` int(11) NOT NULL DEFAULT -1,
  `Phone` int(11) NOT NULL DEFAULT 0,
  `Accused` varchar(64) NOT NULL DEFAULT '********',
  `Crime1` varchar(184) NOT NULL DEFAULT 'Fara',
  `Crime2` varchar(184) NOT NULL DEFAULT 'Fara',
  `Crime3` varchar(184) NOT NULL DEFAULT 'Fara',
  `ShowJob` int(10) NOT NULL,
  `ShowFP` int(10) NOT NULL,
  `ShowLogo` int(10) NOT NULL DEFAULT 1,
  `ShowCeas` int(10) NOT NULL DEFAULT 1,
  `GoldPoints` int(10) NOT NULL,
  `Clan` int(10) NOT NULL,
  `ClanRank` int(10) NOT NULL,
  `Pin` int(10) NOT NULL DEFAULT 0,
  `Seconds` int(10) NOT NULL,
  `GiftPoints` int(10) NOT NULL,
  `NewbieMute` int(10) NOT NULL,
  `HelpedPlayers` int(10) NOT NULL,
  `SpawnChange` int(10) NOT NULL,
  `DailyMission1` int(11) NOT NULL DEFAULT -1,
  `DailyMission2` int(11) NOT NULL DEFAULT -1,
  `Progress1` int(11) NOT NULL,
  `Progress2` int(11) NOT NULL,
  `NeedProgress1` int(10) NOT NULL,
  `NeedProgress2` int(10) NOT NULL,
  `Youtuber` int(10) NOT NULL,
  `ReportTime` int(10) NOT NULL,
  `WTChannel` int(10) NOT NULL,
  `PizzaSkill` int(10) NOT NULL,
  `GasCan` int(10) NOT NULL,
  `ShowGlasses` int(10) NOT NULL,
  `Glasses` int(10) NOT NULL,
  `HelpedPlayersToday` int(10) NOT NULL,
  `Days` int(10) NOT NULL,
  `FarmerSkill` int(10) NOT NULL,
  `PilotSkill` int(10) NOT NULL,
  `ShowHP` int(10) NOT NULL,
  `ShowAP` int(10) NOT NULL,
  `Color` int(10) NOT NULL,
  `Kicks` int(10) NOT NULL,
  `Warns` int(10) NOT NULL,
  `Bans` int(10) NOT NULL,
  `Jails` int(10) NOT NULL,
  `Mutes` int(10) NOT NULL,
  `HoursMonth` int(10) NOT NULL,
  `Vip` int(10) NOT NULL,
  `Mats` int(10) NOT NULL,
  `ClanWarns` int(10) NOT NULL,
  `ClanDays` int(10) NOT NULL,
  `CarLicS` int(10) NOT NULL,
  `FlyLicS` int(10) NOT NULL,
  `BoatLicS` int(10) NOT NULL,
  `GunLicS` int(10) NOT NULL,
  `ShowDMG` int(10) NOT NULL,
  `EscapePoints` int(10) NOT NULL,
  `AJail` int(10) NOT NULL,
  `Hat` int(10) NOT NULL,
  `ShowHat` int(10) NOT NULL,
  `NewbieChat` int(10) NOT NULL,
  `TogLC` int(10) NOT NULL,
  `TogFC` int(10) NOT NULL,
  `TogWT` int(10) NOT NULL,
  `HidePM` int(10) NOT NULL,
  `TogNews` int(10) NOT NULL,
  `TogLicitatie` int(10) NOT NULL,
  `TogClan` int(10) NOT NULL,
  `TogEvent` int(10) NOT NULL,
  `TogDing` int(10) NOT NULL,
  `PhoneOnline` int(10) NOT NULL,
  `DayLogin` int(10) NOT NULL,
  `AW` int(10) NOT NULL,
  `HW` int(10) NOT NULL,
  `LW` int(10) NOT NULL,
  `Tag` int(10) NOT NULL,
  `Referral` int(11) NOT NULL,
  `ReferralMoney` int(11) NOT NULL,
  `ReferralRP` int(11) NOT NULL,
  `SpecialQuest` varchar(300) NOT NULL DEFAULT '0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0',
  `DM` int(10) NOT NULL,
  `WarKills` int(11) NOT NULL,
  `WarDeaths` int(11) NOT NULL,
  `WarTurf` int(11) NOT NULL,
  `TogVip` int(11) NOT NULL,
  `TogSurf` int(11) NOT NULL,
  `TogFind` int(11) NOT NULL,
  `TogRaport` int(11) NOT NULL,
  `TogJob` int(11) NOT NULL,
  `TogAlert` int(11) NOT NULL,
  `ShowCP` int(11) NOT NULL,
  `AchievementStatus` varchar(256) NOT NULL DEFAULT '0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0',
  `WantedTime` int(10) NOT NULL,
  `ShowProgress1` int(11) NOT NULL,
  `ShowProgress2` int(11) NOT NULL,
  `DailyLogin` int(11) NOT NULL,
  `Backpack` int(11) NOT NULL,
  `Voucher` varchar(50) NOT NULL DEFAULT '0 0 0 0 0',
  `Crates` varchar(100) NOT NULL DEFAULT '0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0|',
  `HudGen` int(11) NOT NULL DEFAULT 1,
  `Skin` varchar(256) NOT NULL DEFAULT '250 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1',
  `DailyBonus` int(11) NOT NULL,
  `PetPoints` int(11) NOT NULL,
  `PetLevel` int(11) NOT NULL DEFAULT 1,
  `PetStatus` int(11) NOT NULL,
  `Pet` int(11) NOT NULL,
  `ShowBanca` int(11) NOT NULL,
  `TogRainBow` int(11) NOT NULL,
  `Hidden` int(11) NOT NULL,
  `ShowProgress3` int(11) NOT NULL,
  `JobOwner` int(11) NOT NULL,
  `Tickete` varchar(64) NOT NULL DEFAULT '0 0 0 0 0 0 0 0 0 0 0 0',
  `Quest` int(11) NOT NULL,
  `Credit` int(11) NOT NULL,
  `Slot` int(11) NOT NULL DEFAULT 3,
  `TogPremium` int(11) NOT NULL,
  `ShowProgress4` int(11) NOT NULL,
  `QuestFinish` int(11) NOT NULL,
  `Guns` varchar(50) NOT NULL DEFAULT '0 0 0 0 0 0',
  `DailyActivity` int(11) NOT NULL,
  `BPoints` int(11) NOT NULL,
  `job_skills_points` varchar(50) NOT NULL DEFAULT '0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0',
  `job_skills` varchar(50) NOT NULL DEFAULT '1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1',
  `Fireworks` int(11) NOT NULL,
  `FightStyle` int(11) NOT NULL,
  `PanelNoticeEdited` varchar(100) NOT NULL,
  `PanelNotice` varchar(250) NOT NULL,
  `hunger` varchar(50) NOT NULL DEFAULT '0 0 0 0 0',
  `emotes` varchar(50) NOT NULL DEFAULT '0 0 0 0 0 0 0 0 0 0 0 0',
  `KeyEmote1` int(11) NOT NULL DEFAULT -1,
  `KeyEmote2` int(11) NOT NULL DEFAULT -1,
  `CaseBattle` int(11) NOT NULL,
  `Raport` varchar(30) DEFAULT '0 0 0',
  `RaportExpire` int(11) NOT NULL DEFAULT -1,
  `TogTransfer` int(11) NOT NULL DEFAULT 1,
  `TogFriend` int(11) NOT NULL DEFAULT 1,
  `TogJobGoal` int(11) NOT NULL DEFAULT 1,
  `goal` int(11) NOT NULL,
  `DailyMission3` int(11) NOT NULL DEFAULT -1,
  `NeedProgress3` int(11) NOT NULL,
  `Progress3` int(11) NOT NULL,
  `ConnectedMonth` float NOT NULL DEFAULT 0,
  `Tester` tinyint(1) NOT NULL,
  `name_and_tag` varchar(50) NOT NULL,
  `panelStyle` int(11) NOT NULL,
  `ticketsArhive` int(11) NOT NULL,
  `complaintsArhive` int(11) NOT NULL,
  `ClanMoney` int(11) NOT NULL,
  `ClanPP` int(11) NOT NULL,
  `PetName` varchar(32) NOT NULL,
  `Acceptpoints` int(11) NOT NULL,
  `Reborn` int(11) NOT NULL,
  `Victim` varchar(32) NOT NULL DEFAULT 'None',
  `shards` varchar(50) NOT NULL DEFAULT '0 0 0 0 0 0 0 0 0 0 0',
  `lasers` varchar(100) NOT NULL DEFAULT '0 0 0 0 0 0',
  `hats` varchar(100) NOT NULL DEFAULT '0 0 0 0 0 0 0 0 0 0 0 0 0',
  `WantedDeaths` int(11) NOT NULL,
  `Rainbows` varchar(32) NOT NULL DEFAULT '0 0 0 0 0',
  `RainbowType` int(11) NOT NULL,
  `CasinoCredit` int(11) NOT NULL,
  `crime` varchar(144) NOT NULL,
  `TogLegend` int(11) NOT NULL,
  `stats_info` varchar(144) NOT NULL DEFAULT '0 0 0 0 0',
  `ChatColor` varchar(10) NOT NULL DEFAULT 'FFFFFF',
  `Stucks` int(11) NOT NULL,
  `Cheaters` int(11) NOT NULL,
  `A_DM` int(11) NOT NULL,
  `Complaints` int(11) NOT NULL,
  `acover` varchar(32) NOT NULL,
  `thema` tinyint(1) NOT NULL,
  `ExpHW` int(11) NOT NULL,
  `ExpLW` int(11) NOT NULL,
  `ExpAW` int(11) NOT NULL,
  `ExpFW` int(11) NOT NULL,
  `Progress4` int(11) NOT NULL,
  `Progress5` int(11) NOT NULL,
  `DailyMission4` int(11) NOT NULL DEFAULT -1,
  `DailyMission5` int(11) NOT NULL DEFAULT -1,
  `NeedProgress4` int(11) NOT NULL,
  `NeedProgress5` int(11) NOT NULL,
  `restriction` int(11) NOT NULL,
  `special_quests` varchar(32) NOT NULL DEFAULT '0 0 0 0 0 0 0 0 0 0',
  `Tier` int(11) NOT NULL,
  `BpExp` int(11) NOT NULL,
  `missions_bp` varchar(144) NOT NULL DEFAULT '0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0',
  `bp_claimed` varchar(144) NOT NULL DEFAULT '0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0',
  `GoldPass` int(11) NOT NULL,
  `in_concurs` int(11) NOT NULL,
  `Parkour` int(11) NOT NULL,
  `ApplyDeelay` int(11) NOT NULL,
  `intro` varchar(256) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `password`, `IP`, `Level`, `Admin`, `Helper`, `Premium`, `ConnectedTime`, `Registered`, `Sex`, `Age`, `Muted`, `MuteTime`, `Respect`, `Money`, `Bank`, `Phonebook`, `WantedLevel`, `Job`, `Jailed`, `JailTime`, `Materials`, `Drugs`, `Leader`, `Member`, `Rank`, `FWarn`, `FPunish`, `Model`, `PhoneNr`, `PhoneCredits`, `House`, `Bizz`, `Rob`, `CarLicT`, `CarLic`, `FlyLicT`, `FlyLic`, `BoatLicT`, `BoatLic`, `FishLicT`, `FishLic`, `GunLicT`, `GunLic`, `Tutorial`, `Warnings`, `Rented`, `Fuel`, `WTalkie`, `Lighter`, `Cigarettes`, `Email`, `RegisterDate`, `lastOn`, `Radio2`, `Status`, `Phone`, `Accused`, `Crime1`, `Crime2`, `Crime3`, `ShowJob`, `ShowFP`, `ShowLogo`, `ShowCeas`, `GoldPoints`, `Clan`, `ClanRank`, `Pin`, `Seconds`, `GiftPoints`, `NewbieMute`, `HelpedPlayers`, `SpawnChange`, `DailyMission1`, `DailyMission2`, `Progress1`, `Progress2`, `NeedProgress1`, `NeedProgress2`, `Youtuber`, `ReportTime`, `WTChannel`, `PizzaSkill`, `GasCan`, `ShowGlasses`, `Glasses`, `HelpedPlayersToday`, `Days`, `FarmerSkill`, `PilotSkill`, `ShowHP`, `ShowAP`, `Color`, `Kicks`, `Warns`, `Bans`, `Jails`, `Mutes`, `HoursMonth`, `Vip`, `Mats`, `ClanWarns`, `ClanDays`, `CarLicS`, `FlyLicS`, `BoatLicS`, `GunLicS`, `ShowDMG`, `EscapePoints`, `AJail`, `Hat`, `ShowHat`, `NewbieChat`, `TogLC`, `TogFC`, `TogWT`, `HidePM`, `TogNews`, `TogLicitatie`, `TogClan`, `TogEvent`, `TogDing`, `PhoneOnline`, `DayLogin`, `AW`, `HW`, `LW`, `Tag`, `Referral`, `ReferralMoney`, `ReferralRP`, `SpecialQuest`, `DM`, `WarKills`, `WarDeaths`, `WarTurf`, `TogVip`, `TogSurf`, `TogFind`, `TogRaport`, `TogJob`, `TogAlert`, `ShowCP`, `AchievementStatus`, `WantedTime`, `ShowProgress1`, `ShowProgress2`, `DailyLogin`, `Backpack`, `Voucher`, `Crates`, `HudGen`, `Skin`, `DailyBonus`, `PetPoints`, `PetLevel`, `PetStatus`, `Pet`, `ShowBanca`, `TogRainBow`, `Hidden`, `ShowProgress3`, `JobOwner`, `Tickete`, `Quest`, `Credit`, `Slot`, `TogPremium`, `ShowProgress4`, `QuestFinish`, `Guns`, `DailyActivity`, `BPoints`, `job_skills_points`, `job_skills`, `Fireworks`, `FightStyle`, `PanelNoticeEdited`, `PanelNotice`, `hunger`, `emotes`, `KeyEmote1`, `KeyEmote2`, `CaseBattle`, `Raport`, `RaportExpire`, `TogTransfer`, `TogFriend`, `TogJobGoal`, `goal`, `DailyMission3`, `NeedProgress3`, `Progress3`, `ConnectedMonth`, `Tester`, `name_and_tag`, `panelStyle`, `ticketsArhive`, `complaintsArhive`, `ClanMoney`, `ClanPP`, `PetName`, `Acceptpoints`, `Reborn`, `Victim`, `shards`, `lasers`, `hats`, `WantedDeaths`, `Rainbows`, `RainbowType`, `CasinoCredit`, `crime`, `TogLegend`, `stats_info`, `ChatColor`, `Stucks`, `Cheaters`, `A_DM`, `Complaints`, `acover`, `thema`, `ExpHW`, `ExpLW`, `ExpAW`, `ExpFW`, `Progress4`, `Progress5`, `DailyMission4`, `DailyMission5`, `NeedProgress4`, `NeedProgress5`, `restriction`, `special_quests`, `Tier`, `BpExp`, `missions_bp`, `bp_claimed`, `GoldPass`, `in_concurs`, `Parkour`, `ApplyDeelay`, `intro`) VALUES
(2, 'DEIMAN0009', 'B6226497D7CB1149D5C729C37819517F94CBD5EE72274BCE880C143977240220', '188.27.152.80', 5, 7, 0, 0, 0.143, 0, 0, 25, 0, 0, 21, 20154319, 756303, 1, 0, 16, 0, 0, 0, 0, 1, 1, 7, 0, 0, 60, '80170', 0, 999, 255, 4, 1679385370, 1, 1679385370, 1, 1679385370, 1, 0, 0, 1679385370, 1, 5, 0, -1, 0, 0, 0, 0, 'ionutbossu154@yahoo.com', '2023-03-18 18:56:33', '20.03.2023 20:11', 0, -1, 0, '********', 'Fara', 'Fara', 'Fara', 0, 0, 1, 1, 10, 0, 0, 0, 4479, 250, 0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 27, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0 0 1 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0', 0, 0, 0, 1, 0, '0 0 0 0 0', '0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0|', 1, '250 60 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1', 0, 550, 1, 0, 0, 0, 0, 0, 0, 0, '0 0 0 0 0 0 0 0 0 0 0 0', 0, 25, 3, 0, 0, 0, '0 0 0 0 0 0', 0, 1090, '0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0', '1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1', 0, 0, '', '', '0 0 0 0 0', '0 0 0 0 0 0 0 0 0 0 0 0', -1, -1, 0, '0 0 0', 1679817362, 1, 1, 1, 19393, -1, 0, 0, 0, 0, 'DEIMAN0009', 0, 0, 0, 0, 0, '', 0, 0, 'None', '0 0 0 0 0 0 0 0 0 0 0', '0 0 0 0 0 0', '0 0 0 0 0 0 0 0 0 0 0 0 0', 0, '0 0 0 0 0', 0, 0, '', 0, '0 0 0 0 0', 'FFFFFF', 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, -1, 37, 0, 0, 0, '0 0 0 0 0 0 0 0 0 0', 0, 0, '0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0', '0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0', 0, 0, 0, 0, '0'),
(3, 'Madalin31', '892A8DB7470085E40278FA83F86782A932DC5471918E44C43C580DB3D3BA2834', '178.138.97.180', 50, 7, 0, 3, 11.032, 0, 0, 16, 0, 0, 30, 10099147322117, 36920037, 1, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, '49804', 0, 999, 4, 0, 1679544578, 1, 1679544578, 1, 1679544578, 1, 0, 0, 1679544578, 1, 5, 0, -1, 0, 1, 0, 0, 'madalinalexandru700@gmail.com', '2023-03-18 19:17:44', '21.03.2023 11:00', 1, -1, 0, '********', 'Fara', 'Fara', 'Fara', 0, 0, 1, 1, 1146406143, 1, 7, 0, 6, 1420, 0, 0, 0, 4, 13, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 3, 0, 0, 0, 0, 0, 18, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0 0 1 0 0 0 0 0 0 0 0 0 0 0 1 0 1 0 0 0 0 1 1 0 0 0 0 0 0 1 1 0 1 0 0', 0, 0, 0, 1, 1, '0 0 0 0 0', '0 0 0 0 0 0 0 0 1 1 0', 1, '250 2 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1', 0, 540, 3, 0, 0, 0, 0, 0, 0, 0, '0 0 0 0 0 0 0 0 0 0 0 0', 0, 25, 5, 0, 0, 0, '0 0 0 0 0 0', 1564, 1073, '0 1 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0', '1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1', 0, 0, '', '', '0 0 0 0 0', '0 0 0 0 0 0 0 0 0 0 0 0', -1, -1, 0, '0 0 0', -1, 0, 0, 1, 70502, 18, 1, 0, 5.45083, 0, 'Madalin31', 0, 0, 0, 10560, 10000000, '', 0, 3, 'None', '0 0 0 0 0 0 0 0 0 0 0', '0 0 0 0 0 0', '0 0 0 0 0 0 0 0 0 0 0 0 0', 0, '0 0 0 0 0', 0, 0, '', 0, '0 0 0 0 0', 'FFFFFF', 0, 0, 0, 0, 'T.E.P.A.RHALKFLORIN67', 0, 0, -1, 0, 0, 0, 0, 24, 36, 1, 2, 0, '0 0 0 0 0 0 0 0 0 0', 0, 0, '1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0', '0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0', 1, 0, 0, 0, '0'),
(4, 'xT.shark', '151CEBA84230D1F62472338ECC6B10BA0C1F0BAC0A9270DC6B5F141142CC405E', '82.77.245.29', 5, 0, 0, 0, 0, 0, 0, 11, 0, 0, 19, 20274021, 0, 1, 0, 16, 0, 0, 0, 0, 0, 0, 0, 0, 0, 44, '25264', 0, 999, 255, 0, 1680967169, 1, 1679844255, 1, 1679844255, 1, 0, 0, 1679844255, 1, 5, 0, -1, 0, 0, 0, 0, 'vvpn1060@gmail.com', '2023-03-19 17:16:24', '19.03.2023 17:32', 0, -1, 0, '********', 'Fara', 'Fara', 'Fara', 1, 1, 1, 1, 61, 0, 0, 0, 766, 169, 0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 19008, 0, 0, 0, 0, 5, 11, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 18962, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, '0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '1 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0', 0, 5, 2, 0, 0, '0 0 0 0 0', '0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0|', 1, '250 44 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1', 0, 100, 1, 0, 0, 1, 0, 0, 1, 0, '0 0 0 0 0 0 0 0 0 0 0 0', 0, 25, 3, 0, 1, 0, '0 0 0 0 0 0', 0, 1040, '0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0', '1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1', 0, 0, '', '', '0 0 0 0 0', '0 0 0 0 0 0 0 0 0 0 0 0', -1, -1, 0, '0 0 0', -1, 1, 1, 1, 0, -1, 0, 0, 0, 0, 'xT.shark', 0, 0, 0, 0, 0, '', 0, 0, 'None', '0 0 0 0 0 0 0 0 0 0 0', '0 0 0 0 0 0', '0 0 0 0 0 0 0 0 0 0 0 0 0', 0, '0 0 0 0 0', 0, 0, '', 0, '0 0 0 0 0', 'FFFFFF', 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, -1, 33, 0, 0, 0, '0 0 0 0 0 0 0 0 0 0', 0, 0, '0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0', '0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0', 0, 0, 0, 0, '0'),
(5, 'vSlayeR', '1A9D94C500910B736A524547B61FBADA591C89A0ABAFA7FD9AF430A877B18BCD', '5.14.128.167', 1, 0, 0, 0, 0, 0, 0, 15, 0, 0, 0, 99900, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 250, '0', 0, 999, 255, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, -1, 0, 0, 0, 0, 'paysafe324@gmail.com', '2023-03-19 18:16:10', '19.03.2023 18:16', 0, -1, 0, '********', 'Fara', 'Fara', 'Fara', 0, 0, 1, 1, 0, 0, 0, 0, 21, 0, 0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, '0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0', 0, 0, 0, 0, 0, '0 0 0 0 0', '0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0|', 1, '250 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1', 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, '0 0 0 0 0 0 0 0 0 0 0 0', 0, 0, 3, 0, 0, 0, '0 0 0 0 0 0', 0, 0, '0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0', '1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1', 0, 0, '', '', '0 0 0 0 0', '0 0 0 0 0 0 0 0 0 0 0 0', -1, -1, 0, '0 0 0', -1, 1, 1, 1, 0, -1, 0, 0, 0, 0, 'vSlayeR', 0, 0, 0, 0, 0, '', 0, 0, 'None', '0 0 0 0 0 0 0 0 0 0 0', '0 0 0 0 0 0', '0 0 0 0 0 0 0 0 0 0 0 0 0', 0, '0 0 0 0 0', 0, 0, '', 0, '0 0 0 0 0', 'FFFFFF', 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, -1, 35, 0, 0, 0, '0 0 0 0 0 0 0 0 0 0', 0, 0, '0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0', '0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0', 0, 0, 0, 0, '0'),
(6, 'DaduAdv', '44539E633D4244E47E33F4F19C2CC61BC8532E3428CE12C9D4538FD39B05E626', '94.176.5.142', 5, 5, 0, 0, 0, 0, 0, 14, 0, 0, 17, 1, 123, 1, 0, 16, 0, 0, 0, 0, 0, 0, 0, 0, 0, 15, '62512', 0, 999, 255, 0, 1680971684, 1, 1679848766, 1, 1679848766, 1, 0, 0, 1679848766, 1, 6, 0, -1, 0, 0, 0, 0, 'fdsdg@yahoo.com', '2023-03-19 18:31:09', '19.03.2023 21:36', 0, -1, 0, '********', 'Fara', 'Fara', 'Fara', 1, 1, 1, 1, 60, 0, 0, 0, 1334, 100, 0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0', 0, 7, 7, 0, 0, '0 0 0 0 0', '0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0|', 1, '250 1 15 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1', 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, '0 0 0 0 0 0 0 0 0 0 0 0', 0, 25, 3, 0, 1, 0, '0 0 0 0 0 0', 0, 1020, '0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0', '1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1', 0, 0, '', '', '0 0 0 0 0', '0 0 0 0 0 0 0 0 0 0 0 0', -1, -1, 0, '0 0 0', -1, 1, 1, 1, 0, -1, 0, 0, 0, 0, 'DaduAdv', 0, 0, 0, 0, 0, '', 0, 0, 'None', '0 0 0 0 0 0 0 0 0 0 0', '0 0 0 0 0 0', '0 0 0 0 0 0 0 0 0 0 0 0 0', 0, '0 0 0 0 0', 0, 0, '', 0, '0 0 0 0 0', 'FFFFFF', 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, -1, 37, 0, 0, 0, '0 0 0 0 0 0 0 0 0 0', 0, 0, '0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0', '0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0', 0, 0, 0, 0, '0'),
(7, 'HALKFLORIN67', '9F65280FA057FD631CDBB2B82681C72364A9214DD67A62EFCB134AA77250399B', '93.122.249.156', 30, 6, 0, 1, 1.829, 0, 0, 20, 1, 59940, 10, 20000513640909, 4490191, 1, 0, 9, 0, 0, 0, 0, 4, 4, 7, 0, 0, 107, '999', 0, 14, 255, 4, 1680974133, 1, 1679851282, 1, 1679851282, 1, 0, 0, 1679851282, 1, 5, 0, -1, 0, 0, 0, 0, 'florinoniciuc106@gmail.com', '2023-03-19 19:12:46', '20.03.2023 22:43', 0, -1, 0, '********', 'Fara', 'Fara', 'Fara', 0, 0, 1, 1, 99996930, 1, 1, 1221, 2806, 416, 0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 1, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, '0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0 0 1 0 0 0 0 0 0 0 0 0 0 1 0 1 0 0 0 0 0 1 0 0 0 0 0 0 0 1 1 0 0 0 0', 0, 0, 0, 1, 2, '0 0 0 0 0', '0 0 0 0 0 0 0 0 0 0 0', 1, '250 2 107 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1', 0, 600, 1, 0, 0, 0, 1, 0, 0, 0, '0 0 0 0 0 0 0 0 0 0 0 0', 0, 25, 5, 0, 0, 0, '0 0 0 0 0 0', 0, 130, '0 0 0 0 0 0 0 0 0 3 0 0 0 0 0 0 0', '1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1', 0, 0, '', '', '0 0 0 0 0', '0 0 0 0 0 0 0 0 0 0 0 0', -1, -1, 0, '0 0 0', 1679904822, 1, 1, 1, 86941, -1, 0, 0, 0.914444, 0, 'HALKFLORIN67T.E.P.A.R', 0, 0, 0, 16060, 0, '', 0, 0, 'None', '0 0 0 0 0 0 0 0 0 0 0', '0 0 0 0 0 0', '0 0 0 0 0 0 0 0 0 0 0 0 0', 0, '0 0 0 0 0', 0, 0, '', 0, '0 0 0 0 0', 'FFFFFF', 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, -1, 39, 0, 0, 0, '0 0 0 0 0 0 0 0 0 0', 0, 0, '1 0 0 0 0 0 2 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0', '0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0', 0, 0, 0, 0, '0'),
(8, 'R4resAdv', '1DD6C40705A3B69A5C1E473BC2BE53CE45159033E6D141F096D0CE5AFACE583C', '82.79.79.218', 5, 0, 0, 0, 0, 0, 0, 20, 0, 0, 2, 1215752192, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 250, '17066', 0, 999, 255, 0, 1680982436, 1, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, -1, 0, 0, 0, 0, 'hhuuu@gmail.com', '2023-03-19 21:31:53', '19.03.2023 21:58', 0, -1, 0, '********', 'Fara', 'Fara', 'Fara', 0, 0, 1, 1, 200, 0, 0, 0, 940, 100, 0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0', 0, 0, 0, 0, 0, '0 0 0 0 0', '0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0|', 1, '250 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1', 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, '0 0 0 0 0 0 0 0 0 0 0 0', 0, 0, 3, 0, 0, 0, '0 0 0 0 0 0', 0, 20, '0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0', '1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1', 0, 0, '', '', '0 0 0 0 0', '0 0 0 0 0 0 0 0 0 0 0 0', -1, -1, 0, '0 0 0', -1, 1, 1, 1, 0, -1, 0, 0, 0, 0, 'R4resAdv', 0, 0, 0, 0, 0, '', 0, 0, 'None', '0 0 0 0 0 0 0 0 0 0 0', '0 0 0 0 0 0', '0 0 0 0 0 0 0 0 0 0 0 0 0', 0, '0 0 0 0 0', 0, 0, '', 0, '0 0 0 0 0', 'FFFFFF', 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, -1, 37, 0, 0, 0, '0 0 0 0 0 0 0 0 0 0', 0, 0, '0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0', '0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0', 0, 0, 0, 0, '0'),
(9, 'Lucifer89', '30913586FF49F294FC36E9EF72800FEFF848FE41FF7306A6E174A26BA04A0A31', 'Not logged', 1, 0, 0, 0, 0, 0, 0, 20, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 250, '0', 0, 999, 255, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 'Mocanuelvis800@gmail.com', '2023-03-19 22:33:22', 'Nu exista', 0, -1, 0, '********', 'Fara', 'Fara', 'Fara', 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0', 0, 0, 0, 0, 0, '0 0 0 0 0', '0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0|', 1, '250 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1', 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, '0 0 0 0 0 0 0 0 0 0 0 0', 0, 0, 3, 0, 0, 0, '0 0 0 0 0 0', 0, 0, '0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0', '1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1', 0, 0, '', '', '0 0 0 0 0', '0 0 0 0 0 0 0 0 0 0 0 0', -1, -1, 0, '0 0 0', -1, 1, 1, 1, 0, -1, 0, 0, 0, 0, 'Lucifer89', 0, 0, 0, 0, 0, '', 0, 0, 'None', '0 0 0 0 0 0 0 0 0 0 0', '0 0 0 0 0 0', '0 0 0 0 0 0 0 0 0 0 0 0 0', 0, '0 0 0 0 0', 0, 0, '', 0, '0 0 0 0 0', 'FFFFFF', 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, -1, -1, 0, 0, 0, '0 0 0 0 0 0 0 0 0 0', 0, 0, '0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0', '0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0', 0, 0, 0, 0, ''),
(10, 'Lucifer89.', 'C2035DE561C76FE002F6896507D3D502A7B6A96F65776279B5ABB704631597FB', '188.25.23.238', 1, 0, 0, 0, 0, 0, 0, 20, 0, 0, 2, 203639, 0, 1, 0, 16, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6, '39472', 0, 999, 255, 0, 1680986236, 1, 1679863255, 1, 1679863255, 1, 0, 0, 1679863255, 1, 5, 0, -1, 0, 0, 0, 0, 'Mocanuelvis800@gmail.com', '2023-03-19 22:35:26', '19.03.2023 22:56', 0, -1, 0, '********', 'Fara', 'Fara', 'Fara', 0, 0, 1, 1, 0, 0, 0, 0, 1803, 64, 0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0', 0, 0, 0, 0, 0, '0 0 0 0 0', '0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0|', 1, '250 6 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1', 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, '0 0 0 0 0 0 0 0 0 0 0 0', 0, 25, 3, 0, 0, 0, '0 0 0 0 0 0', 0, 20, '0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0', '1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1', 0, 0, '', '', '0 0 0 0 0', '0 0 0 0 0 0 0 0 0 0 0 0', -1, -1, 0, '0 0 0', -1, 1, 1, 1, 0, -1, 0, 0, 0, 0, 'Lucifer89.', 0, 0, 0, 0, 0, '', 0, 0, 'None', '0 0 0 0 0 0 0 0 0 0 0', '0 0 0 0 0 0', '0 0 0 0 0 0 0 0 0 0 0 0 0', 0, '0 0 0 0 0', 0, 0, '', 0, '0 0 0 0 0', 'FFFFFF', 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, -1, 39, 0, 0, 0, '0 0 0 0 0 0 0 0 0 0', 0, 0, '0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0', '0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0', 0, 0, 0, 0, '0'),
(11, 'Bucsa', '2beb24e4d1a07ce13e226c7c9341eacd417a5e8d1f0c0b479700968bfee696b2', '188.27.152.172', 500, 8, 0, 1, 100, 0, 0, 18, 0, 0, 2, 154329, 100000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 250, '355', 0, 999, 255, 0, 1679508804, 1, 1679508804, 1, 1679508804, 1, 0, 0, 1679508804, 1, 5, 0, -1, 0, 0, 0, 0, 'flaier@gmail.com', '2023-03-20 18:53:41', '20.03.2023 20:20', 0, -1, 0, '********', 'Fara', 'Fara', 'Fara', 0, 0, 1, 1, 4991718, 0, 0, 0, 920, 100, 0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, '0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 0 0 0 0 0', 0, 0, 0, 0, 2, '0 0 0 0 0', '0 0 0 0 0 0 0 0 0 0 0', 1, '250 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1', 0, 500000000, 1, 0, 0, 0, 0, 0, 0, 0, '0 0 0 0 0 0 0 0 0 0 0 0', 0, 0, 6, 0, 0, 0, '0 0 0 0 0 0', 0, 20, '0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0', '1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1', 0, 0, '', '', '0 0 0 0 0', '0 0 0 0 0 0 0 0 0 0 0 0', -1, -1, 0, '0 0 0', -1, 1, 1, 1, 0, -1, 0, 0, 0, 0, 'FARCRY3', 0, 0, 0, 0, 0, 'Englezu', 0, 0, 'None', '0 0 0 0 0 0 0 0 0 0 0', '0 0 0 0 0 0', '0 0 0 0 0 0 0 0 0 0 0 0 0', 0, '0 0 0 0 0', 0, 0, '', 0, '0 0 0 0 0', 'FFFFFF', 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, -1, 35, 0, 0, 0, '0 0 0 0 0 0 0 0 0 0', 0, 0, '0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0', '0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0', 0, 0, 0, 0, '0'),
(12, 'Mr.Rares', 'BA93D8175E58D045FCA912422E768D9DC538DAAFC01A3A3E031C7DBC0778E24A', '127.0.0.1', 69, 7, 0, 0, 1.903, 0, 0, 18, 0, 0, 14, 384455632, 22874648, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 250, '0', 0, 999, 255, 8, 1793834288, 1, 1793834288, 1, 1793834288, 1, 0, 0, 1793834288, 1, 5, 0, -1, 0, 0, 0, 0, 'asdsadad@gmail.com', '2026-11-03 01:17:07', '04.11.2026 01:13', 0, -1, 0, '********', 'Fara', 'Fara', 'Fara', 0, 1, 1, 1, 998500, 0, 0, 0, 822, 618, 0, 0, 0, 7, 9, 0, 0, 1, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 1 1 0 0 0 0 1 1 1 0 0 0 0', 0, 0, 0, 1, 0, '0 0 0 0 0', '0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0|', 1, '250 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1', 0, 1600, 1, 0, 0, 0, 2, 0, 0, 0, '0 0 0 0 0 0 0 0 0 0 0 0', 0, 0, 13, 0, 0, 0, '0 0 0 0 0 0', 1346, 250, '0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0', '1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1', 0, 0, '', '', '0 0 0 0 0', '0 0 0 0 0 0 0 0 0 0 0 0', -1, -1, 0, '0 0 0', -1, 1, 1, 1, 0, 22, 1, 0, 0.951667, 0, 'Mr.Rares', 0, 0, 0, 0, 0, '', 0, 0, 'None', '0 0 0 0 0 0 0 0 0 0 0', '0 0 0 0 0 0', '0 0 0 0 0 0 0 0 0 0 0 0 0', 0, '0 0 0 0 0', 0, 0, '', 0, '0 0 0 0 0', 'FFFFFF', 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 1, 0, -2, 35, 1, 2, 0, '0 0 0 0 0 0 0 0 0 0', 0, 0, '0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0', '0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0', 0, 0, 0, 0, '0'),
(13, 'MrxRares', 'BA93D8175E58D045FCA912422E768D9DC538DAAFC01A3A3E031C7DBC0778E24A', '127.0.0.1', 45, 7, 0, 0, 0, 0, 0, 18, 0, 0, 7, 8828650198, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 250, '0', 0, 999, 255, 0, 1793928765, 1, 1793928765, 1, 1793928765, 1, 0, 0, 1793928765, 1, 5, 0, -1, 0, 0, 0, 0, 'mrxbusinesss19@gmail.com', '2026-11-04 01:20:24', '04.11.2026 21:58', 0, -1, 0, '********', 'Fara', 'Fara', 'Fara', 0, 1, 1, 1, 89052, 0, 0, 0, 5273, 315, 0, 0, 0, 3, 9, 0, 0, 3, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 1 1 0 0 0 0 1 1 1 0 0 0 0', 0, 0, 0, 0, 0, '0 0 0 0 0', '0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0|', 1, '250 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1', 0, 100, 1, 0, 0, 0, 1, 0, 0, 0, '0 0 0 0 0 0 0 0 0 0 0 0', 0, 0, 4, 0, 0, 0, '0 0 0 0 0 0', 1676, 70, '0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0', '1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1', 0, 0, '', '', '0 0 0 0 0', '0 0 0 0 0 0 0 0 0 0 0 0', -1, -1, 0, '0 0 0', -1, 1, 1, 1, 0, 19, 1, 0, 0, 0, 'MrxRares', 0, 0, 0, 0, 0, '', 0, 0, 'None', '0 0 0 0 0 0 0 0 0 0 0', '0 0 0 0 0 0', '0 0 0 0 0 0 0 0 0 0 0 0 0', 0, '0 0 0 0 0', 0, 0, '', 0, '0 0 0 0 0', 'FFFFFF', 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 1, 0, -2, 37, 1, 2, 0, '0 0 0 0 0 0 0 0 0 0', 0, 0, '0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0', '0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0', 0, 0, 0, 0, '0');

-- --------------------------------------------------------

--
-- Table structure for table `war_logs`
--

CREATE TABLE `war_logs` (
  `ID` int(11) NOT NULL,
  `attackers` int(11) NOT NULL,
  `attackers_score` float NOT NULL,
  `defender` int(11) NOT NULL,
  `defender_score` float NOT NULL,
  `Time` varchar(60) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `war_members`
--

CREATE TABLE `war_members` (
  `ID` int(11) NOT NULL,
  `username` varchar(24) NOT NULL,
  `faction` int(11) NOT NULL,
  `score` int(11) NOT NULL,
  `kills` int(11) NOT NULL,
  `deaths` int(11) NOT NULL,
  `TurfTime` int(11) NOT NULL,
  `for_war` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `wcode_applications`
--

CREATE TABLE `wcode_applications` (
  `id` int(11) NOT NULL,
  `UserID` int(11) NOT NULL,
  `UserName` varchar(32) NOT NULL,
  `FactionID` int(11) NOT NULL,
  `Answers` text NOT NULL,
  `Questions` int(11) NOT NULL,
  `Status` int(11) NOT NULL,
  `Date` timestamp NOT NULL DEFAULT current_timestamp(),
  `ActionBy` varchar(24) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `wcode_applications`
--

INSERT INTO `wcode_applications` (`id`, `UserID`, `UserName`, `FactionID`, `Answers`, `Questions`, `Status`, `Date`, `ActionBy`) VALUES
(0, 11, 'FARCRY3', 1, 'Cum te numesti si ce varsta ai?:andrei 16', 1, 0, '2023-03-21 12:46:06', '');

-- --------------------------------------------------------

--
-- Table structure for table `wcode_commentaries`
--

CREATE TABLE `wcode_commentaries` (
  `ID` int(11) NOT NULL,
  `UserID` int(11) NOT NULL,
  `UserName` varchar(32) NOT NULL,
  `Skin` int(11) NOT NULL,
  `Text` text NOT NULL,
  `Date` timestamp NOT NULL DEFAULT current_timestamp(),
  `Section` varchar(32) NOT NULL,
  `TopicID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `wcode_commentaries`
--

INSERT INTO `wcode_commentaries` (`ID`, `UserID`, `UserName`, `Skin`, `Text`, `Date`, `Section`, `TopicID`) VALUES
(0, 86, 'Bucsa', 0, 're', '2023-03-07 16:39:28', 'complaints', 0);

-- --------------------------------------------------------

--
-- Table structure for table `wcode_complaints`
--

CREATE TABLE `wcode_complaints` (
  `ID` int(11) NOT NULL,
  `UserID` int(11) NOT NULL,
  `UserName` varchar(32) NOT NULL,
  `AccusedID` int(11) NOT NULL,
  `AccusedName` varchar(32) NOT NULL,
  `Text` text NOT NULL,
  `Category` int(11) NOT NULL,
  `Faction` int(11) NOT NULL,
  `Status` int(11) NOT NULL,
  `Date` timestamp NOT NULL DEFAULT current_timestamp(),
  `ActionBy` varchar(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `wcode_complaints`
--

INSERT INTO `wcode_complaints` (`ID`, `UserID`, `UserName`, `AccusedID`, `AccusedName`, `Text`, `Category`, `Faction`, `Status`, `Date`, `ActionBy`) VALUES
(1, 86, 'Bucsa', 24, 'Drew', 'abuz de functie\r\n', 1, 0, 0, '2023-03-07 16:35:21', ''),
(2, 11, 'FARCRY3', 3, 'Madalin31', 'adwadwhuadhawdjaidhajudahduadahdiahdiuwd', 0, 0, 0, '2023-03-21 12:56:40', '');

-- --------------------------------------------------------

--
-- Table structure for table `wcode_donations`
--

CREATE TABLE `wcode_donations` (
  `ID` int(11) NOT NULL,
  `Username` varchar(32) NOT NULL,
  `Message` text NOT NULL,
  `Amount` int(11) NOT NULL,
  `CreatedAt` varchar(64) NOT NULL,
  `Date` timestamp NOT NULL DEFAULT current_timestamp(),
  `Activated` int(11) NOT NULL,
  `ActivatedOn` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `wcode_donations_logs`
--

CREATE TABLE `wcode_donations_logs` (
  `ID` int(11) NOT NULL,
  `UserID` int(11) NOT NULL,
  `UserName` varchar(32) NOT NULL,
  `Log` text NOT NULL,
  `Date` timestamp NOT NULL DEFAULT current_timestamp(),
  `IP` varchar(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `wcode_editables`
--

CREATE TABLE `wcode_editables` (
  `ID` int(11) NOT NULL,
  `Text` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `By` varchar(32) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `Form` varchar(32) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `Updated` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `wcode_editables`
--

INSERT INTO `wcode_editables` (`ID`, `Text`, `By`, `Form`, `Updated`) VALUES
(1, '0', 'Bucsa', 'StatusLeader', '2023-03-18 10:17:29'),
(2, '50', 'Bucsa', 'HoursLeader', '2023-03-18 10:18:05'),
(3, '50', 'Bucsa', 'HoursHelper', '2023-03-18 10:24:58'),
(4, '0', 'Bucsa', 'StatusHelper', '2023-03-18 10:24:58'),
(5, '50', 'Bucsa', 'ReducereShop', '2023-03-18 10:52:25');

-- --------------------------------------------------------

--
-- Table structure for table `wcode_functions`
--

CREATE TABLE `wcode_functions` (
  `ID` int(11) NOT NULL,
  `UserID` int(11) NOT NULL,
  `UserName` varchar(32) NOT NULL,
  `Tag` varchar(64) NOT NULL,
  `Color` varchar(32) NOT NULL,
  `Icon` varchar(64) NOT NULL,
  `Date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `wcode_logs`
--

CREATE TABLE `wcode_logs` (
  `ID` int(11) NOT NULL,
  `UserID` int(11) NOT NULL,
  `UserName` varchar(32) NOT NULL,
  `Log` text NOT NULL,
  `VictimID` int(11) NOT NULL,
  `VictimName` varchar(32) NOT NULL,
  `Date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `wcode_logs`
--

INSERT INTO `wcode_logs` (`ID`, `UserID`, `UserName`, `Log`, `VictimID`, `VictimName`, `Date`) VALUES
(0, 86, 'Bucsa', 'Admin Bucsa gave one Warning Point to player Drew for: abuz.', 24, 'Drew', '2023-03-07 16:39:35'),
(0, 86, 'Bucsa', 'Admin Bucsa reseted FWarn field of player Bucsa.', 86, 'Bucsa', '2023-03-18 11:44:02'),
(0, 86, 'Bucsa', 'Admin Bucsa muted(100 minutes) player Bucsa for abuz de functie.', 86, 'Bucsa', '2023-03-18 11:47:50'),
(0, 86, 'Bucsa', 'Admin Bucsa deleted log ID #0 from faction history of FARCRY3.', 1, 'FARCRY3', '2023-03-20 17:58:09'),
(0, 11, 'Bucsa', 'Admin Bucsa muted(999 minutes) player HALKFLORIN67 for abuz de functie.', 7, 'HALKFLORIN67', '2023-03-21 13:32:04'),
(0, 11, 'Bucsa', 'Admin Bucsa suspended permanently player HALKFLORIN67 for abuz de functie.', 7, 'HALKFLORIN67', '2023-03-21 13:32:18'),
(0, 11, 'Bucsa', 'Admin Bucsa reseted FWarn field of player HALKFLORIN67.', 7, 'HALKFLORIN67', '2023-03-21 13:32:30'),
(0, 11, 'Bucsa', 'Admin Bucsa gave one Warning Point to player Bucsa for: abuz.', 11, 'Bucsa', '2023-03-21 13:34:31'),
(0, 11, 'Bucsa', 'Admin Bucsa reseted Warnings field of player Bucsa.', 11, 'Bucsa', '2023-03-21 13:34:35'),
(0, 11, 'Bucsa', 'Admin Bucsa reseted Warnings field of player Bucsa.', 11, 'Bucsa', '2023-03-21 13:35:25'),
(0, 11, 'Bucsa', 'Admin Bucsa reseted FPunish field of player Bucsa.', 11, 'Bucsa', '2023-03-21 13:37:37'),
(0, 11, 'Bucsa', 'Admin Bucsa reseted FPunish field of player Bucsa.', 11, 'Bucsa', '2023-03-21 13:37:49'),
(0, 11, 'Bucsa', 'Admin Bucsa reseted FPunish field of player Bucsa.', 11, 'Bucsa', '2023-03-21 13:40:17'),
(0, 11, 'Bucsa', 'Admin Bucsa reseted FPunish field of player Bucsa.', 11, 'Bucsa', '2023-03-21 13:40:58'),
(0, 11, 'Bucsa', 'Admin Bucsa reseted FPunish field of player Bucsa.', 11, 'Bucsa', '2023-03-21 13:41:04'),
(0, 11, 'Bucsa', 'Admin Bucsa reseted FPunish field of player Bucsa.', 11, 'Bucsa', '2023-03-21 13:41:32'),
(0, 11, 'Bucsa', 'Admin Bucsa reseted FPunish field of player Bucsa.', 11, 'Bucsa', '2023-03-21 13:41:41');

-- --------------------------------------------------------

--
-- Table structure for table `wcode_notifications`
--

CREATE TABLE `wcode_notifications` (
  `ID` int(11) NOT NULL,
  `UserID` int(11) NOT NULL,
  `UserName` varchar(32) NOT NULL,
  `Notification` text NOT NULL,
  `FromID` int(11) NOT NULL,
  `FromName` varchar(32) NOT NULL,
  `Seen` int(11) NOT NULL,
  `Link` text NOT NULL,
  `Date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `wcode_notifications`
--

INSERT INTO `wcode_notifications` (`ID`, `UserID`, `UserName`, `Notification`, `FromID`, `FromName`, `Seen`, `Link`, `Date`) VALUES
(0, 2, 'FARCRY34', 'FARCRY3 uninvited you from the faction!', 1, 'FARCRY3', 1, 'http://localhost/panel/profile/FARCRY34', '2021-10-27 00:35:05'),
(0, 1, 'FARCRY3', 'Your premium points(5) has been updated by Admin FARCRY3.', 1, 'FARCRY3', 1, 'http://localhost/panel/profile/FARCRY3', '2021-10-27 00:36:28'),
(0, 134, 'FARCRY6', 'Your premium points(5) has been updated by Admin FARCRY6.', 134, 'FARCRY6', 1, 'http://127.0.0.1/panel/profile/FARCRY6', '2021-12-04 20:00:01'),
(0, 134, 'FARCRY6', 'Your premium points(100) has been updated by Admin FARCRY6.', 134, 'FARCRY6', 1, 'http://localhost/panel/profile/FARCRY6', '2021-12-04 20:32:20'),
(0, 134, 'FARCRY6', 'Your premium points(150) has been updated by Admin FARCRY6.', 134, 'FARCRY6', 1, 'http://localhost/panel/profile/FARCRY6', '2021-12-04 20:33:08'),
(0, 1, 'FARCRY3', 'Your premium points(250) has been updated by Admin FARCRY6.', 134, 'FARCRY6', 1, 'http://localhost/panel/profile/FARCRY3', '2021-12-04 20:34:07'),
(0, 135, 'FARCRY7', 'Your premium points(1800) has been updated by Admin FARCRY7.', 135, 'FARCRY7', 1, 'http://127.0.0.1/panel/profile/FARCRY7', '2022-03-29 17:59:37'),
(0, 4, '1NG3R', 'SixS uninvited you from the faction!', 3, 'SixS', 1, 'http://127.0.0.1/panel/profile/1NG3R', '2023-02-18 14:15:58'),
(0, 24, 'Drew', 'Bucsa made an Faction complaint against you! Check it out.', 86, 'Bucsa', 1, 'http://localhost/chars/complaints', '2023-03-07 16:35:21'),
(0, 24, 'Drew', 'New comment has been posted in complaint!', 86, 'Bucsa', 1, 'http://localhost/panel/complaints/view/0', '2023-03-07 16:39:28'),
(0, 19, 'ZeRos', 'Your premium points(0) has been updated by Admin Bucsa.', 86, 'Bucsa', 1, 'http://localhost/chars/profile/ZeRos', '2023-03-07 18:13:22'),
(0, 86, 'Bucsa', 'You have no more FWarn points thanks to Bucsa.', 86, 'Bucsa', 1, 'http://localhost/panel/profile/Bucsa', '2023-03-18 11:44:02'),
(0, 86, 'Bucsa', 'Your premium points(0) has been updated by Admin Bucsa.', 86, 'Bucsa', 1, 'http://localhost/panel/profile/Bucsa', '2023-03-18 11:44:08'),
(0, 86, 'Bucsa', 'Your premium points(0) has been updated by Admin Bucsa.', 86, 'Bucsa', 1, 'http://localhost/panel/profile/Bucsa', '2023-03-18 11:44:35'),
(0, 86, 'Bucsa', 'Your premium points(0) has been updated by Admin Bucsa.', 86, 'Bucsa', 1, 'http://localhost/panel/profile/Bucsa', '2023-03-18 11:44:44'),
(0, 86, 'Bucsa', 'Your premium points(0) has been updated by Admin Bucsa.', 86, 'Bucsa', 1, 'http://localhost/panel/profile/Bucsa', '2023-03-18 11:44:52'),
(0, 86, 'Bucsa', 'Your premium points(0) has been updated by Admin Bucsa.', 86, 'Bucsa', 1, 'http://localhost/panel/profile/Bucsa', '2023-03-18 11:45:41'),
(0, 86, 'Bucsa', 'Your premium points(0) has been updated by Admin Bucsa.', 86, 'Bucsa', 1, 'http://localhost/panel/profile/Bucsa', '2023-03-18 11:46:00'),
(0, 86, 'Bucsa', 'Your premium points(0) has been updated by Admin Bucsa.', 86, 'Bucsa', 1, 'http://localhost/panel/profile/Bucsa', '2023-03-18 11:46:32'),
(0, 86, 'Bucsa', 'Your premium points(0) has been updated by Admin Bucsa.', 86, 'Bucsa', 1, 'http://localhost/panel/profile/Bucsa', '2023-03-18 11:46:45'),
(0, 86, 'Bucsa', 'Your premium points(0) has been updated by Admin Bucsa.', 86, 'Bucsa', 1, 'http://localhost/panel/profile/Bucsa', '2023-03-18 11:47:24'),
(0, 86, 'Bucsa', 'You\'ve been muted for 100 minutes!', 86, 'Bucsa', 1, 'http://localhost/panel/profile/Bucsa', '2023-03-18 11:47:50'),
(0, 86, 'Bucsa', 'Your money state(<font color=\"green\">$</font>999,999,999 / <font color=\"green\">$</font>999,999,999) has been updated by Admin Bucsa.', 86, 'Bucsa', 1, 'http://localhost/panel/profile/Bucsa', '2023-03-18 18:13:24'),
(0, 3, 'Madalin31', 'FARCRY3 made an Faction complaint against you! Check it out.', 11, 'FARCRY3', 0, 'http://localhost/panel/complaints', '2023-03-21 12:56:40'),
(0, 2, 'DEIMAN0009', 'Your premium points(10) has been updated by Admin FARCRY3.', 11, 'FARCRY3', 0, 'http://localhost/panel/profile/DEIMAN0009', '2023-03-21 13:07:08'),
(0, 7, 'HALKFLORIN67', 'You\'ve been muted for 999 minutes!', 11, 'Bucsa', 0, 'http://localhost/panel/profile/HALKFLORIN67', '2023-03-21 13:32:04'),
(0, 7, 'HALKFLORIN67', 'You\'ve been permanently suspended from panel!', 11, 'Bucsa', 0, 'http://localhost/panel/', '2023-03-21 13:32:18'),
(0, 7, 'HALKFLORIN67', 'You have no more FWarn points thanks to Bucsa.', 11, 'Bucsa', 0, 'http://localhost/panel/profile/HALKFLORIN67', '2023-03-21 13:32:30'),
(0, 6, 'DaduAdv', 'Your money state(<font color=\"green\">$</font>1 / <font color=\"green\">$</font>1) has been updated by Admin Bucsa.', 11, 'Bucsa', 0, 'http://localhost/panel/profile/DaduAdv', '2023-03-21 13:33:05'),
(0, 6, 'DaduAdv', 'Your money state(<font color=\"green\">$</font>1 / <font color=\"green\">$</font>1) has been updated by Admin Bucsa.', 11, 'Bucsa', 0, 'http://localhost/panel/profile/DaduAdv', '2023-03-21 13:33:09'),
(0, 6, 'DaduAdv', 'Your money state(<font color=\"green\">$</font>1 / <font color=\"green\">$</font>123) has been updated by Admin Bucsa.', 11, 'Bucsa', 0, 'http://localhost/panel/profile/DaduAdv', '2023-03-21 13:33:13'),
(0, 11, 'Bucsa', 'Your money state(<font color=\"green\">$</font>154,329 / <font color=\"green\">$</font>100,000) has been updated by Admin Bucsa.', 11, 'Bucsa', 0, 'http://localhost/panel/profile/Bucsa', '2023-03-21 13:34:06'),
(0, 11, 'Bucsa', 'Your money state(<font color=\"green\">$</font>154,329 / <font color=\"green\">$</font>100,000) has been updated by Admin Bucsa.', 11, 'Bucsa', 0, 'http://localhost/panel/profile/Bucsa', '2023-03-21 13:34:16'),
(0, 11, 'Bucsa', 'You received +1 WarnPoint from Bucsa for abuz.', 11, 'Bucsa', 0, 'http://localhost/panel/profile/Bucsa', '2023-03-21 13:34:31'),
(0, 11, 'Bucsa', 'You have no more Warnings points thanks to Bucsa.', 11, 'Bucsa', 0, 'http://localhost/panel/profile/Bucsa', '2023-03-21 13:34:35'),
(0, 11, 'Bucsa', 'You have no more Warnings points thanks to Bucsa.', 11, 'Bucsa', 0, 'http://localhost/panel/profile/Bucsa', '2023-03-21 13:35:25'),
(0, 11, 'Bucsa', 'You have no more FPunish points thanks to Bucsa.', 11, 'Bucsa', 0, 'http://localhost/panel/profile/Bucsa', '2023-03-21 13:37:37'),
(0, 11, 'Bucsa', 'You have no more FPunish points thanks to Bucsa.', 11, 'Bucsa', 0, 'http://localhost/panel/profile/Bucsa', '2023-03-21 13:37:49'),
(0, 11, 'Bucsa', 'You have no more FPunish points thanks to Bucsa.', 11, 'Bucsa', 0, 'http://localhost/panel/profile/Bucsa', '2023-03-21 13:40:17'),
(0, 11, 'Bucsa', 'You have no more FPunish points thanks to Bucsa.', 11, 'Bucsa', 0, 'http://localhost/panel/profile/Bucsa', '2023-03-21 13:40:58'),
(0, 11, 'Bucsa', 'You have no more FPunish points thanks to Bucsa.', 11, 'Bucsa', 0, 'http://localhost/panel/profile/Bucsa', '2023-03-21 13:41:04'),
(0, 11, 'Bucsa', 'You have no more FPunish points thanks to Bucsa.', 11, 'Bucsa', 0, 'http://localhost/panel/profile/Bucsa', '2023-03-21 13:41:32'),
(0, 11, 'Bucsa', 'You have no more FPunish points thanks to Bucsa.', 11, 'Bucsa', 0, 'http://localhost/panel/profile/Bucsa', '2023-03-21 13:41:41'),
(0, 11, 'Bucsa', 'You\'ve been unmuted by Bucsa!', 11, 'Bucsa', 0, 'http://localhost/panel/profile/Bucsa', '2023-03-21 13:44:54');

-- --------------------------------------------------------

--
-- Table structure for table `wcode_questions`
--

CREATE TABLE `wcode_questions` (
  `id` int(11) NOT NULL,
  `question` text NOT NULL,
  `factionid` int(11) NOT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `wcode_questions`
--

INSERT INTO `wcode_questions` (`id`, `question`, `factionid`, `date`) VALUES
(0, 'Cum te numesti si ce varsta ai?', 1, '2023-03-21 12:45:41'),
(0, 'Cum te numesti si ce varsta ai?', 0, '2023-03-21 12:46:00');

-- --------------------------------------------------------

--
-- Table structure for table `wcode_recover`
--

CREATE TABLE `wcode_recover` (
  `ID` int(11) NOT NULL,
  `user` int(11) NOT NULL,
  `username` varchar(90) NOT NULL,
  `email` text NOT NULL,
  `token` varchar(90) NOT NULL,
  `time` varchar(90) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `wcode_recover`
--

INSERT INTO `wcode_recover` (`ID`, `user`, `username`, `email`, `token`, `time`) VALUES
(0, 86, 'Bucsa', 'mcandreimc777@gmail.com', 'GXYorq0CTCDrjLctWva1', '1679168145');

-- --------------------------------------------------------

--
-- Table structure for table `wcode_suspend`
--

CREATE TABLE `wcode_suspend` (
  `ID` int(11) NOT NULL,
  `User` varchar(32) NOT NULL,
  `Userid` int(11) NOT NULL,
  `Admin` varchar(32) NOT NULL,
  `Adminid` int(11) NOT NULL,
  `Days` int(11) NOT NULL,
  `Date` timestamp NOT NULL DEFAULT current_timestamp(),
  `Date_unix` int(11) NOT NULL,
  `Expire_unix` int(11) NOT NULL,
  `Expire` varchar(32) NOT NULL,
  `Reason` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

--
-- Dumping data for table `wcode_suspend`
--

INSERT INTO `wcode_suspend` (`ID`, `User`, `Userid`, `Admin`, `Adminid`, `Days`, `Date`, `Date_unix`, `Expire_unix`, `Expire`, `Reason`) VALUES
(0, 'HALKFLORIN67', 7, 'Bucsa', 11, 0, '2023-03-21 13:32:18', 1679405538, 0, '', 'abuz de functie');

-- --------------------------------------------------------

--
-- Table structure for table `wcode_tickets`
--

CREATE TABLE `wcode_tickets` (
  `ID` int(11) NOT NULL,
  `UserID` int(11) NOT NULL,
  `UserName` varchar(32) NOT NULL,
  `Category` varchar(64) NOT NULL,
  `Text` text NOT NULL,
  `Status` int(11) NOT NULL,
  `Date` timestamp NOT NULL DEFAULT current_timestamp(),
  `ActionBy` varchar(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `wcode_tickets`
--

INSERT INTO `wcode_tickets` (`ID`, `UserID`, `UserName`, `Category`, `Text`, `Status`, `Date`, `ActionBy`) VALUES
(0, 86, 'Bucsa', 'Account problems', 'Am uitat parola\r\n', 1, '2023-03-18 10:45:04', '');

-- --------------------------------------------------------

--
-- Table structure for table `wcode_unban`
--

CREATE TABLE `wcode_unban` (
  `ID` int(11) NOT NULL,
  `UserID` int(11) NOT NULL,
  `UserName` varchar(32) NOT NULL,
  `BanDetails` text NOT NULL,
  `Title` varchar(32) NOT NULL,
  `Details` text NOT NULL,
  `Status` int(11) NOT NULL,
  `Date` timestamp NOT NULL DEFAULT current_timestamp(),
  `ActionBy` varchar(32) NOT NULL DEFAULT 'Banned'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `atm`
--
ALTER TABLE `atm`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `banlog`
--
ALTER TABLE `banlog`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `bans`
--
ALTER TABLE `bans`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `bizz`
--
ALTER TABLE `bizz`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `blacklist`
--
ALTER TABLE `blacklist`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `cars`
--
ALTER TABLE `cars`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `clanhq`
--
ALTER TABLE `clanhq`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `clans`
--
ALTER TABLE `clans`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `clanvehicle`
--
ALTER TABLE `clanvehicle`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `commands`
--
ALTER TABLE `commands`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `dsveh`
--
ALTER TABLE `dsveh`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `eat_stand`
--
ALTER TABLE `eat_stand`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `emails`
--
ALTER TABLE `emails`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `factionlog`
--
ALTER TABLE `factionlog`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `factions`
--
ALTER TABLE `factions`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `faction_apply`
--
ALTER TABLE `faction_apply`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `faction_logs`
--
ALTER TABLE `faction_logs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `friends`
--
ALTER TABLE `friends`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `garages`
--
ALTER TABLE `garages`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `graffiti`
--
ALTER TABLE `graffiti`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `houses`
--
ALTER TABLE `houses`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `ID` (`ID`);

--
-- Indexes for table `iplogs`
--
ALTER TABLE `iplogs`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `ID` (`ID`);

--
-- Indexes for table `kenny_happs`
--
ALTER TABLE `kenny_happs`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `kenny_hquestions`
--
ALTER TABLE `kenny_hquestions`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `kenny_lapps`
--
ALTER TABLE `kenny_lapps`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `kenny_lquestions`
--
ALTER TABLE `kenny_lquestions`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `key`
--
ALTER TABLE `key`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `logs`
--
ALTER TABLE `logs`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `money_logs`
--
ALTER TABLE `money_logs`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `panel_answers`
--
ALTER TABLE `panel_answers`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `panel_applications`
--
ALTER TABLE `panel_applications`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `panel_badge`
--
ALTER TABLE `panel_badge`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `panel_comment`
--
ALTER TABLE `panel_comment`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `panel_comment_complaints`
--
ALTER TABLE `panel_comment_complaints`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `panel_comment_tickets`
--
ALTER TABLE `panel_comment_tickets`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `panel_complaints`
--
ALTER TABLE `panel_complaints`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `panel_question`
--
ALTER TABLE `panel_question`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `panel_queue`
--
ALTER TABLE `panel_queue`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `panel_recovery`
--
ALTER TABLE `panel_recovery`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `panel_suspend`
--
ALTER TABLE `panel_suspend`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `panel_tickets`
--
ALTER TABLE `panel_tickets`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `panel_unban`
--
ALTER TABLE `panel_unban`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `safezones`
--
ALTER TABLE `safezones`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `ID` (`ID`);

--
-- Indexes for table `sanctions`
--
ALTER TABLE `sanctions`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `seif`
--
ALTER TABLE `seif`
  ADD PRIMARY KEY (`sID`);

--
-- Indexes for table `stuff`
--
ALTER TABLE `stuff`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `svehicles`
--
ALTER TABLE `svehicles`
  ADD PRIMARY KEY (`vID`);

--
-- Indexes for table `svf`
--
ALTER TABLE `svf`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `tickets`
--
ALTER TABLE `tickets`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `transferlog`
--
ALTER TABLE `transferlog`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `turfs`
--
ALTER TABLE `turfs`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `unban-comments`
--
ALTER TABLE `unban-comments`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `unban-panel`
--
ALTER TABLE `unban-panel`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `updates`
--
ALTER TABLE `updates`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id_2` (`id`),
  ADD KEY `id` (`id`);

--
-- Indexes for table `war_logs`
--
ALTER TABLE `war_logs`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `war_members`
--
ALTER TABLE `war_members`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `wcode_applications`
--
ALTER TABLE `wcode_applications`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `wcode_commentaries`
--
ALTER TABLE `wcode_commentaries`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `wcode_complaints`
--
ALTER TABLE `wcode_complaints`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `wcode_donations`
--
ALTER TABLE `wcode_donations`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `wcode_donations_logs`
--
ALTER TABLE `wcode_donations_logs`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `wcode_editables`
--
ALTER TABLE `wcode_editables`
  ADD PRIMARY KEY (`ID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `atm`
--
ALTER TABLE `atm`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `banlog`
--
ALTER TABLE `banlog`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `bans`
--
ALTER TABLE `bans`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `bizz`
--
ALTER TABLE `bizz`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=65;

--
-- AUTO_INCREMENT for table `blacklist`
--
ALTER TABLE `blacklist`
  MODIFY `ID` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `cars`
--
ALTER TABLE `cars`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=50;

--
-- AUTO_INCREMENT for table `clanhq`
--
ALTER TABLE `clanhq`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `clans`
--
ALTER TABLE `clans`
  MODIFY `ID` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `clanvehicle`
--
ALTER TABLE `clanvehicle`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `commands`
--
ALTER TABLE `commands`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `dsveh`
--
ALTER TABLE `dsveh`
  MODIFY `ID` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=60;

--
-- AUTO_INCREMENT for table `eat_stand`
--
ALTER TABLE `eat_stand`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table `emails`
--
ALTER TABLE `emails`
  MODIFY `ID` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `factionlog`
--
ALTER TABLE `factionlog`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `factions`
--
ALTER TABLE `factions`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `faction_apply`
--
ALTER TABLE `faction_apply`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `faction_logs`
--
ALTER TABLE `faction_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `friends`
--
ALTER TABLE `friends`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `garages`
--
ALTER TABLE `garages`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `graffiti`
--
ALTER TABLE `graffiti`
  MODIFY `ID` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `houses`
--
ALTER TABLE `houses`
  MODIFY `ID` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT for table `iplogs`
--
ALTER TABLE `iplogs`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=115;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `ID` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `kenny_lapps`
--
ALTER TABLE `kenny_lapps`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `kenny_lquestions`
--
ALTER TABLE `kenny_lquestions`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `key`
--
ALTER TABLE `key`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `logs`
--
ALTER TABLE `logs`
  MODIFY `ID` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=855;

--
-- AUTO_INCREMENT for table `money_logs`
--
ALTER TABLE `money_logs`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `panel_answers`
--
ALTER TABLE `panel_answers`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `panel_applications`
--
ALTER TABLE `panel_applications`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `panel_badge`
--
ALTER TABLE `panel_badge`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `panel_comment`
--
ALTER TABLE `panel_comment`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `panel_comment_complaints`
--
ALTER TABLE `panel_comment_complaints`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `panel_comment_tickets`
--
ALTER TABLE `panel_comment_tickets`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `panel_complaints`
--
ALTER TABLE `panel_complaints`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `panel_question`
--
ALTER TABLE `panel_question`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `panel_queue`
--
ALTER TABLE `panel_queue`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `panel_recovery`
--
ALTER TABLE `panel_recovery`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `panel_suspend`
--
ALTER TABLE `panel_suspend`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `panel_tickets`
--
ALTER TABLE `panel_tickets`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `panel_unban`
--
ALTER TABLE `panel_unban`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `safezones`
--
ALTER TABLE `safezones`
  MODIFY `ID` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `sanctions`
--
ALTER TABLE `sanctions`
  MODIFY `ID` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `seif`
--
ALTER TABLE `seif`
  MODIFY `sID` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `stuff`
--
ALTER TABLE `stuff`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `svehicles`
--
ALTER TABLE `svehicles`
  MODIFY `vID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=252;

--
-- AUTO_INCREMENT for table `svf`
--
ALTER TABLE `svf`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=122;

--
-- AUTO_INCREMENT for table `tickets`
--
ALTER TABLE `tickets`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `transferlog`
--
ALTER TABLE `transferlog`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `turfs`
--
ALTER TABLE `turfs`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=73;

--
-- AUTO_INCREMENT for table `unban-comments`
--
ALTER TABLE `unban-comments`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `unban-panel`
--
ALTER TABLE `unban-panel`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `updates`
--
ALTER TABLE `updates`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `war_logs`
--
ALTER TABLE `war_logs`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `war_members`
--
ALTER TABLE `war_members`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `wcode_complaints`
--
ALTER TABLE `wcode_complaints`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `wcode_editables`
--
ALTER TABLE `wcode_editables`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
