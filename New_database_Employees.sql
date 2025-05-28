use employees;
select * from employees;

-- Get those employees info whose year of hiring is same as the hiring year of 10002.
select * from employees 
where year(hire_date)=(select year(hire_date) from employees where emp_no=10002);

-- Get the employee no., birth date whose birth date is greater than the birth date among all the persons belonging to emp. no. 10003 to 10006.
select emp_no, birth_date from employees
where birth_date >all (select birth_date from employees where emp_no in (10003, 10006)); 

select * from titles;
select * from departments;

-- Get the emp_no, first_name, title for those employees who are currently working on the 'Senior Engineer' position.
select e.emp_no, e.first_name, t.title from employees as e
join titles as t on e.emp_no=t.emp_no 
where title = 'Senior Engineer';

-- Get the emp_name, birth date for a person who has started working in 1986.
select concat(first_name, ' ',last_name) as emp_name,  birth_date from employees
where year(hire_date) = 1986;

-- Get all the employees info only for that employee who have worked on more than 3 or more positions.
-- select emp_no, count(distinct(title)) from titles group by emp_no having count(distinct(title))>=3;
select * from employees 
where emp_no in (select emp_no from titles group by emp_no having count(distinct(title))>=3);

