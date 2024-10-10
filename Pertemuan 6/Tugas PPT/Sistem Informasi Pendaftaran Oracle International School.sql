-- Membuat database
CREATE DATABASE IF NOT EXISTS oracle_international_school;
USE oracle_international_school;

-- Membuat tabel Calon Siswa
CREATE TABLE calon_siswa (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nama VARCHAR(100),
    tanggal_lahir DATE,
    alamat TEXT,
    nomor_telepon VARCHAR(20),
    email VARCHAR(100),
    status_pendaftaran ENUM('Mendaftar', 'Diterima', 'Ditolak') DEFAULT 'Mendaftar',
    status_pembayaran ENUM('Belum Bayar', 'Sudah Bayar') DEFAULT 'Belum Bayar'
);

-- Membuat tabel Formulir Pendaftaran
CREATE TABLE formulir_pendaftaran (
    id INT AUTO_INCREMENT PRIMARY KEY,
    calon_siswa_id INT,
    tanggal_pendaftaran DATE,
    program_yang_dipilih VARCHAR(50),
    FOREIGN KEY (calon_siswa_id) REFERENCES calon_siswa(id)
);

-- Membuat tabel Pembayaran
CREATE TABLE pembayaran (
    id INT AUTO_INCREMENT PRIMARY KEY,
    calon_siswa_id INT,
    jumlah DECIMAL(10, 2),
    tanggal_pembayaran DATE,
    metode_pembayaran VARCHAR(50),
    status ENUM('Sukses', 'Pending', 'Gagal') DEFAULT 'Pending',
    FOREIGN KEY (calon_siswa_id) REFERENCES calon_siswa(id)
);

-- Contoh query untuk memasukkan data calon siswa
INSERT INTO calon_siswa (nama, tanggal_lahir, alamat, nomor_telepon, email)
VALUES ('John Doe', '2005-05-15', 'Jl. Contoh No. 123', '081234567890', 'john.doe@example.com');

-- Query untuk mengisi formulir pendaftaran
INSERT INTO formulir_pendaftaran (calon_siswa_id, tanggal_pendaftaran, program_yang_dipilih)
VALUES (1, CURDATE(), 'Program IB');

-- Query untuk mencatat pembayaran
INSERT INTO pembayaran (calon_siswa_id, jumlah, tanggal_pembayaran, metode_pembayaran, status)
VALUES (1, 5000000, CURDATE(), 'Transfer Bank', 'Sukses');

-- Query untuk mengupdate status pembayaran calon siswa
UPDATE calon_siswa
SET status_pembayaran = 'Sudah Bayar'
WHERE id = 1;

-- Query untuk laporan pendaftaran
SELECT cs.nama, fp.tanggal_pendaftaran, fp.program_yang_dipilih, cs.status_pendaftaran
FROM calon_siswa cs
JOIN formulir_pendaftaran fp ON cs.id = fp.calon_siswa_id;

-- Query untuk laporan data siswa
SELECT cs.nama, cs.tanggal_lahir, cs.alamat, cs.nomor_telepon, cs.email, cs.status_pendaftaran, cs.status_pembayaran
FROM calon_siswa cs;

-- Query untuk laporan pembayaran
SELECT cs.nama, p.jumlah, p.tanggal_pembayaran, p.metode_pembayaran, p.status
FROM calon_siswa cs
JOIN pembayaran p ON cs.id = p.calon_siswa_id;