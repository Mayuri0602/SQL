use sakila;

select * from payment;

-- we only use those columns with select which are used in group by, to access other columns we use cols with aggregate function

select count(customer_id), sum(amount) from payment group by customer_id;

-- where >> group by >> agg. func.

select customer_id from payment where customer_id > 4 group by customer_id;

-- filter on aggregate function

select customer_id, count(customer_id) from payment
group by customer_id having count(customer_id) > 10;

select * from payment;

select amount, count(*), sum(amount)
from payment
group by amount;

select amount 
from payment 
where amount > 2 group by amount;

-- alias: as is used to give new name
select amount, count(*) as total_count, sum(amount)
from payment 
where amount > 2
group by amount
having total_count > 3000;

select * from payment;

-- get the staff id and total no. of cust. served by each staff
select staff_id, count(customer_id)
from payment 
group by staff_id;

-- get the total amount and no. of payments done for each month 
select sum(amount), count(amount), month(payment_date) as month
from payment 
group by month(payment_date);

-- get the amount and total no. of unique cust. who have done the payment for each amount
select amount, count(distinct customer_id) 
from payment 
group by amount;

-- get the no. of transactions achieved for each amount for the year 2005 where no. of transactions should be greater than 15
select amount, count(payment_id)
from payment 
where year(payment_date) = 2005
group by amount
having count(payment_id) > 15;