-- Part 2: Initial Customer Data
-- Inserts the customers specified in the exercise.

INSERT INTO customers
    (customer_id, first_name, last_name, email, phone, country_code, date_of_birth)
VALUES
    (1,  'Aisha',  'Naidoo',  'aisha.naidoo@gmail.com',         '0825551001',   'ZA', '1992-03-14'),
    (2,  'Daniel', 'Mokoena', 'daniel.mokoena@outlook.com',    '0835551002',   'ZA', '1988-11-02'),
    (3,  'Priya',  'Pillay',  'priya.pillay@yahoo.com',        '0845551003',   'ZA', '1995-07-21'),
    (4,  'Michael', 'Dlamini', 'michael.dlamini@gmail.com',    '0815551004',   'ZA', '1990-01-30'),
    (5,  'Sarah',  'Jacobs',  'sarah.jacobs@outlook.com',      '0725551005',   'ZA', '1985-09-18'),
    (6,  'Thabo',  'Naidoo',  'thabo.naidoo@gmail.com',        '0765551006',   'ZA', '1998-12-05'),
    (7,  'Lindiwe', 'Mokoena','lindiwe.mokoena@yahoo.com',     '0795551007',   'ZA', '1993-05-27'),
    (8,  'Arjun',  'Patel',   'arjun.patel@gmail.com',         '91985551008',  'IN', '1987-06-11'),
    (9,  'Emily',  'Smith',   'emily.smith@outlook.com',       '44775551009',  'GB', '1996-10-23'),
    (10, 'Yusuf',  'Khan',    'yusuf.khan@gmail.com',          '971505551010', 'AE', '1991-02-08'),
    (11, 'John',   'Smith',   'john.smith@gmail.com',          '27825551011',  'ZA', '1989-04-16'),
    (12, 'John',   'Smith',   'john.smith@outlook.com',        '91975551012',  'IN', '1994-08-29');
