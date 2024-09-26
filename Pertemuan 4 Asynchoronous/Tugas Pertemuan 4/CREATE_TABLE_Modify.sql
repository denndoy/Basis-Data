CREATE TABLE `users` (
	`users_id` INTEGER AUTO_INCREMENT,
	`username` VARCHAR(50) NOT NULL UNIQUE,
	`password` VARCHAR(50) NOT NULL,
	`email` VARCHAR(100) NOT NULL UNIQUE,
	`full_name` VARCHAR(100) NOT NULL,
	`birth` DATE,
	PRIMARY KEY(`users_id`)
);


CREATE TABLE `children` (
	`child_id` INTEGER AUTO_INCREMENT,
	`users_id` INTEGER,
	`child_name` VARCHAR(100) NOT NULL,
	`birth` DATE,
	PRIMARY KEY(`child_id`)
);


CREATE TABLE `schedules` (
	`schedule_id` INTEGER AUTO_INCREMENT,
	`users_id` INTEGER,
	`title` VARCHAR(100) NOT NULL,
	`description` TEXT,
	`date` DATE NOT NULL,
	`start_time` DATETIME NOT NULL,
	`end_time` DATETIME NOT NULL,
	`is_work` BOOLEAN DEFAULT false,
	`is_family` BOOLEAN DEFAULT false,
	`is_personal` BOOLEAN DEFAULT false,
	PRIMARY KEY(`schedule_id`)
);


CREATE TABLE `meals` (
	`meal_id` INTEGER AUTO_INCREMENT,
	`meal_name` VARCHAR(100) NOT NULL,
	`description` TEXT,
	`calories` INTEGER,
	`is_child_friendly` BOOLEAN DEFAULT false,
	PRIMARY KEY(`meal_id`)
);


CREATE TABLE `meal_plans` (
	`plan_id` INTEGER AUTO_INCREMENT,
	`users_id` INTEGER,
	`meal_id` INTEGER,
	`planned_date` DATE NOT NULL,
	`meal_type` ENUM NOT NULL,
	PRIMARY KEY(`plan_id`)
);


CREATE TABLE `activities` (
	`activity_id` INTEGER AUTO_INCREMENT,
	`users_id` INTEGER,
	`activity_type` VARCHAR(50) NOT NULL,
	`duration` INTEGER NOT NULL,
	`calories_burned` INTEGER,
	`date` DATE NOT NULL,
	PRIMARY KEY(`activity_id`)
);


CREATE TABLE `goals` (
	`goal_id` INTEGER AUTO_INCREMENT,
	`users_id` INTEGER,
	`title` VARCHAR(100) NOT NULL,
	`description` TEXT,
	`target_date` DATE,
	`is_completed` BOOLEAN DEFAULT false,
	PRIMARY KEY(`goal_id`)
);


ALTER TABLE `children`
ADD FOREIGN KEY(`users_id`) REFERENCES `users`(`users_id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `schedules`
ADD FOREIGN KEY(`users_id`) REFERENCES `users`(`users_id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `meal_plans`
ADD FOREIGN KEY(`users_id`) REFERENCES `users`(`users_id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `meal_plans`
ADD FOREIGN KEY(`meal_id`) REFERENCES `meals`(`meal_id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `activities`
ADD FOREIGN KEY(`users_id`) REFERENCES `users`(`users_id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `goals`
ADD FOREIGN KEY(`users_id`) REFERENCES `users`(`users_id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;