use december;

create table employee( 
emp_id INT,
emp_name VARCHAR(50),
department_id INT,
salary INT,
joining_date DATE);

create table department 
(department_id INT,
department_name VARCHAR(50),
manager_id INT);

INSERT INTO employee (emp_id, emp_name, department_id, salary, joining_date) VALUES
(1, 'Amit Sharma', 10, 75000, '2019-06-15'),
(2, 'Neha Verma', 10, 90000, '2020-01-10'),
(3, 'Rohit Mehta', 20, 60000, '2018-08-20'),
(4, 'Priya Singh', 20, 65000, '2021-03-05'),
(5, 'Ankit Patel', 30, 82000, '2017-11-12'),
(6, 'Sneha Kapoor', 30, 95000, '2016-04-18'),
(7, 'Rahul Jain', 40, 70000, '2019-09-25'),
(8, 'Pooja Malhotra', 40, 72000, '2022-02-14'),
(9, 'Karan Gupta', 10, 90000, '2018-12-01'),
(10, 'Simran Kaur', NULL, 68000, '2020-07-30');

INSERT INTO department (department_id, department_name, manager_id) VALUES
(10, 'IT', 101),
(20, 'HR', 102),
(30, 'Finance', 103),
(40, 'Marketing', 104),
(50, 'Operations', 105);


-- Fetch employee name and department name.
select e.emp_name, d.department_name
from employee as e
left join department as d on e.department_id = d.department_id;

-- List all employees who work in the IT department.
select e.emp_name 
from employee as e
left join department as d 
on e.department_id = d.department_id 
where d.department_name = 'IT';

-- Find employees whose salary is greater than 60,000 along with department name.
select e.emp_name, d.department_name
from employee as e
left join department as d 
on e.department_id = d.department_id
where e.salary > 60000;

-- Display employees who do not belong to any department.
select e.emp_name
from employee as e
left join department as d
on e.department_id = d.department_id
where d.department_id is null;

-- Find departments that have no employees.
select d.department_name 
from department as d 
left join employee as e
on d.department_id = e.department_id
where e.department_id is null;

-- Find department-wise average salary.
select d.department_name, avg(salary)
from employee as e
left join department as d
on e.department_id = d.department_id
group by d.department_name; 

-- Find number of employees in each department.
select d.department_name, count(emp_id) as count_of_emp
from employee as e
left join department as d 
on e.department_id = d.department_id
group by d.department_name;

-- Display departments having more than 3 employees.
select d.department_name
from employee as e
left join department as d
on e.department_id = d.department_id
group by d.department_name
having count(emp_id) > 3;

-- Find maximum salary in each department.
select d.department_name, max(salary)
from employee as e
left join department as d
on e.department_id = d.department_id
group by d.department_name;

-- Get departments where average salary > 70,000.
select d.department_name
from employee as e
left join department as d
on e.department_id = d.department_id
group by d.department_name
having avg(e.salary) > 70000;


SELECT department_name
FROM department
WHERE department_id IN (
    SELECT department_id
    FROM employee
    GROUP BY department_id
    HAVING AVG(salary) > 70000
);


-- Find employees who earn more than the average salary of their department.
select e.emp_name
from employee as e
join department as d
on e.department_id = d.department_id
where salary > (select avg(salary) from employee
               where e.department_id = department_id);


-- Find the highest paid employee in each department.
select e.emp_name
from employee as e
join department as d 
on e.department_id = d.department_id
where e.salary = (select max(salary) from employee where department_id = e.department_id);


SELECT emp_name, department_name, salary
FROM (
    SELECT e.emp_name, d.department_name, e.salary,
           RANK() OVER (PARTITION BY e.department_id ORDER BY e.salary DESC) AS rnk
    FROM employee e
    JOIN department d
    ON e.department_id = d.department_id
) t
WHERE rnk = 1;


-- Find departments where no employee earns more than 80,000.
select d.department_name 
from department as d
join employee as e
on e.department_id = d.department_id
group by d.department_name
having max(e.salary) < 80000;


SELECT d.department_name
FROM department d
WHERE NOT EXISTS (
    SELECT 1
    FROM employee e
    WHERE e.department_id = d.department_id
      AND e.salary > 80000
);


-- List employees who joined before their department manager.
SELECT e.emp_name
FROM employee e
JOIN department d
ON e.department_id = d.department_id
JOIN employee m
ON d.manager_id = m.emp_id
WHERE e.joining_date < m.joining_date;



-- Find employees working in departments managed by manager_id = 101.
SELECT e.emp_name
FROM employee e
JOIN department d
ON e.department_id = d.department_id
WHERE d.manager_id = 101;


-- Fetch the top 2 highest-paid employees from each department.
with dept_highest_sal as (select emp_name, salary, department_name,
                         dense_rank() over (partition by department_name order by salary desc) as rk
                         from employee as e join department as d on e.department_id = d.department_id)
select * 
from dept_highest_sal 
where rk <= 2;                         

-- Find departments with at least one employee earning more than 90,000.
select d.department_name
from employee as e
join department as d
on e.department_id = d.department_id
where e.salary > 90000
group by department_name; 

-- Find employees whose salary is same as someone else in the same department.
select e.emp_name
from employee e
where exists (
    select 1
    from employee e2
    where e.department_id = e2.department_id
      and e.salary = e2.salary
      and e.emp_id <> e2.emp_id
);


-- Display department name and total salary expense.
select d.department_name, sum(salary)
from employee as e
join department as d 
on e.department_id = d.department_id
group by d.department_name;


-- Find employees who work in the department with the highest average salary.
with dept_avg_sal as (
    select 
        department_id,
        avg(salary) as avg_salary
    from employee
    group by department_id
),
ranked_dept as (
    select 
        department_id,
        dense_rank() over (order by avg_salary desc) as rk
    from dept_avg_sal
)
select e.emp_name
from employee e
join ranked_dept r
on e.department_id = r.department_id
where r.rk = 1;

