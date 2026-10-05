-- Part 4: Customer Upsert
-- Demonstrates MySQL INSERT ... ON DUPLICATE KEY UPDATE.

INSERT INTO customers
    (customer_id, first_name, last_name, email, phone, country_code, date_of_birth)
VALUES
    (3,  'Priya',  'Pillay-Singh', 'priya.pillay@gmail.com',         '0845553003',  'ZA', '1995-07-21'),
    (11, 'John',   'Smith',        'john.smith@gmail.com',             '0825553011',  'ZA', '1989-04-16'),
    (13, 'Kavita', 'Reddy',        'kavita.reddy@gmail.com',            '91985553013', 'IN', '1995-07-24'),
    (14, 'James',  'Williams',     'james.williams@outlook.com',        '14155553014', 'US', '2003-11-30')
ON DUPLICATE KEY UPDATE
    first_name = VALUES(first_name),
    last_name = VALUES(last_name),
    email = VALUES(email),
    phone = VALUES(phone),
    country_code = VALUES(country_code);
