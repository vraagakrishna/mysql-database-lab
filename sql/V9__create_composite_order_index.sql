-- Part 18: Advanced SQL / Query Optimisation
-- Composite index for queries filtering by customer and order status.

CREATE INDEX idx_orders_customer_status
    ON orders(customer_id, order_status);
