-- FitTrack Pro Database Schema

-- Initial SQLite setup
.open fittrackpro.db
.mode column

-- Enable foreign key support
PRAGMA foreign_key = ON; 

-- Drop Tables if exists
DROP TABLE IF EXISTS locations;
DROP TABLE IF EXISTS members;
DROP TABLE IF EXISTS staff;
DROP TABLE IF EXISTS equipment;
DROP TABLE IF EXISTS classes;
DROP TABLE IF EXISTS class_schedule;
DROP TABLE IF EXISTS memberships;
DROP TABLE IF EXISTS attendance;
DROP TABLE IF EXISTS class_attendance;
DROP TABLE IF EXISTS payments;
DROP TABLE IF EXISTS personal_training_sessions;
DROP TABLE IF EXISTS member_health_metrics;
DROP TABLE IF EXISTS equipment_maintenance_log;

-- TODO: Create the following tables:
-- 1. locations
CREATE TABLE locations (
    location_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(255) NOT NULL CHECK (length(name) >= 5),
    address VARCHAR(255) NOT NULL CHECK (length(address) >= 10),
    phone_number VARCHAR(20) NOT NULL CHECK (length(phone_number) >= 8),
    email VARCHAR(255) NOT NULL CHECK (email LIKE '%_@__%.__%'), -- Could be done at application level instead of backend
    opening_hours VARCHAR(255) NOT NULL CHECK (length(opening_hours)>=10)
);


-- 2. members
CREATE TABLE members (
    member_id INTEGER PRIMARY KEY AUTOINCREMENT,
    first_name VARCHAR(255) NOT NULL CHECK (length(first_name) >= 2),
    last_name VARCHAR(255) NOT NULL CHECK (length(last_name) >= 2),
    email VARCHAR(255) NOT NULL CHECK (email LIKE '%_@__%.__%'),
    phone_number VARCHAR(20) NOT NULL CHECK (length(phone_number) >= 8),
    date_of_birth DATE NOT NULL,
    join_date DATE NOT NULL DEFAULT CURRENT_DATE, -- Could be a good default value however may not be appropiate
    emergency_contact_name VARCHAR(255) NOT NULL CHECK (length(emergency_contact_name) >= 3),
    emergency_contact_phone VARCHAR(20) NOT NULL CHECK (length(emergency_contact_phone) >= 8)
);

-- 3. staff
CREATE TABLE staff (
    staff_id INTEGER PRIMARY KEY AUTOINCREMENT ,
    first_name VARCHAR(255) NOT NULL CHECK (length(first_name) >= 2),
    last_name VARCHAR(255) NOT NULL CHECK (length(last_name) >= 2),
    email VARCHAR(255) NOT NULL CHECK (email LIKE '%_@__%.__%'), -- Could be done at application level instead of backend
    phone_number VARCHAR(20) NOT NULL CHECK (length(phone_number) >= 8),
    position VARCHAR(255) NOT NULL CHECK(position IN ('Trainer', 'Manager', 'Receptionist', 'Maintenance')),
    hire_date DATE NOT NULL,
    location_id INTEGER NOT NULL CHECK (location_id IN ('1','2')),
    FOREIGN KEY (location_id) REFERENCES locations(location_id)
);
 
-- 4. equipment
CREATE TABLE equipment (
    equipment_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(255) NOT NULL CHECK (length(name) >= 5),
    type VARCHAR(255) NOT NULL CHECK (type IN ('Cardio', 'Strength')),
    purchase_date DATE NOT NULL,
    last_maintenance_date DATE NOT NULL,
    next_maintenance_date DATE NOT NULL,
    location_id INTEGER NOT NULL CHECK (location_id IN ('1','2')),
    FOREIGN KEY (location_id) REFERENCES locations(location_id)
);

-- 5. classes
CREATE TABLE classes (
    class_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(255) NOT NULL CHECK (length(name) >= 5),
    description VARCHAR(255) NOT NULL CHECK(length(description) > 5),
    capacity INTEGER NOT NULL CHECK (capacity > 0),  
    duration INTEGER NOT NULL CHECK (duration > 0),
    location_id INTEGER NOT NULL CHECK (location_id IN ('1','2')),
    FOREIGN KEY (location_id) REFERENCES locations(location_id)
);

