-- Part 13: Repeatable Migration
-- Customer Reporting View

CREATE OR REPLACE VIEW customer_reporting_view AS
SELECT
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    c.country_code,
    COUNT(o.order_id) AS order_count,
    COALESCE(
        SUM(
            CASE
                WHEN o.order_status = 'COMPLETED'
                THEN o.order_amount
                ELSE 0
            END
        ),
        0
    ) AS total_completed_order_value,
    MAX(o.order_date) AS last_order_date
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name,
    c.country_code;