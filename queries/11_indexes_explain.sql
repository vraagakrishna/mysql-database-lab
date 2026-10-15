-- Part 11: Indexes and EXPLAIN
USE customer_order_management;

-- Inspect indexes created by Flyway migrations.
SHOW INDEX FROM customers;
SHOW INDEX FROM orders;

-- Explain lookup by customer email.
EXPLAIN
SELECT *
FROM customers
WHERE email = 'example@gmail.com';

-- Explain customer order lookup.
EXPLAIN
SELECT *
FROM orders
WHERE customer_id = 1;

-- Explain order status lookup.
EXPLAIN
SELECT *
FROM orders
WHERE order_status = 'PENDING';

-- Explain date-range lookup.
EXPLAIN
SELECT *
FROM orders
WHERE order_date BETWEEN '2026-01-01' AND '2026-03-31';

-- Explain the composite customer/status lookup.
EXPLAIN
SELECT *
FROM orders
WHERE customer_id = 1
  AND order_status = 'PENDING';
