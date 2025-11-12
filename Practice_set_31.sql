use college;

CREATE TABLE departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50)
);


CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    dept_id INT,
    salary DECIMAL(10,2),
    hire_date DATE,
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);


INSERT INTO departments (dept_id, dept_name)
VALUES
(10, 'HR'),
(20, 'IT'),
(30, 'Finance');


INSERT INTO employees (emp_id, emp_name, dept_id, salary, hire_date)
VALUES
(1, 'Riya', 10, 50000, '2021-02-10'),
(2, 'Aman', 20, 60000, '2020-06-12'),
(3, 'Neha', 10, 70000, '2022-01-01'),
(4, 'Rahul', 30, 40000, '2021-09-18'),
(5, 'Simran', 20, 65000, '2019-11-25');


-- Find total salary paid in each department.
select dept_id, sum(salary) as total_salary
from employees
group by dept_id;

-- Find average salary per department.
select dept_id, avg(salary) as avg_salary
from employees
group by dept_id;

-- Count employees in each department.
select dept_id, count(emp_id) as count_employees
from employees 
group by dept_id;

-- Find department with maximum total salary.
select d.dept_name, sum(e.salary) as total_salary
from employees as e
join departments as d on e.dept_id = d.dept_id
group by d.dept_name
order by total_salary desc limit 1;

-- Show employee names along with their department names.
select e.emp_name, d.dept_name
from employees as e
join departments as d on e.dept_id = d.dept_id;

-- Show department names and the number of employees in each.
select d.dept_name, count(e.emp_id)
from departments as d
left join employees as e on d.dept_id = e.dept_id 
group by d.dept_name;

-- Show employees who earn above their department’s average salary.
SELECT emp_name, salary, dept_id
FROM employees as e
WHERE salary > (SELECT AVG(salary)
                 FROM employees as e2
                 WHERE e2.dept_id = e.dept_id);
                 
-- Show each employee’s salary rank within their department.
SELECT emp_name, dept_id, salary,
       RANK() OVER (PARTITION BY dept_id ORDER BY salary DESC) AS salary_rank
FROM employees;

-- Find each employee’s average department salary alongside their own.
SELECT emp_name, dept_id, salary,
       AVG(salary) OVER (PARTITION BY dept_id) AS dept_avg_salary
FROM employees;


-- Show the cumulative salary within each department (ordered by salary).
SELECT emp_name, dept_id, salary,
       SUM(salary) OVER (PARTITION BY dept_id ORDER BY salary) AS running_total
FROM employees;
                 

