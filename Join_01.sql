use regex;
create table product( pid int, pname varchar(20), price int);
insert into product values(10,"Iphone",20000), (11,"TV",10000),
(12,"LED",3000), (13,"Jeans",800);

select * from product;

create table orders1( oid int, city varchar(20), pid int);
insert into orders1 values(124111,"Jaipur",10), (124112,"GOA",11),
(145631,"Manali",12), (59869011,"Raipur",16);
select * from orders1;

-- common condition
select o.oid, o.city, o.pid, p.pname from orders1 as o
join product as p where o.pid=p.pid;

-- new syntax (inner join :- common column)
select o.oid, o.city, o.pid, p.pname from orders1 as o
inner join product as p where o.pid=p.pid;

-- left & right join
select o.oid, o.city, o.pid, p.pname from orders1 as o
left join product as p on o.pid=p.pid;

select o.oid, o.city, o.pid, p.pname from orders1 as o
right join product as p on o.pid=p.pid;


use sakila;
select* from actor;
select * from film_actor;
select * from film;

-- combine the above tables to get the actor_id, film_id, film_name by each actor.
select fa.actor_id, fa.film_id, f.title as film_name
from film_actor as fa
join film as f on fa.film_id=f.film_id;


-- Get the actor_id, film name only for those movies which has the length more than 100.
select fa.actor_id, f.title as film_name
from film_actor as fa
join film as f on fa.film_id=f.film_id
where f.length > 100;


-- Get the actor_id and the no. of movies he has done in his whole career.
select actor_id, count(film_id) as total_movies
from film_actor
group by actor_id;


-- Get the title and the film_id for the movies who has a rating of NC-17 and sort all these movies based on descending order of film_id.
select title, film_id
from film where rating = 'NC-17'
order by film_id desc;