-- 6. class_schedule
CREATE TABLE class_schedule (
    schedule_id INTEGER PRIMARY KEY AUTOINCREMENT,
    class_id INTEGER NOT NULL CHECK(class_id > 0),
    staff_id INTEGER NOT NULL CHECK(staff_id > 0),
    start_time DATETIME NOT NULL,
    end_time DATETIME NOT NULL,
    FOREIGN KEY (class_id) REFERENCES classes(class_id),
    FOREIGN KEY (staff_id) REFERENCES staff(staff_id)
);

-- 7. memberships
CREATE TABLE memberships (
    membership_id INTEGER PRIMARY KEY AUTOINCREMENT,
    member_id INTEGER NOT NULL CHECK(member_id > 0),
    type VARCHAR(255) NOT NULL CHECK(type IN ('Basic', 'Premium')),
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    status VARCHAR(255) NOT NULL DEFAULT 'Active' CHECK(status IN ('Active', 'Inactive')),
    FOREIGN KEY (member_id) REFERENCES members(member_id)
);

-- 8. attendance
CREATE TABLE attendance (
    attendance_id INTEGER PRIMARY KEY AUTOINCREMENT,
    member_id INTEGER NOT NULL CHECK(member_id > 0),
    location_id INTEGER NOT NULL CHECK(location_id > 0), 
    check_in_time DATETIME,
    check_out_time DATETIME,
    FOREIGN KEY (member_id) REFERENCES members(member_id),
    FOREIGN KEY (location_id) REFERENCES locations(location_id)
);

-- 9. class_attendance
CREATE TABLE class_attendance (
    class_attendance_id INTEGER PRIMARY KEY AUTOINCREMENT,
    schedule_id INTEGER NOT NULL CHECK(schedule_id > 0),
    member_id INTEGER NOT NULL CHECK(member_id > 0),
    attendance_status VARCHAR(255) NOT NULL CHECK(attendance_status IN ('Registered', 'Attended', 'Unattended')),
    FOREIGN KEY (schedule_id) REFERENCES class_schedule(schedule_id),
    FOREIGN KEY (member_id) REFERENCES members(member_id)
);

-- 10. payments
CREATE TABLE payments (
    payment_id INTEGER PRIMARY KEY AUTOINCREMENT,
    member_id INTEGER NOT NULL CHECK(member_id > 0),
    amount DECIMAL(10, 2) NOT NULL,
    payment_date DATETIME NOT NULL,
    payment_method VARCHAR(255) NOT NULL CHECK(payment_method IN ('Credit Card', 'Bank Transfer', 'PayPal', 'Cash')),
    payment_type VARCHAR(255) NOT NULL CHECK(payment_type IN ('Monthly membership fee', 'Day pass')),
    FOREIGN KEY (member_id) REFERENCES members(member_id)
);

-- 11. personal_training_sessions
CREATE TABLE personal_training_sessions (
    session_id INTEGER PRIMARY KEY AUTOINCREMENT,
    member_id INTEGER NOT NULL CHECK(member_id > 0),
    staff_id INTEGER NOT NULL CHECK(staff_id > 0),
    session_date DATE NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    notes TEXT NOT NULL, -- COULD BE VARCHAR OR TEXT, although text seemed more appropaite
    FOREIGN KEY (member_id) REFERENCES members(member_id),
    FOREIGN KEY (staff_id) REFERENCES staff(staff_id)
);

-- 12. member_health_metrics
CREATE TABLE member_health_metrics (
    metric_id INTEGER PRIMARY KEY AUTOINCREMENT,
    member_id INTEGER NOT NULL CHECK(member_id > 0),
    measurement_date DATE NOT NULL,
    weight DECIMAL(5, 2) NOT NULL,
    body_fat_percentage DECIMAL(5, 2) NOT NULL,
    muscle_mass DECIMAL(5, 2) NOT NULL,
    bmi DECIMAL(5, 2) NOT NULL,
    FOREIGN KEY (member_id) REFERENCES members(member_id)
);

-- 13. equipment_maintenance_log
CREATE TABLE equipment_maintenance_log (
    log_id INTEGER PRIMARY KEY AUTOINCREMENT,
    equipment_id INTEGER NOT NULL CHECK(equipment_id > 0),
    maintenance_date DATE NOT NULL,
    description TEXT NOT NULL, -- COULD BE VARCHAR OR TEXT, although text seemed more appropiatee
    staff_id INTEGER NOT NULL CHECK(staff_id > 0),
    FOREIGN KEY (equipment_id) REFERENCES equipment(equipment_id),
    FOREIGN KEY (staff_id) REFERENCES staff(staff_id)
);

-- After creating the tables, you can import the sample data using:
-- `.read data/sample_data.sql` in a sql file or `npm run import` in the terminal