-- Initial SQLite setup
.open fittrackpro.db
.mode column

-- Enable foreign key support
PRAGMA foreign_key = ON; 
-- Staff Management Queries

-- 1. List all staff members by role
-- TODO: Write a query to list all staff members by role
-- staff_id | first_name | last_name | role
SELECT staff_id, 
       first_name,
       last_name,
       position AS role
FROM staff
ORDER BY position, 
         last_name, 
         first_name;

-- 2. Find trainers with one or more personal training session in the next 30 days
-- TODO: Write a query to find trainers with one or more personal training session in the next 30 days
-- trainer_id | trainer_name | session_count
SELECT s.staff_id AS trainer_id, 
       CONCAT(s.first_name, ' ', s.last_name) AS trainer_name, 
       COUNT(pts.session_id) AS session_count
FROM staff s
JOIN personal_training_sessions pts 
ON s.staff_id = pts.staff_id
WHERE s.position = 'Trainer' AND 
      pts.session_date BETWEEN date('now') AND date('now', '+30 days')
GROUP BY s.staff_id, s.first_name, s.last_name
ORDER BY session_count DESC;