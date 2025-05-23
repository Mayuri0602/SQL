use regex;

select * from customers;

select * from orders02;

-- List the maximum single order amount by each customer.
select max(amount), customer_id
from orders02
group by customer_id;

-- Show the total order value and order count for each customer.
select customer_id, sum(amount), count(order_id)
from orders02
group by customer_id;

-- List each order with the customer's name and country.
select o.order_id, c.cust_name, c.country
from customers as c
join orders02 as o on c.customer_id=o.customer_id;

-- List all customers and their corresponding orders. Show customers even if they haven't placed any orders.
select c.cust_name, o.order_id
from customers as c
left join orders02 as o on c.customer_id=o.customer_id; 

-- List customers who haven't  placed any orders.
select c.cust_name, c.customer_id 
from customers as c
join orders02 as o on c.customer_id=o.customer_id
where o.order_id is null;

-- List the most recent order for each customer.
select customer_id, max(order_date)
from orders02
group by customer_id;

-- Find the total amount spent by customers from the USA.
select o.customer_id, sum(o.amount)
from orders02 as o
join customers as c on o.customer_id=o.customer_id
where c.country='USA'
group by o.customer_id;

-- List orders that were placed in April 2024 alomg with customer info.
select c.customer_id, c.cust_name, c.country
from customers as c 
join orders02 as o on c.customer_id= o.customer_id
where o.order_date between '2024-04-01' and '2024-04-30';
