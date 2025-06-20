create database school;
use school;

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(50),
    region VARCHAR(50)  );
    
INSERT INTO Customers (customer_id, name, region) VALUES
(1, 'Alice', 'North'),
(2, 'Bob', 'South'),
(3, 'Charlie', 'East'),
(4, 'Diana', 'West');

select * from Customers; 

CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    name VARCHAR(50),
    category VARCHAR(50),
    price DECIMAL(10, 2) );
    
INSERT INTO Products (product_id, name, category, price) VALUES
(101, 'Laptop', 'Electronics', 1000),
(102, 'Smartphone', 'Electronics', 700),
(103, 'Office Chair', 'Furniture', 150),
(104, 'Desk Lamp', 'Furniture', 40);

select * from Products;

CREATE TABLE Sales (
    sale_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    sale_date DATE,
    quantity INT,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id) );
    
INSERT INTO Sales (sale_id, customer_id, product_id, sale_date, quantity) VALUES
(1001, 1, 101, '2024-01-15', 1),
(1002, 1, 104, '2024-01-20', 2),
(1003, 2, 102, '2024-02-10', 1),
(1004, 3, 103, '2024-02-15', 3),
(1005, 3, 101, '2024-03-01', 1),
(1006, 4, 102, '2024-03-05', 2),
(1007, 1, 103, '2024-03-01', 1),
(1008, 2, 104, '2024-03-12', 4);

select * from Sales;

-- Find the total quantity sold and the total revenue for each product category.
select p.category, sum(s.quantity) as total_quantity, sum(p.price*s.quantity) as total_revenue
from sales as s
join products as p on s.product_id=p.product_id
group by p.category;

-- list names of customers who made purchases after March 1,2024.
select c.name 
from customers as c
join sales as s on c.customer_id=s.customer_id
where s.sale_date > '2024-03-01';

--  Find the names of customers who have purchased a product from the 'electronics' category   
    select c.name 
    from customers as c
    join sales as s on c.customer_id=s.customer_id
    join products as p on s.product_id=p.product_id
    where p.category='electronics';
    
-- Find each customer's most recent sale date.
select customer_id, max(sale_date) as recent_sale_date 
from sales 
group by customer_id;

-- Show each sale with a running total of quantity sold within its product category.
select s.sale_id, p.category, s.sale_date, s.quantity,
sum(s.quantity) over (partition by p.category 
                      order by s.sale_date, s.sale_id) as running_total_quantity
from sales as s
join products as p on s.product_id = p.product_id
order by p.category, s.sale_date, s.sale_id;




   
