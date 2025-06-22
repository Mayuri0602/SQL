use regex1;

-- Customers
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    city VARCHAR(50)
);

-- Products
CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2)
);

-- Orders
CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- Order_Items (one order → many products)
CREATE TABLE Order_Items (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- Customers
INSERT INTO Customers VALUES
(1, 'Amit', 'amit@gmail.com', 'Delhi'),
(2, 'Priya', 'priya@gmail.com', 'Mumbai'),
(3, 'Rahul', 'rahul@gmail.com', 'Bangalore');

-- Products
INSERT INTO Products VALUES
(101, 'Phone', 'Electronics', 25000),
(102, 'Headphones', 'Electronics', 3000),
(103, 'Shoes', 'Fashion', 4000),
(104, 'T-shirt', 'Fashion', 1500);

-- Orders
INSERT INTO Orders VALUES
(1, 1, '2024-05-01', 28000),
(2, 2, '2024-05-03', 7000),
(3, 1, '2024-05-10', 1500),
(4, 3, '2024-05-15', 4000);

-- Order Items
INSERT INTO Order_Items VALUES
(1, 1, 101, 1), 
(2, 1, 102, 1), 
(3, 2, 103, 1), 
(4, 2, 104, 2), 
(5, 3, 104, 1), 
(6, 4, 103, 1); 

-- Show all customer names and their cities.
select name, city
from customers;

-- List all products with price more than 5000.
select product_name, price
from products
where price > 5000; 

-- Show each order with customer name and total amount.
select c.name as customer_name, o.order_id, o.total_amount
from customers as c
join orders as o on c.customer_id=o.customer_id;

-- Display all products bought by ‘Amit’ with their quantity.
select p.product_name, oi.quantity 
from products as p
join order_items as oi on p.product_id=oi.product_id
join orders as o on oi.order_id=o.order_id
join customers as c on o.customer_id=c.customer_id
where c.name = 'Amit';

-- Show total quantity sold per product.
select p.product_id, p.product_name, sum(oi.quantity) as total_quantity
from order_items as oi
join products as p on oi.product_id=p.product_id
group by p.product_id, p.product_name;

-- Find total revenue per category.
select p.category, sum(price*quantity) as total_revenue
from products as p
join order_items as oi on p.product_id=oi.product_id
group by p.category;

-- List customers who made more than one order.
select c.name as customer_name
from customers as c
join orders as o on c.customer_id=o.customer_id
group by c.name 
having count(order_id) > 1;

-- Show each customer with their first order date (Window function).
select c.name as customer_name, min(o.order_date) as first_order_date
from customers as c
join orders as o on c.customer_id= o.customer_id
group by c.name;





