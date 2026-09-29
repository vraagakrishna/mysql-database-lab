USE customer_order_management;

#Query-1 Sort Customers Alphabetically by Surname(last_name)
SELECT customer_id, first_name, last_name
FROM customers
ORDER BY last_name ASC;

#Query-2 Sort by first_name, then surname(last_name)
SELECT customer_id, first_name, last_name
FROM customers
ORDER BY first_name ASC, last_name ASC;

#Query-3 Newset customers first
SELECT customer_id, first_name, last_name
FROM customers
ORDER BY created_at DESC;

##Query-4 South Africa Customer First
SELECT customer_id, first_name, last_name, country_code
FROM customers
ORDER BY 
CASE 
WHEN country_code = '+21' THEN 0
ELSE 1
END,
country_code ASC;

#Query-5 Orders from Highest amount to lowest 
SELECT order_id, customer_id, order_amount, order_status
FROM orders
ORDER BY order_amount DESC;

#Query-6 Orders by date, newest first
SELECT order_id, customer_id, order_date, order_amount, order_status
FROM orders
ORDER BY order_date DESC;
