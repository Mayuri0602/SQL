show databases;
use tushardb;

CREATE TABLE restaurants (
    restaurant_id INT PRIMARY KEY,
    name VARCHAR(100),
    city VARCHAR(50),
    location VARCHAR(100),
    cuisines VARCHAR(100),
    rating FLOAT,
    votes INT,
    cost_for_two INT,
    online_order VARCHAR(5),
    table_booking VARCHAR(5)
);


INSERT INTO restaurants VALUES
(1,'Cafe Coffee Day','Bangalore','Indiranagar','Cafe',3.8,1200,400,'Yes','No'),
(2,'Empire Restaurant','Bangalore','MG Road','North Indian',4.2,5400,600,'Yes','Yes'),
(3,'Meghana Foods','Bangalore','Jayanagar','Andhra',4.5,8900,700,'Yes','No'),
(4,'Truffles','Bangalore','Koramangala','American',4.6,10500,800,'Yes','Yes'),
(5,'Burger King','Bangalore','BTM','Fast Food',3.9,2100,500,'Yes','No'),
(6,'Leopold Cafe','Mumbai','Colaba','Cafe',4.1,6200,1200,'No','Yes'),
(7,'Social','Mumbai','Lower Parel','Continental',4.3,4800,1500,'Yes','Yes'),
(8,'Burger King','Mumbai','Andheri','Fast Food',3.8,1900,500,'Yes','No'),
(9,'Bastian','Mumbai','Bandra','Seafood',4.4,7500,2500,'No','Yes'),
(10,'Theobroma','Mumbai','Powai','Bakery',4.2,4300,700,'Yes','No'),
(11,'Karim’s','Delhi','Jama Masjid','Mughlai',4.4,7800,900,'No','No'),
(12,'Haldiram’s','Delhi','CP','Street Food',4.1,6500,600,'Yes','No'),
(13,'Bikanervala','Delhi','Karol Bagh','North Indian',4.0,3100,700,'Yes','No'),
(14,'Diggin','Delhi','Chanakyapuri','Italian',4.3,5200,1200,'Yes','Yes'),
(15,'Big Chill','Delhi','Khan Market','Italian',4.5,6900,1800,'No','Yes'),
(16,'Cafe Madras','Chennai','Mylapore','South Indian',4.5,5600,300,'No','No'),
(17,'Murugan Idli','Chennai','T Nagar','South Indian',4.4,6100,250,'No','No'),
(18,'Barbeque Nation','Chennai','Velachery','BBQ',4.3,7200,1600,'Yes','Yes'),
(19,'Coal Barbecue','Chennai','Anna Nagar','BBQ',4.2,4800,1400,'Yes','Yes'),
(20,'Pizza Hut','Chennai','OMR','Fast Food',3.7,2600,800,'Yes','No'),
(21,'Paradise Biryani','Hyderabad','Secunderabad','Biryani',4.2,8200,900,'Yes','No'),
(22,'Bawarchi','Hyderabad','RTC X Roads','Biryani',4.3,9100,800,'No','No'),
(23,'Absolute Barbecue','Hyderabad','Gachibowli','BBQ',4.4,6800,1500,'Yes','Yes'),
(24,'Chutneys','Hyderabad','Madhapur','South Indian',4.1,4300,600,'Yes','No'),
(25,'KFC','Hyderabad','Kukatpally','Fast Food',3.6,2400,700,'Yes','No'),
(26,'Vaishali','Pune','FC Road','South Indian',4.4,5900,400,'No','No'),
(27,'German Bakery','Pune','Koregaon Park','Bakery',4.2,4700,900,'Yes','No'),
(28,'Barometer','Pune','Baner','Continental',4.3,3600,1800,'No','Yes'),
(29,'Burger King','Pune','Wakad','Fast Food',3.7,2100,500,'Yes','No'),
(30,'Cafe Goodluck','Pune','Deccan','Cafe',4.1,5200,350,'No','No'),
(31,'Indian Accent','Delhi','Lodhi Road','Modern Indian',4.7,9800,3500,'No','Yes'),
(32,'Saravana Bhavan','Bangalore','Rajajinagar','South Indian',4.3,6400,500,'No','No'),
(33,'Corner House','Bangalore','Basavanagudi','Desserts',4.5,7300,400,'Yes','No'),
(34,'Toit','Bangalore','Indiranagar','Brewery',4.6,8800,1600,'No','Yes'),
(35,'Nagarjuna','Bangalore','Residency Road','Andhra',4.4,8100,750,'Yes','No'),
(36,'Subway','Mumbai','Dadar','Fast Food',3.5,1700,450,'Yes','No'),
(37,'Pizza Express','Mumbai','BKC','Italian',4.1,3900,1800,'Yes','Yes'),
(38,'SodaBottleOpenerWala','Mumbai','Powai','Parsi',4.2,4600,2000,'No','Yes'),
(39,'Chaayos','Delhi','Saket','Cafe',3.9,2900,300,'Yes','No'),
(40,'BTW','Delhi','Laxmi Nagar','Street Food',4.0,3400,250,'Yes','No'),
(41,'Anand Sweets','Bangalore','Jayanagar','Sweets',4.3,5100,300,'Yes','No'),
(42,'Burger Singh','Delhi','Rajouri','Fast Food',3.8,2200,500,'Yes','No'),
(43,'Wow Momo','Kolkata','Salt Lake','Fast Food',4.0,4100,350,'Yes','No'),
(44,'Peter Cat','Kolkata','Park Street','Continental',4.4,7600,1200,'No','Yes'),
(45,'6 Ballygunge Place','Kolkata','Ballygunge','Bengali',4.5,6800,1500,'No','Yes'),
(46,'Barbeque Nation','Mumbai','Thane','BBQ',4.3,7100,1600,'Yes','Yes'),
(47,'Absolute Barbecue','Pune','Hinjewadi','BBQ',4.2,5400,1500,'Yes','Yes'),
(48,'Keventers','Delhi','CP','Cafe',3.9,2600,400,'Yes','No'),
(49,'Natural Ice Cream','Mumbai','Juhu','Desserts',4.4,8300,350,'Yes','No'),
(50,'Social','Bangalore','Church Street','Continental',4.2,6200,1400,'Yes','Yes');



