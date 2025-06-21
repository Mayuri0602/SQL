use employees;

-- Customers Table
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    city VARCHAR(50)
);

-- Products Table
CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2)
);

-- Sales Table
CREATE TABLE Sales (
    sale_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    quantity INT,
    sale_date DATE,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- Customers
INSERT INTO Customers VALUES
(1, 'Amit', 'Delhi'),
(2, 'Priya', 'Mumbai'),
(3, 'Rahul', 'Bangalore');

-- Products
INSERT INTO Products VALUES
(101, 'Laptop', 'Electronics', 60000),
(102, 'Smartphone', 'Electronics', 30000),
(103, 'Table', 'Furniture', 5000);

-- Sales
INSERT INTO Sales VALUES
(1, 1, 101, 1, '2023-10-01'),
(2, 2, 102, 2, '2023-10-05'),
(3, 1, 103, 1, '2023-10-10'),
(4, 3, 101, 1, '2023-10-15'),
(5, 3, 102, 1, '2023-10-20');

-- Show all customer names and cities.
select name, city 
from customers;

-- List product names and their categories where price > 10000.
select product_name, category
from products 
where price > 10000;

-- Show customer name, product name, and sale date.
select c.name as customer_name, p.product_name, s.sale_date
from customers as c
join sales as s on c.customer_id = s.customer_id
join products as p on s.product_id = p.product_id; 

-- Find total revenue (price × quantity) for each product.
select sum(price*quantity) as total_revenue, p.product_name
from products as p
join sales as s on p.product_id = s.product_id
group by p.product_name; 

-- Show total quantity sold per product.
select sum(quantity) as total_quantity, p.product_name
from sales as s 
join products as p on s.product_id = p.product_id
group by p.product_name;

-- List customer names who bought an 'Electronics' product.
select c.name
from customers as c
join sales as s on c.customer_id = s.customer_id
join products as p on s.product_id = p.product_id
where p.category = 'Electronics';

-- Find the city with the highest total sales revenue.
select c.city, sum(price*quantity) as highest_total_sales_revenue
from customers as c
join sales as s on c.customer_id = s.customer_id
join products as p on s.product_id = p.product_id
group by c.city
order by highest_total_sales_revenue desc
limit 1;

-- Show each sale with a running total of quantity sold per product category.
select s.sale_id, p.category, s.quantity, s.sale_date,
sum(quantity) over (partition by category order by sale_date) as running_total_quantity
from sales as s
join products as p on s.product_id = p.product_id;

