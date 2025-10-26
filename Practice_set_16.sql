create table tushar1(id tinyint);    -- its range is ( -128 to 127 )  ( 1 byte) 2**8= 256
insert into tushar1 values(10), (-9);
insert into tushar1 values(156);  -- error due to tinyint
# id tinyint unsigned --> with unsigned it take only +ve values with range 0 - 255

-- smallint  --> 2 byte   -- 2**16
-- mediumint -->    3 byte  -- 2**32
-- int    -->       4 byte
-- bigint  -->      8 byte

create table tushar2(id float, id2 double); -- float take less decimal value , double take high decimal values
insert into tushar2 values(10.12345678, 10.123456789);
select * from tushar2;

create table tushar3(id2 double(5,2));
insert into tushar3 values(10.123455678);
insert into tushar3 values(107.123455678);
insert into tushar3 values(1045.123455678);  -- gives error
select * from tushar3;
-- double( precision, scale)
--        (total digits, digits after decimal)
--        (5,2) --> total 5 digits and 2 is 2 value only after decimal

create table tushar4( gender char(5));  -- char is fix size and truncate space from ends
insert into tushar4 values( 'abc' );
insert into tushar4 values( 'abcdf' );
insert into tushar4 values( 'abcdfg' ); -- give error as it more than 5 chracter
insert into tushar4 values( 'abc      ' );
select gender, char_length(gender) from tushar4;


create table tushar5( gender varchar(5)); -- truncate widespaces after the size only
insert into tushar5 values( 'abc' );      
insert into tushar5 values( 'abc        ' );
select gender, char_length(gender) from tushar5;

