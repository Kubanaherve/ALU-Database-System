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

-- Classroom table (Cynthia)
CREATE TABLE Classroom (
    classroom_id INT AUTO_INCREMENT PRIMARY KEY,
    room_number VARCHAR(10) NOT NULL,
    building_name VARCHAR(50) NOT NULL,
    capacity INT NOT NULL,
    floor INT NOT NULL
);

-- Faculty / lecturers (Rebecca)
CREATE TABLE Faculty (
    faculty_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    department VARCHAR(100) NOT NULL,
    phone VARCHAR(20),
    hire_date DATE NOT NULL
);

-- Courses needs Faculty and Classroom first (Sonia)
CREATE TABLE Courses (
    course_id INT AUTO_INCREMENT PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    course_code VARCHAR(20) NOT NULL UNIQUE,
    credits INT NOT NULL,
    faculty_id INT NOT NULL,
    classroom_id INT NOT NULL,
    FOREIGN KEY (faculty_id) REFERENCES Faculty(faculty_id),
    FOREIGN KEY (classroom_id) REFERENCES Classroom(classroom_id)
);


-- sample data (Rwandan names, ALU Kigali vibe)

INSERT INTO Students (student_id, first_name, last_name, email, date_of_birth, phone, gender) VALUES
(1, 'Aline', 'Uwimana', 'aline.uwimana@alustudent.com', '2005-01-10', '+250788100001', 'Female'),
(2, 'Patrick', 'Niyonzima', 'patrick.niyonzima@alustudent.com', '2004-05-15', '+250788100002', 'Male'),
(3, 'Claudine', 'Mukamana', 'claudine.mukamana@alustudent.com', '2005-03-20', '+250788100003', 'Female'),
(4, 'Eric', 'Habimana', 'eric.habimana@alustudent.com', '2004-09-12', '+250788100004', 'Male'),
(5, 'Diane', 'Iradukunda', 'diane.iradukunda@alustudent.com', '2005-11-30', '+250788100005', 'Female'),
(6, 'Jean Paul', 'Bizimana', 'jp.bizimana@alustudent.com', '2004-07-08', '+250788100006', 'Male');

INSERT INTO Classroom (classroom_id, room_number, building_name, capacity, floor) VALUES
(1, 'A101', 'Inyubako y''Ubuhanga', 40, 1),
(2, 'A102', 'Inyubako y''Ubuhanga', 35, 1),
(3, 'B201', 'Inyubako y''Ubuyobozi', 50, 2),
(4, 'C301', 'Ikigo cy''Ubumenyi', 60, 3),
(5, 'D401', 'Inyubako y''Ubucuruzi', 45, 4),
(6, 'E105', 'Aho Abanyeshuri Bahanira', 30, 1);

INSERT INTO Faculty (faculty_id, first_name, last_name, email, department, phone, hire_date) VALUES
(1, 'Jean Bosco', 'Mutangana', 'j.mutangana@alueducation.com', 'Computer Science', '+250788200001', '2018-02-01'),
(2, 'Aline', 'Uwase', 'a.uwase@alueducation.com', 'Entrepreneurial Leadership', '+250788200002', '2017-09-15'),
(3, 'Emmanuel', 'Nkurunziza', 'e.nkurunziza@alueducation.com', 'Data Science', '+250788200003', '2019-01-20'),
(4, 'Chantal', 'Mukamana', 'c.mukamana@alueducation.com', 'Software Engineering', '+250788200004', '2016-08-10'),
(5, 'Patrick', 'Habimana', 'p.habimana@alueducation.com', 'International Business', '+250788200005', '2020-03-01'),
(6, 'Grace', 'Uwamahoro', 'g.uwamahoro@alueducation.com', 'Communication', '+250788200006', '2021-05-12');

INSERT INTO Courses (course_id, course_name, course_code, credits, faculty_id, classroom_id) VALUES
(1, 'Database Systems', 'CS201', 3, 1, 1),
(2, 'Entrepreneurial Leadership', 'EL101', 4, 2, 3),
(3, 'Data Analytics for Africa', 'DS210', 3, 3, 4),
(4, 'Software Engineering', 'SE220', 4, 4, 2),
(5, 'International Business', 'IB150', 3, 5, 5),
(6, 'Public Speaking & Debate', 'CM110', 2, 1, 1);


-- individual UPDATE / DELETE / SELECT

-- Joshua
UPDATE Students
SET email = 'aline.uwimana@student.alueducation.com'
WHERE student_id = 1;

SELECT student_id, first_name, last_name, email
FROM Students
WHERE last_name = 'Uwimana';

-- Cynthia
UPDATE Classroom
SET capacity = 55
WHERE classroom_id = 3;

SELECT classroom_id, room_number, building_name, capacity
FROM Classroom
WHERE capacity >= 40;

-- Rebecca
UPDATE Faculty
SET department = 'Computer Science & Engineering'
WHERE faculty_id = 1;

SELECT faculty_id, first_name, last_name, department, email
FROM Faculty
WHERE department LIKE '%Science%';

-- Sonia
UPDATE Courses
SET credits = 5
WHERE course_code = 'DS210';

SELECT course_id, course_name, course_code, credits
FROM Courses
WHERE credits >= 4;

-- deletes (do junction / child rows first so FKs don't break)
DELETE FROM Courses WHERE course_id = 6;
DELETE FROM Students WHERE student_id = 6;
DELETE FROM Classroom WHERE classroom_id = 6;
DELETE FROM Faculty WHERE faculty_id = 6;
