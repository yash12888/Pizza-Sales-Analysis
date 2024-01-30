select * from pizza_sales;

copy pizza_sales from 'C:\yash\Projects\pizza_sales\pizza_sales_analysis\pizza_sales_excel_file.csv' delimiter ',' csv header;

select * from pizza_sales

/* 1. Find total revenue <- sum of total price of all pizza orders*/

select sum(total_price) as total_revenue from pizza_sales

/* 2. Average order value */

select sum(total_price)/count (distinct order_id) as avg_order_value from pizza_sales

/* 3. Total pizzas sold */

select sum(quantity) as total_pizzas_sold from pizza_sales

/* 4. Total Orders */

select count(distinct order_id) as total_orders from pizza_sales

/* 5. average pizza per order */

select cast(cast(sum(quantity) as decimal(10,2))/cast(count(distinct order_id) as decimal(10,2)) as decimal(10,2))
as avg_pizza_order from pizza_sales

/* Seeing daily trend for total orders */

select to_char(order_date,'Day') as day_name,count(distinct order_id) as orders 
from pizza_sales
group by  day_name

/* Monthly trend of total orders */

select to_char(order_date, 'Month') as month_name, count(distinct order_id) as orders
from pizza_sales
group by month_name
order by orders

/* Categorical analysis of sales */

select pizza_category, cast(sum(total_price) as decimal(10,2)) as net_sales ,cast(sum(total_price) *100/ (select sum(total_price) from pizza_sales) as decimal(10,2)) as percent_sales_by_category
from pizza_sales
group by pizza_category

/* applying month filter to the above query */

select pizza_category, cast(sum(total_price) as decimal(10,2)) as net_sales ,cast(sum(total_price) *100/ (select sum(total_price) from pizza_sales) as decimal(10,2)) as percent_sales_by_category
from pizza_sales
where extract(month from order_date) = 1
group by pizza_category

/* percent of sales by pizza size */

select pizza_size, cast(sum(total_price) as decimal(10,2)) as net_sales ,cast(sum(total_price) *100/ (select sum(total_price) from pizza_sales) as decimal(10,2)) as percent_sales_by_category
from pizza_sales
group by pizza_size

/* top 5 best sellers by revenue, total quantity and total orders */

select pizza_name, cast(sum(total_price) as decimal(10,2)) as revenue from pizza_sales
group by pizza_name order by revenue desc limit 5

select pizza_name, cast(sum(quantity) as decimal(10,2)) as total_quantity
from pizza_sales
group by pizza_name
order by total_quantity desc
limit 5

select pizza_name, cast(sum(distinct order_id) as decimal(10,2)) as total_orders
from pizza_sales
group by pizza_name
order by total_orders desc
limit 5

/* bottom 5 pizzas by revenue, total_quantity and total_orders */
select pizza_name, cast(sum(total_price) as decimal(10,2)) as revenue from pizza_sales
group by pizza_name order by revenue limit 5

select pizza_name, cast(sum(quantity) as decimal(10,2)) as total_quantity 
from pizza_sales
group by pizza_name 
order by total_quantity
limit 5

select pizza_name, cast(sum(distinct order_id) as decimal(10,2)) as total_orders
from pizza_sales
group by pizza_name
order by total_orders
limit 5
