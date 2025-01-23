-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Waktu pembuatan: 20 Jan 2025 pada 17.59
-- Versi server: 10.6.17-MariaDB-cll-lve
-- Versi PHP: 8.1.31

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `brabsenm_absensimagang`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `absensis`
--

CREATE TABLE `absensis` (
  `id` int(11) NOT NULL,
  `tgl_absensi` date DEFAULT NULL,
  `jam_masuk` time DEFAULT NULL,
  `jam_keluar` time DEFAULT NULL,
  `foto_masuk` text DEFAULT NULL,
  `foto_keluar` text DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `userId` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data untuk tabel `absensis`
--

INSERT INTO `absensis` (`id`, `tgl_absensi`, `jam_masuk`, `jam_keluar`, `foto_masuk`, `foto_keluar`, `createdAt`, `updatedAt`, `userId`) VALUES
(1, '2025-01-15', '16:16:10', '16:17:56', 'testsiswa-2025-01-15-masuk.png', 'testsiswa-2025-01-15-keluar.png', '2025-01-15 16:16:10', '2025-01-15 16:17:56', 2),
(2, '2025-01-16', '11:04:56', '12:45:33', 'testsiswa-2025-01-16-masuk.jpg', 'testsiswa-2025-01-16-keluar.jpg', '2025-01-16 11:04:56', '2025-01-16 12:45:33', 2),
(3, '2025-01-16', '13:40:15', '16:01:25', 'testsiswa2-2025-01-16-masuk.jpg', 'testsiswa2-2025-01-16-keluar.jpg', '2025-01-16 13:40:15', '2025-01-16 16:01:25', 3),
(4, '2025-01-17', '10:35:23', '12:55:14', 'siswaakl-2025-01-17-masuk.jpg', 'siswaakl-2025-01-17-keluar.jpg', '2025-01-17 10:35:23', '2025-01-17 12:55:14', 5),
(5, '2025-01-17', '11:16:57', NULL, 'testsiswa-2025-01-17-masuk.jpg', NULL, '2025-01-17 11:16:57', '2025-01-17 11:16:57', 2),
(6, '2025-01-20', '10:19:26', NULL, 'testsiswa-2025-01-20-masuk.jpg', NULL, '2025-01-20 10:19:26', '2025-01-20 10:19:26', 2);

-- --------------------------------------------------------

--
-- Struktur dari tabel `jurusans`
--

CREATE TABLE `jurusans` (
  `id` int(11) NOT NULL,
  `namaJurusan` varchar(255) NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data untuk tabel `jurusans`
--

INSERT INTO `jurusans` (`id`, `namaJurusan`, `createdAt`, `updatedAt`) VALUES
(1, 'X AKL1', '2025-01-15 10:49:03', '2025-01-15 10:49:03'),
(2, 'X RPL1', '2025-01-15 10:49:19', '2025-01-15 10:49:19');

-- --------------------------------------------------------

--
-- Struktur dari tabel `laporans`
--

CREATE TABLE `laporans` (
  `id` int(11) NOT NULL,
  `tgl_pembuatan` date NOT NULL,
  `foto_laporan` varchar(255) NOT NULL,
  `keterangan` longtext DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `userId` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data untuk tabel `laporans`
--

INSERT INTO `laporans` (`id`, `tgl_pembuatan`, `foto_laporan`, `keterangan`, `createdAt`, `updatedAt`, `userId`) VALUES
(1, '2025-01-15', 'testsiswa-2025-01-15-1737143926466.png', 'Laporan absensi karyawan bulan Januari', '2025-01-15 11:17:23', '2025-01-18 02:58:46', 2),
(2, '2025-01-15', 'testsiswa-2025-01-15-1736914660405.png', 'Laporan absensi karyawan bulan Januari', '2025-01-15 11:17:40', '2025-01-15 11:17:40', 2),
(4, '2025-01-15', 'testsiswa-2025-01-15-1737199718246.jpg', 'Laporan absensi karyawan bulan Januari', '2025-01-15 11:19:00', '2025-01-18 18:28:38', 2),
(5, '2025-01-15', 'testsiswa-2025-01-15-1736917280050.png', 'magang harike 2', '2025-01-15 12:01:20', '2025-01-15 12:01:20', 2),
(6, '2025-01-15', 'testsiswa-2025-01-15-1736917430247.png', 'magang harike 2 dengan laporan pembelajaran baru', '2025-01-15 12:03:50', '2025-01-15 12:03:50', 2),
(7, '2025-01-16', 'testsiswa-2025-01-16-1737003421190.png', 'test upload11', '2025-01-16 11:57:01', '2025-01-18 03:18:23', 2),
(8, '2025-01-16', 'testsiswa2-2025-01-16-1737010112337.png', 'test upload jurnal', '2025-01-16 13:48:32', '2025-01-16 13:48:32', 3),
(9, '2025-01-16', 'testsiswa2-2025-01-16-1737037936247.jpg', 'jurnal', '2025-01-16 21:32:16', '2025-01-16 21:32:16', 3),
(10, '2025-01-17', 'siswaakl-2025-01-17-1737085173575.png', 'Magang hari ke 2 dengan kegiatan membantu kantor', '2025-01-17 10:39:33', '2025-01-17 10:39:33', 5),
(11, '2025-01-17', 'testsiswa-2025-01-17-1737145470890.png', 'Test aplikasi', '2025-01-17 11:21:47', '2025-01-18 03:24:30', 2),
(12, '2025-01-17', 'siswaakl-2025-01-17-1737093302274.png', 'Test debug', '2025-01-17 12:55:02', '2025-01-17 12:55:02', 5),
(13, '2025-01-17', 'testsiswa-2025-01-17-1737093784781.jpg', 'Testupload update', '2025-01-17 13:03:04', '2025-01-18 02:56:30', 2),
(14, '2025-01-18', 'testsiswa-2025-01-18-1737225388290.jpg', 'testing1update test\r\n', '2025-01-18 03:12:54', '2025-01-19 01:36:28', 2),
(15, '2025-01-20', 'testsiswa-2025-01-20-1737368619394.png', 'Teks adalah rangkaian kata atau kalimat yang memiliki struktur dan tata bahasa tertentu. Teks dapat disusun secara lisan atau tulisan. \r\nTujuan teks adalah untuk menyampaikan informasi, gagasan, atau pesan kepada pembaca atau pendengar. Teks juga dapat menghibur, mengajar, atau meyakinkan pembaca. \r\nJenis-jenis teks:\r\nTeks narasi, yaitu teks yang digunakan untuk menceritakan cerita atau narasi. Contohnya novel, cerita pendek, dongeng, dan autobiografi. \r\nTeks prosedur, yaitu teks yang berisi panduan, langkah-langkah, atau tutorial untuk melakukan sesuatu. \r\nTeks argumentasi, yaitu teks yang memuat penjelasan tentang pendapat atau fakta berdasarkan sudut pandang penulis. \r\nTeks deskripsi, yaitu teks yang memaparkan atau menggambarkan sesuatu menggunakan kata-kata dengan jelas dan terperinci. \r\nTeks eksposisi, yaitu teks yang mengandung serangkaian informasi dan wawasan yang disampaikan secara singkat, padat, dan jelas. \r\nTeks normatif, yaitu teks yang isinya ditulis berdasarkan sebuah peraturan, norma-norma, atau peraturan yang berlaku.', '2025-01-20 17:23:39', '2025-01-20 17:23:39', 2);

-- --------------------------------------------------------

--
-- Struktur dari tabel `Sessions`
--

CREATE TABLE `Sessions` (
  `sid` varchar(36) NOT NULL,
  `expires` datetime DEFAULT NULL,
  `data` text DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data untuk tabel `Sessions`
--

INSERT INTO `Sessions` (`sid`, `expires`, `data`, `createdAt`, `updatedAt`) VALUES
('-dejYC9C5u-R7Wq_h6Dymbv1kqw5k9SK', '2025-01-21 15:10:19', '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"secure\":false,\"httpOnly\":true,\"path\":\"/\"},\"_garbage\":\"Mon Jan 20 2025 15:10:19 GMT+0700 (Western Indonesia Time)\",\"userId\":4,\"userRole\":\"superadmin\"}', '2025-01-20 14:15:23', '2025-01-20 15:10:19'),
('2FEoCobIfIjvIUoS-xcvKi41LUiKEICz', '2025-01-21 10:22:30', '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"secure\":false,\"httpOnly\":true,\"path\":\"/\"},\"_garbage\":\"Mon Jan 20 2025 10:22:30 GMT+0700 (Western Indonesia Time)\",\"userId\":2,\"userRole\":\"siswa\"}', '2025-01-20 10:21:56', '2025-01-20 10:22:30'),
('5RLyJAtk7JdUU7x0ULbEtJU1rdgY4_y_', '2025-01-21 17:23:12', '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"secure\":false,\"httpOnly\":true,\"path\":\"/\"},\"_garbage\":\"Mon Jan 20 2025 17:23:12 GMT+0700 (Western Indonesia Time)\"}', '2025-01-20 17:23:12', '2025-01-20 17:23:12'),
('9AJ2PX3bzEGvwFI-sUy_PSz31Eavqfy_', '2025-01-21 08:21:36', '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"secure\":false,\"httpOnly\":true,\"path\":\"/\"},\"_garbage\":\"Mon Jan 20 2025 08:21:36 GMT+0700 (Western Indonesia Time)\",\"userId\":2,\"userRole\":\"siswa\"}', '2025-01-20 08:21:33', '2025-01-20 08:21:36'),
('AVKdEunrP0iAmH78GFwDvaDrFaB_DCNT', '2025-01-21 03:37:15', '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"secure\":false,\"httpOnly\":true,\"path\":\"/\"},\"_garbage\":\"Mon Jan 20 2025 03:37:15 GMT+0700 (Western Indonesia Time)\"}', '2025-01-20 03:37:15', '2025-01-20 03:37:15'),
('CEEMy4G0hRhd37vY72xmkGpc2dpxA0MJ', '2025-01-21 17:10:18', '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"secure\":false,\"httpOnly\":true,\"path\":\"/\"},\"_garbage\":\"Mon Jan 20 2025 17:10:18 GMT+0700 (Western Indonesia Time)\",\"userId\":2,\"userRole\":\"siswa\"}', '2025-01-20 17:07:30', '2025-01-20 17:10:18'),
('DkEJ9WLKvqJiVhiuifksgYIjzRO08Kv9', '2025-01-21 17:14:24', '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"secure\":false,\"httpOnly\":true,\"path\":\"/\"},\"_garbage\":\"Mon Jan 20 2025 17:14:24 GMT+0700 (Western Indonesia Time)\",\"userId\":2,\"userRole\":\"siswa\"}', '2025-01-20 17:12:52', '2025-01-20 17:14:24'),
('Eeb4jO7JLsAxnPFhNTLbo9aKx-i84bQ3', '2025-01-21 15:37:11', '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"secure\":false,\"httpOnly\":true,\"path\":\"/\"},\"_garbage\":\"Mon Jan 20 2025 15:37:11 GMT+0700 (Western Indonesia Time)\"}', '2025-01-20 15:37:11', '2025-01-20 15:37:11'),
('eJVNpNIYgFG42yPe713ScsP0otp9R-xi', '2025-01-21 17:23:12', '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"secure\":false,\"httpOnly\":true,\"path\":\"/\"},\"_garbage\":\"Mon Jan 20 2025 17:23:12 GMT+0700 (Western Indonesia Time)\"}', '2025-01-20 17:23:12', '2025-01-20 17:23:12'),
('EX2_mjV6L-JtaGWBk92_sWdIkC27k4wD', '2025-01-21 01:56:19', '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"secure\":false,\"httpOnly\":true,\"path\":\"/\"},\"_garbage\":\"Mon Jan 20 2025 01:56:19 GMT+0700 (Western Indonesia Time)\"}', '2025-01-20 01:56:19', '2025-01-20 01:56:19'),
('F6Me1TFBLVP8PDWn_NYttyx6UDKQFgnY', '2025-01-21 16:13:47', '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"secure\":false,\"httpOnly\":true,\"path\":\"/\"},\"_garbage\":\"Mon Jan 20 2025 16:13:47 GMT+0700 (Western Indonesia Time)\"}', '2025-01-20 16:13:47', '2025-01-20 16:13:47'),
('hGKPbAm-SkJDiOm7KyFPZnkrtLdD5nE_', '2025-01-21 12:52:53', '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"secure\":false,\"httpOnly\":true,\"path\":\"/\"},\"_garbage\":\"Mon Jan 20 2025 12:52:53 GMT+0700 (Western Indonesia Time)\"}', '2025-01-20 12:52:53', '2025-01-20 12:52:53'),
('i_aAE_S5HL0gWCmubXubbrASveFM5pWP', '2025-01-21 17:24:51', '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"secure\":false,\"httpOnly\":true,\"path\":\"/\"},\"_garbage\":\"Mon Jan 20 2025 17:24:51 GMT+0700 (Western Indonesia Time)\"}', '2025-01-20 17:24:51', '2025-01-20 17:24:51'),
('lx7GSvpMxsF1bEXkCalQXlxuMoWS6RMu', '2025-01-21 10:01:31', '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"secure\":false,\"httpOnly\":true,\"path\":\"/\"},\"_garbage\":\"Mon Jan 20 2025 10:01:31 GMT+0700 (Western Indonesia Time)\"}', '2025-01-20 10:01:31', '2025-01-20 10:01:31'),
('MKWjY_NwcLR3Y08Mg9F_ilna1AJYjPaC', '2025-01-21 12:52:53', '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"secure\":false,\"httpOnly\":true,\"path\":\"/\"},\"_garbage\":\"Mon Jan 20 2025 12:52:53 GMT+0700 (Western Indonesia Time)\"}', '2025-01-20 12:52:53', '2025-01-20 12:52:53'),
('NdClacCQGowznkoCcGzvbuh2Ne2sQUNc', '2025-01-21 12:52:53', '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"secure\":false,\"httpOnly\":true,\"path\":\"/\"},\"_garbage\":\"Mon Jan 20 2025 12:52:53 GMT+0700 (Western Indonesia Time)\"}', '2025-01-20 12:52:53', '2025-01-20 12:52:53'),
('oBDZVnmvsDkN8EVQOpT0jamw5DL6bLeH', '2025-01-21 17:23:12', '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"secure\":false,\"httpOnly\":true,\"path\":\"/\"},\"_garbage\":\"Mon Jan 20 2025 17:23:12 GMT+0700 (Western Indonesia Time)\"}', '2025-01-20 17:23:12', '2025-01-20 17:23:12'),
('wY6NwE0oX9lwUlrF9O0pBQ9O1h9h_wcE', '2025-01-20 19:22:01', '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"secure\":false,\"httpOnly\":true,\"path\":\"/\"},\"_garbage\":\"Sun Jan 19 2025 19:22:01 GMT+0700 (Western Indonesia Time)\"}', '2025-01-19 19:22:01', '2025-01-19 19:22:01');

-- --------------------------------------------------------

--
-- Struktur dari tabel `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('superadmin','admin','siswa') NOT NULL,
  `jurusanId` int(11) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data untuk tabel `users`
--

INSERT INTO `users` (`id`, `name`, `username`, `password`, `role`, `jurusanId`, `createdAt`, `updatedAt`) VALUES
(1, 'testadmin', 'testadmin', '$argon2id$v=19$m=65536,t=3,p=4$nQLuBkGbkOY0YidcO4cb8Q$jQCcZphSkAyh82BG5skOz6FcU9tyO9HETuk+3GS+JcM', 'admin', 1, '2025-01-15 10:48:55', '2025-01-16 14:29:34'),
(2, 'testsiswa', 'testsiswa', '$argon2id$v=19$m=65536,t=3,p=4$KwgzNvWoEwZfjKc/FxPrgA$9RVUFwgcwWWrmbjgdJpLpULYjqjdU+l4oUA45kHixgY', 'siswa', 1, '2025-01-15 10:49:06', '2025-01-16 19:51:09'),
(3, 'testsiswa2', 'testsiswa2', '$argon2id$v=19$m=65536,t=3,p=4$afi1Yu68zrTLTmcwXNIFUw$V2iFlXuqrD6TGsGggPBMy4eUWRc+/V3bp9v/IVuUw6A', 'siswa', 2, '2025-01-16 12:45:56', '2025-01-16 12:51:33'),
(4, 'superadmin', 'superadmin', '$argon2id$v=19$m=65536,t=3,p=4$FMUcGRSYGcLYNKSZzYVDGg$W+Php7LTuWWEuKLKLeaFQzSE8B+yZLs4T5+qm8YBfTU', 'superadmin', NULL, '2025-01-16 14:29:53', '2025-01-16 14:29:53'),
(5, 'siswaakl', 'siswaakl', '$argon2id$v=19$m=65536,t=3,p=4$4f4KGgMB3JdXdw2pwnkCSQ$OIK+KqaTi/u0Rzp0RdL9iHunX0xQCO0Ssczab3NthX4', 'siswa', 1, '2025-01-17 08:49:39', '2025-01-17 08:49:39'),
(6, 'adminrpl', 'adminrpl', '$argon2id$v=19$m=65536,t=3,p=4$q9iXw3JjOT6Qvxf/AJoCuw$otpR1/rSsgMSDLCquumVLDlSCjomiNblmjwmz+IDe4Y', 'admin', 2, '2025-01-17 08:52:04', '2025-01-17 08:52:04');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `absensis`
--
ALTER TABLE `absensis`
  ADD PRIMARY KEY (`id`),
  ADD KEY `userId` (`userId`);

--
-- Indeks untuk tabel `jurusans`
--
ALTER TABLE `jurusans`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `laporans`
--
ALTER TABLE `laporans`
  ADD PRIMARY KEY (`id`),
  ADD KEY `userId` (`userId`);

--
-- Indeks untuk tabel `Sessions`
--
ALTER TABLE `Sessions`
  ADD PRIMARY KEY (`sid`);

--
-- Indeks untuk tabel `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jurusanId` (`jurusanId`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `absensis`
--
ALTER TABLE `absensis`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT untuk tabel `jurusans`
--
ALTER TABLE `jurusans`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT untuk tabel `laporans`
--
ALTER TABLE `laporans`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT untuk tabel `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `absensis`
--
ALTER TABLE `absensis`
  ADD CONSTRAINT `absensis_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `laporans`
--
ALTER TABLE `laporans`
  ADD CONSTRAINT `laporans_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`jurusanId`) REFERENCES `jurusans` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
