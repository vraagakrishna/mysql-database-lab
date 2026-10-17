-- Part 7: Order Data
-- Inserts the orders specified in the exercise.

INSERT INTO orders
    (order_id, customer_id, order_date, order_amount, order_status)
VALUES
    (1001, 1,  '2026-01-10', 1250.00, 'COMPLETED'),
    (1002, 2,  '2026-01-15',  850.50, 'COMPLETED'),
    (1003, 1,  '2026-02-02',  450.00, 'PENDING'),
    (1004, 3,  '2026-02-10', 2100.00, 'COMPLETED'),
    (1005, 5,  '2026-02-14',  675.25, 'CANCELLED'),
    (1006, 7,  '2026-02-20', 1500.00, 'COMPLETED'),
    (1007, 4,  '2026-03-01',  925.75, 'PENDING'),
    (1008, 8,  '2026-03-04', 3200.00, 'COMPLETED'),
    (1009, 2,  '2026-03-10',  400.00, 'COMPLETED'),
    (1010, 9,  '2026-03-15',  775.50, 'PENDING'),
    (1011, 6,  '2026-03-20', 1100.00, 'COMPLETED'),
    (1012, 10, '2026-03-25', 2500.00, 'COMPLETED'),
    (1013, 1,  '2026-04-01',  300.00, 'CANCELLED'),
    (1014, 7,  '2026-04-05',  950.00, 'PENDING'),
    (1015, 3,  '2026-04-10', 1800.00, 'COMPLETED');