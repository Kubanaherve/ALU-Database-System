/*
================================================================================
  ALU Database System - Group 16
  Shared MySQL script for the NESA school database

  NORMALIZATION NOTE (Group discussion):
  Our schema is normalized to at least 3NF. Each entity table stores facts about
  one subject only: Students hold personal details, Classroom holds room details,
  Faculty hold lecturer details, Courses hold course details, and
  Extra_Curricular_Activities hold activity details. Course instructor and room
  are stored once via faculty_id and classroom_id foreign keys, so lecturer and
  room data are not repeated on every course row. The many-to-many links between
  students and courses, and between students and activities, are handled by the
  junction tables Student_Courses and Student_Activities. Those junctions store
  only foreign key pairs (plus a composite primary key), which avoids duplicating
  student or course/activity attributes and prevents the same enrollment or
  membership from being recorded twice.
================================================================================
*/

-- Recreate cleanly so the whole file can be re-run safely
DROP DATABASE IF EXISTS NESA;
CREATE DATABASE NESA;
USE NESA;


/* =============================================================================
   SECTION 1 - CREATE TABLES (dependency order)
   ============================================================================= */


/* Students - Member A: Joshua | Branch: students-joshua */
CREATE TABLE Students (
    student_id    INT AUTO_INCREMENT PRIMARY KEY,
    first_name    VARCHAR(50)  NOT NULL,
    last_name     VARCHAR(50)  NOT NULL,
    email         VARCHAR(100) NOT NULL UNIQUE,
    date_of_birth DATE         NOT NULL,
    phone         VARCHAR(20),
    gender        ENUM('Male', 'Female', 'Other') NOT NULL
);


/* Classroom - Member B: Cynthia | Branch: classroom-cynthia */
CREATE TABLE Classroom (
    classroom_id  INT AUTO_INCREMENT PRIMARY KEY,
    room_number   VARCHAR(10)  NOT NULL,
    building_name VARCHAR(50)  NOT NULL,
    capacity      INT          NOT NULL,
    floor         INT          NOT NULL,
    CONSTRAINT chk_classroom_capacity CHECK (capacity > 0)
);


/* Faculty (individual lecturers) - Member C: Rebecca | Branch: faculty-rebecca */
CREATE TABLE Faculty (
    faculty_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50)  NOT NULL,
    last_name  VARCHAR(50)  NOT NULL,
    email      VARCHAR(100) NOT NULL UNIQUE,
    department VARCHAR(100) NOT NULL,
    phone      VARCHAR(20),
    hire_date  DATE         NOT NULL
);


/* =============================================================================
   SECTION 2 - INSERT SAMPLE DATA (Rwandan / ALU Kigali examples)
   Six rows per base table: rows 1-5 power the joins; row 6 is deleted later
   and is never referenced by a foreign key that would block the DELETE.
   ============================================================================= */


/* Students - Joshua */
INSERT INTO Students
    (student_id, first_name, last_name, email, date_of_birth, phone, gender)
VALUES
(1, 'Aline',     'Uwimana',    'aline.uwimana@alustudent.com',     '2005-01-10', '+250788100001', 'Female'),
(2, 'Patrick',   'Niyonzima',  'patrick.niyonzima@alustudent.com', '2004-05-15', '+250788100002', 'Male'),
(3, 'Claudine',  'Mukamana',   'claudine.mukamana@alustudent.com', '2005-03-20', '+250788100003', 'Female'),
(4, 'Eric',      'Habimana',   'eric.habimana@alustudent.com',     '2004-09-12', '+250788100004', 'Male'),
(5, 'Diane',     'Iradukunda', 'diane.iradukunda@alustudent.com',  '2005-11-30', '+250788100005', 'Female'),
(6, 'Jean Paul', 'Bizimana',   'jp.bizimana@alustudent.com',       '2004-07-08', '+250788100006', 'Male');


/* Classroom - Cynthia (ALU Kigali campus style) */
INSERT INTO Classroom
    (classroom_id, room_number, building_name, capacity, floor)
VALUES
(1, 'A101', 'Innovation Building', 40, 1),
(2, 'A102', 'Innovation Building', 35, 1),
(3, 'B201', 'Leadership Building', 50, 2),
(4, 'C301', 'Science & Tech Hub',  60, 3),
(5, 'D401', 'Business Pavilion',   45, 4),
(6, 'E105', 'Student Commons',     30, 1);


/* Faculty - Rebecca (ALU Kigali lecturers) */
INSERT INTO Faculty
    (faculty_id, first_name, last_name, email, department, phone, hire_date)
VALUES
(1, 'Jean Bosco', 'Mutangana',  'j.mutangana@alueducation.com',  'Computer Science',           '+250788200001', '2018-02-01'),
(2, 'Aline',      'Uwase',      'a.uwase@alueducation.com',      'Entrepreneurial Leadership', '+250788200002', '2017-09-15'),
(3, 'Emmanuel',   'Nkurunziza', 'e.nkurunziza@alueducation.com', 'Data Science',               '+250788200003', '2019-01-20'),
(4, 'Chantal',    'Mukamana',   'c.mukamana@alueducation.com',   'Software Engineering',       '+250788200004', '2016-08-10'),
(5, 'Patrick',    'Habimana',   'p.habimana@alueducation.com',   'International Business',     '+250788200005', '2020-03-01'),
(6, 'Grace',      'Uwamahoro',  'g.uwamahoro@alueducation.com',  'Communication',              '+250788200006', '2021-05-12');


/* =============================================================================
   SECTION 3 - INDIVIDUAL DML
   ============================================================================= */

/* --- Joshua (Students) --- */
UPDATE Students
SET email = 'aline.uwimana@student.alueducation.com'
WHERE student_id = 1;

DELETE FROM Students
WHERE student_id = 6;

SELECT student_id, first_name, last_name, email
FROM Students
WHERE last_name = 'Uwimana';

/* --- Cynthia (Classroom) --- */
UPDATE Classroom
SET capacity = 55
WHERE classroom_id = 3;

DELETE FROM Classroom
WHERE classroom_id = 6;

SELECT classroom_id, room_number, building_name, capacity
FROM Classroom
WHERE capacity >= 40;

/* --- Rebecca (Faculty) --- */
UPDATE Faculty
SET department = 'Computer Science & Engineering'
WHERE faculty_id = 1;

DELETE FROM Faculty
WHERE faculty_id = 6;

SELECT faculty_id, first_name, last_name, department, email
FROM Faculty
WHERE department LIKE '%Science%';
