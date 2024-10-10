-- Menambahkan lebih banyak data contoh
INSERT INTO ContohTipeData (id, nama, umur, tinggi_cm, berat_kg, tanggal_lahir, waktu_daftar, terakhir_login, aktif, bio, preferences, saldo_akun, rating, status_pesanan)
VALUES 
(2, 'Jane Smith', 28, 165.0, 55.5, '1996-08-20', '10:15:00', '2024-10-08 09:45:00', TRUE, 'Desainer grafis', '{"tema": "terang", "bahasa": "en"}', 750000, 4.9, 'Menunggu'),
(3, 'Bob Johnson', 35, 180.5, 82.1, '1989-03-10', '14:30:00', '2024-10-07 18:20:00', FALSE, 'Manajer proyek', '{"tema": "gelap", "bahasa": "fr"}', 1500000, 4.2, 'Dikirim'),
(4, 'Alice Brown', 22, 170.2, 58.7, '2002-11-30', '09:00:00', '2024-10-09 11:10:00', TRUE, 'Mahasiswa', '{"tema": "terang", "bahasa": "id"}', 250000, 4.5, 'Diproses'),
(5, 'Charlie Davis', 40, 178.0, 75.3, '1984-06-05', '11:45:00', '2024-10-06 20:30:00', TRUE, 'Pengacara', '{"tema": "gelap", "bahasa": "en"}', 2000000, 4.8, 'Selesai');

-- 1. Perintah SELECT dasar
SELECT nama, umur, tinggi_cm FROM ContohTipeData;

-- 2. Perintah WHERE
SELECT nama, saldo_akun FROM ContohTipeData WHERE saldo_akun > 1000000;

-- 3. Perintah ORDER BY
SELECT nama, rating FROM ContohTipeData ORDER BY rating DESC;

-- 4. Perintah GROUP BY
SELECT status_pesanan, COUNT(*) as jumlah FROM ContohTipeData GROUP BY status_pesanan;

-- 5. Kombinasi WHERE, ORDER BY, dan GROUP BY
SELECT status_pesanan, AVG(rating) as rata_rata_rating
FROM ContohTipeData
WHERE aktif = TRUE
GROUP BY status_pesanan
ORDER BY rata_rata_rating DESC;

-- 6. Menggunakan HAVING (filter setelah GROUP BY)
SELECT status_pesanan, AVG(saldo_akun) as rata_rata_saldo
FROM ContohTipeData
GROUP BY status_pesanan
HAVING rata_rata_saldo > 500000;

-- 7. Menggunakan LIMIT
SELECT nama, umur FROM ContohTipeData ORDER BY umur DESC LIMIT 3;

-- 8. Menggunakan DISTINCT
SELECT DISTINCT status_pesanan FROM ContohTipeData;

-- 9. Menggunakan fungsi agregasi
SELECT 
    MIN(umur) as umur_minimum,
    MAX(umur) as umur_maksimum,
    AVG(umur) as umur_rata_rata
FROM ContohTipeData;

-- 10. Menggunakan subquery
SELECT nama, umur
FROM ContohTipeData
WHERE umur > (SELECT AVG(umur) FROM ContohTipeData);