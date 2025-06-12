use regex;
create table Employees30(emp_id int, emp_name varchar(20), department varchar(5), salary int,
joining_date date, manager_id int);

insert into Employees30 values
(1, 'AliceJohnson', 'IT',     75000, '2018-06-15', 5),
(2, 'BobSmith',     'HR',     68000, '2019-08-20', 6),
(3, 'CharlieLee',   'FIN',    72000, '2020-01-10', 7),
(4, 'DianaGreen',   'IT',     76000, '2021-03-05', 5),
(5, 'EvaBrown',     'IT',     90000, '2016-12-01', NULL),
(6, 'FrankWhite',   'HR',     85000, '2017-07-12', NULL),
(7, 'GeorgeBlack',  'FIN',    92000, '2015-11-23', NULL),
(8, 'HelenClark',   'IT',     72000, '2022-09-01', 1),
(9, 'IvyScott',     'HR',     67000, '2023-01-15', 2),
(10, 'JohnDoe',     'FIN',    71000, '2021-06-10', 3);

select * from Employees30;

-- List all employees in the IT department.
select * from employees30 
where department='IT';

-- Display the names of employees who joined after 1st Jan 2018.
select * from employees30 
where joining_date > '2018-01-01';

-- Find the total number of employees in the table.
select count(emp_id) from employees30 ;

-- Find the names and salaries of employees who earn more than ₹75,000.
select emp_name, salary from employees30 
where salary > 75000;

-- Show the name, department, and joining date of employees in ascending order of joining date.
select emp_name, department, joining_date from employees30
order by joining_date asc;

-- Find the employee with the highest salary.
select * from employees30 
where salary  =  (select max(salary) from employees30);

-- Count how many employees are there in each department.
select department, count(emp_id) from employees30 
group by department;

-- What is the average salary of employees in the HR department?
select department, avg(salary) from employees30 
where department ='HR' 
group by department;

-- List departments with more than 2 employees.
select department, count(emp_id) from employees30
group by department
having count(emp_id) > 2;

-- Find the total salary paid to employees under each manager.
select manager_id,  sum(salary) as total_salary from employees30
where manager_id is not null
group by manager_id;

-- List all unique departments in the company.
select distinct(department) from employees30;

-- Find all employees who do not manage anyone (i.e., whose emp_id is not present as any manager_id).
select emp_id, emp_name, manager_id from employees30
where emp_id not in (select distinct manager_id from employees30
                     where manager_id is not null);

select e.* from employees30 as e
left join employees30 as m on e.emp_id = m.manager_id
where m.manager_id is null;

-- Find all managers and list the employees reporting to them (using a self join).
select 
    m.emp_id as manager_id,
    m.emp_name as manager_name,
    e.emp_id as employee_id,
    e.emp_name as employee_name
from Employees30 as e
join Employees30 as m on e.manager_id = m.emp_id;

-- Show employees whose salary is above the average salary of all employees.
select emp_id, emp_name from employees30
where salary > (select avg(salary) from employees30);

-- Find names of employees who have the same salary as someone else.
select distinct e1.emp_name
from employees30 as e1
join employees30 as e2 on e1.salary = e2.salary and e1.emp_id != e2.emp_id;

select emp_name from employees30
where salary in (select salary from employees30
                 group by salary having count(*) > 1);

-- Display employee details along with their manager's name. (Using CTE)
with ManagerInfo as (
    SELECT emp_id AS manager_id, emp_name AS manager_name
    FROM employees30
)
SELECT *
FROM employees30 as e
JOIN ManagerInfo as m ON e.manager_id = m.manager_id;







