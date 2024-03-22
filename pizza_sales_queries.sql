use project;
# A) KPIs 
-- help in assessing progress, identifying areas for improvement, and making informed decisions to optimize performance. 
-- 1. Total revenue
select sum(total_price) as total_revenue from pizza_sales;

-- 2. Average order value
select (sum(total_price)/count(distinct order_id)) as Avg_order_value from pizza_sales; 

-- 3. Total pizzas sold
select sum(quantity) as Total_quantity from pizza_sales ;

-- 4. Total orders sold
select count(distinct order_id) as Total_orders_sold from pizza_sales;

-- select count(order_id) as Total_orders_sold from pizza_sales;

-- 5. Average Pizza per order
select sum(quantity)/count(distinct order_id) as avg_pizza_order from pizza_sales;

-- or using cast we can specify the data type of the result

SELECT CAST(CAST(SUM(quantity) AS DECIMAL(10,2)) / 
CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2)) AS DECIMAL(10,2))
AS Avg_Pizzas_per_order
FROM pizza_sales;
# B. Daily Trend for Total Orders
Select Dayname(STR_TO_DATE(order_date, '%d-%m-%Y')) AS order_day, 
       Count(DISTINCT order_id) AS total_orders 
FROM pizza_sales
GROUP BY order_day;

select * from pizza_sales;
-- C. Monthly Trend for Orders
Select monthname(STR_TO_DATE(order_date, '%d-%m-%Y')) AS month, 
       Count(DISTINCT order_id) AS total_orders 
FROM pizza_sales
GROUP BY month ;

-- D. % of Sales by Pizza Category
-- select * from pizza_sales;
select distinct pizza_category,sum(total_price) as total_revenue,sum(total_price)*100/(select sum(total_price) from pizza_sales) as Percentage  from pizza_sales
group by pizza_category;

-- E. % of Sales by Pizza Size
select pizza_size ,sum(total_price) as total_revenue, sum(total_price)*100/(select sum(total_price) from pizza_sales) as Percentage  from pizza_sales
group by pizza_size
order by pizza_size;

-- F.  Total Pizzas Sold by Pizza Category
select * from pizza_sales;
select pizza_category,sum(quantity) as total_quantity_sold from pizza_sales
group by pizza_category
order by total_quantity_sold;

-- G. Top 5 Pizzas by Revenue
select pizza_name,sum(total_price) as total_revenue from pizza_sales
group by pizza_name
order by total_revenue desc
limit 5;

-- H.  Bottom 5 Pizzas by Revenue
select pizza_name,sum(total_price) as total_revenue from pizza_sales
group by pizza_name
order by total_revenue asc
limit 5;

-- I. Top 5 Pizzas by Quantity
select pizza_name,sum(quantity) as total_pizza_sold from pizza_sales
group by pizza_name
order by total_pizza_sold desc
limit 5;

-- J. Bottom 5 Pizzas by Quantity
select pizza_name,sum(quantity) as total_pizza_sold from pizza_sales
group by pizza_name
order by total_pizza_sold asc
limit 5;

-- --K. Top 5 Pizzas by Total Orders
select pizza_name,count(distinct order_id) as total_orders from pizza_sales
group by pizza_name
order by total_orders desc
limit 5;

-- L. Bottom 5 Pizzas by Total Orders
select pizza_name,count(distinct order_id) as total_orders from pizza_sales
group by pizza_name
order by total_orders asc
limit 5;
 -- M Peak Sales hours 
Select Case
           When hour(order_time) >= 0 and hour(order_time) < 6 then 'Night (00:00 - 06:00)'
           When hour(order_time) >= 6 and hour(order_time) < 12 then 'Morning (06:00 - 12:00)'
           when hour(order_time) >= 12 and hour(order_time) < 18 then 'Afternoon (12:00 - 18:00)'
           when hour(order_time) >= 18 and hour(order_time) < 24 then 'Evening (18:00 - 00:00)'
       end as time_segment,
       COUNT(*) as total_orders
from pizza_sales
group by time_segment
order by total_orders desc;

-- N  Most common pizza ingredients used across all orders

Select pizza_ingredients, COUNT(*) AS ingredient_count
From pizza_sales
Group by pizza_ingredients
order by ingredient_count desc
limit 1;


-- O  Most common order time for pizza orders

Select order_time, COUNT(*) as order_count
From pizza_sales
Group by order_time
Order by order_count Desc
Limit 1;

