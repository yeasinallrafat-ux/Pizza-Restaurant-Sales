-- How many orders does the shop have each month?
USE pizza_sales;
SELECT 
	DATE_FORMAT(
    STR_TO_DATE(o.date, '%m/%d/%Y'),
    '%Y-%m'
    )
    AS order_month,
    COUNT(DISTINCT o.order_id) as total_orders
FROM orders as o
INNER JOIN order_details AS od
	ON o.order_id= od.order_id
GROUP BY 
		DATE_FORMAT(
        STR_TO_DATE(o.date, '%m/%d/%Y'),
        '%Y-%m'
        )
ORDER BY 
	
    order_month ASC;
-- What are the pick hours in which most customers order pizza?
SELECT 
	HOUR(time) AS order_hour,
    COUNT(DISTINCT order_id) as total_orders
FROM orders
GROUP BY HOUR(time)
ORDER BY total_orders DESC;
-- How many pizzas are typically in an order?
 SELECT
	ROUND(AVG(pizzas_per_order), 2) AS avg_pizzas_per_order
    FROM (
		SELECT
			order_id,
            SUM(quantity) AS pizzas_per_order
    FROM order_details
    GROUP BY order_id
    ) AS order_summary;
-- How much money did the shop made?
SELECT
	ROUND(SUM(od.quantity * p.price), 2) AS total_revenue
FROM orders AS o
JOIN order_details AS od
	ON o.order_id= od.order_id
JOIN pizzas AS p
	ON od.pizza_id=p.pizza_id;