select * from restaurants limit 10;



-- 1. ️Which city has the highest number of restaurants?
select city, count(name) as total_restaurants
from restaurants
group by city
order by total_restaurants desc;  
 
 

-- 2. Which city has the highest average rating?
select city, round(avg(rating),2) as avg_rating 
from restaurants
group by city
having avg(rating) = ( select max(avg_rating) from (           
					                                 select avg(rating) as avg_rating
                                                     from restaurants
                                                     group by city ) as t );



-- 3. Top 5 most popular restaurants (by votes)
select name, city, votes
from restaurants
order by votes desc 
limit 5; 




-- 4. Do online-order restaurants have better ratings?
select online_order, round(avg(rating),2) as avg_rating
from restaurants
group by online_order;

-- If Yes > No then online-order restaurants have better ratings otherwise no



-- 5. Which cuisine is most popular (by votes)?
select cuisines, sum(votes) as total_votes
from restaurants
group by cuisines
order by total_votes desc;



-- 6. Which city generates the highest engagement (votes)?
select city, sum(votes) as highest_engagement
from restaurants
group by city
order by highest_engagement desc;



-- 7. Top 3 restaurants per city (ranking logic)
select * 
from ( select name, city, rating,
      rank() over (partition by city order by rating desc) as rnk
	  from restaurants) as t
where rnk <= 3;      



-- 8. Restaurants performing above city average
SELECT r.*
FROM restaurants as r
WHERE rating >
              ( SELECT AVG(rating)
                FROM restaurants
                WHERE city = r.city
              );




-- 9. Best city to open a new Cafe?
SELECT city, ROUND(AVG(rating),2) AS avg_rating, COUNT(*) AS cafe_count
FROM restaurants
WHERE cuisines LIKE '%Cafe%'
GROUP BY city
ORDER BY avg_rating DESC;



-- 10. Which restaurants should Zomato promote?
SELECT name, city, rating, votes
FROM restaurants
WHERE rating >= 4.3 AND votes >= 5000
ORDER BY votes DESC;

