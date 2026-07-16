CREATE DATABASE NESA;
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












/* 
   SECTION 5 - EXTRA CURRICULAR ACTIVITIES (Rosette)
   Branch: Extra_Curricular_Activities
    */












/* 
   SECTION 6 - JUNCTION TABLES (Marvella)
   Branch: junctions-marvella
  */


















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