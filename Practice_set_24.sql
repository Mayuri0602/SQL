create database november;
use november;

create table table1 (student_id int, 
                     student_name varchar(20), 
                     city varchar (20),
                     enrollment_date date);
                     
create table table2 (enroll_id int,
                        student_id int,
                        course_name varchar(20),
                        course_fee int,
                        grade char,
                        enroll_date date);
                        
insert into table1 values (1, 'Amit', 'Delhi', '2023-01-15'),
                            (2, 'Sneha', 'Mumbai', '2023-02-10'),
                            (3, 'Raj', 'Delhi', '2023-03-05'),
                            (4, 'Priya', 'Bangalore', '2023-01-25'),
                            (5, 'Vikram', 'Mumbai', '2023-04-12'),
                            (6, 'Anjali', 'Delhi', '2023-02-28'),
                            (7, 'Karan', 'Chennai', '2023-03-20');
 
insert into table2 values      (101, 1, 'SQL Basics', 5000, 'A', '2023-01-20'),
                               (102, 1, 'Python', 6000, 'B', '2023-02-25'),
                               (103, 2, 'SQL Basics', 6000, 'B', '2023-02-12'),
                               (104, 2, 'Data Science', 10000, 'A', '2023-03-01'),
                               (105, 3, 'SQL Basics', 5000, 'C', '2023-03-07'),
                               (106, 4, 'Python', 6000, 'A', '2023-01-28'),
                               (107, 5, 'SQL Basics', 5000, 'B', '2023-04-15'),
                               (108, 6, 'Data Science', 10000, 'A', '2023-03-05'),
                               (109, 6, 'SQL Basics', 5000, 'A', '2023-03-12'),
                               (110, 7, 'Python', 6000, 'B', '2023-03-25');
                               
-- Find the number of students enrolled in each course.
select course_name, count(student_id) as total_students
from table2
group by course_name
order by total_students desc;

-- Find students who took at least one course with grade = 'A'.
select distinct student_name
from table1 as t1
join table2 as t2 on t1.student_id = t2.student_id
where t2.grade = 'A';

-- For each student, show their course and total number of courses taken using a window function.
select t1.student_name, t2.course_name, 
count(t2.course_name) over(partition by t1.student_name) as total_courses
from table1 as t1
join table2 as t2 on t1.student_id = t2.student_id;

-- Find the student(s) who paid the highest course fee.
select t1.student_name
from table1 as t1
join table2 as t2 on t1.student_id = t2.student_id
where t2.course_fee = (select max(course_fee) from table2);

update table2 set course_fee = 5000 where enroll_id = 103;

-- Find students whose all enrolled courses have fees greater than or equal to 6000.
select t1.student_name
from table1 as t1 
join table2 as t2 on t1.student_id = t2.student_id
group by t1.student_name
having min(course_fee) >= 6000;

SELECT DISTINCT t1.student_name
FROM table1 AS t1
JOIN table2 AS t2 ON t1.student_id = t2.student_id
WHERE t2.student_id NOT IN (
    SELECT student_id
    FROM table2
    WHERE course_fee < 6000 );
    

-- Find the student(s) who enrolled in the course with the lowest fee.
select  t1.student_name, t2.course_name
from table1 as t1
join table2 as t2 on t1.student_id = t2.student_id
where t2.course_fee = (select min(course_fee) from table2);  

-- Show cumulative course fees per student (running total).
SELECT 
    t1.student_name,
    t2.course_name,
    t2.course_fee,
    t2.enroll_date,
    SUM(t2.course_fee) 
        OVER (PARTITION BY t1.student_id ORDER BY t2.enroll_date) AS cumulative_fee
FROM table1 AS t1
JOIN table2 AS t2 
    ON t1.student_id = t2.student_id
ORDER BY t1.student_id, t2.enroll_date;

   
    



                               
											
                               
                     