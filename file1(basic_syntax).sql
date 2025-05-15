show databases;

use sakila;

show tables;	

select * from actor;

select actor_id, last_name from actor;
select actor_id, actor_id * 10 from actor;

select * from actor where actor_id = 5;
select * from actor where first_name = 'ED';

select * from actor where first_name = 'ED' and actor_id > 100;
select * from actor where first_name = 'ED' or actor_id >100;
select * from actor where actor_id > 10 and actor_id < 25;
select * from actor where not actor_id between 10 and 20;

-- comment:- between operator between lower and higher

select * from actor where actor_id between 11 and 24;
select actor_id,first_name from actor where actor_id = 8;
select * from actor where actor_id between 2 and 5;
select * from actor where actor_id in (2,6);

-- % – any number of characters,   _ – exactly one character

select * from actor where first_name like 'M%';
select * from actor where last_name like 'M_____';
select * from actor where first_name like '_a%';