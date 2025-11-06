use testing12;

CREATE TABLE departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50)
);

CREATE TABLE employee (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    dept_id INT,
    salary DECIMAL(10,2),
    manager_id INT,
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);

CREATE TABLE projects (
    project_id INT PRIMARY KEY,
    project_name VARCHAR(100),
    dept_id INT,
    budget DECIMAL(10,2),
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);

INSERT INTO departments (dept_id, dept_name) VALUES
(10, 'HR'),
(20, 'IT'),
(30, 'Finance');


INSERT INTO employee (emp_id, emp_name, dept_id, salary, manager_id) VALUES
(1, 'Alice', 10, 90000, NULL),
(2, 'Bob', 10, 70000, 1),
(3, 'Charlie', 20, 60000, 1),
(4, 'David', 20, 50000, 3),
(5, 'Eva', 30, 40000, 2),
(6, 'Frank', 30, 55000, 2);


INSERT INTO projects (project_id, project_name, dept_id, budget) VALUES
(101, 'RecruitApp', 10, 150000),
(102, 'PayrollSys', 30, 250000),
(103, 'WebPortal', 20, 300000),
(104, 'DataHub', 20, 200000);

-- Use a CTE to find employees whose salary is greater than the average salary of all employees.
WITH avg_sal AS (
  SELECT AVG(salary) AS avg_salary
  FROM employee
)
SELECT e.emp_name, e.salary
FROM employee e, avg_sal
WHERE e.salary > avg_sal.avg_salary;

-- Show department name and total salary expense using a CTE.
WITH dept_salary AS (
  SELECT dept_id, SUM(salary) AS total_salary
  FROM employee
  GROUP BY dept_id
)
SELECT d.dept_name, ds.total_salary
FROM dept_salary ds
JOIN departments d ON d.dept_id = ds.dept_id;

-- Show employees who earn more than their manager.
WITH emp_manager AS (
  SELECT e.emp_name AS employee, e.salary AS emp_salary,
         m.emp_name AS manager, m.salary AS mgr_salary
  FROM employees e
  JOIN employees m ON e.manager_id = m.emp_id
)
SELECT *
FROM emp_manager
WHERE emp_salary > mgr_salary;

-- Find the second highest salary using a CTE.
WITH ranked AS (
  SELECT salary,
         DENSE_RANK() OVER (ORDER BY salary DESC) AS rnk
  FROM employee
)
SELECT salary
FROM ranked
WHERE rnk = 2;


-- Count employees in each department having salary > 50000
WITH high_paid AS (
  SELECT dept_id, COUNT(*) AS cnt
  FROM employees
  WHERE salary > 50000
  GROUP BY dept_id
)
SELECT d.dept_name, h.cnt
FROM high_paid h
JOIN departments d ON d.dept_id = h.dept_id;


-- Show top 2 highest paid employees in each department.
WITH ranked AS (
  SELECT emp_id, emp_name, dept_id, salary,
         DENSE_RANK() OVER (PARTITION BY dept_id ORDER BY salary DESC) AS rnk
  FROM employee
)
SELECT emp_name, dept_id, salary
FROM ranked
WHERE rnk <= 2;

-- Find departments whose total project budget > 200000.
WITH dept_budget AS (
  SELECT dept_id, SUM(budget) AS total_budget
  FROM projects
  GROUP BY dept_id
)
SELECT d.dept_name, db.total_budget
FROM dept_budget db
JOIN departments d ON d.dept_id = db.dept_id
WHERE db.total_budget > 200000;

-- Show department with highest total salary.
WITH dept_total AS (
  SELECT dept_id, SUM(salary) AS total_salary
  FROM employee
  GROUP BY dept_id
),
ranked AS (
  SELECT dept_id, total_salary,
         RANK() OVER (ORDER BY total_salary DESC) AS rnk
  FROM dept_total
)
SELECT d.dept_name, r.total_salary
FROM ranked r
JOIN departments d ON d.dept_id = r.dept_id
WHERE r.rnk = 1;

-- Find employees who work in departments having more than one project.
WITH dept_proj_count AS (
  SELECT dept_id, COUNT(project_id) AS proj_count
  FROM projects
  GROUP BY dept_id
  HAVING COUNT(project_id) > 1
)
SELECT e.emp_name, d.dept_name
FROM employee e
JOIN dept_proj_count dp ON e.dept_id = dp.dept_id
JOIN departments d ON e.dept_id = d.dept_id;







