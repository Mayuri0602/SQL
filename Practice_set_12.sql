-- multi row subquery-(we use 'in')

select * from payment;

select amount from payment where payment_id=2 or payment_id=3;

select * from payment where 
amount = ( select amount from payment where payment_id=2 or payment_id=3); -- it will give error

-- in
select * from payment where 
amount in ( select amount from payment where payment_id=2 or payment_id=3); 

-- in or =any (both are same)

select * from payment where 
amount =any ( select amount from payment where payment_id=2 or payment_id=3);

-- with any we can use comparision operator

select * from payment where 
amount >any ( select amount from payment where payment_id=2 or payment_id=3);

select * from payment where 
amount >=any ( select amount from payment where payment_id=2 or payment_id=3);

select * from payment where 
amount <any ( select amount from payment where payment_id=2 or payment_id=3);

select * from payment where 
amount <=any ( select amount from payment where payment_id=2 or payment_id=3);

select * from payment where 
amount !=any ( select amount from payment where payment_id=2 or payment_id=3);

-- all

select * from payment where 
amount >all ( select amount from payment where payment_id=2 or payment_id=3);

select * from payment where 
amount <all ( select amount from payment where payment_id=2 or payment_id=3);

select * from payment where 
amount <=all ( select amount from payment where payment_id=2 or payment_id=3)
order by amount;