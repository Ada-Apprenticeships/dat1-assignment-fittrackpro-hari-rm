-- FitTrack Pro Database Schema

-- Initial SQLite setup
.open fittrackpro.db
.mode column

-- Enable foreign key support
PRAGMA foreign_keys = ON; 

-- Drop Tables if exists
DROP TABLE IF EXISTS locations;
DROP TABLE IF EXISTS members;
/*DROP TABLE IF EXISTS staff;
DROP TABLE IF EXISTS equipment;
DROP TABLE IF EXISTS classes;
DROP TABLE IF EXISTS class_schedule;
DROP TABLE IF EXISTS memberships;
DROP TABLE IF EXISTS attendance;
DROP TABLE IF EXISTS class_attendance;
DROP TABLE IF EXISTS payments;
DROP TABLE IF EXISTS personal_training_sessions;
DROP TABLE IF EXISTS member_health_metrics;
DROP TABLE IF EXISTS equipment_maintenance_log;*/

-- Create your tables here
-- Example:
-- CREATE TABLE table_name (
--     column1 datatype,
--     column2 datatype,
--     ...
-- );

-- TODO: Create the following tables:
-- 1. locations
CREATE TABLE locations (
    location_id INTEGER PRIMARY KEY AUTOINCREMENT, 
    name VARCHAR(255) NOT NULL CHECK(length(name) >= 2), 
    address VARCHAR(255) NOT NULL CHECK(length(address) >= 15),
    phone_number VARCHAR(255) NOT NULL CHECK(length(phone_number) >= 8),
    email VARCHAR(255) NOT NULL CHECK(length(email) >= 5),
    opening_hours VARCHAR(255) NOT NULL CHECK (length(opening_hours) >= 10)
); 


-- 2. members
CREATE TABLE members (
    member_id INTEGER PRIMARY KEY AUTOINCREMENT, 
    first_name VARCHAR(255) NOT NULL CHECK(length(first_name) >= 2), 
    last_name VARCHAR(255) NOT NULL CHECK(length(last_name) >= 2), 
    email VARCHAR(255) NOT NULL CHECK(length(email) >= 5),
    phone_number VARCHAR(255) NOT NULL CHECK(length(phone_number) >= 8),
    date_of_birth VARCHAR(255) NOT NULL CHECK(length(date_of_birth) >= 8),
    join_date VARCHAR(255) NOT NULL CHECK(length(join_date) >= 8),
    emergency_contact_name VARCHAR(255) NOT NULL CHECK(length(emergency_contact_name) >= 2), 
    emergency_contact_phone VARCHAR(255) NOT NULL CHECK(length(emergency_contact_phone) >= 8)
); 

INSERT INTO members (first_name, last_name, email, phone_number, date_of_birth, join_date, emergency_contact_name, emergency_contact_phone)
VALUES 
('Alice', 'Johnson', 'alice.j@email.com', '555-1111', '1990-05-15', '2024-11-10', 'Bob Johnson', '555-1112'),
('Bob', 'Smith', 'bob.s@email.com', '555-2222', '1985-09-22', '2024-12-15', 'Alice Smith', '555-2223'),
('Carol', 'Williams', 'carol.w@email.com', '555-3333', '1992-12-03', '2025-01-20', 'David Williams', '555-3334'),
('David', 'Brown', 'david.b@email.com', '555-4444', '1988-07-30', '2024-11-25', 'Emily Brown', '555-4445'),
('Emily', 'Jones', 'emily.j@email.com', '555-5555', '1995-03-12', '2024-12-30', 'Frank Jones', '555-5556'),
('Frank', 'Miller', 'frank.m@email.com', '555-6666', '1983-11-18', '2025-01-10', 'Grace Miller', '555-6667'),
('Grace', 'Davis', 'grace.d@email.com', '555-7777', '1993-01-25', '2024-11-20', 'Henry Davis', '555-7778'),
('Henry', 'Wilson', 'henry.w@email.com', '555-8888', '1987-08-05', '2024-12-15', 'Ivy Wilson', '555-8889'),
('Ivy', 'Moore', 'ivy.m@email.com', '555-9999', '1991-04-09', '2025-01-01', 'Jack Moore', '555-9990'),
('Jack', 'Taylor', 'jack.t@email.com', '555-0000', '1986-06-28', '2024-11-12', 'Kelly Taylor', '555-0001'),
('Karen', 'Lee', 'karen.l@email.com', '555-1313', '1989-02-14', '2024-12-05', 'Liam Lee', '555-1314'),
('Liam', 'Anderson', 'liam.a@email.com', '555-1515', '1994-07-19', '2025-01-01', 'Mia Anderson', '555-1516'),
('Mia', 'Thomas', 'mia.t@email.com', '555-1717', '1991-11-30', '2025-01-10', 'Noah Thomas', '555-1718'),
('Noah', 'Roberts', 'noah.r@email.com', '555-1919', '1987-04-25', '2025-01-15', 'Olivia Roberts', '555-1920'),
('Olivia', 'Clark', 'olivia.c@email.com', '555-2121', '1993-09-08', '2025-01-20', 'Peter Clark', '555-2122');

/*
-- 3. staff
CREATE TABLE staff (



); 
-- 4. equipment
CREATE TABLE equipment (



); 
-- 5. classes
CREATE TABLE classes (



); 
-- 6. class_schedule
CREATE TABLE class_schedule (



); 
-- 7. memberships
CREATE TABLE memberships (



); 
-- 8. attendance
CREATE TABLE attendance (



); 
-- 9. class_attendance
CREATE TABLE class_attendance (



); 
-- 10. payments
CREATE TABLE payments (



); 
-- 11. personal_training_sessions
CREATE TABLE personal_training_sessions (



); 
-- 12. member_health_metrics
CREATE TABLE member_health_metrics (



); 
-- 13. equipment_maintenance_log
CREATE TABLE equipment_maintenance_log (



); 

-- After creating the tables, you can import the sample data using:
-- `.read data/sample_data.sql` in a sql file or `npm run import` in the terminal
*/