-- Part 3: Update Customer Information - Manual Verification
-- These SELECT statements intentionally live outside Flyway migrations.
-- Run the relevant checks before and after V3__customer_details_updation.sql.

-- Identify all Yahoo customers before the migration.
SELECT customer_id, first_name, last_name, email
FROM customers
WHERE email LIKE '%@yahoo.com';

-- Inspect customers affected by phone/name changes.
SELECT customer_id, first_name, last_name, phone, email, updated_at
FROM customers
WHERE customer_id IN (1, 3, 11, 12)
ORDER BY customer_id;

-- Verify that no Yahoo addresses remain after the migration.
SELECT customer_id, first_name, last_name, email
FROM customers
WHERE email LIKE '%@yahoo.com';

-- Verify the final values for the targeted customer records.
SELECT customer_id, first_name, last_name, phone, email, updated_at
FROM customers
WHERE customer_id IN (1, 3, 11, 12)
ORDER BY customer_id;
