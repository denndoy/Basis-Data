CREATE DATABASE persona_ibu_maya;
USE persona_ibu_maya;

CREATE TABLE `users` (
  `users_id` INT PRIMARY KEY AUTO_INCREMENT,
  `username` VARCHAR(50) UNIQUE NOT NULL,
  `password` VARCHAR(50) NOT NULL,
  `email` VARCHAR(100) UNIQUE NOT NULL,
  `full_name` VARCHAR(100) NOT NULL,
  `birth` DATE
);

CREATE TABLE `children` (
  `child_id` INT PRIMARY KEY AUTO_INCREMENT,
  `users_id` INT,
  `child_name` VARCHAR(100) NOT NULL,
  `birth` DATE
);

CREATE TABLE `schedules` (
  `schedule_id` INT PRIMARY KEY AUTO_INCREMENT,
  `users_id` INT,
  `title` VARCHAR(100) NOT NULL,
  `description` TEXT,
  `date` DATE NOT NULL,
  `start_time` DATETIME NOT NULL,
  `end_time` DATETIME NOT NULL,
  `is_work` BOOLEAN DEFAULT false,
  `is_family` BOOLEAN DEFAULT false,
  `is_personal` BOOLEAN DEFAULT false
);

CREATE TABLE `meals` (
  `meal_id` INT PRIMARY KEY AUTO_INCREMENT,
  `meal_name` VARCHAR(100) NOT NULL,
  `description` TEXT,
  `calories` INT,
  `is_child_friendly` BOOLEAN DEFAULT false
);

CREATE TABLE `meal_plans` (
  `plan_id` INT PRIMARY KEY AUTO_INCREMENT,
  `users_id` INT,
  `meal_id` INT,
  `planned_date` DATE NOT NULL,
  `meal_type` ENUM ('Sarapan', 'Makan Siang', 'Makan Malam', 'Cemilan') NOT NULL
);

CREATE TABLE `activities` (
  `activity_id` INT PRIMARY KEY AUTO_INCREMENT,
  `users_id` INT,
  `activity_type` VARCHAR(50) NOT NULL,
  `duration` INT NOT NULL,
  `calories_burned` INT,
  `date` DATE NOT NULL
);

CREATE TABLE `goals` (
  `goal_id` INT PRIMARY KEY AUTO_INCREMENT,
  `users_id` INT,
  `title` VARCHAR(100) NOT NULL,
  `description` TEXT,
  `target_date` DATE,
  `is_completed` BOOLEAN DEFAULT false
);

ALTER TABLE `children` ADD FOREIGN KEY (`users_id`) REFERENCES `users` (`users_id`);

ALTER TABLE `schedules` ADD FOREIGN KEY (`users_id`) REFERENCES `users` (`users_id`);

ALTER TABLE `meal_plans` ADD FOREIGN KEY (`users_id`) REFERENCES `users` (`users_id`);

ALTER TABLE `meal_plans` ADD FOREIGN KEY (`meal_id`) REFERENCES `meals` (`meal_id`);

ALTER TABLE `activities` ADD FOREIGN KEY (`users_id`) REFERENCES `users` (`users_id`);

ALTER TABLE `goals` ADD FOREIGN KEY (`users_id`) REFERENCES `users` (`users_id`);
