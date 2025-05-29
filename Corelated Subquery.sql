use employees;
select * from employees;
select * from dept_emp;
select * from departments;

-- Get the emp_no and the first_name and the dept_no for the employees from employees table and dept_emp table.
 select e.emp_no, e.first_name, dept_no from employees as e
 join dept_emp as d on e.emp_no=d.emp_no;
 
 
 select * from salaries;
 
 select * from salaries as sal
 where salary > (select avg(salary) from salaries as s where sal.emp_no=s.emp_no);
 
 -- A co-related query is a type of sub-query that depends on the outer query to execute.
 -- It is re-excuted again and again for each row, we don't use it generally because it took more time.
 
 create database regex1;
use regex1;
CREATE TABLE Departments (
    DeptID INT PRIMARY KEY,
    DeptName VARCHAR(100)
);

INSERT INTO Departments (DeptID, DeptName) VALUES
(1, 'Engineering'),
(2, 'Marketing'),
(3, 'HR');


CREATE TABLE Employees (
    EmpID INT PRIMARY KEY,
    EmpName VARCHAR(100),
    Salary DECIMAL(10, 2),
    DeptID INT,
    FOREIGN KEY (DeptID) REFERENCES Departments(DeptID)
);

INSERT INTO Employees (EmpID, EmpName, Salary, DeptID) VALUES
(1, 'Alice', 70000, 1),
(2, 'Bob', 60000, 1),
(3, 'Charlie', 50000, 1),
(4, 'Diana', 55000, 2),
(5, 'Eve', 65000, 2),
(6, 'Frank', 40000, 3);

select * from departments;
select * from employees;

-- Find employees who earn more than the average salary of their department.
select deptid, avg(salary) from employees group by deptid;

select * from employees as e
where e.salary > (
    select avg(e2.salary) from employees as e2
    where e2.deptid = e.deptid
);


-- list departments where at least one employee earns more than $60,000.
select d.deptname
from employees as e
join departments as d on e.deptid=d.deptid
where salary > 60000;

              
-- Find employees who have the highest salary in their department.
select max(salary), deptid from employees group by deptid;

select empname from employees as e
where e.salary = (
          select max(salary) from employees as e2
          where e.deptid=e2.deptid);


use regex;
CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    StudentName VARCHAR(100),
    Department VARCHAR(50)
);

INSERT INTO Students (StudentID, StudentName, Department) VALUES
(1, 'Alice', 'Computer Science'),
(2, 'Bob', 'Computer Science'),
(3, 'Charlie', 'Mathematics'),
(4, 'Diana', 'Mathematics'),
(5, 'Eve', 'Physics');


CREATE TABLE Courses (
    CourseID INT PRIMARY KEY,
    CourseName VARCHAR(100),
    Department VARCHAR(50)
);

INSERT INTO Courses (CourseID, CourseName, Department) VALUES
(101, 'Data Structures', 'Computer Science'),
(102, 'Algorithms', 'Computer Science'),
(201, 'Calculus', 'Mathematics'),
(202, 'Linear Algebra', 'Mathematics'),
(301, 'Quantum Mechanics', 'Physics');


CREATE TABLE Enrollments (
    StudentID INT,
    CourseID INT,
    Grade DECIMAL(5, 2),
    PRIMARY KEY (StudentID, CourseID),
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);

INSERT INTO Enrollments (StudentID, CourseID, Grade) VALUES
(1, 101, 88.5),
(1, 102, 92.0),
(2, 101, 76.0),
(2, 102, 81.5),
(3, 201, 85.0),
(3, 202, 90.0),
(4, 201, 78.0),
(4, 202, 82.5),
(5, 301, 91.0);

select * from Students;
select *  from Courses;
select * from Enrollments;


-- Get the studentname, studentid, coursename for each student.            
select studentname, studentid, coursename from students as s
join courses as c on s.department=c.department;

-- Find students who scored above the average in any course they enrolled in.
select courseid, avg(grade) from enrollments group by courseid;

select studentname, courseid, grade from Enrollments as e
join students as s on e.studentid=s.studentid
where e.grade > (select avg(grade) from 
Enrollments as e1 where e.courseid=e1.courseid);


-- List all students who have the highest grade in at least one course.
select s.studentname, grade, courseid from Enrollments as e
join Students s on e.studentid = s.studentid
where e.grade = (
    select max(e2.grade) from Enrollments as e2
    where e2.courseid = e.courseid);



			
 
 
 
 
                
 
 