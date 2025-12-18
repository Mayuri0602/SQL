use december;

create table empdetails (empid int, fullname varchar(30), managerid int, date_of_joining date, city varchar(20));
insert into empdetails values (121, 'Snow', 321, '2019-01-31', 'Toronto'),
                              (321, 'John', 986, '2020-01-30', 'California'),
                              (421, 'Kuldeep', 876, '2021-11-27', 'NEw Delhi');
select * from empdetails;

create table empsalary (empid int, project varchar(10), salary int, variable int);
insert into empsalary values (121, 'P1', 8000, 500),
                             (321, 'P2', 10000, 1000),
                             (421, 'P1', 12000, 0);
select * from empsalary;

-- SQL Query to fetch records that are present in one table but not in another table.
select ed.* 
from empdetails as ed
left join empsalary as es 
on ed.empid = es.empid
where es.empid is null; 

-- (To find records present in one table but not another, we use left join with null check, not in, or not exists)

select *
from empdetails e
where not exists (
    select 1
    from empsalary s
    where e.empid = s.empid
);

-- (SELECT 1 is used with EXISTS because we only need to check whether a matching row exists, not retrieve actual data)

-- SQL query to fetch all the employees who are not working on any project.
select e.empid
from empdetails e
where not exists (
    select 1
    from empsalary s
    where e.empid = s.empid
      and s.project is not null
);


select e.empid
from empdetails e
left join empsalary s
on e.empid = s.empid
where s.project is null;


-- SQL query to fetch all the Employees from EmployeeDetails who joined in the Year 2020.
select * 
from empdetails 
where year(date_of_joining) = 2020;


-- Fetch all employees from EmployeeDetails who have a salary record in EmployeeSalary.
select * 
from empdetails as e
where exists ( select 1 from empsalary where  e.empid = empid);


-- Write an SQL query to fetch a project-wise count of employees.
select project, count(empid)
from empsalary 
group by project; 


-- Fetch employee names and salaries even if the salary value is not present for the employee.
select ed.fullname, es.salary
from empdetails as ed
left join empsalary as es
on ed.empid = es.empid;


-- Write an SQL query to fetch all the Employees who are also managers.
select distinct ed.fullname
from empdetails as ed
join empdetails as es
on ed.empid = es.managerid;


-- Write an SQL query to fetch duplicate records from EmployeeDetails.
select *
from (select *,
	  row_number() over (
	  partition by empid
	  order by empid ) as rn from empdetails ) t
where rn > 1;


select empid, count(*) as cnt
from empdetails
group by empid
having count(*) > 1;



-- Write an SQL query to fetch only odd rows from the table.
select * 
from ( select *, row_number() over (order by empid) as rn from empdetails) as x
where rn % 2 = 1;



-- Write a query to find the 3rd highest salary from a table without top or limit keyword. 
with highest_salary as ( select *,
						dense_rank() over (order by salary desc) as rnk 
                        from empsalary)                             
                        
select * from highest_salary
where rnk = 3;                        