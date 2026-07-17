-- NESA database for our ALU Kigali school system project
-- Group 16

-- Normalization note (we discussed this as a group):
-- Each table only stores info about one thing. Students has student details,
-- Classroom has rooms, Faculty has lecturers, Courses has courses, and
-- Extra_Curricular_Activities has clubs/activities. We use faculty_id and
-- classroom_id on Courses so we don't repeat lecturer or room names.
-- Students can take many courses and join many activities, so we added
-- Student_Courses and Student_Activities as junction tables instead of
-- stuffing lots of IDs into one row.

DROP DATABASE IF EXISTS NESA;
CREATE DATABASE NESA;
USE NESA;


-- Students table (Joshua)
CREATE TABLE Students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    date_of_birth DATE NOT NULL,
    phone VARCHAR(20),
    gender ENUM('Male', 'Female', 'Other') NOT NULL
);


-- sample data (Rwandan names, ALU Kigali vibe)

INSERT INTO Students (student_id, first_name, last_name, email, date_of_birth, phone, gender) VALUES
(1, 'Aline', 'Uwimana', 'aline.uwimana@alustudent.com', '2005-01-10', '+250788100001', 'Female'),
(2, 'Patrick', 'Niyonzima', 'patrick.niyonzima@alustudent.com', '2004-05-15', '+250788100002', 'Male'),
(3, 'Claudine', 'Mukamana', 'claudine.mukamana@alustudent.com', '2005-03-20', '+250788100003', 'Female'),
(4, 'Eric', 'Habimana', 'eric.habimana@alustudent.com', '2004-09-12', '+250788100004', 'Male'),
(5, 'Diane', 'Iradukunda', 'diane.iradukunda@alustudent.com', '2005-11-30', '+250788100005', 'Female'),
(6, 'Jean Paul', 'Bizimana', 'jp.bizimana@alustudent.com', '2004-07-08', '+250788100006', 'Male');


-- individual UPDATE / DELETE / SELECT

-- Joshua
UPDATE Students
SET email = 'aline.uwimana@student.alueducation.com'
WHERE student_id = 1;

SELECT student_id, first_name, last_name, email
FROM Students
WHERE last_name = 'Uwimana';

-- deletes (do junction / child rows first so FKs don't break)
DELETE FROM Students WHERE student_id = 6;
