use sakila;
select * from payment;

-- Get the payment_id, cust_id, amount from the payment table where the amount spent by the customer
-- is greater than the avg amount done by the customer. 

select payment_id, customer_id, amount from payment p
where amount > (select avg(amount) from payment
               where customer_id = p.customer_id);
               
               
-- offset clause ka use tab hota hai jab query results mein se kuch rows skip karni hoti hain-- generally LIMIT ke saath use hota hai, jise kuch databases FETCH ke saath bhi replace karte hain
    
select * from actor order by actor_id limit 2,5;    
select * from actor order by actor_id limit 5 offset 3;    
    
-- Standard order of execution in MySQL
-- 1)From/Join     2)Where    3)Group by    4)Having     5)Select     6)Distinct    7)Order by     8)Limit/Offset

-- multi row subquery
select * from film_actor
where actor_id =any ( select actor_id from film_actor where film_id=140);


-- case      when condition then ?
--           when condition then ?
--           else
-- end

select *,
case when actor_id = 1 then 'Flop'
     when actor_id = 2 then 'Hit'
     else 'Average'
end as status
from film_actor;     


-- 1 -> actor has worked in a movie
-- 10 -> actor has worked in ___ movies

select actor_id, count(film_id) as total_movies,
case when count(film_id) = 1 then 'actor has worked in 1 movie'
     else concat('actor has worked in', count(film_id), 'movies')
end as no_of_movies_status
from film_actor
group by actor_id; 

