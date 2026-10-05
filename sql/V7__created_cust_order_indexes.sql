-- Part 11: Indexes
-- Indexes support the frequently executed customer/order queries.

CREATE INDEX idx_customers_email
    ON customers(email);

CREATE INDEX idx_orders_customer_id
    ON orders(customer_id);

CREATE INDEX idx_orders_status
    ON orders(order_status);

CREATE INDEX idx_orders_order_date
    ON orders(order_date);
