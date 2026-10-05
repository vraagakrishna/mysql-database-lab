-- Part 15: Stored Procedure - Create Customer Order

DROP PROCEDURE IF EXISTS create_customer_order;

DELIMITER $$

CREATE PROCEDURE create_customer_order(
    IN p_customer_id INT,
    IN p_order_date DATE,
    IN p_order_amount DECIMAL(10,2),
    IN p_order_status VARCHAR(20)
)
BEGIN
    DECLARE v_customer_exists INT DEFAULT 0;
    DECLARE v_order_id INT;

    SELECT COUNT(*)
    INTO v_customer_exists
    FROM customers
    WHERE customer_id = p_customer_id
      AND customer_status = 'ACTIVE';

    IF v_customer_exists = 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Customer does not exist or account is closed';
    END IF;

    IF p_order_date IS NULL THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Order date cannot be null';
    END IF;

    IF p_order_amount IS NULL OR p_order_amount < 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Order amount cannot be null or negative';
    END IF;

    IF p_order_status IS NULL
       OR p_order_status NOT IN ('PENDING', 'COMPLETED', 'CANCELLED') THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Invalid order status';
    END IF;

    INSERT INTO orders (
        customer_id,
        order_date,
        order_amount,
        order_status
    )
    VALUES (
        p_customer_id,
        p_order_date,
        p_order_amount,
        p_order_status
    );

    SET v_order_id = LAST_INSERT_ID();

    SELECT
        order_id,
        customer_id,
        order_date,
        order_amount,
        order_status,
        created_at,
        updated_at
    FROM orders
    WHERE order_id = v_order_id;
END$$

DELIMITER ;
