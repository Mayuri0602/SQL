use sakila;

-- Arithmetic Operators 
select 12+4;
select 45-34;
select 23*2 as mul;
select 45/5 as 'select';   -- backtik and quote can be used
select 45%6;

-- select 67//7;   
-- select 2**3;
-- floor division and power (**) cannot be used in sql

select * from customer;
select * from customer where store_id=1 and active=0;
select concat(first_name,'  ',last_name) from customer;

select * from film_actor;
select actor_id, film_id from film_actor where film_id=3;
select actor_id, film_id from film_actor where film_id=3 or film_id=47;
select actor_id, film_id from film_actor where actor_id=1 and film_id=23;