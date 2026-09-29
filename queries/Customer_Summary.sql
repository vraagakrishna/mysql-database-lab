USE customer_order_management;

# Test with a customer who has orders
CALL customer_summary(1);

# Test a customer with only one order
CALL customer_summary(5);

# Test a customer with no orders
CALL customer_summary(11);