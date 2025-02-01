-- Initial SQLite setup
.open fittrackpro.db
.mode column

-- Enable foreign key support
PRAGMA foreign_key = ON; 
-- Attendance Tracking Queries

-- 1. Record a member's gym visit
-- TODO: Write a query to record a member's gym visit
INSERT INTO attendance (member_id, location_id, check_in_time)
VALUES (7, 1, datetime('now'));

-- 2. Retrieve a member's attendance history
-- TODO: Write a query to retrieve a member's attendance history
-- visit_date | check_in_time | check_out_time
SELECT DATE(check_in_time) AS visit_date, 
       check_in_time, 
       check_out_time
FROM attendance
WHERE member_id = 5
ORDER BY check_in_time;

-- 3. Find the busiest day of the week based on gym visits
-- TODO: Write a query to find the busiest day of the week based on gym visits
-- day_of_week | visit_count
-- Could use strftime('%w', check_in_time) AS day_of_week as a numerical output
SELECT 
    CASE strftime('%w', check_in_time)
        WHEN '0' THEN 'Sunday'
        WHEN '1' THEN 'Monday'
        WHEN '2' THEN 'Tuesday'
        WHEN '3' THEN 'Wednesday'
        WHEN '4' THEN 'Thursday'
        WHEN '5' THEN 'Friday'
        WHEN '6' THEN 'Saturday'
    END AS day_of_week, 
    COUNT(*) AS visit_count
FROM attendance
GROUP BY day_of_week
ORDER BY visit_count DESC
LIMIT 1;

-- 4. Calculate the average daily attendance for each location
-- TODO: Write a query to calculate the average daily attendance for each location
-- location_name | avg_daily_attendance
SELECT l.name AS location_name,
       AVG(daily_attendance) AS avg_daily_attendance
FROM (SELECT location_id, 
             DATE(check_in_time) AS visit_date, 
             COUNT(*) AS daily_attendance
      FROM attendance
      GROUP BY location_id, visit_date) AS daily_counts
JOIN locations l ON daily_counts.location_id = l.location_id
GROUP BY l.name;