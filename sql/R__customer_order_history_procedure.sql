-- Part 14: Stored Procedure - Customer Order History

DROP PROCEDURE IF EXISTS customer_order_history;

DELIMITER $$

CREATE PROCEDURE customer_order_history(IN p_customer_id INT)
BEGIN
    SELECT
        c.customer_id,
        c.first_name,
        c.last_name,
        c.email,
        o.order_id,
        o.order_date,
        o.order_amount,
        o.order_status
    FROM customers c
    LEFT JOIN orders o
        ON c.customer_id = o.customer_id
    WHERE c.customer_id = p_customer_id
    ORDER BY o.order_date, o.order_id;
END$$

DELIMITER ;
