-- Part 5: Customer Queries
USE customer_order_management;

-- Query 1: Customer directory
SELECT first_name, last_name, email, country_code
FROM customers;

-- Query 2: South African customers
SELECT * FROM customers
WHERE country_code = 'ZA';

-- Query 3: Indian customers
SELECT * FROM customers
WHERE country_code = 'IN';

-- Query 4: Gmail customers
SELECT * FROM customers
WHERE email LIKE '%@gmail.com';

-- Query 5: Outlook customers
SELECT * FROM customers
WHERE email LIKE '%@outlook.com';

-- Query 6: Customers with the surname Naidoo
SELECT * FROM customers
WHERE last_name = 'Naidoo';

-- Query 7: Customers born in the 1990s
SELECT * FROM customers
WHERE date_of_birth BETWEEN '1990-01-01' AND '1999-12-31';

-- Query 8: South African customers using Gmail
SELECT * FROM customers
WHERE country_code = 'ZA'
  AND email LIKE '%@gmail.com';
