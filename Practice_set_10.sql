-- SubQuery :- Query within a query or nested query 

use sakila;

select * from actor;

select first_name from actor where actor_id = 2;
select * from actor where first_name = 'NICK';

select * from actor where first_name = 'ED';

select * from actor 
where first_name = (select first_name from actor where actor_id = 2);           -- subquery (that is in bracket will execute first)

select * from payment;

-- get those payments whose amount is equal to payment id = 3
select * from payment 
where amount = (select amount from payment where payment_id = 3);

-- get the payment id, amount and payment date where the amount of rental id is equal to 1476
select payment_id, payment_date, amount from payment
where amount = (select amount from payment where rental_id = 1476);  

-- get the payment id, amount and payment date where the month of the table is equal to the month of payment id = 4
select payment_id, amount, payment_date
from payment 
where month(payment_date) = (select month(payment_date) from payment where payment_id = 4);

select * from payment;

-- get the payment id and amount from the table where the amount = max amount from the table
select payment_id, amount 
from payment
where amount = (select max(amount) from payment);



