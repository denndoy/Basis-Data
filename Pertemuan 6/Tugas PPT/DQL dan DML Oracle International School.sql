-- 1. INSERT: Menambahkan data ke tabel calon_siswa
INSERT INTO calon_siswa (id_calon_siswa, nama, tanggal_lahir)
VALUES (1, 'John Doe', '2005-05-15'),
       (2, 'Jane Smith', '2006-03-20');

-- 2. INSERT: Menambahkan data ke tabel data_calon_siswa
INSERT INTO data_calon_siswa (id_data_calon_siswa, id_calon_siswa, nilai_ujian, prestasi)
VALUES (1, 1, 85, 'Juara 1 Olimpiade Matematika'),
       (2, 2, 90, 'Juara 2 Lomba Karya Ilmiah');

-- 3. INSERT: Menambahkan data ke tabel pendaftaran
INSERT INTO pendaftaran (id_pendaftaran, id_calon_siswa, tanggal_pendaftaran, status)
VALUES (1, 1, '2024-01-15', 'Diterima'),
       (2, 2, '2024-01-16', 'Dalam Proses');

-- 4. INSERT: Menambahkan data ke tabel test_seleksi
INSERT INTO test_seleksi (id_test, id_pendaftaran, nilai_test, tanggal_test)
VALUES (1, 1, 88, '2024-02-01'),
       (2, 2, 92, '2024-02-01');

-- 5. INSERT: Menambahkan data ke tabel pembayaran
INSERT INTO pembayaran (id_pembayaran, id_pendaftaran, jumlah_bayar, tanggal_bayar)
VALUES (1, 1, 5000000.00, '2024-02-15'),
       (2, 2, 5000000.00, '2024-02-16');

-- 6. UPDATE: Mengubah status pendaftaran
UPDATE pendaftaran
SET status = 'Diterima'
WHERE id_pendaftaran = 2;

-- 7. UPDATE: Mengubah nilai ujian calon siswa
UPDATE data_calon_siswa
SET nilai_ujian = 95
WHERE id_calon_siswa = 2;

-- 8. DELETE: Menghapus data pembayaran (contoh saja, hati-hati dalam penggunaan DELETE)
DELETE FROM pembayaran
WHERE id_pembayaran = 2;

-- DQL (Data Query Language)

-- 9. SELECT: Menampilkan semua data calon siswa
SELECT * FROM calon_siswa;

-- 10. SELECT dengan JOIN: Menampilkan data calon siswa beserta nilai ujian dan prestasi
SELECT cs.id_calon_siswa, cs.nama, cs.tanggal_lahir, dcs.nilai_ujian, dcs.prestasi
FROM calon_siswa cs
JOIN data_calon_siswa dcs ON cs.id_calon_siswa = dcs.id_calon_siswa;

-- 11. SELECT dengan WHERE: Menampilkan pendaftaran dengan status 'Diterima'
SELECT * FROM pendaftaran WHERE status = 'Diterima';

-- 12. SELECT dengan JOIN dan WHERE: Menampilkan data test seleksi untuk pendaftaran yang diterima
SELECT ts.id_test, cs.nama, ts.nilai_test, ts.tanggal_test
FROM test_seleksi ts
JOIN pendaftaran p ON ts.id_pendaftaran = p.id_pendaftaran
JOIN calon_siswa cs ON p.id_calon_siswa = cs.id_calon_siswa
WHERE p.status = 'Diterima';

-- 13. SELECT dengan GROUP BY dan agregasi: Menghitung jumlah pendaftaran per status
SELECT status, COUNT(*) as jumlah_pendaftaran
FROM pendaftaran
GROUP BY status;

-- 14. SELECT dengan subquery: Menampilkan calon siswa dengan nilai test di atas rata-rata
SELECT cs.nama, ts.nilai_test
FROM calon_siswa cs
JOIN pendaftaran p ON cs.id_calon_siswa = p.id_calon_siswa
JOIN test_seleksi ts ON p.id_pendaftaran = ts.id_pendaftaran
WHERE ts.nilai_test > (SELECT AVG(nilai_test) FROM test_seleksi);

-- 15. SELECT dengan ORDER BY: Menampilkan pembayaran diurutkan berdasarkan tanggal
SELECT p.id_pembayaran, cs.nama, p.jumlah_bayar, p.tanggal_bayar
FROM pembayaran p
JOIN pendaftaran pn ON p.id_pendaftaran = pn.id_pendaftaran
JOIN calon_siswa cs ON pn.id_calon_siswa = cs.id_calon_siswa
ORDER BY p.tanggal_bayar DESC;