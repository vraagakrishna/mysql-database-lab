-- Part 3: Update Customer Information
-- Updates existing customer data from the exercise requirements.

-- Task 1: Change all Yahoo email addresses to Gmail.
-- The local part of each email address remains unchanged.
use customer_order_management_test;


UPDATE customers
SET email = REPLACE(email, '@yahoo.com', '@gmail.com')
WHERE customer_id IN (3, 7);

-- Task 2: Aisha Naidoo phone number update.
UPDATE customers
SET phone = '0825552001'
WHERE customer_id = 1;

-- Task 3: Customer 3 surname correction.
UPDATE customers
SET last_name = 'Pillay-Singh'
WHERE customer_id = 3;

-- Task 4: South African John Smith.
UPDATE customers
SET phone = '0825552011'
WHERE customer_id = 11;

-- Task 4: Indian John Smith.
UPDATE customers
SET phone = '91975552012'
WHERE customer_id = 12;

-- updated_at is maintained by the ON UPDATE CURRENT_TIMESTAMP
-- definition created in V1.