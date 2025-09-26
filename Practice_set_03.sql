use sakila;

-- trim function:- remove whitespaces from a string, rtrim, ltrim
select char_length('   hello   ');
select char_length( trim('   hello   ') );

-- replace:- (orig_str, from_substr, to_substr)
select first_name, replace(first_name, 'E', '#') from actor;

-- lpad, rpad
select first_name, lpad(first_name, 5, '@') from actor;

-- Numeric functions
-- round:- round off the value
select round(11.5);
select round(11.6, 1);    -- only the decimal part
select round(11.68, 1);   -- only the decimal part
select round(11.68, 2);
select round(11.6894, 3);
select round(11.6894, 2);

select round(7.627, -1);   -- only the integer round off
select round(2.627, -1);
select round(11.687, -2);
select round(57.687, -2);
select round(159.687, -3);
select round(549.687, -3);

-- truncate:-  extracts the value
select round(6546.637, 2), truncate(6546.637, 2);

-- other functions
select mod(10,2), floor(6.9999999), ceil(4.002);

-- Date functions (important):-
-- in-built 
select current_date(), current_time();   -- curdate(), curtime()
select current_timestamp(), now();       -- same

-- adddate
select now(), adddate( now(), 2);
select now(), adddate( now(), interval 2 month);   -- month,year,hour,min,sec,week
select now(), adddate( now(), interval -2 year);   -- can't add time

-- addtime()
select now(), addtime( now(), '02:00:00');

-- year and month
select now(), year(now()), last_day(now());

-- extract
select now(), extract(quarter from now());

-- date_format:- string format output
select now(), date_format( now(), 'Year is %y, my month is %M');


select * from payment;

select payment_date from payment;

select payment_date , year(payment_date),
extract(year from payment_date),
date_format(payment_date, 'Hour of shopping is %H'),
datediff(payment_date, now() ) 
from payment;