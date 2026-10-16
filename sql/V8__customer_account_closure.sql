-- Part 12: Customer Account Closure
--
-- Soft deletion is used instead of physically deleting the customer.
-- This preserves historical orders.
--
-- Customer 1 is being closed as part of this database lab.

UPDATE customers
SET
    customer_status = 'CLOSED',
    closed_at = CURRENT_TIMESTAMP
WHERE customer_id = 1;