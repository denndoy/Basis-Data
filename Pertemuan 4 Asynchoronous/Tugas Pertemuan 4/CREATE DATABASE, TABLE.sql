CREATE DATABASE persona_ibu_maya;
USE persona_ibu_maya;

CREATE TABLE users (
	users_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    birth DATE
);

CREATE TABLE children (
	child_id INT PRIMARY KEY AUTO_INCREMENT,
    users_id INT,
    child_name VARCHAR(100) NOT NULL,
    birth DATE,
    FOREIGN KEY (users_id) REFERENCES users(users_id)
);

CREATE TABLE schedules (
	schedule_id INT PRIMARY KEY AUTO_INCREMENT,
    users_id INT,
    title VARCHAR(100) NOT NULL,
    deskripsi TEXT,
    tanggal DATE NOT NULL,
    start_time DATETIME NOT NULL,
    end_time DATETIME NOT NULL,
    is_work BOOLEAN DEFAULT FALSE,
    is_family BOOLEAN DEFAULT FALSE,
    is_personal BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (users_id) REFERENCES users(users_id)
);

CREATE TABLE meals (
	meal_id INT PRIMARY KEY AUTO_INCREMENT,
    meal_name VARCHAR(100) NOT NULL,
    deskripsi TEXT,
    kalori INT,
    is_child_friendly BOOLEAN DEFAULT FALSE
);

CREATE TABLE meal_plans (
	plan_id INT PRIMARY KEY AUTO_INCREMENT,
    users_id INT,
    meal_id INT,
    planned_date DATE NOT NULL,
    meal_type ENUM('Sarapan', 'Makan Siang', 'Makan Malam', 'Cemilan') NOT NULL,
    FOREIGN KEY (users_id) REFERENCES users(users_id),
    FOREIGN KEY (meal_id) REFERENCES meals(meal_id)
);

CREATE TABLE activities (
	activity_id INT PRIMARY KEY AUTO_INCREMENT,
    users_id INT,
    activity_type VARCHAR(50) NOT NULL,
    duration INT NOT NULL,
    kalori_terbakar INT,
    tanggal DATE NOT NULL,
    FOREIGN KEY (users_id) REFERENCES users(users_id)
);

CREATE TABLE goals (
	goal_id INT PRIMARY KEY AUTO_INCREMENT,
    users_id INT,
    title VARCHAR(100) NOT NULL,
    deskripsi TEXT,
    target_date DATE,
    is_completed BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (users_id) REFERENCES users(users_id)
);