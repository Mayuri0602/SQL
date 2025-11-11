call create_email_list(10, @email_list);

select  @email_list;





SET @amt_list = '';

CALL amount_list02(@amt_list);

SELECT @amt_list;