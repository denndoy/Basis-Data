CREATE VIEW daily_summary AS
SELECT
	u.users_id,
    u.full_name,
    s.date,
		COUNT(DISTINCT CASE WHEN s.is_work = TRUE THEN s.schedule_id END) AS work_activities,
		COUNT(DISTINCT CASE WHEN s.is_family = TRUE THEN s.schedule_id END) AS family_activities,
		COUNT(DISTINCT CASE WHEN s.is_personal = TRUE THEN s.schedule_id END) AS personal_activities,
		SUM(a.calories_burned) AS total_calories_burned,
		GROUP_CONCAT(DISTINCT m.meal_name ORDER BY mp.meal_type SEPARATOR ', ') AS meals_planned
FROM
	users u
LEFT JOIN schedules s ON u.users_id = s.users_id AND DATE(s.start_time) = CURDATE()
LEFT JOIN activities a ON u.users_id = a.users_id AND a.date = CURDATE()
LEFT JOIN meal_plans mp ON u.users_id = mp.users_id AND mp.planned_date = CURDATE()
LEFT JOIN meals m ON mp.meal_id = m.meal_id
GROUP BY 
    u.users_id, u.full_name, s.date;
    
DELIMITER $$
CREATE PROCEDURE create_schedule (
	IN p_users_id INT,
    IN p_title VARCHAR(100),
    IN p_deskripsi TEXT,
    IN p_start_time DATETIME,
    IN p_end_time DATETIME,
    IN p_is_work BOOLEAN,
    IN p_is_family BOOLEAN,
    IN p_is_personal BOOLEAN
)

BEGIN
	INSERT INTO schedules (users_id, title, deskripsi, start_time, end_time, is_work, is_family, is_personal)
    VALUES (p_users_id, p_title, p_deskripsi, p_start_time, p_end_time, p_is_work, p_is_family, p_is_personal);
END $$

CREATE PROCEDURE read_schedule(
    IN p_schedule_id INT
)
BEGIN
    SELECT * FROM schedules WHERE schedule_id = p_schedule_id;
END $$

CREATE PROCEDURE update_schedule(
    IN p_schedule_id INT,
    IN p_title VARCHAR(100),
    IN p_description TEXT,
    IN p_start_time DATETIME,
    IN p_end_time DATETIME,
    IN p_is_work BOOLEAN,
    IN p_is_family BOOLEAN,
    IN p_is_personal BOOLEAN
)
BEGIN
    UPDATE schedules
    SET title = p_title,
        description = p_description,
        start_time = p_start_time,
        end_time = p_end_time,
        is_work = p_is_work,
        is_family = p_is_family,
        is_personal = p_is_personal
    WHERE schedule_id = p_schedule_id;
END $$

CREATE PROCEDURE delete_schedule(
    IN p_schedule_id INT
)
BEGIN
    DELETE FROM schedules WHERE schedule_id = p_schedule_id;
END $$

DELIMITER ;