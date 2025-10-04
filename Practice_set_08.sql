-- Composite key:- combination of columns that can be used as primary key in a table

-- Inner join:- returns rows that have matching values in both the tables

-- use 'on' in place of 'where' when using join

show databases;
use regex123;
show tables;

create table product(pid int, pname varchar(20), price int);
insert into product values(100, 'iphone', 4000), (101, 'mit tv', 3000), (102, 'fridge', 5000), (103, 'cover', 500);
 
create table orders1(orderid int, city varchar(20), productid int);
insert into orders1 values(994, 'Jaipur', 100), (995, 'Goa', 102), (996, 'J&K', 100), (997, 'japan', 102), (998, 'bhutan', 110);
 
 select * from product;
 
 select * from orders1;
 
 -- left join:- returns the common values as well as the data from the left table
 
select p.pid, p.pname, p.price, o.productid, o.city 
from product as p
left join orders1 as o
on p.pid = o.productid;


select p.pid, p.pname, p.price, o.productid, o.city 
from orders1 as o
left join product as p
on o.productid = p.pid;

-- right join:- returns the common values from both the tables and data from the right table also

select p.pid, p.pname, p.price, o.productid, o.city 
from orders1 as o
right join product as p
on o.productid = p.pid;

select p.pid, p.pname, p.price, o.productid, o.city 
from product as p
right join orders1 as o
on p.pid = o.productid;

use sakila;

select * from actor;
desc actor;

select count(actor_id), count(distinct actor_id) from actor;

select * from film_actor;
desc film_actor;

select a.actor_id, a.first_name, fa.film_id
from actor as a
join film_actor as fa                          -- inner join
on a.actor_id = fa.actor_id; 


select a.actor_id, a.first_name, fa.film_id
from actor as a
join film_actor as fa                         
on a.actor_id = fa.actor_id
and a.actor_id = 1;                         -- actor_id (X),  a.actor_id (correct)



drop database regex123;
create database regex123;

use regex123;
CREATE TABLE Student (
    StudentID INT PRIMARY KEY,
    StudentName VARCHAR(50)
);

CREATE TABLE Enrollment (
    EnrollmentID INT PRIMARY KEY,
    StudentID INT,
    CourseName VARCHAR(50),
    FOREIGN KEY (StudentID) REFERENCES Student(StudentID)
);


INSERT INTO Student (StudentID, StudentName) VALUES
(1, 'Alice'),
(2, 'Bob'),
(3, 'Charlie'),
(4, 'David'),
(5, 'Eva'),
(6, 'Frank'),
(7, 'Grace'),
(8, 'Helen'),
(9, 'Ian'),
(10, 'Jack');


INSERT INTO Enrollment (EnrollmentID, StudentID, CourseName) VALUES
(101, 1, 'Math'),
(102, 2, 'Physics'),
(103, 3, 'Chemistry'),
(104, 1, 'English'),
(105, 5, 'Biology'),
(106, 7, 'History'),
(107, 10, 'Math'); 

select * from Student;

select * from Enrollment;

-- students who are enrolled in any course
select s.studentid, s.StudentName, e.enrollmentid
from Student as s
join Enrollment as e 
on s.StudentID  = e.StudentID;

-- all students with enrolled courses  
select s.studentid, s.StudentName, e.CourseName
from Student as s
left join Enrollment as e 
on s.StudentID  = e.StudentID;  

-- display only stud who are enrolled in atleast one course
select s.studentname, e.coursename
from student as s
join enrollment as e 
on s.StudentID  = e.StudentID;  

-- students who do not enrolled in any course
select s.studentname, e.coursename
from student as s
left join enrollment as e 
on s.StudentID  = e.StudentID
where enrollmentid is null;        -- is null (correct), null(incorrect)

-- name of all stud and in how many courses they enrolled
select s.studentid, count(e.enrollmentid) 
from student as s
left join enrollment as e 
on s.StudentID  = e.StudentID
group by s.studentid;

-- group by course name 
select e.coursename, count(s.studentid) 
from student as s
inner join enrollment as e 
on s.StudentID  = e.StudentID
group by e.coursename;
    




