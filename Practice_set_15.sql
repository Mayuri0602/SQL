-- constraints :- these are specified rules & regulations which do not allow invalid data entry in the table
-- 1. Not Null :- ensures a column cannot have null values
use regex123;

create table test(id int);
insert into test values(10), (11), (10), (null); 

create table test2(id int not null);
insert into test2 values(10), (11), (10);
insert into test2 values(10), (null);        -- this will give error

-- 2. Unique :- prevents duplicate values in a column
create table test3(id int unique);
insert into test3 values(10), (11);
insert into test3 values(10), (11), (10);     -- this will give error

-- 3. Default :- provides a default value if no value is given
create table test4(id int, gender varchar(20) );
insert into test4 values(10);
select * from test4;

create table test5(id int, gender varchar(20) default 'female');
insert into test5(id) values(10);
select * from test5;

-- 4. Check :- adds a condition that must be check for each row
create table test6(id int check (id > 5), gender varchar(20) );
insert into test6(id) values(10);
insert into test6(id) values(4);     -- this will give error because id = 4 less than 4 (check condition)
select * from test6;

create table test7(id int check (id > 5), gender varchar(20) check (gender in ('male', 'female')));
insert into test7 values(10, 'male');
insert into test7 values(11, 'transgender');     -- this will give error
select * from test7;
   
   
-- given name to a constraint helps us to know easily   
create table test8(id int check (id > 5), gender varchar(20) constraint db_test8_gender_chk check (gender in ('male', 'female')));  
insert into test8 values(10, 'male');
insert into test8 values(11, 'transgender');
select * from test8;

create table test9(id int primary key, gender varchar(20) );
insert into test9 values(10, 'male');
insert into test9 values(10, 'female');     -- this will give error because int is a primary key which does not contain duplicate values
select * from test9;

-- 6. Foreign Key :- 
create table product1(pid int primary key, pname varchar(20));
insert into product1 values('101', 'iphone');
-- insert into product1 values('101', 'ipad'); 
insert into product1 values('102', 'ipad'); 

create table orders1(o_id int primary key, price int, pid int);
insert into orders1 values(1981, 200, 101), (1982, 260, 102), (1983, 275, 101), (1984, 300, 108);   -- foreign key constraint is not used that's why 108 id data is inserted easily
select * from orders1;

-- with foreign key
create table orders6 (o_id int, price int, pid int, foreign key (pid) references product1(pid));
insert into orders6 values(1981, 200, 101), (1982, 260, 102), (1983, 275, 101);   
select * from orders6;



-- create 2 tables :- employees (emp_id primary key, emp_name, emp_email should be unique, dept_id which refers to dept table, give constraint name to unique)
-- department (dept_id as unique, dept_name which will be on check constraint the dept should be biology or physics, try to insert null values in dept_id column)9       
   
create table employees01 (emp_id int primary key, emp_name varchar(20), e_mail varchar(30) unique, dept_id int); 
insert into employees01 values(200, 'Ana', 'ana098@gmail.com', 100), (201, 'Bliss', 'bliss123@gmail.com', 101);
select * from employees01;

create table department01 (dept_id int unique, dept_name varchar(20) check (dept_name in ('biology', 'physics')));
insert into department01 values(100, 'Biology'), (101, 'Physics'), (null, 'Biology');
select * from department01;
