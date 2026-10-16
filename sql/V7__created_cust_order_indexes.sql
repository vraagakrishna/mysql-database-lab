# INDEXES 

#for customers_email
CREATE INDEX idx_customers_email
ON customers(email);

#for orders of customers_id
CREATE INDEX idx_orders_customer_id
ON orders(customer_id);

#for orders status
CREATE INDEX idx_orders_status
ON orders(order_status);

#for orders range
CREATE INDEX idx_orders_order_date
ON orders(order_date);