-- Part 18: Advanced SQL
USE customer_order_management;

-- Which customers have placed orders above the average order value?
SELECT DISTINCT c.customer_id, c.first_name, c.last_name
FROM customers c
INNER JOIN orders o
    ON c.customer_id = o.customer_id
WHERE o.order_amount > (
    SELECT AVG(order_amount)
    FROM orders
);

-- Which customers have spent more than the average customer?
SELECT c.customer_id, c.first_name, c.last_name,
       COALESCE(
           SUM(CASE
               WHEN o.order_status = 'COMPLETED' THEN o.order_amount
               ELSE 0
           END),
           0
       ) AS total_completed_spending
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING total_completed_spending > (
    SELECT AVG(customer_total)
    FROM (
        SELECT c2.customer_id,
               COALESCE(
                   SUM(CASE
                       WHEN o2.order_status = 'COMPLETED' THEN o2.order_amount
                       ELSE 0
                   END),
                   0
               ) AS customer_total
        FROM customers c2
        LEFT JOIN orders o2
            ON c2.customer_id = o2.customer_id
        GROUP BY c2.customer_id
    ) AS customer_spending
);

-- Common Table Expression (CTE)
WITH customer_spending AS (
    SELECT c.customer_id, c.first_name, c.last_name,
           COALESCE(
               SUM(CASE
                   WHEN o.order_status = 'COMPLETED' THEN o.order_amount
                   ELSE 0
               END),
               0
           ) AS total_completed_spending
    FROM customers c
    LEFT JOIN orders o
        ON c.customer_id = o.customer_id
    GROUP BY c.customer_id, c.first_name, c.last_name
)
SELECT *
FROM customer_spending
ORDER BY total_completed_spending DESC;

-- CASE for Business Classification
WITH customer_spending AS (
    SELECT c.customer_id, c.first_name, c.last_name,
           COALESCE(
               SUM(CASE
                   WHEN o.order_status = 'COMPLETED' THEN o.order_amount
                   ELSE 0
               END),
               0
           ) AS total_completed_spending
    FROM customers c
    LEFT JOIN orders o
        ON c.customer_id = o.customer_id
    GROUP BY c.customer_id, c.first_name, c.last_name
)
SELECT customer_id, first_name, last_name, total_completed_spending,
       CASE
           WHEN total_completed_spending >= 3000 THEN 'High Value'
           WHEN total_completed_spending >= 1000 THEN 'Medium Value'
           ELSE 'Low Value'
       END AS customer_category
FROM customer_spending
ORDER BY total_completed_spending DESC;

-- Window Function: RANK()
WITH customer_spending AS (
    SELECT c.customer_id, c.first_name, c.last_name,
           COALESCE(
               SUM(CASE
                   WHEN o.order_status = 'COMPLETED' THEN o.order_amount
                   ELSE 0
               END),
               0
           ) AS total_completed_spending
    FROM customers c
    LEFT JOIN orders o
        ON c.customer_id = o.customer_id
    GROUP BY c.customer_id, c.first_name, c.last_name
)
SELECT customer_id, first_name, last_name, total_completed_spending,
       RANK() OVER (ORDER BY total_completed_spending DESC) AS spending_rank
FROM customer_spending
ORDER BY spending_rank;

-- ROW_NUMBER(): most recent order for each customer.
SELECT customer_id, order_id, order_date, order_amount, order_status
FROM (
    SELECT o.*,
           ROW_NUMBER() OVER (
               PARTITION BY customer_id
               ORDER BY order_date DESC, order_id DESC
           ) AS rn
    FROM orders o
) AS customer_orders
WHERE rn = 1
ORDER BY customer_id;

-- Running Total with SUM() OVER()
SELECT order_id, customer_id, order_date, order_amount, order_status,
       SUM(order_amount) OVER (
           ORDER BY order_date, order_id
       ) AS running_order_total
FROM orders
ORDER BY order_date, order_id;

-- Query Optimisation with EXPLAIN
EXPLAIN
SELECT *
FROM orders
WHERE customer_id = 1;

EXPLAIN
SELECT *
FROM orders
WHERE order_date BETWEEN '2026-01-01' AND '2026-09-30';

EXPLAIN
SELECT *
FROM orders
WHERE customer_id = 1
  AND order_status = 'PENDING';
