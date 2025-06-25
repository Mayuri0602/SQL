-- DCL:- Data Control Language
-- Used to control access to data in a database, it includes commands that manage permissions and security levels.

-- 1. GRANT Statement
-- Used to give a user permission to perform certain actions.
-- Example:- GRANT SELECT, INSERT ON Employees TO user1;

-- 2. REVOKE Statement
-- Used to take back permissions from a user.
-- Example:- REVOKE INSERT ON Employees FROM user1;

-- Common Privileges:
   -- SELECT: Read data
   -- INSERT: Add data
   -- UPDATE: Modify data
   -- DELETE: Remove data
   -- ALL PRIVILEGES: Grant all permissions

-- Only a DBA (Database Administrator) or users with high-level privileges can use DCL commands.

-- Users in MySQL are special objects used for the purpose of:- Authentication and Authorization
-- Authentication:-  making sure that a user can access the MySQL server.
-- Authorization:- making sure that a user can interact with objects in the database.

-- How to create user ?
-- create user username @IP address identified by 'password'
create user isha identified by 'isha123';
select current_user();

-- mysql inbuit table --> data dictionary

select * from mysql.user;
select * from mysql.user where user='isha';

use sakila;
create table sakila.test20(id int);
insert into sakila.test20 values(10),(20);
select * from sakila.test20;

show tables;

grant all privileges on sakila.test20 to isha;
-- (only sakila.test20 table), for all tables:- sakila.*
show grants for isha;
grant select on sakila.actor to isha; 
 
revoke all privileges on sakila.test20 from 'isha';
revoke select on sakila.actor from 'isha';

grant select(first_name, last_name) on sakila.actor to 'isha';
show grants for 'isha';

-- changing user password
alter user 'isha' identified by 'regex'; 


-- Q.1 Create a table named as 'userdata(id,name) and then insert 2-3 values
create table userdata(id int,
                     name varchar(20));
                     
insert into userdata values(1, 'aman'), (2, 'asha'), (3, 'bittu') ;

-- Q.2  Add new column as email in this table
alter table userdata add email varchar(50);


--  Check if a primary key already exists
-- If it does, drop it:
-- ALTER TABLE your_table DROP PRIMARY KEY;

-- Ensure the column is NOT NULL:
-- ALTER TABLE your_table MODIFY your_column INT NOT NULL;

-- Add the primary key:
-- ALTER TABLE your_table ADD PRIMARY KEY (your_column);

-- Or, with a constraint name:
-- ALTER TABLE your_table ADD CONSTRAINT pk_your_table_your_column PRIMARY KEY (your_column);

-- Q.3 Set id column as primary key
alter table userdata add constraint primary key(id);

-- Q.4 Set email as unique key
alter table userdata add constraint unique key (email); 

-- Q.5 Create a new column phone no. in varchar datatype
alter table userdata add phone_no varchar(12);

-- Q.6 Insert record in above column as 'abc'
UPDATE userdata SET phone_no = 'abc' WHERE id = 1;
UPDATE userdata SET phone_no = 'pqr' WHERE id = 2;
UPDATE userdata SET phone_no = 'xyz' WHERE id = 3;

-- Q.7 Change the datatype of this column as 'int'
UPDATE userdata SET phone_no = NULL WHERE phone_no REGEXP '[^0-9]';

alter table userdata modify phone_no int;

-- Q.8 Change the column name from phone_no to 'phone'
 alter table userdata change phone_no phone int;

                 