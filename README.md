# MySQL Database Exercises

## Overview

You are going to build a small **Customer and Order Management System** using MySQL.

The exercise is designed to grow as new SQL concepts are introduced.

You will start with a single table and gradually introduce:

- Data types
- Primary keys
- Inserting data
- Updating data
- Selecting data
- Filtering
- Sorting
- Foreign keys
- Relationships
- Joins
- Indexes
- Aggregation
- Upserts
- Repeatable Flyway migrations
- Stored procedures
- Transactions
- Query optimisation
- Advanced SQL

You will work with the **same database and data throughout the exercise**.

This is intentional.

Later exercises will depend on decisions and data introduced earlier.

---

# Scenario

You work for a company that sells products to customers in different countries.

The company has a customer management system and needs to maintain:

- Customer information
- Customer contact information
- Customer location
- Customer orders

A customer can place multiple orders.

An order belongs to one customer.

```text
Customer
   |
   | 1
   |
   | many
   |
 Order
```

The company operates internationally, including **South Africa** and **India**.

---

# Business Rules

The following business rules apply throughout the exercise.

## Customers

A customer:

- Has a unique customer ID.
- Has a first name and surname.
- Has an email address.
- Has a phone number.
- Has a country.
- Has a date of birth.
- Has a date/time indicating when the record was created.
- Has a date/time indicating when the record was last changed.

Two different customers can have the same name.

For example, the following are two different people:

```text
John Smith
John Smith
```

Do not assume that a person's name uniquely identifies a customer.

The customer's ID is the unique identifier.

---

## Orders

A customer can have zero, one, or many orders.

Orders are business records and may be required for historical reporting.

Therefore, deleting a customer should not casually result in historical order information being lost.

The database design should enforce the appropriate relationship between customers and orders.

---

# Independent Learning

You will encounter topics that may not yet have been covered in class.

When this happens, you are expected to research the topic before implementing it.

You may use:

- Official MySQL documentation
- Official Flyway documentation
- Technical books
- Tutorials
- Videos
- Other reliable technical resources

You should understand the SQL that you submit.

If asked to explain your solution, being able to say "the query worked" is not sufficient.

---

# Flyway

All **database changes** must be managed through Flyway.

You must learn the difference between:

## Versioned migrations

Used for changes that should happen in a specific order.

Examples:

- Creating a table
- Adding a column
- Adding a foreign key
- Changing a database structure
- Inserting initial data

---

## Repeatable migrations

Used for database objects or other scripts that may need to be reapplied when their contents change.

Examples can include:

- Views
- Stored procedures
- Functions

You must research how Flyway determines whether a repeatable migration needs to execute again.

---

## Upsert / MERGE concept

You will also investigate how databases handle the following requirement:

> Insert a record when it does not exist, but update it when it already exists.

This is commonly called an **upsert**.

You may encounter the term `MERGE` when researching this topic.

However, do not assume that all database systems implement `MERGE` in the same way.

For MySQL, investigate:

```sql
INSERT ... ON DUPLICATE KEY UPDATE
```

You must understand why the database is able to determine that a record already exists.

---

# Flyway Learning Resources

Before starting, learn the basics of Flyway.

### Video

