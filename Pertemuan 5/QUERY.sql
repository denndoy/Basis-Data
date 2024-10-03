SELECT * FROM dosen;

SELECT * FROM dosen
WHERE Nip = '0429038801';

INSERT INTO dosen (Nip, Nama_Dosen) VALUES ('0429038801', 'Mariana S.Kom. MMSI.');

INSERT INTO mahasiswa (Nim, Nama_Mhs, Tgl_Lahir, Alamat, Jenis_Kelamin, IPK) 
VALUES ('202307001', 'Budi', '1999-09-15', 'Jakarta', 'Laki-laki', 3.75);
INSERT INTO mahasiswa (Nim, Nama_Mhs, Tgl_Lahir, Alamat, Jenis_Kelamin, IPK) 
VALUES ('202307002', 'Alfaris', '2003-06-13', 'Jakarta', 'Laki-laki', 2.56);

INSERT INTO matakuliah (Kode_MK, Nama_MK, Sks) 
VALUES ('INF001', 'Basis Data', 3);
INSERT INTO matakuliah (Kode_MK, Nama_MK, Sks) 
VALUES ('INF002', 'Arsitektur Perilaku', 2);
INSERT INTO matakuliah (Kode_MK, Nama_MK, Sks) 
VALUES ('INF003', 'Komputasi WEB', 3);
INSERT INTO matakuliah (Kode_MK, Nama_MK, Sks) 
VALUES ('INF004', 'Sistem Operasi', 3);
INSERT INTO matakuliah (Kode_MK, Nama_MK, Sks) 
VALUES ('INF005', 'Kalkulus', 3);


INSERT INTO perkuliahan (Nim, Kode_MK, Nip, Kehadiran, Nilai_Bobot, Nilai_Angka, Poin) 
VALUES ('202307001', 'INF001', '0429038801', 90, 'A', 93.59, '4');
INSERT INTO perkuliahan (Nim, Kode_MK, Nip, Kehadiran, Nilai_Bobot, Nilai_Angka, Poin) 
VALUES ('202307002', 'INF002', '0429038801', 50, 'B', 88.59, '3');
INSERT INTO perkuliahan (Nim, Kode_MK, Nip, Kehadiran, Nilai_Bobot, Nilai_Angka, Poin) 
VALUES ('202307002', 'INF003', '0429038801', 75, 'C', 90, '4');
INSERT INTO perkuliahan (Nim, Kode_MK, Nip, Kehadiran, Nilai_Bobot, Nilai_Angka, Poin) 
VALUES ('202307002', 'INF004', '0429038801', 70, 'D', 85, '4');
INSERT INTO perkuliahan (Nim, Kode_MK, Nip, Kehadiran, Nilai_Bobot, Nilai_Angka, Poin) 
VALUES ('202307002', 'INF005', '0429038801', 80, 'C', 75, '4');

UPDATE dosen
SET Nama_Dosen = 'Nurita S.Kom. MMSI.'
WHERE Nip = '0429038801';

UPDATE mahasiswa
SET IPK = 3.80
WHERE Nim = '202307001';

DELETE FROM dosen
WHERE Nip = '0429038801';

DELETE FROM mahasiswa
WHERE Nim = '202307001';

-- Kehadiran < 75% maka Nilai_Angka dikurangi 35%
UPDATE perkuliahan
SET Nilai_Angka = Nilai_Angka * 0.65
WHERE Kehadiran < 75;

-- Mengisi kolom Nilai_Bobot berdasarkan Nilai_Angka
UPDATE perkuliahan
SET Nilai_Bobot = CASE
  WHEN Nilai_Angka BETWEEN 91 AND 100 THEN 'A'
  WHEN Nilai_Angka BETWEEN 81 AND 90 THEN 'B'
  WHEN Nilai_Angka BETWEEN 71 AND 80 THEN 'C'
  WHEN Nilai_Angka BETWEEN 61 AND 70 THEN 'D'
  ELSE 'E'
END;

-- Rumus menghitung IPK
SELECT SUM(Sks * Poin) / SUM(Sks) AS IPK
FROM perkuliahan
JOIN matakuliah ON perkuliahan.Kode_MK = matakuliah.Kode_MK
WHERE Nim = '202307001';

-- Alter tabel mahasiswa menambahkan kolom
ALTER TABLE mahasiswa ADD COLUMN Email VARCHAR(50);

-- SP untuk menambah dosen
DELIMITER $$
CREATE PROCEDURE SP_Tambah_Dosen (IN Nip_dosen VARCHAR(12), IN Nama_dosen VARCHAR(25))
BEGIN
  INSERT INTO dosen (Nip, Nama_Dosen) VALUES (Nip_dosen, Nama_dosen);
END$$
DELIMITER ;

-- SP untuk update dosen
DELIMITER $$
CREATE PROCEDURE SP_Update_Dosen (IN Nip_dosen VARCHAR(12), IN Nama_dosen VARCHAR(25))
BEGIN
  UPDATE dosen SET Nama_Dosen = Nama_dosen WHERE Nip = Nip_dosen;
END$$
DELIMITER ;

-- SP untuk delete dosen
DELIMITER $$
CREATE PROCEDURE SP_Delete_Dosen (IN Nip_dosen VARCHAR(12))
BEGIN
  DELETE FROM dosen WHERE Nip = Nip_dosen;
END$$
DELIMITER ;

select * from dosen;
select * from mahasiswa;
select * from matakuliah;
select * from perkuliahan;




