USE customer_order_management;

/* CUSTOMER STATISTICS */ 
#Query-1 Total Numbers of customers
SELECT COUNT(*) AS total_customers
FROM customers;

#Query-2 Number of customers per country
SELECT country_code,
COUNT(*) AS customer_count
FROM customers
GROUP BY country_code
ORDER BY customer_count DESC;

#Query-3 Number of customers using Gmail
SELECT COUNT(*) AS gmail_customers
FROM customers
WHERE email LIKE '%@gmail.com';

#Query-4 Number of customers using Outlook
SELECT COUNT(*) AS outlook_customers
FROM customers
WHERE email LIKE '%@outlook.com';

/* ORDER STATISTICS */
#Query-1 Total number of orders
SELECT COUNT(*) AS total_orders
FROM orders;

#Query-2 Total value of all orders
SELECT SUM(order_amount) AS total_order_value
FROM orders;

#Query-3 Total value of completed orders
SELECT SUM(order_amount) as total_completed_order_value
FROM orders
WHERE order_status = 'Completed';

#Query-4 Average order value
SELECT AVG(order_amount) AS average_order_value
FROM orders;

#Query-5 Largest order
SELECT MAX(order_amount) AS largest_order
FROM orders;

#Query-6 Smallest order
SELECT MIN(order_amount) AS smallest_order
FROM orders;

/*CUSTOMER LEVEL STATISTICS */
#Query-1 Number of orders per customers
SELECT c.customer_id, c.first_name, c.last_name, COUNT(o.order_id) AS order_count
FROM customers c
LEFT JOIN orders o 
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY c.customer_id;

#Query-2 Total completed order value pre customer
SELECT c.customer_id, c.first_name, c.last_name,
COALESCE(
SUM( CASE
WHEN o.order_status = 'COMPLETED'
THEN o.order_amount
ELSE 0
END),
0
) AS total_completed_order_vlaue
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY c.customer_id;

#Average Order value per customer
SELECT c.customer_id, c.first_name, c.last_name,
COALESCE(AVG(o.order_amount),0) AS average_order_value
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id 
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY c.customer_id;
