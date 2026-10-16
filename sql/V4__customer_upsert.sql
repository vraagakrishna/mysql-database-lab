USE customer_order_management;

#CHECKS THOSE CUSTOMERS ARE EXISTS ARE NOT, AND WE HAVE IMPELMENTED THE "ORDER BY" FOR ORDER
SELECT customer_id, first_name, last_name, email, phone, country_code
FROM customers
WHERE customer_id IN (3, 11, 13, 14)
order BY customer_id;

/*INSERTED THE CUSTOMER INFORMATION IN TO THE TABLE BY THEIR CUSTOMER_IDS
IF IDS ALREADY EXISTS WE REPLACE THEM WITH NEW INFORMATION */
INSERT INTO customers (customer_id, first_name, last_name, email, phone, country_code)
VALUES  (3, 'Aka', 'VedhaKrishna', 'vedhakrishna@gmail.com', '0845553003', '+21'),
    (11, 'varma', 'S', 'varma@gmail.com', '0825553011', '+22'),
    (12,'Kannaya','varma','kannaya24@gmail.com','7539514652','+23'),
    (13, 'Kavita', 'Reddy', 'kavita.reddy@gmail.com', '91985553013', '+91'),
    (14, 'James', 'Williams', 'james.williams@outlook.com', '14155553014', '+20')
#FROM HERE THE BELOW QUERY IS FOR DUPLICATES. IF EXISTS UPDATE THEM, IF NOT EXISTS INSERT THEM 
ON DUPLICATE KEY UPDATE
first_name =  VALUES(first_name),
last_name = VALUES(last_name),
email = VALUES(email),
phone = VALUES(phone),
country_code = VALUES(country_code);

#CHECKS WHEATHER THE DETAILS ARE UPDATED OR NOT
select * from customers;

