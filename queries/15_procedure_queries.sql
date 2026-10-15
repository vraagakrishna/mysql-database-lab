-- Part 15: Stored Procedure - Create Customer Order
USE customer_order_management;

-- Test a valid order.
CALL create_customer_order(
    1,
    '2026-09-23',
    1500.00,
    'PENDING'
);

-- Test an invalid customer.
CALL create_customer_order(
    999,
    '2026-09-23',
    500.00,
    'PENDING'
);

-- Test a negative order amount.
CALL create_customer_order(
    1,
    '2026-09-23',
    -100.00,
    'PENDING'
);

-- Test an invalid order status.
CALL create_customer_order(
    1,
    '2026-09-23',
    500.00,
    'SHIPPED'
);

-- Test a NULL order date.
CALL create_customer_order(
    1,
    NULL,
    500.00,
    'PENDING'
);

-- Manual verification of the newly created order.
SELECT *
FROM orders
WHERE order_id = 1016;
