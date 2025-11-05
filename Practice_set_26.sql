-- Views are vitual tables that is used to make complex queries simpler, provides security by providing access to specific cols or rows

use sakila;

select first_name, film_id 
from actor as a
join film_actor as fa
where a.actor_id = fa.film_id;

-- complex query view
create view v_actor as 
select first_name, film_id 
from actor as a
join film_actor as fa
where a.actor_id = fa.film_id;


select * from v_actor;

-- view for specific column (security)
create view v_first as
select first_name from actor;

select * from v_first;     -- only first_name column access

-- ctas(create table as select) :- it insert the data of one table to another table
create table yash10 as
select * from actor where actor_id between 2 and 5;

select * from yash10;

create view v_yash as                    -- updatable or insertable
select actor_id, first_name from yash10;

select * from v_yash;

set sql_safe_updates = 0;
update yash10 set first_name = 'Rishi';

select * from yash10;       -- 

-- Non - Updatable view (with any function) :-

create view v_sec as
select first_name, film_id 
from actor as a
join film_actor as fa
where a.actor_id = fa.film_id;

select * from v_sec;


create table act as
select * from actor;

create view v_check2 as
select * from act where actor_id<6;

select * from v_check2;
update v_check2 set first_name='abc';

select * from act;


-- Indexes :- Index is like a shortcut that helps MySQL find data faster.                      
-- Just like an index in a book

-- 1.clusterd index
-- explain-- keyword use to define how query running

Create table students(
student_id int,name varchar(50),age int);

insert into students (student_id,name,age) values
(3,'a',10),
(5,'b',20),
(1,'c',40),
(2,'d',70),
(4,'e',60);

select * from students;

-- clustered index-->

explain select * from students where student_id=2; -- it filter 5 row 

alter table students add primary key(student_id);

explain select * from students where student_id=2; -- it filter only 1 row 
select * from students;


-- non-clustered index -- 
drop table students;
Create table students(
student_id int,name varchar(50),age int);

insert into students (student_id,name,age) values
(3,'a',10),
(5,'b',20),
(1,'c',40),
(2,'d',70),
(4,'e',60);

select * from students;


-- composite index

create index idx_student_c on students(student_id,name);

explain select * from students where student_id=3 and name='a'; -- it filter only 1 row 

-- prefix index
drop table students;

Create table students(
student_id int,name varchar(50),age int);

insert into students (student_id,name,age) values
(3,'alice',10),
(5,'altata',20),
(1,'alien',40),
(2,'david',70),
(4,'eva',60);

select * from students where name like 'al%';

create index idx_student_c on students(name(3)); -- partial index, here 3 mean upto three character

explain select * from students where name like 'ali%'; -- it will run
explain select * from students where name like 'alien';   -- it will not run



create table students (
       student_id int,
       name varchar (20),
       age int);
       
 insert into students values (3, 'aluce', 13),
							(1, 'bob', 15),
                            (5, 'chetan', 18),
                            (2, 'mira', 17),
                            (4, 'dheer', 16);
                            
select * from students;

explain select * from students where student_id = 2;   -- use of index
explain select * from students where name = 'Bob';     -- no index use

create index idx_student on students(student_id);   -- index created (non - clustered index)
show indexes from students;

-- composite index  (just like a composite key)
create index idx_stud on students (student_id, name);  
explain select * from students where student_id = 2 and name = 'chia';
explain select * from students where name = 'Bob';  

select * from students;                            

explain select * from students where name like 'Al%';
create index idx_name on students( name (3));   -- partial index
explain select * from students where name like 'Alice';
 

