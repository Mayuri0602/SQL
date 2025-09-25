use sakila;

select actor_id, actor_id + 4 from acTor;

-- like operator (pattern ke acc. data filter)
-- % (wildcard character) : zero or more characters
select * from actor where first_name like 'T%';

select * from actor where first_name like '%T';

select * from actor where first_name like 'S%T';

select * from actor where first_name like '%S%';

-- (_) : exactly one character
select * from actor where first_name like 'J__';

select * from actor where first_name like 'E_';

select * from actor where first_name like 'A____%';

select * from actor where first_name like '_A%';

-- get the actor id and first name where the last two word should be 'TE'
select actor_id, first_name 
from actor
where first_name like '%TE'; 

-- get the actor id & first name where 'NN' should be present in the middle
select actor_id, first_name 
from actor
where first_name like '_%NN%_';

-- get the last name & first name where last name col. the first word is B and the second last word R
select first_name, last_name 
from actor 
where last_name like 'B%R_';

-- get all the user info where the first name should have minimum 4 characters
select * from actor
where first_name like '____%';

-- get all the columns where the actor id is from 2 to 90 and in first name, 'S' should be present in the middle and 'A' should be the last second character
select * from actor 
where actor_id between 2 and 90
and first_name like '_%S%A_';

-- Functions (in-built) :  Scalar and Multi-row functions
-- Scaler function (row function : apply on each row and return the output for each row)

select first_name, char_length(first_name)  from actor;

select first_name, char_length(first_name), lower(first_name)  from actor;

-- concat mein by default space nhi diya jata
select first_name, last_name, concat(first_name, ' % ', last_name)  from actor;

select first_name, last_name, concat_ws(' ', 'MR/MRS', first_name, last_name)  from actor;

-- substr (to extract some data)
select first_name, substr(first_name, 2) from actor;

-- substr(col_name, position, total characters)
select first_name, substr(first_name, -3, 3) from actor;
select first_name, substr(first_name, 2, 5) from actor;

