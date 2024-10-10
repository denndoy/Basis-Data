-- Membuat database
CREATE DATABASE IF NOT EXISTS sistem_pendaftaran_siswa;
USE sistem_pendaftaran_siswa;

-- Membuat tabel-tabel
CREATE TABLE siswa (
    id_siswa INT PRIMARY KEY AUTO_INCREMENT,
    nama VARCHAR(100),
    alamat TEXT,
    nomor_telepon VARCHAR(15)
);

CREATE TABLE formulir (
    id_formulir INT PRIMARY KEY AUTO_INCREMENT,
    id_siswa INT,
    tanggal_pengisian DATE,
    status_pengisian ENUM('Belum Lengkap', 'Lengkap'),
    FOREIGN KEY (id_siswa) REFERENCES siswa(id_siswa)
);

CREATE TABLE pembayaran (
    id_pembayaran INT PRIMARY KEY AUTO_INCREMENT,
    id_formulir INT,
    jumlah DECIMAL(10, 2),
    tanggal_pembayaran DATE,
    status_pembayaran ENUM('Belum Dibayar', 'Sudah Dibayar'),
    FOREIGN KEY (id_formulir) REFERENCES formulir(id_formulir)
);

CREATE TABLE data_siswa (
    id_data_siswa INT PRIMARY KEY AUTO_INCREMENT,
    id_siswa INT,
    nilai_ujian DECIMAL(5, 2),
    status_verifikasi ENUM('Belum Diverifikasi', 'Sudah Diverifikasi'),
    FOREIGN KEY (id_siswa) REFERENCES siswa(id_siswa)
);

-- Stored Procedures

DELIMITER //

-- 1. Prosedur untuk pembayaran dan pengisian formulir
CREATE PROCEDURE sp_pembayaran_dan_pengisian_formulir(
    IN p_nama VARCHAR(100),
    IN p_alamat TEXT,
    IN p_nomor_telepon VARCHAR(15),
    IN p_jumlah_pembayaran DECIMAL(10, 2)
)
BEGIN
    DECLARE v_id_siswa INT;
    DECLARE v_id_formulir INT;
    
    -- Insert data siswa
    INSERT INTO siswa (nama, alamat, nomor_telepon) VALUES (p_nama, p_alamat, p_nomor_telepon);
    SET v_id_siswa = LAST_INSERT_ID();
    
    -- Insert formulir
    INSERT INTO formulir (id_siswa, tanggal_pengisian, status_pengisian) 
    VALUES (v_id_siswa, CURDATE(), 'Belum Lengkap');
    SET v_id_formulir = LAST_INSERT_ID();
    
    -- Insert pembayaran
    INSERT INTO pembayaran (id_formulir, jumlah, tanggal_pembayaran, status_pembayaran)
    VALUES (v_id_formulir, p_jumlah_pembayaran, CURDATE(), 'Sudah Dibayar');
    
    -- Generate kwitansi (dalam bentuk output)
    SELECT CONCAT('Kwitansi untuk ', p_nama, ' sejumlah ', p_jumlah_pembayaran) AS kwitansi;
END //

-- 2. Prosedur untuk penyerahan data siswa
CREATE PROCEDURE sp_penyerahan_data_siswa(
    IN p_id_siswa INT,
    IN p_nilai_ujian DECIMAL(5, 2)
)
BEGIN
    INSERT INTO data_siswa (id_siswa, nilai_ujian, status_verifikasi)
    VALUES (p_id_siswa, p_nilai_ujian, 'Belum Diverifikasi');
    
    UPDATE formulir SET status_pengisian = 'Lengkap' WHERE id_siswa = p_id_siswa;
END //

-- 3. Prosedur untuk pengecekan data siswa
CREATE PROCEDURE sp_pengecekan_data_siswa(IN p_id_siswa INT)
BEGIN
    UPDATE data_siswa SET status_verifikasi = 'Sudah Diverifikasi' WHERE id_siswa = p_id_siswa;
    
    -- Mengirim data ke Bag Akademik (simulasi dengan SELECT)
    SELECT * FROM data_siswa WHERE id_siswa = p_id_siswa;
    
    -- Menyimpan ke file data siswa (simulasi dengan SELECT)
    SELECT * FROM siswa s
    JOIN data_siswa ds ON s.id_siswa = ds.id_siswa
    WHERE s.id_siswa = p_id_siswa;
END //

-- 4. Prosedur untuk mendapatkan laporan pendaftaran
CREATE PROCEDURE sp_laporan_pendaftaran()
BEGIN
    SELECT s.nama, f.tanggal_pengisian, f.status_pengisian, p.status_pembayaran, ds.nilai_ujian, ds.status_verifikasi
    FROM siswa s
    JOIN formulir f ON s.id_siswa = f.id_siswa
    LEFT JOIN pembayaran p ON f.id_formulir = p.id_formulir
    LEFT JOIN data_siswa ds ON s.id_siswa = ds.id_siswa;
END //

DELIMITER ;

-- Contoh penggunaan stored procedures:
CALL sp_pembayaran_dan_pengisian_formulir('John Doe', 'Jl. Contoh No. 123', '08123456789', 1000000.00);
CALL sp_penyerahan_data_siswa(1, 85.5);
CALL sp_pengecekan_data_siswa(1);
CALL sp_laporan_pendaftaran();