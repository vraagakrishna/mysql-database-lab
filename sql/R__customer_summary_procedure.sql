DROP PROCEDURE IF EXISTS customer_summary;

DELIMITER $$

CREATE PROCEDURE customer_summary(
    IN p_customer_id INT
)
BEGIN
    SELECT c.first_name, c.last_name, c.country_code,
        COUNT(o.order_id) AS number_of_orders,
        SUM(
            CASE
                WHEN o.order_status = 'COMPLETED'
                THEN 1
                ELSE 0
            END
        ) AS completed_orders,
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
        COALESCE(
            AVG(
                CASE
                    WHEN o.order_status = 'COMPLETED'
                    THEN o.order_amount
                END
            ),
            0
        ) AS average_completed_order_value,
        MAX(o.order_date) AS most_recent_order_date
    FROM customers c
    LEFT JOIN orders o
        ON c.customer_id = o.customer_id
    WHERE c.customer_id = p_customer_id
    GROUP BY c.customer_id, c.first_name, c.last_name, c.country_code;
END$$

DELIMITER ;