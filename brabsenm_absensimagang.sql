-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Waktu pembuatan: 06 Feb 2025 pada 11.27
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
(2, '2025-01-16', '11:00:00', '12:40:00', 'testsiswa-2025-01-16-masuk.jpg', 'testsiswa-2025-01-16-keluar.jpg', '2025-01-16 11:04:56', '2025-02-01 04:00:24', 2),
(4, '2025-01-17', '10:35:23', '12:55:14', 'siswaakl-2025-01-17-masuk.jpg', 'siswaakl-2025-01-17-keluar.jpg', '2025-01-17 10:35:23', '2025-01-17 12:55:14', 5);

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
(2, 'X RPL1', '2025-01-15 10:49:19', '2025-01-15 10:49:19'),
(4, 'XII PM1', '2025-01-20 19:13:59', '2025-01-20 19:14:14'),
(5, 'XII AP1', '2025-01-23 20:16:39', '2025-01-23 20:16:44');

-- --------------------------------------------------------

--
-- Struktur dari tabel `laporans`
--

CREATE TABLE `laporans` (
  `id` int(11) NOT NULL,
  `tgl_pembuatan` date NOT NULL,
  `foto_laporan` varchar(255) DEFAULT NULL,
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
(15, '2025-01-20', 'testsiswa-2025-01-20-1737368619394.png', 'Test\r\n', '2025-01-20 17:23:39', '2025-02-04 12:10:24', 2),
(16, '2025-01-20', 'testsiswa-2025-01-20-1737374360884.png', 'Test download pdf', '2025-01-20 18:59:20', '2025-02-04 12:10:38', 2),
(17, '2025-01-23', 'testsiswa-2025-01-23-1737633356180.png', 'Update pagination', '2025-01-23 18:55:56', '2025-01-23 18:55:56', 2),
(18, '2025-01-26', 'testsiswa-2025-01-26-1737829986077.jpg', 'Test paginate', '2025-01-26 01:33:06', '2025-01-26 01:33:06', 2),
(19, '2025-01-26', 'testsiswa-2025-01-26-1737829999703.jpg', 'Testing update paginate', '2025-01-26 01:33:19', '2025-01-26 01:33:35', 2),
(20, '2025-02-01', 'uploadexcel-2025-02-01-1738357139652.jpg', 'buat baru setelah update', '2025-02-01 03:58:59', '2025-02-01 03:58:59', 12);

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
('qPh63uRcLBVbUV-NMEKBGzRyaeSnXPlh', '2025-02-06 09:02:37', '{\"cookie\":{\"originalMaxAge\":600000,\"expires\":\"2025-02-06T02:02:37.849Z\",\"secure\":false,\"httpOnly\":true,\"path\":\"/\"},\"_garbage\":\"Thu Feb 06 2025 08:52:37 GMT+0700 (Western Indonesia Time)\"}', '2025-02-06 08:52:37', '2025-02-06 08:52:37'),
('t1JfXS604Xd8Rc4T7snFnGJyQo8YP9Wt', '2025-02-06 09:02:39', '{\"cookie\":{\"originalMaxAge\":600000,\"expires\":\"2025-02-06T02:02:39.791Z\",\"secure\":false,\"httpOnly\":true,\"path\":\"/\"},\"_garbage\":\"Thu Feb 06 2025 08:52:39 GMT+0700 (Western Indonesia Time)\"}', '2025-02-06 08:52:39', '2025-02-06 08:52:39');

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
(2, 'Siswa', 'testsiswa', '$argon2id$v=19$m=65536,t=3,p=4$pJm5LfM4NvgOLySx+MmQMQ$Vp+8uSiA/BYR0ipM5DAw7RQV1RyAWxn0s1H8hPMLyrw', 'siswa', 1, '2025-01-15 10:49:06', '2025-02-01 01:50:54'),
(3, 'testsiswa2', 'testsiswa2', '$argon2id$v=19$m=65536,t=3,p=4$afi1Yu68zrTLTmcwXNIFUw$V2iFlXuqrD6TGsGggPBMy4eUWRc+/V3bp9v/IVuUw6A', 'siswa', 2, '2025-01-16 12:45:56', '2025-01-16 12:51:33'),
(4, 'superadmin', 'superadmin', '$argon2id$v=19$m=65536,t=3,p=4$FMUcGRSYGcLYNKSZzYVDGg$W+Php7LTuWWEuKLKLeaFQzSE8B+yZLs4T5+qm8YBfTU', 'superadmin', NULL, '2025-01-16 14:29:53', '2025-01-16 14:29:53'),
(5, 'siswaakl', 'siswaakl', '$argon2id$v=19$m=65536,t=3,p=4$4f4KGgMB3JdXdw2pwnkCSQ$OIK+KqaTi/u0Rzp0RdL9iHunX0xQCO0Ssczab3NthX4', 'siswa', 1, '2025-01-17 08:49:39', '2025-01-17 08:49:39'),
(6, 'adminrpl', 'adminrpl', '$argon2id$v=19$m=65536,t=3,p=4$q9iXw3JjOT6Qvxf/AJoCuw$otpR1/rSsgMSDLCquumVLDlSCjomiNblmjwmz+IDe4Y', 'admin', 2, '2025-01-17 08:52:04', '2025-01-17 08:52:04'),
(7, 'Adminpm1', 'Adminpm1', '$argon2id$v=19$m=65536,t=3,p=4$F0S4W9AFEoanuBocdRpb/A$4X7Ze9CuVxCbVyxJLl4CvO9LBdB2tGIpf/rdBlzYM6A', 'admin', 4, '2025-01-20 19:14:56', '2025-01-20 19:14:56'),
(8, 'Superadmin2', 'Superadmin2', '$argon2id$v=19$m=65536,t=3,p=4$RfGh+utEM/b1TuZTHeTYJw$W9lBaaAbHF5wd+uMzrdR+IJ9Im8MX11FZKOCqz2TRUU', 'superadmin', NULL, '2025-01-20 19:15:14', '2025-01-20 19:15:14'),
(9, 'Siswapm1', 'Siswapm1', '$argon2id$v=19$m=65536,t=3,p=4$7mNanClwAVdYeLzv4kk2mA$n17ZXWXD8sp8XytzTlR0LQfpfRy4C+OYk6MtE3Hdlew', 'siswa', 4, '2025-01-20 19:16:00', '2025-01-20 19:16:00'),
(10, 'adminap', 'adminap', '$argon2id$v=19$m=65536,t=3,p=4$eN1y4E5kqIRR0FzES5vtQA$wRXlj7iuHgD5lxn3zZN34jooCKpoYY2CjQ4s52wqCyg', 'admin', 5, '2025-01-23 20:17:01', '2025-01-23 20:17:01'),
(11, 'siswaap', 'siswaap', '$argon2id$v=19$m=65536,t=3,p=4$tsdKHX6mpnT2fdHuq6BBmw$zXK4PV8890VvV57S2r9SFyPWQaChwovvP/FQAJUTTmQ', 'siswa', 5, '2025-01-23 20:17:18', '2025-01-23 20:17:18'),
(12, 'uploadexcel', 'uploadexcel', '$argon2id$v=19$m=65536,t=3,p=4$fkqRud2hmQhOLqUa211CKQ$7vqFYi5kYu/El/R3z+3XEtmfV+u9PqT/vjTaxgh/R4Y', 'siswa', 1, '2025-02-01 03:58:04', '2025-02-01 03:58:04'),
(13, 'siswauploadexcel', 'siswauploadexcel', '$argon2id$v=19$m=65536,t=3,p=4$p9sV+vI0txIFXnLneI30yQ$aru9hpkSvMOXZU/tr5eFzWDU7iL8ZbW5MFIL2P3URfQ', 'siswa', 1, '2025-02-01 03:58:04', '2025-02-01 03:58:04'),
(14, 'bimo', 'bimo', '$argon2id$v=19$m=65536,t=3,p=4$OrseNNZAOM1h9DqcTNCmlA$uoMo6xTUPTf5VMUunK8Dsubk7xT7iQxZNQsFjFxf5eU', 'siswa', 1, '2025-02-01 03:59:48', '2025-02-01 03:59:48');

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT untuk tabel `jurusans`
--
ALTER TABLE `jurusans`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT untuk tabel `laporans`
--
ALTER TABLE `laporans`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT untuk tabel `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

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
