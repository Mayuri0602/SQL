-- CTE :- temporary named result set that we can reference within a single SQL query 
-- can be treated as a table 
-- we can reuse it again & again as per our requirement

use window_test;

select * from employee_sales;

select max(sale_amount) from employee_sales
where sale_amount < (Select max(sale_amount) from employee_sales);

-- with subquery
select * from (select *, dense_rank() over(order by sale_amount desc) as total_rank from employee_sales) as abc
where total_rank = 6; 

-- with cte
with abc as (select *, dense_rank() over(order by sale_amount desc) as total_rank
		    from employee_sales)
select * from abc where total_rank = 6;
            
use sakila;

select * from actor;
select * from film_actor;               

with film_cte as (select * from film_actor where actor_id = 1)
select a.actor_id, fc.film_id 
from actor as a 
join film_cte as fc on a.actor_id = fc.actor_id;

-- set operation :- combine the result of two or more select statements or query into one query

-- union removes duplicacy whereas union all not
-- no. of columns should be same in both the queries
-- queries can be of two different tables

select * from actor where actor_id < 3
union
select * from actor where actor_id between 2 and 6;

select * from actor where actor_id < 3
union all
select * from actor where actor_id between 2 and 6;

-- recursive cte

-- generate a series of number from 1 to 10
with recursive cte as( 
select 1 as num            -- base case     
union 
select num + 1 from cte      
where num < 10)            -- end case
select * from cte;

-- correlated subquery vs cte vs subquery

use regex1;
select * from employees;

select * from employees as eout where salary > (select avg(salary) from employees as ein 
                                                where ein.deptid = eout.deptid);
                                                
with xyz as (
select deptid, avg(salary) as avg_salary from employees group by deptid)
select * from employees join xyz where employees.deptid = xyz.deptid and employees.salary > xyz.avg_salary;                                          

