use regex;

CREATE TABLE emp (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(100),
    photo_path VARCHAR(255)
);

INSERT INTO emp (emp_id, emp_name, photo_path)
VALUES
(1, 'Mayuri Somani', 'C:\Users\lenovo\OneDrive\Pictures\Saved Pictures\img.jpg');

select * from emp;

-- window functions 
-- lag():- access previous row value
-- lead():- access next row value
-- ntile():- divides the result set into n equal groups (or buckets) and assigns a bucket number to each row

use regex;

CREATE TABLE sales_data (
    id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    region VARCHAR(20),
    month VARCHAR(10),
    sales INT
);

INSERT INTO sales_data (id, emp_name, region, month, sales) VALUES
(1, 'Asha',   'North', 'Jan', 12000),
(2, 'Asha',   'North', 'Feb', 15000),
(3, 'Asha',   'North', 'Mar', 14000),

(4, 'Ravi',   'South', 'Jan', 10000),
(5, 'Ravi',   'South', 'Feb', 13000),
(6, 'Ravi',   'South', 'Mar', 17000),

(7, 'Neha',   'East',  'Jan', 16000),
(8, 'Neha',   'East',  'Feb', 15500),
(9, 'Neha',   'East',  'Mar', 18000),

(10, 'Kiran', 'West',  'Jan', 9000),
(11, 'Kiran', 'West',  'Feb', 11000),
(12, 'Kiran', 'West',  'Mar', 15000);

select * from sales_data;

-- lag()
select emp_name, month, sales,
lag(sales) over(partition by emp_name order by id) as prev_month_sales
from sales_data;

-- lead()
select emp_name, month, sales,
lead(sales) over(partition by emp_name order by id) as next_month_sales
from sales_data;

-- ntile()
select emp_name, month, sales,
ntile(3) over(order by sales desc)
from sales_data;

-- CTE (Common Table Expression):- temporary named result set that we can reference within a single SQL query

select dept, avg(salary) as avg_salary
from employees
group by dept
having avg_salary > 50000;


with dept_avg as (select dept, avg(salary) as avg_salary
                 from employees group by dept)
select * from dept_avg 
where avg_salary > 50000;
