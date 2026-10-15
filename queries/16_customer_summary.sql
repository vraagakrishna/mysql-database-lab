-- Part 16: Stored Procedure - Customer Summary
USE customer_order_management;

-- Test a customer with orders.
CALL customer_summary(1);

-- Test a customer with one order.
CALL customer_summary(5);

-- Test a customer with no orders.
CALL customer_summary(11);
