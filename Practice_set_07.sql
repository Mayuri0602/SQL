-- Primary key:- key unique identifier we identify each row in a table unique and it can't be null

-- Super key:- column or combination of columns that uniquely identify each record

-- Candidate key:- minimal super key

 -- Normlization:- It is a technique to organise our data in a database to remove redundancy(duplicacy) and to convert larger tables into smaller ones so that it speeds up the process/execution
 
 -- To achieve normalization, there are multiple steps like 1NF, 2NF and so on
 
 -- In 1NF, there should be only one atomic value and no repeating groups  (ek col mein multiple values nhi ho skti)
 
 -- In 2NF, table must be in 1NF, and we should remove partial dependency (non-key attribute should not depend partially on primary key)
 
 -- Foreign key:- can be multiple in a table, used to set relationships between two tables, create relationship using primary/unique key based on another table
 
 create database regex123;
 
 create table product(pid int, pname varchar(20), price int);
 insert into product values(100, 'iphone', 4000), (101, 'mit tv', 3000), (102, 'fridge', 5000), (103, 'cover', 500);
 
 create table orders1(orderid int, city varchar(20), productid int);
 insert into orders1 values(994, 'Jaipur', 100), (995, 'Goa', 102), (996, 'J&K', 100), (997, 'japan', 102), (998, 'bhutan', 110);
 
 select * from product;
 
 select * from orders1;
 
 -- pid is primary key in product
 select pid, pname from product as p;
 
 -- orderid is primary key, productid is foreign key that refer to primary key of product table(pid)
 select o.productid, o.city from orders1 as o;
 
 select p.pid, p.pname, o.productid, o.city
 from product as p
 join orders1 as o
 where p.pid = o.productid;
 
 select p.pid, p.pname, o.productid, o.city
 from product as p
 join orders1 as o
 where p.pid = o.productid and pname = 'iphone';
 
                                                                                                                                                                                                                                                                                                                                                                                                                                  
 