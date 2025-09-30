-- Write a query to return the absolute value of -35.
select abs(-35) as absolute_value;

-- Find the square root of 225.
select sqrt(225) as square_root; 

-- Use ROUND() to round the value 123.4567 to:
-- 2 decimal places
select round(123.4567, 2);

-- 0 decimal places
select round(123.4567);

-- Use CEIL() and FLOOR() on 56.78.
select ceil(56.78), floor(56.78);

-- Write a query to return the modulus of 25 ÷ 4.
select mod(25, 4);

use sakila;

select * from payment;

select customer_id, amount, count(amount)
from payment group by customer_id, amount;

-- how much amount we have spent in each year
select sum(amount), year(payment_date)  
from payment 
group by year(payment_date);

-- 
select sum(amount), year(payment_date), staff_id  
from payment 
group by year(payment_date), staff_id;

-- order by:- sorting in asc & desc order
select * from payment order by rental_id;   -- asc order

select * from payment order by customer_id desc, amount desc; 

-- conditional functions(statements)
select customer_id, amount, if (amount>3, "High", "Low") from payment;

select customer_id, amount, if(amount=2.99, "High", if(amount=5.99, "Avg", "Low")) from payment;

select customer_id, amount, 
case 
     when amount = 2.99 then "High"
     when amount = 5.99 then "Avg"
     else "Low"
end as Salary
from payment;     

-- select cust id and status if the cust id > 1 print hello, cust id > 4 print user otherwise print regex
select customer_id, 
case 
	when customer_id > 4 then "User"
    when customer_id > 1 then "Hello"
    else "Regex"
end as "Status"
from payment;    













