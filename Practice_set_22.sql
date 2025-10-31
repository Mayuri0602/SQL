-- DCL :- Data Control Language used to give permissions and control access to database objects

-- create user user_name identified by password

create user 'ram' identified by 'ram';

select * from mysql.user;     -- shows all the users

show grants for 'ram';   -- will show privileges

-- grant statement      database.table
grant all privileges on regex.* to 'ram';

grant select on regex.* to 'ram';
show grants for 'ram';


use regex;
show tables;
select * from employees30;

-- revoke statement
revoke all privileges on regex.* from 'ram';

show databases;

-- how to create role
create role 'role_name';
grant 'role_name' to 'user_name'@'host_name';


use sakila;
create role 'tushar31';
grant 'tushar31' to 'ram';
show grants for 'ram';




