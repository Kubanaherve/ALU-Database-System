IICREATE DATABASE NESA;
USE NESA;




/* 
   SECTION 1 - STUDENTS (Joshua)
   Branch: students-joshua
    */
















/* 
   SECTION 2 - CLASSROOM (Cynthia)
   Branch: classroom-cynthia
   */













/* 
   SECTION 3 - FACULTY (Rebecca)
   Branch: faculty-rebecca
    */












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


















/* 
   SECTION 7 - QUERIES (Friend)
   Branch: queries-friend
   */









