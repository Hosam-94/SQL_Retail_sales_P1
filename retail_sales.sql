-- SQL Retail Sales Analysis - P1
CREATE DATABASE task_1;
USE task_1;

-- create table 
drop table if exists retail_sales; 
create table retail_sales
	(
	transactions_id	int	 not null primary key,
    sale_date	 date null,
	sale_time	 time null,
	customer_id	 int null,	
    gender  varchar(15) null,	
	age	 int null,
    category  varchar(15) null,	
	quantiy	 int null,
    price_per_unit  float null,	
	cogs	 float null,
	total_sale	 float null
	);
    



---------------------------------------------------------------------------------------------------------
-- (1) write SQL querry to retrieve all columns for sales made on '2022-11-05'
select * 
from retail_sales
	where 
		sale_date = '2022-11-05';

-- (2) write SQL querry to retreive all transations where the category is 'Clothing and the quantity sold is more than or equal 4 in the month of no-2022'
select *
from retail_sales
	where 
		category = 'Clothing'
	and
		sale_date like '2022-11%'  
	and 
		quantiy >= 4;

-- (3) write a querry to calculate the total sales (total_sale) for each category
select 
	category,
    sum(total_sale)
from retail_sales
	group by 
		category;

-- (4) write a SQL query to find the average age of customers who purchased items from the 'Beauty' category
select 
	avg(age)
from retail_sales
	where 
		category = 'beauty';

-- (5) write a SQL querry to find all transactions where the total_sale is greater 1000
select * 
from retail_sales
	where 
		total_sale > 1000;

-- (6) write a SQL querry to find the total number of transactions (transaction_id) made by each gender in each category
select 
	category, 
    gender, 
    count(*) as n_of_transactions
from retail_sales
	group by 
		category, 
		gender;
    
-- (7) write a SQL query to calculate the average sale for each month. Find out best selling month in each year

select 
	year(sale_date),
	month(sale_date), 
	round(avg(total_sale),0)
from retail_sales
    group by 
		1,2
	order by 
		3 desc
    limit 
		2;
    
-- (8) write a SQL query to find the top 5 customers based on the highest total sales
select 
	customer_id,
	sum(total_sale) as total_sales
from retail_sales
	group by 
		1
	order by 
		2 desc
	limit 
		5;

-- (9) write a SQL query to find the number of unique customers who purchased items from each category
select 
	count(distinct customer_id) as unique_customers,
    category
from retail_sales
	group by 
		category;

-- (10) write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
with hourly_sale
as
(        
select *,
	case
		when hour(sale_time) <= 12 then 'Morning shift'
        when hour(sale_time) >  17 then 'Evining shift'
        else 'Afternoon shift'
	end as 'shifts'
   from retail_sales 
 )
 select
	count(*),
	shifts
 from hourly_sale
	group by
		2;






