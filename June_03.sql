use sakila;
create table admission(adm_id int primary key,
						name varchar(20) unique key,
                        clgname varchar(30));
insert into admission values(1, 'Aditi', 'Poornima');
insert into admission values(2, 'Aditya', 'Manipal'); 
insert into admission values(3, 'Anjali', 'Manipal');
select * from admission;


create table student(s_id int primary key,
						name varchar(20) unique key);
insert into student values(1, 'Aditi');
insert into student values(2, 'Aditya'); 
-- insert into student values(3, 'Anjali');
select * from Student;


drop table admission;


create table admission(stud_id int primary key,
						name varchar(20) unique key,
                        clgname varchar(30), foreign key (stud_id) references student(s_id));
-- references should be given to primary and unique key only.                       
insert into admission values(1, 'Aditi', 'Poornima');
insert into admission values(2, 'Aditya', 'Manipal'); 
select * from admission;



use sakila;
create table Student01(stud_id int Primary Key, name varchar(20), age int, grade int, 
city varchar(20));
insert into Student01 values
(1, 'Alice', 14, 9, 'NewYork'), 
(2, 'Bob', 15, 10, 'LosAngeles'), 
(3, 'Charlie', 14, 9, 'Chicago'), 
(4, 'David',16, 11, 'NewYork'), 
(5, 'Eve',15, 10, 'Chicago');
select * from Student01;

create table Marks01(s_id int, subject varchar(20), marks int,
                     foreign key (s_id) references student01(stud_id));

                     
use sakila;
select * from actor;
create table test99 as
      select * from actor;
select * from test99;     
-- constraints copy nhi hote 
create table test98 as
       select actor_id, first_name from actor;      
 select * from test98;                  
 
-- Delete that actor_id whose actor_id is same as the actor name Penelope.
delete from test98
where actor_id in (select actor_id from actor where first_name = 'Penelope');
select * from test98;

create table payment30 as 
	select * from payment;
select * from payment30;

-- update the amount done by cust_id 1 as with the same amount done by the customer for payment_id=2.
update payment30
set amount = (select amount from payment
              where payment_id = 2)
where customer_id = 1;
select * from payment30;
  


                         