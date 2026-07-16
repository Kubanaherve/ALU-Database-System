CREATE DATABASE NESA;
USE NESA;




/* 
   SECTION 1 - STUDENTS (Joshua)
   Branch: students-joshua
    */
















/* 
   SECTION 2 - CLASSROOM (Cynthia)
   Branch: classroom-cynthia
   */CREATE TABLE Classroom (
    classroom_id INT PRIMARY KEY,
    classroom_name VARCHAR(50),
    capacity INT,
building VARCHAR(100)
INSERT INTO Classroom (classroom_id, classroom_name, capacity, building) VALUES
(1, 'Amahoro Hall', 40, 'Block A'),
(2, 'Kigali Room', 35, 'Block B'),
(3, 'Virunga Hall', 50, 'Block C'),
(4, 'Akagera Room', 30, 'Block A'),
(5, 'Muhabura Hall', 45, 'Block D');
-- Cynthia: Update one classroom

UPDATE Classroom
SET building = 'Block E'
WHERE classroom_id = 2;
-- Cynthia: Update one classroom

UPDATE Classroom
SET capacity = 55
WHERE classroom_id = 3;

);















/* 
   SECTION 3 
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









