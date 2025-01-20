-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jan 20, 2025 at 06:14 AM
-- Server version: 8.0.30
-- PHP Version: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `absensimagang`
--

-- --------------------------------------------------------

--
-- Table structure for table `absensis`
--

CREATE TABLE `absensis` (
  `id` int NOT NULL,
  `tgl_absensi` date DEFAULT NULL,
  `jam_masuk` time DEFAULT NULL,
  `jam_keluar` time DEFAULT NULL,
  `foto_masuk` text,
  `foto_keluar` text,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `userId` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `absensis`
--

INSERT INTO `absensis` (`id`, `tgl_absensi`, `jam_masuk`, `jam_keluar`, `foto_masuk`, `foto_keluar`, `createdAt`, `updatedAt`, `userId`) VALUES
(1, '2025-01-15', '16:16:00', '16:18:00', 'testsiswa-2025-01-15-masuk.png', 'testsiswa-2025-01-15-keluar.png', '2025-01-15 16:16:10', '2025-01-20 11:41:29', 2),
(2, '2025-01-16', '11:04:56', '12:45:33', 'testsiswa-2025-01-16-masuk.jpg', 'testsiswa-2025-01-16-keluar.jpg', '2025-01-16 11:04:56', '2025-01-16 12:45:33', 2),
(3, '2025-01-16', '13:40:15', '16:01:25', 'testsiswa2-2025-01-16-masuk.jpg', 'testsiswa2-2025-01-16-keluar.jpg', '2025-01-16 13:40:15', '2025-01-16 16:01:25', 3);

-- --------------------------------------------------------

--
-- Table structure for table `jurusans`
--

CREATE TABLE `jurusans` (
  `id` int NOT NULL,
  `namaJurusan` varchar(255) NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `jurusans`
--

INSERT INTO `jurusans` (`id`, `namaJurusan`, `createdAt`, `updatedAt`) VALUES
(1, 'X AKL1', '2025-01-15 10:49:03', '2025-01-19 01:10:28'),
(2, 'X RPL1', '2025-01-15 10:49:19', '2025-01-15 10:49:19'),
(5, 'XII PM 2', '2025-01-17 18:28:25', '2025-01-17 18:28:25');

-- --------------------------------------------------------

--
-- Table structure for table `laporans`
--

CREATE TABLE `laporans` (
  `id` int NOT NULL,
  `tgl_pembuatan` date NOT NULL,
  `foto_laporan` varchar(255) NOT NULL,
  `keterangan` varchar(255) NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `userId` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `laporans`
--

INSERT INTO `laporans` (`id`, `tgl_pembuatan`, `foto_laporan`, `keterangan`, `createdAt`, `updatedAt`, `userId`) VALUES
(3, '2025-01-15', 'testsiswa-2025-01-15-1737144298085.png', 'Laporan absensi karyawan bulan Januari', '2025-01-15 11:18:02', '2025-01-18 03:04:58', 2),
(4, '2025-01-15', 'testsiswa-2025-01-15-1736914740292.png', 'Laporan absensi karyawan bulan Januari', '2025-01-15 11:19:00', '2025-01-15 11:19:00', 2),
(5, '2025-01-15', 'testsiswa-2025-01-15-1736917280050.png', 'magang harike 2', '2025-01-15 12:01:20', '2025-01-15 12:01:20', 2),
(6, '2025-01-15', 'testsiswa-2025-01-15-1736917430247.png', 'magang harike 2 dengan laporan pembelajaran baru', '2025-01-15 12:03:50', '2025-01-15 12:03:50', 2),
(7, '2025-01-16', 'testsiswa-2025-01-16-1737003421190.png', 'test upload update', '2025-01-16 11:57:01', '2025-01-18 02:43:32', 2),
(8, '2025-01-16', 'testsiswa2-2025-01-16-1737010112337.png', 'test upload jurnal', '2025-01-16 13:48:32', '2025-01-16 13:48:32', 3),
(9, '2025-01-16', 'testsiswa2-2025-01-16-1737037936247.jpg', 'jurnal', '2025-01-16 21:32:16', '2025-01-16 21:32:16', 3),
(10, '2025-01-17', 'siswaakl-2025-01-17-1737085173575.png', 'Magang hari ke 2 dengan kegiatan membantu kantor', '2025-01-17 10:39:33', '2025-01-17 10:39:33', 5);

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `sid` varchar(36) NOT NULL,
  `expires` datetime DEFAULT NULL,
  `data` text,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`sid`, `expires`, `data`, `createdAt`, `updatedAt`) VALUES
('c3b0zAZjgvw4uTWIyh3fe14cTCMLU0aP', '2025-01-21 13:14:00', '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"secure\":false,\"httpOnly\":true,\"path\":\"/\"},\"_garbage\":\"Mon Jan 20 2025 13:14:00 GMT+0700 (Western Indonesia Time)\",\"userId\":1,\"userRole\":\"admin\"}', '2025-01-20 12:40:06', '2025-01-20 13:14:00'),
('dJgS5YNT3nIFSjCQGp3PvdPB8Vrl1Jtl', '2025-01-21 11:20:35', '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"secure\":false,\"httpOnly\":true,\"path\":\"/\"},\"_garbage\":\"Mon Jan 20 2025 11:20:35 GMT+0700 (Western Indonesia Time)\",\"userId\":1,\"userRole\":\"admin\"}', '2025-01-20 11:18:55', '2025-01-20 11:20:35'),
('jUARJxU1sMuUn7-iNwKcJ0hHj9om8KXZ', '2025-01-21 11:40:51', '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"secure\":false,\"httpOnly\":true,\"path\":\"/\"},\"_garbage\":\"Mon Jan 20 2025 11:40:51 GMT+0700 (Western Indonesia Time)\"}', '2025-01-20 11:40:51', '2025-01-20 11:40:51');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('superadmin','admin','siswa') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `jurusanId` int DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `username`, `password`, `role`, `jurusanId`, `createdAt`, `updatedAt`) VALUES
(1, 'testadmin', 'testadmin', '$argon2id$v=19$m=65536,t=3,p=4$hHCa4GoMrRztRU8oaQqHSQ$/7oYmI1+mEXduSRLXXzalfWPtMC0+sWxoDcdubfIY/8', 'admin', 1, '2025-01-15 10:48:55', '2025-01-18 02:06:57'),
(2, 'testsiswa', 'testsiswa', '$argon2id$v=19$m=65536,t=3,p=4$KwgzNvWoEwZfjKc/FxPrgA$9RVUFwgcwWWrmbjgdJpLpULYjqjdU+l4oUA45kHixgY', 'siswa', 1, '2025-01-15 10:49:06', '2025-01-16 19:51:09'),
(3, 'testsiswa2', 'testsiswa2', '$argon2id$v=19$m=65536,t=3,p=4$afi1Yu68zrTLTmcwXNIFUw$V2iFlXuqrD6TGsGggPBMy4eUWRc+/V3bp9v/IVuUw6A', 'siswa', 2, '2025-01-16 12:45:56', '2025-01-16 12:51:33'),
(4, 'superadmin', 'superadmin', '$argon2id$v=19$m=65536,t=3,p=4$FMUcGRSYGcLYNKSZzYVDGg$W+Php7LTuWWEuKLKLeaFQzSE8B+yZLs4T5+qm8YBfTU', 'superadmin', NULL, '2025-01-16 14:29:53', '2025-01-16 14:29:53'),
(5, 'siswaakl', 'siswaakl', '$argon2id$v=19$m=65536,t=3,p=4$4f4KGgMB3JdXdw2pwnkCSQ$OIK+KqaTi/u0Rzp0RdL9iHunX0xQCO0Ssczab3NthX4', 'siswa', 1, '2025-01-17 08:49:39', '2025-01-17 08:49:39'),
(6, 'adminrpl', 'adminrpl', '$argon2id$v=19$m=65536,t=3,p=4$q9iXw3JjOT6Qvxf/AJoCuw$otpR1/rSsgMSDLCquumVLDlSCjomiNblmjwmz+IDe4Y', 'admin', 2, '2025-01-17 08:52:04', '2025-01-17 08:52:04'),
(7, 'testadmin', 'testadmin', '$argon2id$v=19$m=65536,t=3,p=4$OfR7lUk4ZrI0V5CRMuTFnQ$rOVslv3ti1/wHNqtRP8dwDcnKl7dAzq5dYTO76X/Zao', 'admin', 2, '2025-01-17 15:47:09', '2025-01-17 15:53:39'),
(11, 'bimo', 'bimo', '$argon2id$v=19$m=65536,t=3,p=4$Zt2LT1FIZ8zCv5jMt2skEA$gAdMFV1FuKdMopSAoNpod9Zo4l21KBdEyZbHEoA38e0', 'siswa', 1, '2025-01-17 17:34:11', '2025-01-17 17:34:11'),
(13, 'bimoadmin', 'bimoadmin', '$argon2id$v=19$m=65536,t=3,p=4$lyRGkPNv0nswKSzu+mVC8Q$D2J0nEvByHSlOTREJPIFDq9iFtrJ7QGqCSVWtaGhpQw', 'admin', 2, '2025-01-17 18:00:34', '2025-01-17 18:00:40'),
(14, 'testuserbaru', 'testuserbaru', '$argon2id$v=19$m=65536,t=3,p=4$FcEkAMxindDy6c2QDfcx7Q$Vj4uwMXdZfXgSjDgpJon2rRc2DKVzFL1v0XxbeoAIYA', 'siswa', 1, '2025-01-17 18:38:11', '2025-01-17 18:38:11');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `absensis`
--
ALTER TABLE `absensis`
  ADD PRIMARY KEY (`id`),
  ADD KEY `userId` (`userId`);

--
-- Indexes for table `jurusans`
--
ALTER TABLE `jurusans`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `laporans`
--
ALTER TABLE `laporans`
  ADD PRIMARY KEY (`id`),
  ADD KEY `userId` (`userId`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`sid`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jurusanId` (`jurusanId`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `absensis`
--
ALTER TABLE `absensis`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `jurusans`
--
ALTER TABLE `jurusans`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `laporans`
--
ALTER TABLE `laporans`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `absensis`
--
ALTER TABLE `absensis`
  ADD CONSTRAINT `absensis_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `laporans`
--
ALTER TABLE `laporans`
  ADD CONSTRAINT `laporans_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`jurusanId`) REFERENCES `jurusans` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
