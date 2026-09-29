-- Part 18: Composite Index

CREATE INDEX idx_orders_customer_status
ON orders(customer_id, order_status);