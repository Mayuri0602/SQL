use sakila;
select * from film_actor;
select * from actor;

-- Find the no. of actors who have worked in film_id=40.
select count(actor_id) from film_actor where film_id=40;

-- Find out those actors who have worked in film_id =40.
select concat(first_name,'  ', last_name) as actors from actor as a 
join film_actor as f on a.actor_id=f.actor_id
where  film_id=40;

-- Get total no. of movies done by each actor.
select actor_id, count(film_id) from film_actor group by actor_id;

-- Get the no. of actors who have worked in each movie.
select film_id, count(actor_id) from film_actor group by film_id;

-- Get only the film_id where no. of actors worked is greater than 2.
select film_id from film_actor group by film_id 
having count(actor_id) > 2;


select * from payment;

-- Get the no. of staff serving each customer, the total amount and avg(amount) spent by each customer
select customer_id, count(staff_id), sum(amount) as total_amount, avg(amount)
from payment
group by customer_id;

-- Get the total amount spent by each staff member for each customer 
select staff_id, customer_id, sum(amount) as total_amount_spent
from payment
group by staff_id, customer_id;

-- total amount spent for each month of a year
select year(payment_date), month(payment_date), sum(amount) as total_amount
from payment
group by year(payment_date), month(payment_date);

select * from payment;

-- Get all the columns whose payment_date is greater than the payment_date for payment_id=3
select * from payment 
where payment_date > (select payment_date from payment where payment_id=3); 

-- Get those info where the staff_id and the amount is same as that of payment_id=2
-- multi-column subquery
select * from payment
where (staff_id, amount)= (select staff_id, amount from payment where payment_id=2);

-- Get those customers and the total no. of payment done where total no. of payment done > total no. of payments done by customer_id=2
select customer_id, count(payment_id)  from payment group by customer_id 
having count(payment_id) > (select count(payment_id) from payment where customer_id = 2);