[How to Set Up Flyway On Your Database — Database Star](https://www.youtube.com/watch?v=qsacSRcHCCs)

### Official Documentation

[Getting Started with Flyway — Redgate](https://documentation.red-gate.com/flyway/getting-started-with-flyway)

You should understand:

- Migration naming
- Versioned migrations
- Repeatable migrations
- Migration ordering
- Migration history
- Checksums
- What happens when a migration has already been executed
- Why executed versioned migrations should not normally be modified

---

# Database

Create a database for this exercise.

Use:

```text
customer_order_management
```

All parts of the exercise use this database.

---

# Part 1 — Customer Table

Create the initial `customers` table.

The table must represent the following information:

| Information   | Description                          |
| ------------- | ------------------------------------ |
| Customer ID   | Unique identifier                    |
| First name    | Customer's first name                |
| Last name     | Customer's surname                   |
| Email         | Customer's email address             |
| Phone         | Customer's telephone number          |
| Country code  | Country associated with the customer |
| Date of birth | Customer's date of birth             |
| Created at    | When the record was created          |
| Updated at    | When the record was last changed     |

## Requirements

Choose appropriate MySQL data types.

You must decide:

- Which column is the primary key.
- How the primary key is generated.
- Appropriate string lengths.
- Appropriate date types.
- Appropriate date/time types.
- Which columns should be `NOT NULL`.
- Which columns may contain `NULL`.
- Whether any columns should have a default value.

Do not use `VARCHAR(255)` automatically for every string field.

Consider the actual business meaning and expected contents of each column.

## Submission

This is a **Flyway versioned migration**.

Determine the appropriate migration filename yourself based on your Flyway research.

---

# Part 2 — Initial Customer Data

Insert the following customers.

The IDs are shown so that the same customers can be identified in later exercises.

Do not assume that the ID should necessarily be manually inserted.

|  ID | First Name | Last Name | Email                                                           | Phone        | Country Code | Date of Birth |
| --: | ---------- | --------- | --------------------------------------------------------------- | ------------ | ------------ | ------------- |
|   1 | Aisha      | Naidoo    | [aisha.naidoo@gmail.com](mailto:aisha.naidoo@gmail.com)         | 0825551001   | ZA           | 1992-03-14    |
|   2 | Daniel     | Mokoena   | [daniel.mokoena@outlook.com](mailto:daniel.mokoena@outlook.com) | 0835551002   | ZA           | 1988-11-02    |
|   3 | Priya      | Pillay    | [priya.pillay@yahoo.com](mailto:priya.pillay@yahoo.com)         | 0845551003   | ZA           | 1995-07-21    |
|   4 | Michael    | Dlamini   | [michael.dlamini@gmail.com](mailto:michael.dlamini@gmail.com)   | 0815551004   | ZA           | 1990-01-30    |
|   5 | Sarah      | Jacobs    | [sarah.jacobs@outlook.com](mailto:sarah.jacobs@outlook.com)     | 0725551005   | ZA           | 1985-09-18    |
|   6 | Thabo      | Naidoo    | [thabo.naidoo@gmail.com](mailto:thabo.naidoo@gmail.com)         | 0765551006   | ZA           | 1998-12-05    |
|   7 | Lindiwe    | Mokoena   | [lindiwe.mokoena@yahoo.com](mailto:lindiwe.mokoena@yahoo.com)   | 0795551007   | ZA           | 1993-05-27    |
|   8 | Arjun      | Patel     | [arjun.patel@gmail.com](mailto:arjun.patel@gmail.com)           | 91985551008  | IN           | 1987-06-11    |
|   9 | Emily      | Smith     | [emily.smith@outlook.com](mailto:emily.smith@outlook.com)       | 44775551009  | GB           | 1996-10-23    |
|  10 | Yusuf      | Khan      | [yusuf.khan@gmail.com](mailto:yusuf.khan@gmail.com)             | 971505551010 | AE           | 1991-02-08    |
|  11 | John       | Smith     | [john.smith@gmail.com](mailto:john.smith@gmail.com)             | 27825551011  | ZA           | 1989-04-16    |
|  12 | John       | Smith     | [john.smith@outlook.com](mailto:john.smith@outlook.com)         | 91975551012  | IN           | 1994-08-29    |

Notice that customers `11` and `12` have the same first name and last name.

They are **different customers**.

Their customer IDs, email addresses, phone numbers, countries and dates of birth are different.

## Submission

This is a **Flyway versioned migration**.

Determine the migration filename yourself.

---

# Part 3 — Update Customer Information

The company has received updated customer information.

You must modify the existing data.

## Task 1 — Email Provider Change

The company has migrated some customers away from Yahoo email addresses.

All customers currently using a Yahoo email address must now use Gmail.

The local part of the email address should remain the same.

For example:

```text
person@yahoo.com
```

should become:

```text
person@gmail.com
```

### Requirement

Identify the affected records using a `SELECT` first.

Your solution must demonstrate the use of:

```sql
LIKE
```

Do not manually update each customer by ID.

---

## Task 2 — Customer Contact Update

Aisha Naidoo has provided a new phone number:

```text
0825552001
```

Update her customer record.

---

## Task 3 — Customer Name Correction

Customer `3` has corrected her surname.

Her surname should now be:

```text
Pillay-Singh
```

Update the appropriate customer.

---

## Task 4 — Same Name, Different Customers

There are two customers called:

```text
John Smith
```

One lives in South Africa and one lives in India.

The South African customer has provided a new phone number:

```text
0825552011
```

The Indian customer has provided a new phone number:

```text
91975552012
```

Update both customers correctly.

### Important

Do not identify the customers using only:

```text
first_name
last_name
```

The database contains two different people with the same name.

Use an appropriate unique identifier or combination of information to identify the correct customer.

---

## Task 5 — Investigate `updated_at`

Before executing your updates, inspect the table definition and the existing data.

Determine how the `updated_at` field is intended to behave.

When customer information changes, the record's modification timestamp should accurately reflect that change.

Implement the update accordingly.

Do not simply ignore `updated_at`.

The requirement is deliberately not giving you the exact SQL mechanism to use.

Research the available MySQL options and decide what is appropriate.

---

## Submission

All changes in this part must be represented by an appropriate **Flyway migration**.

Do not modify the migration that originally inserted the customers.

---

# Part 4 — Customer Upsert

The company receives customer information from an external system every night.

The incoming data may contain:

- Existing customers with changed information.
- Completely new customers.

The import process should not create duplicate records when a customer already exists.

Research the MySQL **upsert** pattern.

The external system sends the following records:

| Customer ID | First Name | Last Name    | Email                                                           | Phone       | Country Code |
| ----------: | ---------- | ------------ | --------------------------------------------------------------- | ----------- | ------------ |
|           3 | Priya      | Pillay-Singh | [priya.pillay@gmail.com](mailto:priya.pillay@gmail.com)         | 0845553003  | ZA           |
|          11 | John       | Smith        | [john.smith@gmail.com](mailto:john.smith@gmail.com)             | 0825553011  | ZA           |
|          13 | Kavita     | Reddy        | [kavita.reddy@gmail.com](mailto:kavita.reddy@gmail.com)         | 91985553013 | IN           |
|          14 | James      | Williams     | [james.williams@outlook.com](mailto:james.williams@outlook.com) | 14155553014 | US           |

The operation must result in:

- Existing customer information being updated where appropriate.
- New customers being inserted.
- Existing customers not being duplicated.

Research and use the MySQL mechanism appropriate for this requirement.

## Submission

This should be implemented as a **Flyway migration**.

Consider carefully whether this migration should be **versioned or repeatable**, and be prepared to explain your decision.

---

# Part 5 — Customer Queries

The customer service department needs to retrieve customer information.

Create read-only SQL queries to answer the following questions.

These are **query exercises**, not database migrations.

Place the queries in an appropriate SQL file in your submission.

## Customer Service Queries

### 1. Customer directory

Display all customers with:

- First name
- Last name
- Email
- Country code

---

### 2. South African customers

Display all customers whose country is South Africa.

---

### 3. Indian customers

Display all customers whose country is India.

---

### 4. Gmail customers

The marketing department wants to identify customers using Gmail.

Find all customers whose email address uses Gmail.

---

### 5. Outlook customers

Find all customers whose email address uses Outlook.

---

### 6. Customers with the surname Naidoo

Find all customers whose surname is `Naidoo`.

---

### 7. Customers born in the 1990s

Find all customers whose date of birth falls between:

```text
1990-01-01
```

and:

```text
1999-12-31
```

---

### 8. Customers matching multiple conditions

Find customers who:

- Are from South Africa
- And use Gmail

---

# Part 6 — Customer and Order Relationship

The company now needs to track orders.

Create an `orders` table.

An order represents a purchase made by a customer.

The order must contain:

- Order ID
- Customer ID
- Order date
- Order amount
- Order status
- Created timestamp
- Updated timestamp

## Business Requirements

### Requirement 1

Every order must belong to an existing customer.

An order must not reference a customer that does not exist.

### Requirement 2

A customer may have multiple orders.

### Requirement 3

A customer may have no orders.

### Requirement 4

Historical orders are important to the company.

If a customer account is closed, the company still needs the customer's order history for reporting and auditing.

Therefore, the database must not casually delete historical orders when a customer is removed.

### Requirement 5

An order amount cannot represent a negative purchase value.

### Requirement 6

An order must have an order date.

### Requirement 7

The order status must represent a valid business state.

Possible states initially include:

```text
PENDING
COMPLETED
CANCELLED
```

Research which MySQL constraints are appropriate for enforcing these requirements.

## Submission

This is a **Flyway versioned migration**.

---

# Part 7 — Order Data

Insert the following orders.

| Order ID | Customer ID | Order Date |  Amount | Status    |
| -------: | ----------: | ---------- | ------: | --------- |
|     1001 |           1 | 2026-01-10 | 1250.00 | COMPLETED |
|     1002 |           2 | 2026-01-15 |  850.50 | COMPLETED |
|     1003 |           1 | 2026-02-02 |  450.00 | PENDING   |
|     1004 |           3 | 2026-02-10 | 2100.00 | COMPLETED |
|     1005 |           5 | 2026-02-14 |  675.25 | CANCELLED |
|     1006 |           7 | 2026-02-20 | 1500.00 | COMPLETED |
|     1007 |           4 | 2026-03-01 |  925.75 | PENDING   |
|     1008 |           8 | 2026-03-04 | 3200.00 | COMPLETED |
|     1009 |           2 | 2026-03-10 |  400.00 | COMPLETED |
|     1010 |           9 | 2026-03-15 |  775.50 | PENDING   |
|     1011 |           6 | 2026-03-20 | 1100.00 | COMPLETED |
|     1012 |          10 | 2026-03-25 | 2500.00 | COMPLETED |
|     1013 |           1 | 2026-04-01 |  300.00 | CANCELLED |
|     1014 |           7 | 2026-04-05 |  950.00 | PENDING   |
|     1015 |           3 | 2026-04-10 | 1800.00 | COMPLETED |

## Submission

This is a **Flyway migration**.

---

# Part 8 — Customer Order Reports

The customer service department now needs information from both tables.

These are **read-only query exercises**.

They should not be implemented as Flyway migrations.

## Query 1 — Customer Order History

Display:

- Customer first name
- Customer last name
- Order ID
- Order date
- Order amount
- Order status

Only customers who have orders should appear.

---

## Query 2 — All Customers

The customer service department wants a list of all customers, including customers who have never placed an order.

Display:

- Customer ID
- First name
- Last name
- Order ID
- Order date
- Order amount

Customers without orders must still appear.

---

## Query 3 — Customer Spending

The finance department wants to see how much each customer has spent.

Display:

- Customer ID
- Customer name
- Total completed order value

Customers who have never completed an order should still be represented.

---

## Query 4 — Pending Orders

The operations team wants a list of pending orders.

Display:

- Order ID
- Customer name
- Customer country
- Order date
- Order amount

Only pending orders should appear.

---

## Query 5 — High-Value Orders

Management wants to review orders worth more than `1000`.

Display:

- Order ID
- Customer name
- Order amount
- Order status

---

# Part 9 — Sorting

The customer service team needs different ways to view customer information.

Write queries to:

1. Sort customers alphabetically by surname.
2. Sort customers by first name and then surname.
3. Display the newest customers first.
4. Display customers from South Africa first.
5. Display orders from highest amount to lowest amount.
6. Display orders by order date, newest first.

Use appropriate:

```sql
ORDER BY
ASC
DESC
```

---

# Part 10 — Aggregation and Business Reporting

Management wants summary information rather than individual records.

Create queries to determine:

### Customer statistics

- Total number of customers.
- Number of customers per country.
- Number of customers using Gmail.
- Number of customers using Outlook.

### Order statistics

- Total number of orders.
- Total value of all orders.
- Total value of completed orders.
- Average order value.
- Largest order.
- Smallest order.

### Customer-level statistics

Determine:

- Number of orders per customer.
- Total completed order value per customer.
- Average order value per customer.

Use appropriate:

```text
COUNT
SUM
AVG
MIN
MAX
GROUP BY
HAVING
```

---

# Part 11 — Indexes

The system is now receiving thousands of customers and orders.

The following queries are executed frequently:

1. Find a customer by email.
2. Find all orders belonging to a customer.
3. Find orders by status.
4. Find orders within a date range.

Research which indexes may be appropriate.

Create the required indexes.

You must be able to explain why each index exists.

Also investigate:

```sql
EXPLAIN
```

Use it to inspect relevant queries.

---

# Part 12 — Customer Account Closure

A customer requests that their account be closed.

The customer has existing orders.

The company needs to preserve historical order information.

Determine an appropriate database design and operation for closing the account.

Consider:

- Foreign keys
- Referential integrity
- `DELETE`
- Soft deletion
- Customer status
- Historical reporting

Implement the solution you determine is appropriate.

Explain your decision in a short comment or documentation file.

---

# Part 13 — Repeatable Migration: Customer Reporting View

The finance department frequently needs a summary of customer order activity.

Create a database view containing useful information such as:

- Customer ID
- Customer name
- Country
- Number of orders
- Total completed order value

The view should be maintained using a **Flyway repeatable migration**.

Research how repeatable migrations work.

Then modify the view definition.

Run Flyway again and observe what happens.

You should understand why Flyway knows that the repeatable migration has changed.

---

# Part 14 — Stored Procedure: Customer Order History

The customer service application frequently requests a customer's order history.

Create a stored procedure that accepts a customer ID.

The procedure should return the customer's:

- Customer ID
- First name
- Last name
- Email
- Order ID
- Order date
- Order amount
- Order status

The procedure should work for customers with:

- Multiple orders.
- One order.
- No orders.

Research MySQL stored procedure syntax before implementing it.

## Flyway

The stored procedure must be managed through Flyway.

Determine whether a stored procedure is better represented as a versioned or repeatable migration, and explain your choice.

---

# Part 15 — Stored Procedure: Create Customer Order

The application needs a database operation for creating a new order.

Create a stored procedure that accepts the information required to create an order.

The procedure should:

1. Verify that the customer exists.
2. Validate the order information.
3. Create the order.
4. Set the appropriate timestamps.
5. Return useful information about the newly created order.

Research how MySQL stored procedures can:

- Accept parameters.
- Use variables.
- Perform conditional logic.
- Handle errors.

---

# Part 16 — Stored Procedure: Customer Summary

Management wants to request a summary for a specific customer.

Create a stored procedure that accepts a customer ID and returns:

- Customer name.
- Country.
- Number of orders.
- Number of completed orders.
- Total completed order value.
- Average completed order value.
- Most recent order date.

Customers without orders must be handled correctly.

---

# Part 17 — Transactions

The order creation process now has more than one database operation.

Research MySQL transactions.

Investigate:

```sql
START TRANSACTION
COMMIT
ROLLBACK
```

Design an exercise where an order operation must either complete fully or leave the database unchanged.

Consider what should happen if:

- The customer does not exist.
- The order contains an invalid amount.
- An error occurs while creating the order.

---

# Part 18 — Advanced SQL

Continue extending the system as additional SQL concepts are introduced.

Possible future topics include:

## Subqueries

Answer questions such as:

- Which customers have placed orders above the average order value?
- Which customers have spent more than the average customer?

## Common Table Expressions

Use:

```sql
WITH
```

to simplify more complex reporting queries.

## CASE

Classify customers or orders into business categories.

For example:

```text
High Value
Medium Value
Low Value
```

The actual thresholds should be defined as part of the business requirement.

## Window Functions

Research functions such as:

```text
ROW_NUMBER()
RANK()
DENSE_RANK()
SUM() OVER()
AVG() OVER()
```

Use them to answer reporting questions such as:

- Rank customers by total spending.
- Find the most recent order for each customer.
- Calculate running order totals.

## Query Optimisation

Investigate:

- `EXPLAIN`
- Index usage
- Composite indexes
- Query execution plans
- Filtering
- Join performance

---

# Submission Structure

Do not assume that every part belongs in the same type of file.

For every part, determine whether the requirement represents:

- A database structure change.
- A database data change.
- A repeatable database object.
- A read-only query.
- A stored procedure.
- An investigation/research task.

Use Flyway where appropriate.

A possible final project structure could contain:

```text
mysql-database-lab/
│
├── README.md
│
├── migrations/
│   ├── ...
│   └── ...
│
└── queries/
    ├── ...
    └── ...
```

The exact migration filenames and versions are intentionally **not provided**.

You are expected to determine the correct Flyway naming convention from the Flyway documentation.

---

# Important Rules

## 1. Do not modify executed versioned migrations

Once a versioned migration has been executed, do not edit it to change the database history.

Create a new migration instead.

---

## 2. Investigate before modifying data

Before executing an:

```sql
UPDATE
```

or:

```sql
DELETE
```

use a `SELECT` to confirm which records will be affected.

---

## 3. Do not assume names are unique

The database deliberately contains:

```text
John Smith
John Smith
```

They are different people.

Do not use a person's name as their unique identifier.

---

## 4. Think about business meaning

A SQL statement can be syntactically correct and still be a poor database operation.

Before modifying or deleting data, consider:

- Relationships
- Business rules
- Historical information
- Data integrity
- Referential integrity

---

# Learning Objectives

By completing this exercise, you should be able to demonstrate knowledge of:

### Database Design

- Tables
- Columns
- Data types
- String lengths
- Primary keys
- Foreign keys
- Constraints
- Relationships

### Data Manipulation

- `INSERT`
- `UPDATE`
- `DELETE`
- Upsert
- `INSERT ... ON DUPLICATE KEY UPDATE`

### Data Retrieval

- `SELECT`
- `WHERE`
- `LIKE`
- `IN`
- `BETWEEN`
- `IS NULL`
- `IS NOT NULL`
- `ORDER BY`
- `JOIN`
- `GROUP BY`
- `HAVING`

### Database Objects

- Views
- Stored procedures
- Functions

### Performance

- Indexes
- Composite indexes
- `EXPLAIN`
- Query optimisation

### Transactions

- `START TRANSACTION`
- `COMMIT`
- `ROLLBACK`

### Flyway

- Versioned migrations
- Repeatable migrations
- Migration ordering
- Checksums
- Migration history
- Immutable executed migrations

---

# Final Principle

The exercise is intentionally designed so that the requirements become more complex over time.

Do not focus only on making individual SQL statements execute.

Think about the system as a whole:

```text
Business requirement
        ↓
What data is required?
        ↓
How should the data be represented?
        ↓
What constraints protect the data?
        ↓
How is the data created?
        ↓
How is the data changed?
        ↓
How is the data queried?
        ↓
How are related records handled?
        ↓
How is the database optimised?
        ↓
How are database changes versioned?
```

As new SQL concepts are covered in class, additional requirements can be added to this same system.
