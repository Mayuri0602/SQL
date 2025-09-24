-- will show all databases in mysql
show  databases;

-- use sakila as a database(folder)
use sakila;

-- show tables to see all the table
show tables;

-- select statement (DQL),   * access all columns
select * from actor;

-- will give table info (column, datatype, relationships and more)
describe actor;

-- SQL is case-insensetive (can be in any case format) 
select actor_id, FIRST_NAME from ACTor;

select actor_id, first_name, last_name,
actor_id from actor;

select actor_id, first_name,
actor_id * 5 from actor;         -- can't create new column in original data

-- 'where' condition used to filter rows
select * from actor where actor_id = 3;

select * from actor where first_name = 'NICK';

select actor_id from actor where last_name = 'DAVIS';

-- not equal to (comparison operator)
select * from actor where actor_id != 5;

select * from actor where actor_id <> 9;

-- logical operator :- and (to apply multiple conditiions together) 
select * from actor where first_name = 'NICK' and actor_id = 44;


-- logical operator :- or 
select * from actor where first_name = 'NICK' or actor_id = 46;
select * from actor where last_name = 'DAVIS' or actor_id != 67;

-- between operator (lower to higher)
select * from actor where actor_id between 2 and 6; -- inclusive 
select * from actor where actor_id >= 2 and actor_id <=6;

select * from actor where actor_id not between 2 and 6;

-- in operator
select * from actor where actor_id in (2,8,9);  -- multiple 'or' conditions together using 'in' operator
select * from actor where actor_id = 2 or actor_id = 8 or actor_id = 9;

-- from the actor table, get the first name and actor id whose last name is genius
select first_name, actor_id
from actor
where last_name = 'GENIUS'; 

-- get the actor id and the first name where the actor id is from value 3 to 18 or the first name should not be 'ED'
select actor_id, first_name
from actor
where actor_id between 3 and 18
or first_name != 'ED';

-- get the last name, actor id and first name where first name is either Nick or Grace
 select last_name, actor_id, first_name 
 from actor
 where first_name = 'NICK' or first_name = 'GRACE';
 
-- get all the columns where the actor id is from 2 to 6 or actor id greater than 5
select * from actor 
where actor_id between 2 and 6
or actor_id > 5;
