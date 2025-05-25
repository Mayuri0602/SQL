use sakila;
select * from actor;
select first_name, count(actor_id) from actor
group by first_name 
order by count(actor_id) desc limit 5;

-- Datatypes in SQL
-- Number (int, float, double)
-- character (char, varchar, string)
-- date, timestamp

-- create statement
create table test(id int);
insert into test values(10);
select * from test;
-- 1 byte => 8 bit, 2^8 = 256  (-128 to 127)
create table test2(id tinyint);
insert into test2 values(127);
select * from test2;

-- unsigned
create table test3(id tinyint unsigned);
insert into test3 values(255);           -- 0 to 255
select * from test3;

create table test4(id decimal(5,2));
insert into test4 values(845);
insert into test4 values(845.74125); -- will give only 2 digits after decimal 
insert into test4 values(8454.7);  -- will give error 
select * from test4;

create table test5(fname char(5) );   -- fixed lenth character
insert into test5 values('hi');
insert into test5 values('hiasd');
insert into test5 values('hiasdfghjk');      -- will give error because characters are more than 5
select * from test5;

create table test6( fname varchar(5) );   -- varchar - variable character
insert into test6 values('hi');
insert into test6 values('hey      ');
insert into test6 values('hisadifghrh'); -- will give error because varchar limit is 5
select fname, char_length(fname) from test6;

-- date and timestamp
create table test7(dob date);
insert into test7 values('2023-12-01');    -- right  yyyy-mm-dd
insert into test7 values('01-01-2025');      #error (incorrect format)
select * from test7;

create table test8(dob timestamp);
insert into test8 values('2023-12-01 10:15:59');
insert into test8 values( now() );   #error (incorrect format)
select * from test8;

-- subquery:- query within a query

select payment_id, amount from payment;
select * from payment where payment_id=15;
select * from payment where amount=5.99;
select * from payment
where amount=(select amount from payment where payment_id=15);

-- Get the payment_id, customer_id, rental_id, staff_id and amount only for those payment where the staff_id is equal to the staff_id of
-- rental_id=1422

select staff_id from payment
where rental_id=1422;
select payment_id, customer_id, rental_id, staff_id, amount from payment
where staff_id=(select staff_id from payment where rental_id=1422);

