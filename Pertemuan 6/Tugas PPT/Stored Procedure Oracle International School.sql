DELIMITER //

-- 1. Stored Procedure untuk menambahkan calon siswa baru
CREATE PROCEDURE sp_tambah_calon_siswa(
    IN p_id_calon_siswa INT,
    IN p_nama VARCHAR(100),
    IN p_tanggal_lahir DATE
)
BEGIN
    INSERT INTO calon_siswa (id_calon_siswa, nama, tanggal_lahir)
    VALUES (p_id_calon_siswa, p_nama, p_tanggal_lahir);
END //

-- 2. Stored Procedure untuk mendaftarkan calon siswa
CREATE PROCEDURE sp_daftar_calon_siswa(
    IN p_id_pendaftaran INT,
    IN p_id_calon_siswa INT,
    IN p_tanggal_pendaftaran DATE,
    IN p_status VARCHAR(50)
)
BEGIN
    INSERT INTO pendaftaran (id_pendaftaran, id_calon_siswa, tanggal_pendaftaran, status)
    VALUES (p_id_pendaftaran, p_id_calon_siswa, p_tanggal_pendaftaran, p_status);
END //

-- 3. Stored Procedure untuk mencatat hasil test seleksi
CREATE PROCEDURE sp_catat_hasil_test(
    IN p_id_test INT,
    IN p_id_pendaftaran INT,
    IN p_nilai_test INT,
    IN p_tanggal_test DATE
)
BEGIN
    INSERT INTO test_seleksi (id_test, id_pendaftaran, nilai_test, tanggal_test)
    VALUES (p_id_test, p_id_pendaftaran, p_nilai_test, p_tanggal_test);
END //

-- 4. Stored Procedure untuk mencatat pembayaran
CREATE PROCEDURE sp_catat_pembayaran(
    IN p_id_pembayaran INT,
    IN p_id_pendaftaran INT,
    IN p_jumlah_bayar DECIMAL(10,2),
    IN p_tanggal_bayar DATE
)
BEGIN
    INSERT INTO pembayaran (id_pembayaran, id_pendaftaran, jumlah_bayar, tanggal_bayar)
    VALUES (p_id_pembayaran, p_id_pendaftaran, p_jumlah_bayar, p_tanggal_bayar);
END //

-- 5. Stored Procedure untuk mengupdate status pendaftaran
CREATE PROCEDURE sp_update_status_pendaftaran(
    IN p_id_pendaftaran INT,
    IN p_status VARCHAR(50)
)
BEGIN
    UPDATE pendaftaran
    SET status = p_status
    WHERE id_pendaftaran = p_id_pendaftaran;
END //

-- 6. Stored Procedure untuk menampilkan data calon siswa beserta nilai ujian dan prestasi
CREATE PROCEDURE sp_tampil_data_calon_siswa()
BEGIN
    SELECT cs.id_calon_siswa, cs.nama, cs.tanggal_lahir, dcs.nilai_ujian, dcs.prestasi
    FROM calon_siswa cs
    JOIN data_calon_siswa dcs ON cs.id_calon_siswa = dcs.id_calon_siswa;
END //

-- 7. Stored Procedure untuk menampilkan data test seleksi untuk pendaftaran yang diterima
CREATE PROCEDURE sp_tampil_hasil_test_diterima()
BEGIN
    SELECT ts.id_test, cs.nama, ts.nilai_test, ts.tanggal_test
    FROM test_seleksi ts
    JOIN pendaftaran p ON ts.id_pendaftaran = p.id_pendaftaran
    JOIN calon_siswa cs ON p.id_calon_siswa = cs.id_calon_siswa
    WHERE p.status = 'Diterima';
END //

-- 8. Stored Procedure untuk menghitung jumlah pendaftaran per status
CREATE PROCEDURE sp_hitung_pendaftaran_per_status()
BEGIN
    SELECT status, COUNT(*) as jumlah_pendaftaran
    FROM pendaftaran
    GROUP BY status;
END //

-- 9. Stored Procedure untuk menampilkan calon siswa dengan nilai test di atas rata-rata
CREATE PROCEDURE sp_calon_siswa_nilai_diatas_rata_rata()
BEGIN
    SELECT cs.nama, ts.nilai_test
    FROM calon_siswa cs
    JOIN pendaftaran p ON cs.id_calon_siswa = p.id_calon_siswa
    JOIN test_seleksi ts ON p.id_pendaftaran = ts.id_pendaftaran
    WHERE ts.nilai_test > (SELECT AVG(nilai_test) FROM test_seleksi);
END //

DELIMITER ;

-- Contoh penggunaan Stored Procedure:
CALL sp_tambah_calon_siswa(3, 'Alice Johnson', '2006-08-10');
CALL sp_daftar_calon_siswa(3, 3, '2024-01-17', 'Dalam Proses');
CALL sp_catat_hasil_test(3, 3, 87, '2024-02-02');
CALL sp_catat_pembayaran(3, 3, 5000000.00, '2024-02-17');
CALL sp_update_status_pendaftaran(3, 'Diterima');
CALL sp_tampil_data_calon_siswa();
CALL sp_tampil_hasil_test_diterima();
CALL sp_hitung_pendaftaran_per_status();
CALL sp_calon_siswa_nilai_diatas_rata_rata();