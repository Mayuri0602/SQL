create database december;
use december;

CREATE TABLE employees (
    emp_id INT,
    emp_name VARCHAR(50),
    department VARCHAR(30),
    salary INT,
    join_date DATE,
    manager_id INT
);

INSERT INTO employees VALUES
(1, 'Amit',   'IT',    60000, '2021-01-10', NULL),
(2, 'Riya',   'IT',    75000, '2020-03-15', 1),
(3, 'Neha',   'HR',    50000, '2022-07-01', 4),
(4, 'Raj',    'HR',    80000, '2019-05-20', NULL),
(5, 'Karan',  'Sales', 55000, '2021-11-12', 6),
(6, 'Pooja',  'Sales', 90000, '2018-09-30', NULL),
(7, 'Vikas',  'IT',    65000, '2023-02-18', 1);

select * from employees;

-- Display all emp from IT dept
select *
from employees
where department = 'IT';

-- Employees earning more than 60,000
select * 
from employees
where salary > 60000;

-- Sort employees by salary (high → low)
select * 
from employees
order by salary desc;

-- Department-wise total salary
select department, sum(salary)
from employees
group by department;

-- Department-wise average salary
select department, avg(salary)
from employees
group by department;

-- Employees earning more than average salary   (subquery ques)
select * 
from employees 
where salary > (select avg(salary) from employees);

-- Highest salary in each department   (subquery ques)
select * 
from employees as e
where salary = (select max(salary) from employees where department = e.department);

-- Employees earning more than department average      (correlated subquery runs once for each row)
select * 
from employees as e
where salary > (select avg(salary) 
                from employees
                where department = e.department);

-- Employees who earn more than their manager    (self join)
select *
from employees as e
join employees as m on e.manager_id = m.emp_id
where e.salary > m.salary;

-- Rank employees by salary (overall)
select emp_name, salary,
rank() over (order by salary desc) as rnk
from employees;

-- Rank employees department-wise
select *, 
rank() over(partition by department order by salary desc) as rnk_per_dept
from employees;

-- Find 2nd highest salary
with rnk as (select *, dense_rank() over(order by salary desc) as rk from employees)

select * from rnk where rk = 2; 

-- Employees joined after 2021
select emp_name, salary, join_date
from employees 
where join_date > '2021-12-31';

-- Employees joined in last 2 years
select * 
from employees
where join_date >= current_date() - interval 2 year;

-- Find departments having more than 2 employees
select department, count(emp_id)
from employees
group by department
having count(emp_id) > 2;

-- Employees earning more than department average       (cte)
with dept_avg as (select department, avg(salary) as avg_salary
                 from employees
                 group by department)

select * 
from employees as e
join dept_avg as d
on e.department = d.department
where e.salary > d.avg_salary;                 

-- Find the highest paid employee overall
select *
from employees
order by salary desc
limit 1;

-- Find employees without a manager
select emp_name, department, manager_id 
from employees
where manager_id is null;