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
mysql-database-lab/
├── README.md
├── COMMON_ERRORS.md
├── flyway.toml
├── sql/                 # Flyway-managed versioned and repeatable migrations
└── queries/             # Read-only queries, verification and practice SQL
```

The `sql/` directory contains database changes managed by Flyway. The `queries/` directory contains reporting, verification and learning queries and is not scanned as a Flyway migration location.

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

Versioned migrations use:

```text
V<version>__<description>.sql
```

Examples:

```text
V1__customers_table.sql
V2__initial_customer_data.sql
V3__customer_details_updation.sql
```

Repeatable migrations use:

```text
R__<description>.sql
```

Flyway executes versioned migrations in version order. Repeatable migrations are tracked separately and are rerun when their definition changes.

## Migration Flow

```text
V1  Customer table
 ↓
V2  Initial customer data
 ↓
V3  Customer information updates
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

For this project, migrations should be tested against a **new database** so that the complete V1 → V9 sequence is exercised from the beginning.

## Important Migration Rule

Do not put verification `SELECT` statements inside versioned or repeatable migrations. Run those checks manually or from the appropriate file in `queries/`.

Also avoid editing a versioned migration that has already been applied to a shared database. If a new database change is required after a migration has been executed, create the next versioned migration.

## Part 4 Data Note

The Part 4 external-system data supplied by the exercise contains customer IDs 3, 11, 13 and 14, but it does not supply dates of birth for the new customers 13 and 14. The customer table requirement says every customer has a date of birth.

Therefore, the final DOB values for customers 13 and 14 must be supplied by the business requirement before the Part 4 upsert is completed. No artificial dates should be invented.

## Application Scenario

The database represents a real customer/order application rather than a collection of unrelated SQL examples. The customer table stores customer identity, contact and location information. The orders table records purchases and maintains the relationship between customers and their orders.
