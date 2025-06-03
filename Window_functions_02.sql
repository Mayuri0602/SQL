use sakila;
select * from payment;

select payment_id, customer_id, amount,
sum(amount) over()
from sakila.payment;

select payment_id, customer_id, amount,
sum(amount) over(partition by customer_id)
from sakila.payment;

-- rank():- gives the same rank to rows with equal values in the order by column, 
-- skips rank after duplicates.  (1,1,1,4,4,4,4,8)

select payment_id, customer_id, amount,
sum(amount) over(partition by customer_id),
rank() over(partition by customer_id order by amount desc)
from sakila.payment;

-- dense_rank():- same as rank, but does not skip rank after duplicates. (1,1,2,2,2,3)

select payment_id, customer_id, amount,
sum(amount) over(partition by customer_id) as total_sum,
dense_rank() over(partition by customer_id order by amount desc) as rank1
from sakila.payment;

-- Filter those payment id and customer id who have the 3rd most ranking.

select * from 
          (select payment_id, customer_id, amount,
          dense_rank() over(order by amount desc) as drank1
          from sakila.payment) as tab where drank1=3;
          
          
-- how to insert and update data ?
-- insert, update, delete are DML operations 
-- create is DDL operation 
-- select is DQL operation

use sakila;
create table xyz(id int, fname varchar(20));
insert into xyz values(10, 'aman');
insert into xyz(id) values (11);
insert into xyz(fname) values ('aditi');       -- fname=> null 
select * from xyz;

update xyz set fname='regex';    -- all rows are updated
update xyz set fname='tushar' where id=10;
select * from xyz;

-- delete from xyz (whole table is deleted)
delete from xyz where id=11;   -- (conditions should be given so that the whole data does not get affected)
select * from xyz;

drop table xyz;  -- ddl (drop will delete everything i.e. table/structure/schema and data)

-- drop   vs   delete   vs   truncate
-- no rollback(undo) in drop   vs   dlt can rollback
-- truncate (ddl) => data dlt and table dlt but recreate the table structure  (no rollback)
              
              
-- constraints => set of rules applied to column to define restriction on the (unwanted) data. 
-- company => default value
-- aadhar card => primary key

-- Constraints are rules enforced on data in tables. They ensure data accuracy and integrity.
--  Constraints can be applied to a single column or multiple columns (table-level).

--    Common Types of SQL Constraints:
-- Constraint	       Description
-- NOT NULL	       Ensures that a column cannot have a NULL value.
-- UNIQUE	           Ensures all values in a column are unique.
-- PRIMARY KEY	       Uniquely identifies each row in a table. Cannot be NULL and must be UNIQUE.
-- FOREIGN KEY	       Ensures the referential integrity of data between two tables.
-- CHECK	           Ensures that all values in a column satisfy a specific condition.
-- DEFAULT	           Sets a default value for a column when no value is specified.









              
              



          