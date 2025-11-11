-- use sakila;
-- delimiter //

-- create procedure p4(in var int)
-- begin
-- 	  tushar: loop
--       set var = var + 1;
--       select * from actor where actor_id = var;

--       if var = 14 then
--            leave tushar;
--        end if;
--        end loop;
-- end //
-- delimiter ;      


use sakila;
delimiter //
-- procedure is created
create procedure create_email_list(in eid int, out email_list text)

begin
     -- variable to access value from cursor to plsql  
     declare done bool default false;
     declare email_address varchar(100) default "";
     
     -- declare cursor for employee email
     declare cur cursor for select first_name from sakila.actor where actor_id < eid;
     
     -- handler to see cursor have all the elements 
     declare continue handler 
              for not found set done = true;
              
     -- open the cursor
     OPEN cur;
     
     set email_list = '';
        
        process: loop
           
              -- cur will have first row and we insert it into the email_address variable 
              fetch cur into email_address;
              
              if done = True then
                      leave process;
               end if;
               
               -- concatenate the email into the emailist
               set email_list = concat(email_address, "-", email_list);
               -- aman-tushar-mayank 
	   end loop;
       
       --  close the cursor
       close cur;
       
end //
delimiter ;       




use sakila;
delimiter //
-- procedure is created
create procedure create_email_list(in eid int, out email_list text)

begin
     -- variable to access value from cursor to plsql  
     declare done bool default false;
     declare email_address varchar(100) default "";
     
     -- declare cursor for employee email
     declare cur cursor for select first_name from sakila.actor where actor_id < eid;
     
     -- handler to see cursor have all the elements 
     declare continue handler 
              for not found set done = true;
              
     -- open the cursor
     OPEN cur;
     
     set email_list = '';
        
        process: loop
           
              -- cur will have first row and we insert it into the email_address variable 
              fetch cur into email_address;
              
              if done = True then
                      leave process;
               end if;
               
               -- concatenate the email into the emailist
               set email_list = concat(email_address, "-", email_list);
               -- -aman-tushar-mayank 
	   end loop;
       
       --  close the cursor
       close cur;
       
end //
delimiter ;       



-- you have to create a procedure in which declare cursor in which it will access the amount for id < 10
-- access the amount from sakila.payent table
-- open the cursor and then fetch the cursor value into the variable
-- if the amount is 5.99 then close the cursor


drop procedure amount_list;

use sakila;
delimiter //
-- procedure is created
create procedure amount_list02(out amt_list text) 

begin

     declare done int default 0;
     declare v_amt decimal(5,2);
     
     -- declare cursor for employee email
     declare cur cursor for select amount from sakila.payment where payment_id < 10;
     
     -- handler to see cursor have all the elements 
     declare continue handler for not found set done = 1;
     
     -- initialize out parameter
     set amt_list = '';
     
     -- open the cursor
     OPEN cur;
     
        amt_loop: loop
           
              -- cur will have first row and we insert it into the email_address variable 
              fetch cur into v_amt;
              
              if done=1 then
                      leave amt_loop;
               end if;
               
              -- build a dash - seperated list without trailing and leading spaces
              if amt_list = '' then
                 set amt_list = cast(v_amt as char);
              else 
                  set amt_list = concat(amt_list, '-', v_amt);
              end if;
              
              -- stop early if amt equals to 5.99
              if v_amt = 5.99 then
                 leave amt_loop;
              end if;
          end loop;
          
          close cur;
 
 end //
 
 delimiter ;
              
               
               






     
     
     
     