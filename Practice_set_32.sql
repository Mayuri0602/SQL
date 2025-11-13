create database abhi;
use abhi;

CREATE TABLE sales (
    id INT PRIMARY KEY,
    employee VARCHAR(50),
    region VARCHAR(50),
    sale_date DATE,
    amount DECIMAL(10,2)
);

INSERT INTO sales (id, employee, region, sale_date, amount) VALUES
(1, 'Alice', 'East', '2024-01-05', 500),
(2, 'Bob', 'West', '2024-01-07', 300),
(3, 'Alice', 'East', '2024-01-10', 700),
(4, 'Charlie', 'North', '2024-01-11', 200),
(5, 'Bob', 'West', '2024-01-12', 450),
(6, 'Diana', 'South', '2024-01-13', 650),
(7, 'Alice', 'East', '2024-01-14', 250),
(8, 'Charlie', 'North', '2024-01-15', 900),
(9, 'Bob', 'West', '2024-01-16', 800),
(10, 'Diana', 'South', '2024-01-17', 300),
(11, 'Alice', 'East', '2024-02-01', 600),
(12, 'Bob', 'West', '2024-02-03', 1000),
(13, 'Charlie', 'North', '2024-02-04', 400),
(14, 'Diana', 'South', '2024-02-06', 750),
(15, 'Alice', 'East', '2024-02-07', 100),
(16, 'Bob', 'West', '2024-02-08', 200),
(17, 'Charlie', 'North', '2024-02-11', 850),
(18, 'Diana', 'South', '2024-02-13', 500),
(19, 'Alice', 'East', '2024-02-14', 900),
(20, 'Bob', 'West', '2024-02-15', 650),
(21, 'Charlie', 'North', '2024-03-01', 300),
(22, 'Diana', 'South', '2024-03-02', 200),
(23, 'Alice', 'East', '2024-03-04', 450),
(24, 'Bob', 'West', '2024-03-05', 780),
(25, 'Charlie', 'North', '2024-03-06', 620),
(26, 'Diana', 'South', '2024-03-08', 900),
(27, 'Alice', 'East', '2024-03-10', 840),
(28, 'Bob', 'West', '2024-03-11', 500),
(29, 'Charlie', 'North', '2024-03-12', 950),
(30, 'Diana', 'South', '2024-03-13', 700);

-- Rank each employee’s sales by amount (highest first)
select employee, amount,
rank() over(partition by employee order by amount desc) as sale_rank
from sales;

-- Calculate total and running total of sales per employee
select employee, sale_date, amount,
sum(amount) over (partition by employee) as total_sales,
sum(amount) over(partition by employee order by sale_date) as running_total
from sales;

-- Find each region’s average sale amount and show each sale compared to that average
select employee, sale_date, amount,
avg(amount) over(partition by region) as avg_sale_per_region,
amount - avg(amount) over(partition by region) as diff_from_avg
from sales;

-- Show top 3 sales per region
select * from (select id, employee, region, amount,
               dense_rank() over (partition by region order by amount desc) as rnk
               from sales) as t
where rnk <= 3;


