-- Initial SQLite setup
.open fittrackpro.db
.mode column

-- Enable foreign key support
PRAGMA foreign_key = ON; 
-- Membership Management Queries

-- 1. List all active memberships
-- TODO: Write a query to list all active memberships
-- member_id | first_name | last_name | membership_type | join_date
SELECT ms.member_id,
       m.first_name,
       m.last_name, 
       ms.type as membership_type, 
       m.join_date 
FROM memberships ms 
JOIN members m
ON ms.member_id = m.member_id
WHERE ms.status = 'Active';

-- 2. Calculate the average duration of gym visits for each membership type
-- TODO: Write a query to calculate the average duration of gym visits for each membership type
-- membership_type | avg_visit_duration_minutes
SELECT m.type AS membership_type, 
       AVG((strftime('%s', a.check_out_time) - strftime('%s', a.check_in_time)) / 60.0) AS avg_visit_duration_minutes
FROM memberships m
JOIN attendance a 
ON m.member_id = a.member_id
GROUP BY m.type;

-- 3. Identify members with expiring memberships this year
-- TODO: Write a query to identify members with expiring memberships this year
SELECT m.member_id, 
       m.first_name, 
       m.last_name, 
       m.email, 
       ms.end_date
FROM members m
JOIN memberships ms 
ON m.member_id = ms.member_id
WHERE ms.end_date BETWEEN date('now') AND date('now', '+1 year');