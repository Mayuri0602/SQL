-- DQL(Data Query Language):- window functions(imp. part of DQL)

-- A window function perform a calculation over a window of rows, defined by the over() clause.
-- partition by:- simialr values ke data ko har row ke sath apply karna

use sakila;
select payment_id, customer_id, amount,
avg(amount) over(),
avg(amount) over(partition by customer_id) from payment;

-- running sum:- 
select payment_id, customer_id, amount,
sum(amount) over(order by payment_id) from payment;

select payment_id, customer_id, amount, 
sum(amount) over (partition by customer_id),
sum(amount) over (partition by customer_id order by payment_id) from payment;

use employees;
select * from salaries;
create table salary1 
as select * from salaries limit 200;

-- Get the emp_no, total_salary, avg salary  from the salaries table.
select emp_no, sum(salary), avg(salary) from salary1 group by emp_no;

select emp_no, 
sum(salary) over(), 
avg(salary) over() from salary1;

-- Get the emp_no, salary, year of hiring along with the avg salary of that employee from the salaries table.
select emp_no, salary, year(from_date) as hiring_year,
avg(salary) over (partition by emp_no) from salary1;

-- Get the emp_no, salary, running salary for each customer from the salary table.
select emp_no, salary,
sum(salary) over (partition by emp_no order by from_date) as running_salary from salary1;

