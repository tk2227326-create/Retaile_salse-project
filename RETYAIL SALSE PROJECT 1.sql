---SQL retail salse project _p2

create database sql_project_p2

--CREATE TABLE
drop table if exists retails_salse;
CREATE TABLE retails_salse
(
transactions_id int primary key,
sale_date date,
sale_time time,
customer_id	int,
gender	varchar(15),
age	int,
category varchar(15),
quantiy int,
price_per_unit float,
cogs	float,
total_sale float

);

select * from retails_salse
limit 10

select
count(*)
from retails_salse

---+
select * from retails_salse

--- how maney data we have ?
select COUNT (*) as total_sale from retails_salse

--how many unic coustomers we have

select COUNT (distinct customer_id ) as total_sale 

--- how many category we have

select distinct category  from retails_salse

---DATA ANALYSIS & BUSINESS problems---------



--- Q -1 write a SQL quaery to retrivie the all column for salse made on  2022-11-05


select *
from retails_salse
limit 10

---update retails_salse
select 
	category,
	sum(total_sale) as net_age
	coun(*)as total_order
from retails_salse
------------------ Data cleeaning
------------------ How to find a null values in the data
SELECT * FROM retails_salse
WHERE 
	transactions_id is null
	or
	sale_date is null
	or sale_time is null
	or 
	gender is null
	or
	category is null
	or
	quantiy is null
	or
	cogs is null
	or
	total_sale is null; 

----------- How to delete the NULL values iin the data 

delete from retails_salse
WHERE 
	transactions_id is null
	or
	sale_date is null
	or sale_time is null
	or 
	gender is null
	or
	category is null
	or
	quantiy is null
	or
	cogs is null
	or
	total_sale is null; 
---- count of total data in the database the total data in the database 1997
SELECT
	COUNT(*)
FROM retails_salse

---------------=============++
-----+++++++++

---data exploration

--- How many salse we have?
SELECT COUNT(*) as total_sale from retails_salse --- 1997

--- How maney  unique customers we have

select count( distinct customer_id) as total_sale from retails_salse 

select distinct category from retails_salse



----- Data analysis and Business key problems& answers

---Q-1 write a SQL quary to retrive all customer for sale made on 2022-11-25

select *
from retails_salse
where sale_date ='2022-11-05';

---q-2- Write a SQL quary to retrive the all transactions where the catogery is 'clothing ' and the quantity sold is more then 10 in the month of Nov-2022

select
	*
from retails_salse
where category = 'clothing'
	and
	to_char(sale_date,'YYYY-MM') = '2022-11'
	and
	quantiy >=4
---- Q-3- write a SQL quary to calculate the total salse (total_sale ) for each catogery
select 
	category,
	sum(total_sale) as net_sale,
	count(*) as total_orders
from retails_salse
group by 1

----Q-4  write a quary to find the average age of customer who purchesed items fro the Beauty category,

select 
	round(AVG(age),2) as avg_age 
from retails_salse
where category = 'Beauty'

---- Q-5- write a SQL query  to find all transactions where the total_sale is greater then 1000
select * from retails_salse
where total_sale >1000

---Q--6 write a SQL query to find the total number of transactions_id made by each genger in each catogery

select
	category,
	gender,
	count(*) as total_trans
from retails_salse
group 
	by
	category,
	gender
order by 3

select * from retails_salse
limit 8 

---- Q-7-- Write a quary  to caluculate the avarage  of each month find out best selling  month in each year
--- we need to check the closing breakets in the Quaery
select 
	EXTRACT(year FROM sale_date) as year,
	EXTRACT(month from sale_date) as month,--- this is sum of the year and month in the average of the best selling year
	sum(total_sale) as sum_sale
from retails_salse
group by 1,2
order by 1,2,3 desc

---- Q-7- of ex-this is the average of the best selling year 
SELECT * FROM
(
select 
	EXTRACT(year FROM sale_date) as year,
	EXTRACT(month from sale_date) as month,--- this is sum of the year and month in the average of the best selling year
	avg(total_sale) as avg_sale,
	RANK() over(PARTITION BY EXTRACT(YEAR FROM sale_date)order by avG(total_sale)DESC)
from retails_salse
group by 1,2
) as t1
where rank =1

---Q-8- write a SQL query to (find the top 5 customer) based on the (highest total sale)

select 
	category,
	count(customer_id)
	customer_id
from retails_salse
group by category

-----


select 
	category,
	customer_id,
	
from retails_salse
group by 1
order by 2 DESC
limit 5


-----Q-9- Write a query to fiind the unique customers who purchesed item from each catogery
WITH HOURLY_SALE
AS
select 
	category,
	count( DISTINCT customer_id) AS cnt_unique_cs
from retails_salse
group by category

---Q- Write a SQL query to create each shift and number of orders (
---(example  morning <=12 afternoon betweeen 12& 17 evening >17)
WITH HOURLY_SALE
AS
(
select *,
	CASE
		WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
		WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
		ELSE 'Evening'
	END as shift
from retails_salse
)
SELECT
	shift,
	count(*) as total_orders
from hourly_sale
group by shift