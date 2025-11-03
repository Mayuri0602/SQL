use corrdb;

CREATE TABLE Courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(50),
    duration_months INT,
    course_fee INT
);

INSERT INTO Courses VALUES
(101, 'Data Science', 6, 40000),
(102, 'Web Development', 4, 30000),
(103, 'Cyber Security', 5, 35000),
(104, 'AI & ML', 8, 60000);

CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(50),
    city VARCHAR(30),
    admission_year INT
);

INSERT INTO Students VALUES
(1, 'Amit Sharma', 'Delhi', 2022),
(2, 'Neha Patel', 'Mumbai', 2023),
(3, 'Rohit Verma', 'Pune', 2022),
(4, 'Sneha Iyer', 'Chennai', 2023),
(5, 'Karan Singh', 'Delhi', 2024);

CREATE TABLE Enrollments (
    enroll_id INT PRIMARY KEY,
    student_id INT,
    course_id INT,
    enroll_date DATE,
    grade CHAR(1),
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);

INSERT INTO Enrollments VALUES
(1, 1, 101, '2023-01-10', 'A'),
(2, 2, 102, '2023-02-05', 'B'),
(3, 3, 103, '2023-03-15', 'A'),
(4, 1, 104, '2024-01-10', 'B'),
(5, 4, 102, '2023-06-20', 'A'),
(6, 5, 101, '2024-07-15', 'C');

-- Show all students from the city “Delhi”.
select student_name 
from students
where city = 'Delhi';

-- List all courses that have a duration greater than 5 months.
select course_name
from courses 
where duration_months > 5;

-- Display student names and their enrolled course IDs from the Enrollments table.
select s.student_name, e.course_id                                     -- group_concat aggregate function
from students as s
inner join enrollments as e on s.student_id = e.student_id;

-- Count how many students enrolled in total.
select count(enroll_id) as total_students
from enrollments;

-- Show the distinct cities from where students come.
select distinct city
from students; 

-- Show student names along with the course names they enrolled in.
select s.student_name, c.course_name
from students as s
join enrollments as e on s.student_id = e.student_id
join courses as c on e.course_id = c.course_id;

-- Find total number of students enrolled in each course.
select c.course_name, count(e.enroll_id) as total_students
from courses as c
join enrollments as e on c.course_id = e.course_id
group by c.course_name;

-- Show the average course fee.
select avg(course_fee) as avg_course_fee
from courses;

-- Find students who enrolled after '2023-03-01'.
select s.student_name 
from students as s
join enrollments as e on s.student_id = e.student_id
where e.enroll_date > '2023-03-01';

-- List students who enrolled in more than one course.
select s.student_name
from students as s
join enrollments as e on s.student_id = e.student_id
group by s.student_name
having count(e.course_id) > 1;  

-- Find the course with the highest number of enrollments.
select c.course_name, count(e.enroll_id) as total_enrollments
from courses as c
join enrollments as e on c.course_id = e.course_id
group by c.course_name
order by total_enrollments desc
limit 1;

-- Show total course fees per student using a JOIN.
select s.student_name, sum(c.course_fee) as total_course_fees
from students as s
join enrollments as e on s.student_id = e.student_id
join courses as c on e.course_id = c.course_id 
group by s.student_name;

-- Find all students who got grade 'A' in any course.
select distinct s.student_name
from students as s
join enrollments as e on s.student_id = e.student_id
where e.grade = 'A'; 

-- Display students who enrolled in a course with a fee higher than the average course fee (use subquery).
select s.student_name
from students as s
join enrollments as e on s.student_id = e.student_id
join courses as c on e.course_id = c.course_id
where c.course_fee > (select avg(course_fee) from courses);

-- Find the city-wise number of students enrolled.
select s.city, count(distinct s.student_id) as total_students_enrolled
from students as s
join enrollments as e on s.student_id = e.student_id
group by s.city;
