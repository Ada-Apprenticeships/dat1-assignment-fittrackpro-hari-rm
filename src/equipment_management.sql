-- Initial SQLite setup
.open fittrackpro.db
.mode column

-- Enable foreign key support
PRAGMA foreign_key = ON; 

-- Equipment Management Queries
-- 1. Find equipment due for maintenance
-- TODO: Write a query to find equipment due for maintenance
-- equipment_id | name | next_maintenance_date
SELECT equipment_id,
       name,
       next_maintenance_date
FROM equipment
WHERE next_maintenance_date
BETWEEN date('now') AND date('now', '+30 days');

-- 2. Count equipment types in stock
-- TODO: Write a query to count equipment types in stock
-- equipment_type | count
SELECT type as equipment_type,
       COUNT(*) as count
FROM equipment
GROUP BY equipment_type;

-- 3. Calculate average age of equipment by type (in days)
-- TODO: Write a query to calculate average age of equipment by type (in days)
-- equipment_type | avg_age_days
SELECT type as equipment_type,
       ROUND(AVG(julianday('now') - julianday(purchase_date)), 0) as avg_age_days
FROM equipment
GROUP by equipment_type;
