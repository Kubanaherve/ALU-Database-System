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

/* 
   SECTION 7 - QUERIES (Friend)
   Branch: queries-friend
   */









