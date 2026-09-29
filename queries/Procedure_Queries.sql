# PROCEDURE QUERY
USE customer_order_management;

# Test a valid order
CALL create_customer_order(
    1,
    '2026-09-23',
    1500.00,
    'PENDING'
);

# Test invalid customer
CALL create_customer_order(
    999,
    '2026-09-23',
    500.00,
    'PENDING'
);

# Test negative order amount
CALL create_customer_order(
    1,
    '2026-09-23',
    -100.00,
    'PENDING'
);

# Test invalid order status
CALL create_customer_order(
    1,
    '2026-09-23',
    500.00,
    'SHIPPED'
);

# Test NULL order date
CALL create_customer_order(
    1,
    NULL,
    500.00,
    'PENDING'
);

# '1016' confirm it actually exist in the orders table
SELECT *
FROM orders
WHERE order_id = 1016;