-- TCL :- Transaction Control Language used to control & manage transactions in a database
-- transaction - set of logical statements or a sequence of one or more sql operations(dml operations)

create database testing12;
use testing12;
create table xyz(id int, name varchar(20));
insert into xyz values(10, 'mayu'), (11, 'aman');
select * from xyz;

-- transaction start
-- ddl/dml operations
-- transaction end

-- 1) disable autocommit / write statement for transaction start in order to start the transaction
-- 2)
-- 3) to end the trnsaction, we use (commit, rollback, ddl, dcl statemennts)

-- commit - permanently save the changes in a database

-- rollback - discard the changes in a database 

start transaction;
insert into xyz values(12, 'tushar');
select * from xyz;
commit;


start transaction;
set sql_safe_updates = 0;    -- safe mode disable
delete from xyz;
insert into xyz values(100, 'shri');
select * from xyz;
rollback;                    -- revert the transaction

-- pending transactions are autosaved on running ddl operations
-- drop and truncate cannot be revert back because these are ddl operations (and ddl operations are autosaved)

create table yas123(id int);

-- savepoint :- saves a point within a transaction  to which we can later rollback

start transaction;
update xyz set name = 'sana';
savepoint tushar_savepoint;
insert into xyz values(101, 'chitthi');
rollback to tushar_savepoint;
select * from xyz;

-- recursive cte example

with recursive cte as (
select e.emp_name, e.emp_id, e.emp_name as managerchain
from employees as e
where e.manager_id is null
union
select e.emp_id, e.emp_name,
concat(m.managerchain,  ' -> ', e.emp_name) as managerchain
from employees as e
join cte as m on e.manager_id = m.emp_id)

select * from cte;


