use sakila;
select distinct(first_name) from actor;
select count(last_name) from actor;
select count(distinct(first_name)) from actor;

-- distinct (unique values), count(counts no. of rows)
-- String Functions - scaler and multi-row
-- Indexing starts from zero

select first_name, lower(first_name),upper(lower(first_name)) from actor;
select first_name, substr(first_name,3) from actor;
select last_name, substr(last_name,3,2) from actor;
select first_name, substr(first_name,-3,2) from actor;

-- substr(col_name,index,no. of characters)
-- instr returns the index of the first occurence of the character

select first_name, instr(first_name,'E') from actor;
select first_name, last_name, concat(first_name, '  ',  last_name) from actor;
select first_name, last_name, concat(first_name, ' $ ',  last_name) from actor;

-- lpad(), rpad()

select first_name, rpad(first_name,6,'$') from actor;

-- trim - whitespace, character

select first_name,  trim('    h       ey    ') from actor;
