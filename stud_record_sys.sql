use employees;
-- Students Table
CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    name VARCHAR(100),
    age INT,
    gender CHAR(1),
    department VARCHAR(50)
);

-- Courses Table
CREATE TABLE Courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100),
    credits INT
);

-- Enrollments Table (Many-to-Many)
CREATE TABLE Enrollments (
    enrollment_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    course_id INT,
    semester INT,
    marks INT,
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);

-- Students
INSERT INTO Students VALUES
(1, 'Amit', 20, 'M', 'Computer Science'),
(2, 'Priya', 21, 'F', 'IT'),
(3, 'Rahul', 22, 'M', 'Mechanical'),
(4, 'Sneha', 20, 'F', 'Computer Science');

-- Courses
INSERT INTO Courses VALUES
(101, 'DBMS', 4),
(102, 'Operating Systems', 3),
(103, 'Data Structures', 4);

-- Enrollments
INSERT INTO Enrollments (student_id, course_id, semester, marks) VALUES
(1, 101, 3, 85),
(1, 102, 3, 78),
(2, 101, 3, 90),
(3, 103, 4, 70),
(4, 101, 3, 88),
(4, 103, 4, 92);

-- Show the names of all students and their departments.
select name, department
from students;

-- List all courses with more than 3 credits.
select course_name, credits 
from courses
where credits > 3;

-- Show student names and the courses they are enrolled in.
select s.name, c.course_name
from students as s
join enrollments as e on s.student_id = e.student_id
join courses as c on e.course_id = c.course_id;

-- Display student names and their marks in ‘DBMS’ course.
select s.name, e.marks
from students as s
join enrollments as e on s.student_id = e.student_id
join courses as c on e.course_id = c.course_id
where course_name = 'DBMS';

-- Find the average marks per course.
select avg(marks) as avg_marks, c.course_name
from enrollments as e
join courses as c on e.course_id = c.course_id
group by c.course_name;

-- Find names of students who scored more than 85 marks.
select s.name 
from students as s
join enrollments as e on s.student_id = e.student_id
where marks > 85;

-- List each course name and the number of students enrolled in it.
select c.course_name, count(student_id)
from courses as c 
join enrollments as s on c.course_id = s.course_id
group by c.course_name;

-- Show student name, course name, and marks sorted by marks in descending order.
select s.name, c.course_name, e.marks
from students as s
join enrollments as e on s.student_id = e.student_id
join courses as c on e.course_id = c.course_id
order by e.marks desc;