-- Part 12: Customer Account Closure
-- Implements soft account closure so historical orders remain available.

ALTER TABLE customers
    ADD COLUMN customer_status VARCHAR(20) NOT NULL DEFAULT 'ACTIVE',
    ADD COLUMN closed_at TIMESTAMP NULL;

-- Close customer 1 as the exercise example.
-- The customer row is retained, so historical orders remain available.
UPDATE customers
SET
    customer_status = 'CLOSED',
    closed_at = CURRENT_TIMESTAMP
WHERE customer_id = 1;
