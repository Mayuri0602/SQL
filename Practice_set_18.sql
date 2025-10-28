-- Window or Analytical functions used to perform aggregation on each row 

use regex;
CREATE TABLE EmployeeSales (
    EmployeeID INT,
    EmployeeName VARCHAR(100),
    Department VARCHAR(50),
    SaleDate DATE,
    SaleAmount DECIMAL(10, 2)
);


INSERT INTO EmployeeSales (EmployeeID, EmployeeName, Department, SaleDate, SaleAmount) VALUES
(1, 'Alice', 'Sales', '2025-06-01', 1200.00),
(1, 'Alice', 'Sales', '2025-06-03', 1800.00),
(1, 'Alice', 'Sales', '2025-06-07', 1500.00),
(2, 'Bob', 'Sales', '2025-06-01', 2000.00),
(2, 'Bob', 'Sales', '2025-06-05', 2200.00),
(2, 'Bob', 'Sales', '2025-06-08', 2100.00),
(3, 'Carol', 'Marketing', '2025-06-02', 3000.00),
(3, 'Carol', 'Marketing', '2025-06-06', 2800.00),
(3, 'Carol', 'Marketing', '2025-06-10', 2700.00),
(4, 'Dave', 'Marketing', '2025-06-01', 1000.00),
(4, 'Dave', 'Marketing', '2025-06-03', 1100.00),
(4, 'Dave', 'Marketing', '2025-06-09', 1300.00),
(5, 'Eve', 'HR', '2025-06-04', 900.00),
(5, 'Eve', 'HR', '2025-06-07', 950.00),
(5, 'Eve', 'HR', '2025-06-10', 1000.00),
(6, 'Frank', 'Sales', '2025-06-02', 1700.00),
(6, 'Frank', 'Sales', '2025-06-05', 1900.00),
(6, 'Frank', 'Sales', '2025-06-09', 1600.00),
(7, 'Grace', 'Finance', '2025-06-01', 2500.00),
(7, 'Grace', 'Finance', '2025-06-06', 2400.00),
(7, 'Grace', 'Finance', '2025-06-10', 2600.00),
(8, 'Hank', 'Finance', '2025-06-03', 2300.00),
(8, 'Hank', 'Finance', '2025-06-04', 2200.00),
(8, 'Hank', 'Finance', '2025-06-08', 2100.00),
(9, 'Ivy', 'HR', '2025-06-02', 800.00),
(9, 'Ivy', 'HR', '2025-06-06', 850.00),
(9, 'Ivy', 'HR', '2025-06-09', 950.00),
(10, 'Jake', 'IT', '2025-06-05', 3000.00),
(10, 'Jake', 'IT', '2025-06-07', 3200.00),
(10, 'Jake', 'IT', '2025-06-10', 3100.00);

select * from employeeSales;

select employeename, sum(saleamount) from employeesales group by employeename;


select *, sum(saleamount) over(),
avg(saleamount) over() from employeesales;

select *, max(saleamount) over(partition by employeename) from employeesales;

select *, max(saleamount) over(partition by department) from employeesales;

select *, max(saleamount) over(),
max(saleamount) over(partition by employeename) from employeesales;

-- over(order by):- running sum or cummulative sum (take that col in order by which is unique)

-- runninng sum (cummulative sum) of full data
select *, sum(saleamount) over(order by saleamount) from employeesales;

-- running sum of each department
select *, sum(saleamount) over(partition by department order by saleamount) from employeesales;

-- running sum of each user
select *, sum(saleamount) over(partition by employeename order by saleamount) from employeesales;

create database window_test;

use window_test;

CREATE TABLE employee_sales (
    emp_id INT AUTO_INCREMENT PRIMARY KEY,
    emp_name VARCHAR(50),
    department VARCHAR(50),
    sale_amount DECIMAL(10,2),
    sale_date DATE
);

-- 2. Insert at least 20 sample records
INSERT INTO employee_sales (emp_name, department, sale_amount, sale_date) VALUES
('Alice', 'Electronics', 1200.00, '2025-01-10'),
('Bob', 'Electronics', 950.00, '2025-01-12'),
('Charlie', 'Furniture', 2100.00, '2025-01-15'),
('David', 'Furniture', 1800.00, '2025-01-18'),
('Ella', 'Clothing', 400.00, '2025-01-20'),
('Frank', 'Clothing', 750.00, '2025-01-22'),
('Grace', 'Clothing', 600.00, '2025-01-23'),
('Henry', 'Electronics', 1300.00, '2025-01-24'),
('Isabella', 'Furniture', 2500.00, '2025-01-25'),
('Jack', 'Clothing', 900.00, '2025-01-26'),
('Karen', 'Electronics', 1450.00, '2025-01-28'),
('Leo', 'Furniture', 1900.00, '2025-01-29'),
('Mona', 'Clothing', 500.00, '2025-01-30'),
('Nate', 'Electronics', 1600.00, '2025-02-01'),
('Olivia', 'Clothing', 800.00, '2025-02-02'),
('Peter', 'Furniture', 1700.00, '2025-02-03'),
('Quinn', 'Electronics', 1250.00, '2025-02-04'),
('Rose', 'Clothing', 1000.00, '2025-02-05'),
('Steve', 'Furniture', 2200.00, '2025-02-06'),
('Tina', 'Electronics', 1800.00, '2025-02-07');


select * from employee_sales;

select *, sum(sale_amount) over(partition by department) from employee_sales;

select *, sum(sale_amount) over(order by department) from employee_sales;

select *, sum(sale_amount) over(partition by department order by sale_amount) from employee_sales;

-- row_number():- assigns unique sequential number to each row

select *, sum(sale_amount) over(partition by department order by sale_amount),
row_number() over(partition by department) from employee_sales;

-- rank():- assigns rank without gaps for ties (1,2,2,4)

select *, sum(sale_amount) over(partition by department order by sale_amount),
rank() over(partition by department) from employee_sales;

update employee_sales set sale_amount = 500 where emp_id = 7;

select * from employee_sales;

select *, sum(sale_amount) over(partition by department),
rank() over(partition by department order by sale_amount) from employee_sales;

-- dense_rank():- assigns rank without gaps (1, 2, 3, 3, 5)

select *, sum(sale_amount) over(partition by department),
rank() over(partition by department order by sale_amount),
dense_rank() over (partition by department order by sale_amount) from employee_sales;


