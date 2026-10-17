# MySQL Customer and Order Management System

## Overview

This project builds a small **Customer and Order Management System** using MySQL and Flyway.

The company manages customer information, customer contact/location details, and orders. A customer can place multiple orders, while an order belongs to one customer. Historical order information must be preserved when a customer account is closed.

## Requirements

- MySQL 8.x
- Flyway Community Edition
- A MySQL client such as MySQL Workbench

## Project Structure

```text
mysql-db-lab/
├── .gitignore
├── README.md
├── COMMON_ERRORS.md
├── flyway.toml
├── queries/
│   ├── 03_customer_update_checks.sql
│   ├── 05_customer_service_queries.sql
│   ├── 08_customer_order_queries.sql
│   ├── 09_sorting_queries.sql
│   ├── 10_aggregation_and_business_reporting.sql
│   ├── 11_indexes_explain.sql
│   ├── 15_procedure_queries.sql
│   ├── 16_customer_summary.sql
│   ├── 17_transactions_queries.sql
│   └── 18_advanced_sql.sql
└── sql/
    ├── R__create_customer_order.sql
    ├── R__customer_order_history_procedure.sql
    ├── R__customer_reporting_view.sql
    ├── R__customer_summary_procedure.sql
    ├── V1__customer_table.sql
    ├── V2__customer_details_inserted.sql
    ├── V3__customer_details_updation.sql
    ├── V4__customer_upsert.sql
    ├── V5__create_orders_table.sql
    ├── V6__insert_orders_data.sql
    ├── V7__created_cust_order_indexes.sql
    ├── V8__customer_account_closure.sql
    └── V9__create_composite_order_index.sql
```

The `sql/` directory contains Flyway-managed versioned and repeatable migrations. The `queries/` directory contains reporting, verification and practice SQL files; these are not scanned as Flyway migrations.

## Database

Create the database before running Flyway:

```sql
CREATE DATABASE customer_order_management;
```

The same database and data are used throughout the exercise.

## Flyway Configuration

`flyway.toml` belongs in the project root. It should point Flyway to the `sql/` directory and to the local MySQL database.

Example:

```toml
[flyway]
locations = ["filesystem:D:/mysql-db-lab/sql"]

[environments.local]
url = "jdbc:mysql://127.0.0.1:3306/customer_order_management?allowPublicKeyRetrieval=true&useSSL=false"
user = "root"
password = "YOUR_MYSQL_PASSWORD"
```

Never commit a real database password.

## Migration Naming

Versioned migrations use the following format:

```text
V<version>__<description>.sql
```

Examples from this project:

```text
V1__customer_table.sql
V2__customer_details_inserted.sql
V3__customer_details_updation.sql
```

Repeatable migrations use:

```text
R__<description>.sql
```

Flyway executes versioned migrations in version order. Repeatable migrations are tracked separately and rerun when their definitions change.

## Migration Flow

```text
V1  Customer table
 ↓
V2  Customer details inserted
 ↓
V3  Customer details updated
 ↓
V4  Customer upsert
 ↓
V5  Orders table
 ↓
V6  Order data
 ↓
V7  Indexes
 ↓
V8  Customer account closure
 ↓
V9  Composite index
 ↓
R__ Repeatable database objects
```

## Query Parts

| File | Part | Purpose |
|---|---:|---|
| `03_customer_update_checks.sql` | 3 | Manual before/after verification for customer updates |
| `05_customer_service_queries.sql` | 5 | Customer queries |
| `08_customer_order_queries.sql` | 8 | Customer/order reports |
| `09_sorting_queries.sql` | 9 | Sorting |
| `10_aggregation_and_business_reporting.sql` | 10 | Aggregation and business reporting |
| `11_indexes_explain.sql` | 11 | Indexes and `EXPLAIN` |
| `15_procedure_queries.sql` | 15 | Create-customer-order procedure tests |
| `16_customer_summary.sql` | 16 | Customer summary procedure tests |
| `17_transactions_queries.sql` | 17 | Transactions |
| `18_advanced_sql.sql` | 18 | Advanced SQL |

## Running Flyway

Check migration status:

```powershell
flyway -configFiles="D:\mysql-db-lab\flyway.toml" -environment=local info
```

Apply migrations:

```powershell
flyway -configFiles="D:\mysql-db-lab\flyway.toml" -environment=local migrate
```

After migration, check the status again:

```powershell
flyway -configFiles="D:\mysql-db-lab\flyway.toml" -environment=local info
```

For this project, migrations should be tested against a new database so that the complete V1 → V9 sequence is exercised from the beginning.

## Important Migration Rule

Do not put verification `SELECT` statements inside versioned or repeatable migrations. Run those checks manually or from the appropriate file in `queries/`.

Also avoid editing a versioned migration that has already been applied to a shared database. If a new database change is required after a migration has been executed, create the next versioned migration.

## Data Note: Customer Upsert

The customer upsert exercise contains customer IDs 3, 11, 12, 13 and 14. The supplied data does not provide dates of birth for new customers 13 and 14, while the customer table requires a date of birth.

The final date-of-birth values for customers 13 and 14 must therefore be confirmed from the business requirements before the upsert is completed. Do not invent dates.

# Scenario

The database represents a real customer/order application rather than a collection of unrelated SQL examples.

The customer table stores customer identity, contact and location information. The orders table records purchases and maintains the relationship between customers and their orders.

## Customers

The `customers` table stores customer information, including names, email addresses, phone numbers, country codes and dates of birth. Each customer is identified by a customer ID.

Customer information can be inserted or updated as required. When a customer account is closed, the project is intended to preserve historical order information rather than physically deleting the customer.

## Orders

The `orders` table stores order information, including the customer associated with each order, the order date, amount and status.

Each order belongs to one customer, and one customer can have multiple orders. The foreign-key relationship between `orders.customer_id` and `customers.customer_id` maintains this relationship and helps protect the integrity of order records.

## Information Summary

| Information | Description |
|---|---|
| Customer management | Stores and updates customer details |
| Order management | Records customer orders, amounts, dates and statuses |
| Data integrity | Uses primary keys, foreign keys and constraints |
| Query practice | Includes filtering, sorting, aggregation and reporting |
| Performance | Uses indexes and `EXPLAIN` to examine query performance |
| Database automation | Uses Flyway migrations and repeatable database objects |
| Historical records | Aims to preserve orders when a customer account is closed |
