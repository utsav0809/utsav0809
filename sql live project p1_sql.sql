# SQL Data Analysis retail Project
create database project1;
use project1;

# create table
create table retail
(
transactions_id	int primary key,
sale_date date,
sale_time time,
customer_id	int,
gender  varchar(15),
age	int,
category  varchar(15),
quantiy	int,
price_per_unit float,
cogs	float,
total_sale float
);

select * from retail;
#count
select count(*) from retail; 
#Data cleaning
select * from retail
where transactions_id is null;

select * from retail
where 
transactions_id is null
or
sale_date is null
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

#delete null values
delete from retail
where 
transactions_id is null
or
sale_date is null
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
# data exploration
# how many sales we have?
select count(*)as total_sales from retail;

# how many unique customers we have?
select count(distinct customer_id) as total_sales from retail;

# how many unique category we have?
select count(distinct category)as total_sales from retail;
select distinct category from retail;

# data analysis and Business key problems

-- My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
select * from retail where sale_date = "2022-11-05";

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 3 in the month of Nov-2022
select * from retail where category = "clothing" and quantiy > 3 and month (sale_date)= 11 and year (sale_date)= 2022;


-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
select category,sum(total_sale) as net_sale,count(*) as total_order from retail group by 1;

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
select category,round(avg(age)),count(*) from retail where category = "beauty"  ; 

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
select * from retail where total_sale > 1000 ;

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
select category,gender ,count(*)from retail group by 1,2 order by 1; 

-- Q.7 Write a SQL query to find the top 5 customers based on the highest total sales 

select customer_id , sum(total_sale) from retail group by 1 order by 2 desc limit 5;

-- Q.8 Write a SQL query to find the number of unique customers who purchased items from each category.
select category, count(distinct customer_id) from retail group by 1;

-- Q.9 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
WITH hourly_sale
AS
(
SELECT *,
    CASE
        WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END as shift
FROM retail
)
SELECT 
    shift,
    COUNT(*) as total_orders    
FROM hourly_sale
GROUP BY shift

	
	-- end --
	
	


