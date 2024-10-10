CREATE DATABASE oracleintschool;
USE oracleintschool;

CREATE TABLE calon_siswa (
    id_calon_siswa INT PRIMARY KEY,
    nama VARCHAR(100),
    tanggal_lahir DATE
);

CREATE TABLE data_calon_siswa (
    id_data_calon_siswa INT PRIMARY KEY,
    id_calon_siswa INT,
    nilai_ujian INT,
    prestasi VARCHAR(255),
    FOREIGN KEY (id_calon_siswa) REFERENCES calon_siswa(id_calon_siswa)
);

CREATE TABLE pendaftaran (
    id_pendaftaran INT PRIMARY KEY,
    id_calon_siswa INT,
    tanggal_pendaftaran DATE,
    status VARCHAR(50),
    FOREIGN KEY (id_calon_siswa) REFERENCES calon_siswa(id_calon_siswa)
);

CREATE TABLE test_seleksi (
    id_test INT PRIMARY KEY,
    id_pendaftaran INT,
    nilai_test INT,
    tanggal_test DATE,
    FOREIGN KEY (id_pendaftaran) REFERENCES pendaftaran(id_pendaftaran)
);

CREATE TABLE pembayaran (
    id_pembayaran INT PRIMARY KEY,
    id_pendaftaran INT,
    jumlah_bayar DECIMAL(10,2),
    tanggal_bayar DATE,
    FOREIGN KEY (id_pendaftaran) REFERENCES pendaftaran(id_pendaftaran)
);