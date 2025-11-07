create database windfunc;

use windfunc;

CREATE TABLE sales (
    id INT,
    employee_name VARCHAR(50),
    department VARCHAR(50),
    sale_date DATE,
    sale_amount DECIMAL(10,2)
);

INSERT INTO sales VALUES
(1, 'Alice', 'Electronics', '2024-01-05', 1000),
(2, 'Bob', 'Electronics', '2024-01-10', 800),
(3, 'Alice', 'Electronics', '2024-02-02', 1200),
(4, 'David', 'Furniture', '2024-01-07', 400),
(5, 'Emma', 'Furniture', '2024-01-18', 700),
(6, 'David', 'Furniture', '2024-02-15', 900),
(7, 'Bob', 'Electronics', '2024-02-20', 1500),
(8, 'Alice', 'Electronics', '2024-03-01', 1300),
(9, 'Emma', 'Furniture', '2024-03-05', 1100),
(10, 'David', 'Furniture', '2024-03-08', 500);

-- For each employee, find the difference between the current and previous sale amount using LAG().
select employee_name, sale_date, sale_amount,
lag(sale_amount) over(partition by employee_name order by sale_date) as prev_sales,
sale_amount - lag(sale_amount) over(partition by employee_name order by sale_date) as diff
from sales
order by employee_name, sale_date;

-- Rank employees within each department by their total sales.
select employee_name, department,
sum(sale_amount) as total_sales,
rank() over (partition by department order by sum(sale_amount) desc) as ranking
from sales
group by department, employee_name
order by department, ranking;

-- Compute cummulative sales per department over time.
select department, sale_date, sale_amount,
sum(sale_amount) over (partition by department order by sale_date) as dept_cum_sum
from sales
order by department, sale_date;

-- Show the difference between each sale and the department average.
select department, employee_name, sale_amount,
round(avg(sale_amount) over (partition by department), 2) as dept_avg,
sale_amount - avg(sale_amount) over (partition by department) as diff_from_avg
from sales;

-- Get top 2 highest sale records in each department.
SELECT *
FROM (SELECT 
        department, employee_name, sale_amount,
        RANK() OVER (PARTITION BY department ORDER BY sale_amount DESC) AS rnk
        FROM sales) as ranked
WHERE rnk <= 2;



