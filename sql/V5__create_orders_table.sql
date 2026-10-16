#CREATED A CUSTOMERS ORDERS TABLE
CREATE TABLE orders ( 
order_id int auto_increment PRIMARY KEY,
customer_id int NOT NULL,
order_date DATE NOT NULL,
order_amount DECIMAL(10,2) NOT NULL,
order_status VARCHAR(20) NOT NULL,
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
CONSTRAINT chk_orders_amount CHECK (order_amount >= 0),
CONSTRAINT chk_orders_status CHECK (order_status IN ('PENDING', 'COMPLETED', 'CANCELLED')),
CONSTRAINT fk_orders_customer
FOREIGN KEY (customer_id)
REFERENCES customers(customer_id)
ON DELETE RESTRICT 
ON UPDATE CASCADE
);

SELECT * FROM orders;

