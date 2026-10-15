-- Part 17: Transactions
USE customer_order_management;

-- Transaction Syntax: successful operation.
START TRANSACTION;

INSERT INTO orders
    (customer_id, order_date, order_amount, order_status)
VALUES
    (1, '2026-09-23', 750.00, 'PENDING');

COMMIT;

-- Transaction Rollback.
START TRANSACTION;

INSERT INTO orders
    (customer_id, order_date, order_amount, order_status)
VALUES
    (1, '2026-09-23', 900.00, 'PENDING');

ROLLBACK;

-- Test invalid customer with a transaction.
START TRANSACTION;

INSERT INTO orders
    (customer_id, order_date, order_amount, order_status)
VALUES
    (999, '2026-09-23', 500.00, 'PENDING');

ROLLBACK;

-- Test invalid amount.
START TRANSACTION;

INSERT INTO orders
    (customer_id, order_date, order_amount, order_status)
VALUES
    (1, '2026-09-23', -500.00, 'PENDING');

ROLLBACK;

-- Test an error after an earlier successful operation.
START TRANSACTION;

INSERT INTO orders
    (customer_id, order_date, order_amount, order_status)
VALUES
    (1, '2026-09-23', 600.00, 'PENDING');

INSERT INTO orders
    (customer_id, order_date, order_amount, order_status)
VALUES
    (999, '2026-09-23', 700.00, 'PENDING');

ROLLBACK;
