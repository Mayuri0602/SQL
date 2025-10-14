create database corrdb;
use corrdb;

-- Create products table
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10, 2)
);

-- Create sales table
CREATE TABLE sales (
    sale_id INT PRIMARY KEY,
    product_id INT,
    quantity INT,
    sale_date DATE,
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Insert data into products
INSERT INTO products (product_id, product_name, category, price) VALUES
(1, 'Laptop', 'Electronics', 1200.00),
(2, 'Phone', 'Electronics', 800.00),
(3, 'Chair', 'Furniture', 150.00),
(4, 'Desk', 'Furniture', 300.00),
(5, 'Monitor', 'Electronics', 250.00);

-- Insert data into sales
INSERT INTO sales (sale_id, product_id, quantity, sale_date) VALUES
(1, 1, 3, '2025-09-10'),
(2, 2, 5, '2025-09-11'),
(3, 1, 2, '2025-09-15'),
(4, 3, 7, '2025-09-12');

select * from products;
select * from sales;

-- list all the prod whose price is higher than the avg price of other products in the same category.
select po.product_name 
from products as po
where po.price > (select avg(price) from products as pi where po.category = pi.category);

-- select category, avg(price) 
-- from products 
-- group by category; 

-- exists and in keyword


-- get all the products that have been sold more than 3 times in any single sale transaction.
select p.product_name, s.quantity
from products as p 
join sales as s on p.product_id = s.product_id 
and s.quantity > 3;


select product_name 
from products as p 
where p.product_id in (select s.product_id from sales as s 
                      where p.product_id = s.product_id and quantity > 3);
                      

-- second highest price
-- limit operator
-- offset operator

select max(price) 
from products  
where price < (select max(price) from products);  

-- for full info
select * from products
where price =  (select max(price) 
               from products  
			   where price < (select max(price) from products));     
  
-- for 2nd lowest price   
select * from products
where price =  (select min(price) 
               from products  
			   where price > (select min(price) from products)); 
               
-- get all the info from products table where price is greater than price of pid = 3
select * from products 
where price > (select price from products where product_id = 3);

-- get all the info from prod table where category of the product is same as product_id = 2
select * from products
where category in (select category from products where product_id = 2);

-- get all the info from prod table where category of the prod is same as pid = 2 and pid = 3
select * from products 
where category in (select category from products where product_id = 2 and product_id = 3);

-- select * from products 
-- where category in (select category from products where product_id = 2 or product_id = 3);

-- get all the info from prod table where the price of the prod is greater than among all the prices of product in furniture category
select * from products
where price >all (select price from products where category = 'Furniture');

-- get the pid, pname and total quantity sold for each product
select p.product_id, p.product_name, sum(s.quantity)
from products as p
join sales as s on p.product_id = s.product_id
group by p.product_name, p.product_id;


     
               
               
                      