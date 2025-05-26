-- Subquery :- query within a query
-- Single row subquery
use sakila;
select * from payment where payment_id=6;
select * from payment where amount=4.99;

select * from payment
where amount=(select amount from payment where payment_id=6);

-- I need to get all the columns for the actor whose actor_id is greater than the actor_id of a person whose first name=ED and last name=CHASE
select * from actor;
select * from actor where 
actor_id>(select actor_id from actor where first_name='ED' and last_name='CHASE'); 

select * from payment;

-- Get all the payment details for those payments where the month should be equal to month of payment_id=5
select * from payment where 
month(payment_date)=(select month(payment_date) from payment where payment_id=5); 

select * from payment;
-- Get the customer_id, payment_id and the amount for the payments where the rental_id is less than the rental_id of payment_id= 7 and amount less than 5
select customer_id, payment_id, amount from payment where
rental_id<(select rental_id from payment where payment_id=7 and amount<5);

select * from payment;
-- Get the amount and the total no. of payments done where the total no. of payments is greater than the total no.of payments for amount=5.99
select amount, count(payment_id) from payment 
group by amount having count(payment_id)>(select count(payment_id) from payment where amount=5.99);

-- Multi row subquery :- We cannot use =,<=,>=,<,> operators

select amount from payment where payment_id in (3,1);
select * from payment
where amount=(select amount from payment where payment_id in (3,1));

-- (2.99, 5.99)
-- We use in or =any, <any, >any, >all, <all, >=all in multi row subquery
select * from payment
where amount in (select amount from payment where payment_id in (3,1));
select * from payment
where amount =any (select amount from payment where payment_id in (3,1) );

-- nested query => (2.99 , 5.99)
-- >any means greater than the minimum value of subquery, i.e. 2.99 here
select * from payment
where amount >any (select amount from payment where payment_id in (3,1));

-- <any means less than the maximum value of subquery
select * from payment
where amount <any (select amount from payment where payment_id in (3,1));

-- >all: greater than the maximum value of subquery
select * from payment
where amount >all (select amount from payment where payment_id in (3,1));

select * from payment
where amount >=all (select amount from payment where payment_id in (3,1));

select * from payment
where amount <all (select amount from payment where payment_id in (3,1));

