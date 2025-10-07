-- self join example (query)
drop database if exists regex123;

create database regex123;
use regex123;

CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    name VARCHAR(100),
    manager_id INT,
    FOREIGN KEY (manager_id) REFERENCES employees(employee_id)
);


INSERT INTO employees (employee_id, name, manager_id) VALUES
(1, 'Alice', NULL),       -- CEO
(2, 'Bob', 1),            -- VP of Sales
(3, 'Carol', 1),          -- VP of Engineering
(4, 'David', 2),          -- Sales Manager 1
(5, 'Eve', 2),            -- Sales Manager 2
(6, 'Frank', 3),          -- Engineering Manager 1
(7, 'Grace', 3),          -- Engineering Manager 2
(8, 'Heidi', 4),          -- Salesperson under David
(9, 'Ivan', 4),           -- Salesperson under David
(10, 'Judy', 5),          -- Salesperson under Eve
(11, 'Mallory', 6),       -- Engineer under Frank
(12, 'Niaj', 6),          -- Engineer under Frank
(13, 'Olivia', 7),        -- Engineer under Grace
(14, 'Peggy', 7),         -- Engineer under Grace
(15, 'Trent', 3);         -- Tech Lead under Carol (no direct reports)


select * from employees;

-- self join:- when a table is joined with itself based on same column name & values or datatypes

select e.employee_id, e.name, e.manager_id, m.employee_id, m.name as manager_name 
from employees as e
join employees as m 
on e.manager_id = m.employee_id;

-- Natural join:- useless, joins automatically based on same column name 
-- if there is no same col_name then natural join works as cross join
-- if there is same col_name then it will work as inner join 

-- Cross/Cartesian join:- cartesian product where each row of first table combined with each row of second table, i.e. m * n

select p.pid, p.price, o.productid, o.city
from product as p
cross join orders as o;

use sakila;
select * from actor;
select * from film_actor;

select a.actor_id, concat(first_name, '  ', last_name) as actor_name, f.film_id
from actor as a
join film_actor as f
on a.actor_id = f.actor_id;

select * from film;
select * from film_actor;

select  f.film_id, f.title as movie_name from film as f
join film_actor as fa
on f.film_id = fa.film_id;


select a.actor_id, concat(first_name, '  ', last_name) as actor_name, fa.film_id, f.title as film_name
from actor as a
join film_actor as fa
join film as f
on a.actor_id = fa.actor_id and fa.film_id = f.film_id;
