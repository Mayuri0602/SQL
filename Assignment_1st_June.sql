use regex;
create table Student1( stud_id int Primary Key, name varchar(20), age int, grade int, city varchar(20));
insert into Student1 values
(1, 'Alice', 14, 9, 'NewYork'), 
(2, 'Bob', 15, 10, 'LosAngeles'), 
(3, 'Charlie', 14, 9, 'Chicago'), 
(4, 'David',16, 11, 'NewYork'), 
(5, 'Eve',15, 10, 'Chicago');

Truncate table Student1;
INSERT INTO Student1 VALUES
(1, 'Alice', 14, 9, 'NewYork'), 
(2, 'Bob', 15, 10, 'LosAngeles'), 
(3, 'Charlie', 14, 9, 'Chicago'), 
(4, 'David', 16, 11, 'NewYork'), 
(5, 'Eve', 15, 10, 'Chicago');

select * from Student1;


create table Marks2( s_id int, subject varchar(20), marks int);
insert into Marks2 values
(1, 'Math', 85),
(1, 'Science', 90),
(2, 'Math', 78),
(2, 'Science', 88),
(3, 'Math', 95),
(3, 'Science', 89),
(4, 'Math', 80),
(4, 'Science', 70),
(5, 'Math', 88),
(5, 'Science', 92);
select * from Marks2; 

--  Get the student name with the starting 3 character from name in a column name as 'select' for grade >=9.
select substr(name,1,3) as `select` from Student1 where grade >= 9;     
select left(name,3) as `select` from Student1 where grade >= 9;

-- backticks(`) are necessary because "select" is a reserved word.

-- Find the marks of all subjects for the student named "Charlie" with 10% grace marks in a new column. 
select m.marks, m.subject, 
m.marks * 1.10 as grace_marks 
from Marks2 as m
join Student1 as s on m.s_id=s.stud_id
where s.name = 'Charlie';

-- List the names of students who scored more than 90 in Science.
select s.name from Student1 as s
join Marks2 as m on s.stud_id=m.s_id
where m.marks > 90 and m.subject='Science';

-- Find the total marks scored by each student across all subjects. 
select s.name,sum(marks) from Marks2 as m 
join Student1 as s on m.s_id=s.stud_id
group by s.name;

-- Display the name and total marks of the top-scoring student in Science.
select s.name, m.marks as total_marks
from Student1 as s 
join Marks2 as m on s.stud_id=m.s_id
where m.subject='Science' and
marks = (select max(marks) from Marks2 where subject='Science');

-- List all students who have scored more than the average marks in Math.
select s.name from Student1 as s
join Marks2 as m on s.stud_id=m.s_id
where m.subject = 'Math'
and  m.marks > (select avg(marks) from Marks2 where subject='Math');

-- What is RDBMS? Explain in detail.
-- RDBMS:- Relational Database Management System is a type of DBMS that stores data in the form of related tables(in the form of rows and columns) 
-- (also called relations), allowing for easy organization, retrieval, and manipulation of data using SQL. 
-- RDBMS = Database + Tables + Relationships + SQL
-- It’s the backbone of most business applications, websites, and data systems we interact with today.
 -- It allows structured storage, retrieval, and management of large sets of related data efficiently.


-- What is normalization? Explain in detail with example.
-- Normalization is the process of organizing data in a relational database to reduce redundancy (duplicate data)
-- and improve data integrity. It involves dividing large tables into smaller, related tables and defining 
-- relationships between them using foreign keys.

-- example:- StudentID	Name	Courses	        Instructor
--           1	        Alice	Math, Science	Smith, Johnson
--           2	        Bob	    Math	        Smith
-- Problems:- Multiple values in Courses and Instructor columns.
-- Student Table:
-- StudentID	Name
-- 1            Alice
-- 2	        Bob

-- CourseEnrollment Table:
-- StudentID	Course
-- 1	        Math
-- 1         	Science
-- 2	        Math

-- Course Table:
-- Course	  Instructor
-- Math	      Smith
-- Science	  Johnson
      