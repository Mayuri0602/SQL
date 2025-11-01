use window_test;

CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(50),
    dept_id INT,
    admission_year INT
);

CREATE TABLE Enrollments (
    enroll_id INT PRIMARY KEY,
    student_id INT,
    course_name VARCHAR(50),
    marks INT,
    semester INT,
    FOREIGN KEY (student_id) REFERENCES Students(student_id)
);

INSERT INTO Students VALUES
(1, 'Amit', 1, 2021),
(2, 'Neha', 2, 2021),
(3, 'Ravi', 1, 2022),
(4, 'Priya', 3, 2022),
(5, 'Karan', 2, 2023);

INSERT INTO Enrollments VALUES
(101, 1, 'Math', 85, 1),
(102, 1, 'Science', 78, 2),
(103, 2, 'Math', 88, 1),
(104, 2, 'English', 92, 2),
(105, 3, 'Math', 90, 1),
(106, 3, 'Science', 80, 2),
(107, 4, 'Math', 75, 1),
(108, 4, 'English', 84, 2),
(109, 5, 'Math', 65, 1),
(110, 5, 'Science', 70, 2);

-- Q: Show each student’s name with the courses they are enrolled in.
select s.student_name,  GROUP_CONCAT(e.course_name ORDER BY e.course_name SEPARATOR ', ') AS courses_enrolled
from students as s
left join enrollments as e on s.student_id = e.student_id
group by s.student_name;

-- Find the average marks of each student.
select s.student_name, avg(e.marks) as avg_marks
from students as s
join enrollments as e on s.student_id = e.student_id
group by s.student_name;

-- Q: Find students who scored more than the overall average marks in any course.
select distinct s.student_name
from students as s
join enrollments as e on s.student_id = e.student_id
where e.marks > (select avg(marks) from enrollments);

-- Q: Rank students by their total marks (overall rank).
SELECT 
    s.student_name,
    SUM(e.marks) AS total_marks,
    RANK() OVER(ORDER BY SUM(e.marks) DESC) AS rank_overall
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
GROUP BY s.student_name;

-- Q: Rank students within each department by their total marks.
SELECT 
    s.dept_id,
    s.student_name,
    SUM(e.marks) AS total_marks,
    RANK() OVER(PARTITION BY s.dept_id ORDER BY SUM(e.marks) DESC) AS dept_rank
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
GROUP BY s.dept_id, s.student_name;

-- Q: Show each student’s marks along with their previous semester’s marks.
SELECT 
    student_id,
    course_name,
    semester,
    marks,
    LAG(marks) OVER(PARTITION BY student_id ORDER BY semester) AS prev_sem_marks
FROM Enrollments;


 