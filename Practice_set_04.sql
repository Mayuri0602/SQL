-- Multi-row function:- aggregate function returns a single output value
use sakila;

select * from payment;

select amount, round(amount) from payment;

-- To sum the values
select sum(amount) from payment;

-- To count the no. of values skipping the null values
select count(amount) from payment;

-- where clause runs first and then aggregate function
select count(amount) from payment where amount > 5;

-- count(*) counts the row with null values also
select * from address;
select count(address_id), count(address2), count(*) from address;

select * from payment;

select max(amount), min(amount), sum(amount), count(amount), avg(amount) from payment;

select distinct amount from payment;

-- combination of distinct or unique values of amount and customer_id
select distinct amount, customer_id from payment;

select count(distinct amount), count(amount) from payment;

-- get the payment id and amount for year 2005
select payment_id, amount
from payment
where year(payment_date) = 2005;

-- get the count of unique customers who have done the payment in the month of June
select count(distinct customer_id)
from payment
where month(payment_date) = 6; 

-- get the max amount, avg amount and the diff between max and avg amount where the amount of payment is greater than 2$ for the year 2006
select max(amount), avg(amount), (max(amount) - avg(amount))
from payment 
where amount > 2 and year(payment_date) = 2006;

-- group by :- grouping similar values
-- column on which 'group by' applies only that column will be used in 'select' statement

select count(payment_id) from payment where customer_id = 4;

select customer_id from payment group by customer_id;

-- distinct is used to find unique values from the table, 
-- in distinct we can not apply aggregate function,
-- expensive & time-taking task 

-- select distinct customer_id, count(customer_id) from payment;  --> this will not work

select customer_id, count(payment_id) from payment group by customer_id;

 
