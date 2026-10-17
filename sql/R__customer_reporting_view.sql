-- Part 13: Repeatable Migration - Customer Reporting View

CREATE OR REPLACE VIEW customer_reporting AS
SELECT
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    c.country_code AS country,
    COUNT(o.order_id) AS number_of_orders,
    COALESCE(
        SUM(
            CASE
                WHEN o.order_status = 'COMPLETED'
                THEN o.order_amount
                ELSE 0
            END
        ),
        0
    ) AS total_completed_order_value
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name,
    c.country_code;
