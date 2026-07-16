CREATE DATABASE NESA;
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













/* 
   SECTION 3 - FACULTY (Rebecca)
   Branch: faculty-rebecca
    */












/* 
   SECTION 4 - COURSES (Sonia)
   Branch: course-sonia
   */












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









