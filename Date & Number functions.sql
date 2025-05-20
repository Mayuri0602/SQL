-- Dual table is a special one-row, one-column table present by default in Oracle and other 
-- database installations (used for testing purpose)

select 9*123 from dual;  
select sysdate(), current_timestamp(), now();
-- same output 
select curdate(), curtime() from dual;
select now(), adddate(now(), 2) from dual;
select now(), adddate(now(), interval 2 month) from dual;
select datediff('2025-07-19', '2025-05-19') from dual;
select last_day(now()) from dual;
select month (now()), year (now()) from dual;
select extract( year from now() ) from dual;
select extract( minute from now() ) from dual;
select now(), date_format( now(), 'This is %Y year') from dual;

-- Number functions - round(), truncate(), pow, floor(), ceil

select 24.654, round(24.654), round(24.654, 1), round(24.654, -1) from dual;
select round(364.32, -2) from dual;
select truncate(364.32, 1) from dual;
select mod(11,2), pow(2,3), floor(11.9999), ceil(9.0001) from dual;

-- if (condition, true, false)

use sakila;
select * from actor;
select first_name, actor_id, if(first_name='NICK', actor_id*10, 'No Value') from actor;
select first_name, if(first_name='NICK', 'YES', if(first_name='ED', 'hello', 'no')) from actor;
select actor_id, first_name,
case 
   when mod(actor_id,2)=0 then 'even'
   when actor_id=5 then '$$$'
   else'odd'
end
from actor;   

-- order by, alias

select * from actor order by first_name;
select * from actor order by first_name, actor_id desc;

-- alias:- giving a name/nickname to a column

select actor_id, actor_id+10 as 'new_actor' from actor;