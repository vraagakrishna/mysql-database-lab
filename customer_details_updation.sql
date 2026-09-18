use customers;
select * from customers;

#THIS QUERY IS FOR EMAIL UPDATE IN CUSTOMERS TABLE 
select customer_id, first_name, last_name, email 
from customers
where email like "%@yahoo.com";


#UPDATED CUSTOMER EMAIL
UPDATE customers
SET email = replace(email,'@yahoo.com','@gmail.com')
WHERE customer_id IN (1,4,7,11);


#CHECKS WHEATHER THE DATA UPDATED OR NOT
select customer_id, first_name, last_name, email 
from customers
where email like "%@yahoo.com";


#THIS QUERY IS FOR PHONE NUMBER UPDATE IN CUSTOMER DETAILS
SELECT customer_id, first_name,Last_name, phone
FROM customers
where customer_id = 1;


#UPDATED CUSTOMER PHONE NUMBER
UPDATE customers
SET phone = "7386792242"
where customer_id = 1;


#For multipule updation in phone number
update customers
set phone = case customer_id
when 4 then '6301772242'
when 11 then '9951435381'
end
where customer_id in (4, 11);
 
 #for verifying the updation in customer table
select * from customers;

