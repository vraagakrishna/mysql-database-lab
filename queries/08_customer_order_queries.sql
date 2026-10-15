-- Part 8: Customer Order Reports
USE customer_order_management;

-- Query 1: Customer Order History
SELECT c.first_name, c.last_name, o.order_id, o.order_date, o.order_amount, o.order_status
FROM customers c
INNER JOIN orders o
    ON c.customer_id = o.customer_id
ORDER BY o.order_id;

-- Query 2: All Customers
SELECT c.customer_id, c.first_name, c.last_name,
       o.order_id, o.order_date, o.order_amount
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
ORDER BY c.customer_id, o.order_id;

-- Query 3: Customer Spending
SELECT c.customer_id,
       CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
       COALESCE(
           SUM(CASE
               WHEN o.order_status = 'COMPLETED' THEN o.order_amount
               ELSE 0
           END),
           0
       ) AS total_completed_order_value
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY c.customer_id;

-- Query 4: Pending Orders
SELECT o.order_id,
       CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
       c.country_code,
       o.order_date,
       o.order_amount
FROM orders o
INNER JOIN customers c
    ON o.customer_id = c.customer_id
WHERE o.order_status = 'PENDING'
ORDER BY o.order_id;

-- Query 5: High-Value Orders
SELECT o.order_id,
       CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
       o.order_amount,
       o.order_status
FROM orders o
INNER JOIN customers c
    ON o.customer_id = c.customer_id
WHERE o.order_amount > 1000
ORDER BY o.order_id;
