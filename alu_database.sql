IICREATE DATABASE NESA;
USE NESA;




/* 
   SECTION 1 - STUDENTS (Joshua)
   Branch: students-joshua
    */
CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    date_of_birth DATE
);

INSERT INTO Students VALUES
(1, 'Aline', 'Uwimana', 'aline.uwimana@gmail.com', '2005-01-10'),
(2, 'Patrick', 'Niyonzima', 'patrick.niyonzima@gmail.com', '2004-05-15'),
(3, 'Claudine', 'Mukamana', 'claudine.mukamana@gmail.com', '2005-03-20'),
(4, 'Eric', 'Habimana', 'eric.habimana@gmail.com', '2004-09-12'),
(5, 'Diane', 'Iradukunda', 'diane.iradukunda@gmail.com', '2005-11-30');


UPDATE Students
SET email = 'aline.uwimana@alu.edu'
WHERE student_id = 1;


DELETE FROM Students
WHERE student_id = 5;


SELECT *
FROM Students
WHERE first_name = 'Aline';















/* 
   SECTION 2 - CLASSROOM (Cynthia)
   Branch: classroom-cynthia
   */




CREATE TABLE Classroom (
    classroom_id INT AUTO_INCREMENT PRIMARY KEY,
    room_number VARCHAR(10) NOT NULL,
    building_name VARCHAR(50) NOT NULL,
    capacity INT NOT NULL,
    floor INT NOT NULL
);

INSERT INTO Classroom (room_number, building_name, capacity, floor)
VALUES
('A101', 'Main Building', 40, 1),
('A102', 'Main Building', 35, 1),
('B201', 'Science Block', 50, 2),
('C301', 'Engineering Block', 60, 3),
('D401', 'Business Block', 45, 4);


UPDATE Classroom
SET capacity = 55
WHERE classroom_id = 3;

DELETE FROM Classroom
WHERE classroom_id = 5;

SELECT *
FROM Classroom
WHERE capacity >= 40;















/* 
   SECTION 3 
    */


CREATE TABLE Faculty (
    faculty_id INT AUTO_INCREMENT PRIMARY KEY,
    faculty_name VARCHAR(100) NOT NULL,
    dean_name VARCHAR(100) NOT NULL,
    office_location VARCHAR(100),
    contact_email VARCHAR(100) UNIQUE,
    established_year YEAR
);

 Insert at least 5 sample rows

INSERT INTO Faculty (faculty_name, dean_name, office_location, contact_email, established_year)
VALUES
('Faculty of Engineering', 'Dr. John Smith', 'Block A', 'engineering@university.edu', 2010),
('Faculty of Business', 'Dr. Mary Johnson', 'Block B', 'business@university.edu', 2008),
('Faculty of Science', 'Dr. Peter Brown', 'Block C', 'science@university.edu', 2012),
('Faculty of Education', 'Dr. Grace Williams', 'Block D', 'education@university.edu', 2005),
('Faculty of Law', 'Dr. David Wilson', 'Block E', 'law@university.edu', 2015);

 UPDATE statement

UPDATE Faculty
SET office_location = 'Block F'
WHERE faculty_id = 2;

 DELETE statement

DELETE FROM Faculty
WHERE faculty_id = 5;

 SELECT statement with a WHERE clause

SELECT *
FROM Faculty
WHERE established_year > 2009;



/* 
   SECTION 4 - COURSES (Sonia)
   Branch: course-sonia
   */
CREATE TABLE Courses (
    course_id INT AUTO_INCREMENT PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    course_code VARCHAR(20) UNIQUE NOT NULL,
    credits INT NOT NULL,
    faculty_id INT,
    FOREIGN KEY (faculty_id) REFERENCES Faculty(faculty_id)
);
INSERT INTO Courses (course_name, course_code, credits, faculty_id, classroom_id)
VALUES
('Database Systems', 'CS201', 3, 1, 1),
('Computer Networks', 'CS202', 3, 2, 2),
('Software Engineering', 'CS203', 4, 3, 3),
('Web Development', 'CS204', 3, 4, 4),
('Artificial Intelligence', 'CS205', 4, 5, 5);
UPDATE Courses
SET credits = 5
WHERE course_code = 'CS205';

DELETE FROM Courses
WHERE course_code = 'CS204';

SELECT *
FROM Courses
WHERE credits >= 4;




/* 
   SECTION 5 - EXTRA CURRICULAR ACTIVITIES (Rosette)
   Branch: Extra_Curricular_Activities
    */










/* 
   SECTION 6 - JUNCTION TABLES (Marvella)
   Branch: junctions-marvella
  */

CREATE TABLE Student_Courses (
    student_id INT,
    course_id INT,

    PRIMARY KEY (student_id, course_id),

    FOREIGN KEY (student_id)
        REFERENCES Students(student_id),

    FOREIGN KEY (course_id)
        REFERENCES Courses(course_id)
);

INSERT INTO Student_Courses VALUES
(1,1),
(1,2),
(2,1),
(3,3),
(4,2);

CREATE TABLE Student_Activities (
    student_id INT,
    activity_id INT,

    PRIMARY KEY (student_id, activity_id),

    FOREIGN KEY (student_id)
        REFERENCES Students(student_id),

    FOREIGN KEY (activity_id)
        REFERENCES Extra_Curricular_Activities(activity_id)
);

INSERT INTO Student_Activities VALUES
(1,1),
(2,2),
(3,1),
(4,3),
(5,2)

/* SECTION 7 - QUERIES (Friend)
   Branch: queries-friend
*/

/* QUERY 1
   I displayed each student, the course they are enrolled in,
   the faculty member teaching the course, and the classroom.
*/

SELECT
    s.student_id,
    CONCAT(s.first_name, ' ', s.last_name) AS Student,
    c.course_name AS Course,
    CONCAT(f.first_name, ' ', f.last_name) AS Faculty,
    cl.room_name AS Classroom
FROM Students s
JOIN Student_Courses sc
    ON s.student_id = sc.student_id
JOIN Courses c
    ON sc.course_id = c.course_id
JOIN Faculty f
    ON c.faculty_id = f.faculty_id
JOIN Classroom cl
    ON c.classroom_id = cl.classroom_id;


/* QUERY 2
   I displayed students participating in extracurricular activities.
*/

SELECT
    CONCAT(s.first_name, ' ', s.last_name) AS Student,
    e.activity_name AS Activity
FROM Students s
JOIN Student_Activities sa
    ON s.student_id = sa.student_id
JOIN Extra_Curricular_Activities e
    ON sa.activity_id = e.activity_id;


/* QUERY 3
   I displayed faculty members and the courses they teach.
*/

SELECT
    CONCAT(f.first_name, ' ', f.last_name) AS Faculty,
    c.course_name AS Course
FROM Faculty f
JOIN Courses c
    ON f.faculty_id = c.faculty_id
ORDER BY Faculty;


/* AGGREGATE QUERY
   I counted the number of students enrolled in each course.
*/

SELECT
    c.course_name,
    COUNT(sc.student_id) AS Total_Students
FROM Courses c
LEFT JOIN Student_Courses sc
    ON c.course_id = sc.course_id
GROUP BY
    c.course_id,
    c.course_name
ORDER BY Total_Students DESC;
