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

-- Activities / clubs, advised by a faculty member (Rosette)
CREATE TABLE Extra_Curricular_Activities (
    activity_id INT AUTO_INCREMENT PRIMARY KEY,
    activity_name VARCHAR(100) NOT NULL,
    activity_type VARCHAR(50) NOT NULL,
    meeting_day VARCHAR(20) NOT NULL,
    meeting_time TIME NOT NULL,
    faculty_id INT NOT NULL,
    classroom_id INT NOT NULL,
    FOREIGN KEY (faculty_id) REFERENCES Faculty(faculty_id),
    FOREIGN KEY (classroom_id) REFERENCES Classroom(classroom_id)
);

-- Junction tables for many-to-many (Marvella)
CREATE TABLE Student_Courses (
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    enrollment_date DATE NOT NULL,
    PRIMARY KEY (student_id, course_id),
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);

CREATE TABLE Student_Activities (
    student_id INT NOT NULL,
    activity_id INT NOT NULL,
    join_date DATE NOT NULL,
    PRIMARY KEY (student_id, activity_id),
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (activity_id) REFERENCES Extra_Curricular_Activities(activity_id)
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

INSERT INTO Extra_Curricular_Activities (activity_id, activity_name, activity_type, meeting_day, meeting_time, faculty_id, classroom_id) VALUES
(1, 'ALU Football Club', 'Sports', 'Monday', '16:00:00', 5, 1),
(2, 'Kigali Debate Society', 'Academic', 'Tuesday', '15:30:00', 2, 3),
(3, 'Intore Dance Ensemble', 'Arts', 'Wednesday', '16:30:00', 2, 1),
(4, 'Robotics & Innovation', 'STEM', 'Thursday', '15:00:00', 1, 4),
(5, 'Umuganda Outreach', 'Service', 'Friday', '14:00:00', 3, 5),
(6, 'Chess Club', 'Academic', 'Saturday', '10:00:00', 4, 2);

INSERT INTO Student_Courses (student_id, course_id, enrollment_date) VALUES
(1, 1, '2025-09-01'),
(1, 2, '2025-09-01'),
(2, 1, '2025-09-01'),
(2, 3, '2025-09-02'),
(3, 4, '2025-09-01'),
(3, 2, '2025-09-03'),
(4, 3, '2025-09-01'),
(4, 5, '2025-09-02'),
(5, 1, '2025-09-01'),
(5, 4, '2025-09-04');

INSERT INTO Student_Activities (student_id, activity_id, join_date) VALUES
(1, 1, '2025-09-10'),
(1, 2, '2025-09-12'),
(2, 4, '2025-09-11'),
(3, 1, '2025-09-10'),
(3, 3, '2025-09-15'),
(4, 2, '2025-09-12'),
(4, 5, '2025-09-18'),
(5, 3, '2025-09-15'),
(5, 4, '2025-09-20');


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

-- Rosette
UPDATE Extra_Curricular_Activities
SET meeting_day = 'Thursday'
WHERE activity_id = 3;

SELECT activity_id, activity_name, activity_type, meeting_day
FROM Extra_Curricular_Activities
WHERE activity_type = 'Academic';

-- Marvella
UPDATE Student_Courses
SET enrollment_date = '2025-09-05'
WHERE student_id = 1 AND course_id = 2;

SELECT student_id, course_id, enrollment_date
FROM Student_Courses
WHERE student_id = 1;

UPDATE Student_Activities
SET join_date = '2025-09-22'
WHERE student_id = 2 AND activity_id = 4;

SELECT student_id, activity_id, join_date
FROM Student_Activities
WHERE activity_id = 1;

-- deletes (do junction / child rows first so FKs don't break)
DELETE FROM Student_Courses WHERE student_id = 5 AND course_id = 4;
DELETE FROM Student_Activities WHERE student_id = 5 AND activity_id = 4;
DELETE FROM Courses WHERE course_id = 6;
DELETE FROM Extra_Curricular_Activities WHERE activity_id = 6;
DELETE FROM Students WHERE student_id = 6;
DELETE FROM Classroom WHERE classroom_id = 6;
DELETE FROM Faculty WHERE faculty_id = 6;


-- group join queries (Friend)

-- Student X is enrolled in Course Y, taught by Faculty Z, in Classroom W.
SELECT CONCAT(
    s.first_name, ' ', s.last_name,
    ' is enrolled in ', c.course_name, ' (', c.course_code, '), taught by ',
    f.first_name, ' ', f.last_name,
    ', in classroom ', cl.room_number, ' (', cl.building_name, ').'
) AS full_sentence
FROM Students s
JOIN Student_Courses sc ON s.student_id = sc.student_id
JOIN Courses c ON sc.course_id = c.course_id
JOIN Faculty f ON c.faculty_id = f.faculty_id
JOIN Classroom cl ON c.classroom_id = cl.classroom_id
ORDER BY s.last_name, c.course_code;

-- Student X participates in Activity Y, advised by Faculty Z.
SELECT CONCAT(
    s.first_name, ' ', s.last_name,
    ' participates in ', a.activity_name,
    ', advised by ', f.first_name, ' ', f.last_name, '.'
) AS full_sentence
FROM Students s
JOIN Student_Activities sa ON s.student_id = sa.student_id
JOIN Extra_Curricular_Activities a ON sa.activity_id = a.activity_id
JOIN Faculty f ON a.faculty_id = f.faculty_id
ORDER BY s.last_name, a.activity_name;

-- extra join: course + room + how many students
SELECT CONCAT(
    c.course_name, ' (', c.course_code, ') meets in ',
    cl.room_number, ' - ', cl.building_name,
    ' and has ', COUNT(sc.student_id), ' student(s).'
) AS full_sentence
FROM Courses c
JOIN Classroom cl ON c.classroom_id = cl.classroom_id
LEFT JOIN Student_Courses sc ON c.course_id = sc.course_id
GROUP BY c.course_id, c.course_name, c.course_code, cl.room_number, cl.building_name
ORDER BY c.course_code;

-- aggregate: how many students in each course
SELECT
    c.course_code,
    c.course_name,
    CONCAT(f.first_name, ' ', f.last_name) AS taught_by,
    COUNT(sc.student_id) AS total_students
FROM Courses c
JOIN Faculty f ON c.faculty_id = f.faculty_id
LEFT JOIN Student_Courses sc ON c.course_id = sc.course_id
GROUP BY c.course_id, c.course_code, c.course_name, f.first_name, f.last_name
ORDER BY total_students DESC, c.course_code;
