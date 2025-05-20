use sakila;
select * from payment;

-- multi-row functions: sum,count,max,min,avg

select distinct(customer_id) from payment;
select count(customer_id) from payment;
select count(customer_id), count(distinct(customer_id)) from payment;
select count(customer_id) as TotalCustomers,
count(distinct(customer_id)) as UniqueCustomers,
count(customer_id) - count(distinct(customer_id)) as repeatative_customer from payment;

-- Aggregate functions are used to perform calculations over certain values and returns a single value

select count(amount), sum(amount), avg(amount), max(amount), min(amount) from payment;

-- group by:- similar values ka group

select customer_id, count(amount), sum(amount) from payment group by customer_id;
select staff_id, count(rental_id), sum(amount), max(rental_id) from payment group by staff_id;
select month(payment_date), count(customer_id), max(rental_id), min(rental_id), avg(amount) from payment group by month(payment_date);