use sakila;
create table employee1( e_id int, e_name varchar(20), manager_id int);
insert into employee1 values(10,"tushar", null), (11,"aman",12), (12,"adi",10), (13,"sakshi",11);
select * from employee1;

-- Self join is a type of SQL join where a table is joined with itself.
-- It's called a self join because the same table is used on both sides of the join.
-- We use a self join when we want to compare rows within the same table. 

select emp.e_id, emp.e_name, emp.manager_id, manager.e_id, manager.e_name
from employee1 as emp
join employee1 as manager where emp.manager_id=manager.e_id;

-- Natural join(useless) is a type of SQL join that automatically joins two tables based on columns with the same name
-- and compatible data types in both tables, it behaves like an INNER JOIN by default.


select * from payment;
select customer_id, count(payment_id) from payment group by customer_id having count(payment_id) > 30;
-- where clause only filters the data which is present in the table
-- having clause is used only with group by, when we want to filter aggregate function & calculated column

select customer_id, count(payment_id)
 from payment where customer_id not in (2,3)
 group by customer_id having count(payment_id) > 35;
 
 -- Get the number of payments for each amount
 select amount, count(payment_id) from payment group by amount;
 
 -- Count the total no. of customers who had done the payment for each amount except amount 2.99 and 0.99
 select count(customer_id), amount
 from payment where amount not in (2.99, 0.99)
 group by amount;
 
 -- Get the sum of rental_id and the total amount of payment only for the amount 2.99, 0.99 and 5.99 and the sum of rental_id should be greater than 1000.
select amount, sum(rental_id), sum(amount)
from payment where amount in (2.99, 0.99, 5.99)
group by amount having sum(rental_id) > 1000;

select * from actor;
select * from film_actor;

select a.actor_id, a.first_name, fa.film_id
from actor as a
join film_actor as fa where a.actor_id=fa.actor_id;

-- How many film has done by each actor
select a.actor_id, count(film_id)
from actor as a
join film_actor as fa where a.actor_id=fa.actor_id
group by a.actor_id;

-- How many actors work in each film
select fa.film_id, count(fa.actor_id) as actors
from film_actor as fa
join actor as a on fa.actor_id=a.actor_id
group by fa.film_id;
