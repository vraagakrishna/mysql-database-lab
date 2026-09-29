#these queries for to show the indexes we have created before 
SHOW INDEX FROM customers;
SHOW INDEX FROM orders;

#Explain query for email column in customers table
EXPLAIN
SELECT *
FROM customers
WHERE email = 'example@gmail.com';

#Explain qurey for test customer orders 
EXPLAIN
SELECT *
FROM orders
WHERE customer_id = 1;

#Explain query for test the order_status index
EXPLAIN
SELECT *
FROM orders
WHERE order_status = 'PENDING';

#Explain query for date_range index
EXPLAIN
SELECT *
FROM orders
WHERE order_date BETWEEN '2026-01-01' AND '2026-03-31';