# MySQL Database Lab --- Complete MySQL + Flyway Guide

> A complete record of the MySQL Workbench + Flyway setup,
> troubleshooting journey, migration history, repeatable database
> objects, SQL query collection, and final project structure.

------------------------------------------------------------------------

## 1. Project Overview

This project is a practical MySQL database lab built and managed with
**MySQL Workbench** and **Flyway Community Edition**.

The project documents:

-   MySQL installation and connection setup
-   MySQL Workbench configuration
-   Flyway installation and configuration
-   Database migrations
-   Migration troubleshooting and recovery
-   Customer and order database changes
-   Versioned Flyway migrations
-   Repeatable Flyway migrations
-   Customer/order reporting queries
-   SQL aggregation, sorting, transactions, procedures, views, and
    index-related work
-   A reusable workflow for future MySQL + Flyway projects

### Main technologies

-   **Operating System:** Windows 11
-   **Database:** MySQL 8.0.43
-   **Database Client:** MySQL Workbench
-   **Migration Tool:** Flyway Community Edition 13.7.0
-   **Database:** `customer_order_management`
-   **Project folder:** `D:\mysql-db-lab`
-   **Flyway installation:** `D:\flyway\flyway-13.7.0`

------------------------------------------------------------------------

# 2. Final Repository Structure

The repository is organized into two separate SQL-related areas:

1.  `sql/` --- Flyway-controlled database migrations and repeatable
    database objects
2.  `queries/` --- SQL queries used for reporting, practice, analysis,
    procedures, transactions, sorting, aggregation, and other database
    exercises

The final project structure is:

``` text
D:\mysql-db-lab
│
├── .git\
│
├── flyway.toml
│
├── queries\
│   ├── Advanced_Sql.sql
│   ├── Aggregation_and_Business_Reporting.sql
│   ├── customer_order_queries.sql
│   ├── customer_service_queries.sql
│   ├── Customer_Summary.sql
│   ├── indexes_explain.sql
│   ├── Procedure_Queries.sql
│   ├── Sorting_Queries.sql
│   └── Transactions_Queries.sql
│
└── sql\
    ├── R__create_customer_order.sql
    ├── R__customer_order_history_procedure.sql
    ├── R__customer_reporting_view.sql
    ├── R__customer_summary_procedure.sql
    │
    ├── V1__customers_table.sql
    ├── V2__customer_details_updation.sql
    ├── V3__customer_details_inserted.sql
    ├── V4__customer_upsert.sql
    ├── V5__create_orders_table.sql
    ├── V6__insert_orders_data.sql
    ├── V7__created_cust_order_indexes.sql
    ├── V8__customer_account_closure.sql
    └── V9__create_composite_order_index.sql
```

### Important distinction

``` text
mysql-db-lab
│
├── flyway.toml
│
├── sql/
│   ├── V1 ... V9       ← versioned Flyway migrations
│   └── R__...          ← repeatable Flyway migrations
│
└── queries/
    └── *.sql           ← query/reporting/practice SQL
```

`flyway.toml` is the Flyway configuration file.

The `sql` folder is the Flyway migration location.

The `queries` folder is a separate collection of SQL queries and is
**not the Flyway migration location**.

------------------------------------------------------------------------

# 3. What Flyway Does

Flyway is a database migration tool.

Instead of manually applying database changes every time, database
changes are stored as SQL files with a defined naming convention.

### Versioned migration flow

``` text
V1
 ↓
V2
 ↓
V3
 ↓
...
 ↓
V9
```

Flyway executes versioned migrations in version order and records their
status in:

``` text
flyway_schema_history
```

The basic process is:

``` text
Migration file exists
        ↓
Flyway detects it
        ↓
Pending
        ↓
migrate
        ↓
Successfully executed
        ↓
Recorded in flyway_schema_history
```

------------------------------------------------------------------------

# 4. Versioned and Repeatable Migrations

The `sql` folder contains two different Flyway migration types.

## 4.1 Versioned migrations

Versioned migrations use:

``` text
V<version>__<description>.sql
```

Examples from this project:

``` text
V1__customers_table.sql
V2__customer_details_updation.sql
V3__customer_details_inserted.sql
V4__customer_upsert.sql
V5__create_orders_table.sql
V6__insert_orders_data.sql
V7__created_cust_order_indexes.sql
V8__customer_account_closure.sql
V9__create_composite_order_index.sql
```

Versioned migrations are applied in version order.

------------------------------------------------------------------------

## 4.2 Repeatable migrations

Repeatable migrations use:

``` text
R__<description>.sql
```

The project contains:

``` text
R__create_customer_order.sql
R__customer_order_history_procedure.sql
R__customer_reporting_view.sql
R__customer_summary_procedure.sql
```

These files are separate from the V1--V9 version sequence.

Their filenames indicate database objects such as a customer/order
object, procedures, and a reporting view.

> The exact SQL behavior of each repeatable file should be taken from
> the SQL file itself. This README does not infer implementation details
> from filenames alone.

------------------------------------------------------------------------

# 5. Database Architecture

The project uses the database:

``` text
customer_order_management
```

At a high level, the database contains customer/order data together with
Flyway's migration history.

Conceptually:

``` text
MySQL Server
│
└── Database: customer_order_management
    │
    ├── customers
    │
    ├── orders
    │
    └── flyway_schema_history
```

Additional database objects are managed through the repeatable
migrations in `sql/`.

------------------------------------------------------------------------

# 6. MySQL Port Problem

Initially, the project was trying to use:

``` text
3305
```

However, the actual MySQL 8.0 Windows service was configured to use:

``` text
3306
```

The MySQL Windows service was:

``` text
MySQL80
```

The MySQL configuration contained:

``` text
port=3306
```

The server was verified using:

``` cmd
netstat -ano | findstr :3306
```

Inside MySQL, the port was confirmed using:

``` sql
SHOW VARIABLES LIKE 'port';
```

Expected result:

``` text
3306
```

### Final connection

``` text
Host: 127.0.0.1
Port: 3306
User: root
```

------------------------------------------------------------------------

# 7. Root Password Problem

At one point:

``` cmd
mysql -u root -p
```

returned:

``` text
ERROR 1045 (28000): Access denied for user 'root'@'localhost'
```

The root password therefore had to be reset.

## Security rule

Never put the real MySQL password in this README or commit it to GitHub.

Use:

``` text
YOUR_MYSQL_PASSWORD
```

as a placeholder.

For a real project, use a secure credential-management approach rather
than storing credentials in source control.

------------------------------------------------------------------------

# 8. Root Password Reset

The Windows `--skip-grant-tables` method caused MySQL startup problems,
so that approach was abandoned.

The working method was the MySQL `--init-file` method.

A temporary file was created:

``` text
C:\mysql-init.txt
```

It contained an `ALTER USER` command to set a new root password.

MySQL was started manually with:

``` cmd
"C:\Program Files\MySQL\MySQL Server 8.0\bin\mysqld.exe" --defaults-file="C:\ProgramData\MySQL\MySQL Server 8.0\my.ini" --init-file=C:\\mysql-init.txt --console
```

The server successfully reported that it was ready for connections on
port `3306`.

A second CMD window tested:

``` cmd
mysql -u root -p
```

The login succeeded.

After the reset:

``` cmd
del C:\mysql-init.txt
```

The normal Windows service was started:

``` cmd
net start MySQL80
```

Normal login was tested again:

``` cmd
mysql -u root -p
```

This confirmed that the normal MySQL service was working.

------------------------------------------------------------------------

# 9. MySQL Workbench Configuration

The old Workbench connection used port `3305`.

It was changed to:

``` text
Connection Method: Standard (TCP/IP)
Hostname: 127.0.0.1
Port: 3306
Username: root
Password: New MySQL password
```

The **Test Connection** operation succeeded.

Therefore Workbench connects to:

``` text
127.0.0.1:3306
```

------------------------------------------------------------------------

# 10. Flyway Installation

Flyway Community Edition 13.7.0 was installed at:

``` text
D:\flyway\flyway-13.7.0
```

The executable is:

``` text
D:\flyway\flyway-13.7.0\flyway.cmd
```

Because the Flyway folder was not initially available through PATH, the
full executable path was used.

------------------------------------------------------------------------

# 11. Finding flyway.toml

An incorrect path was initially used:

``` text
D:\mysql-db-lab\sql\flyway.toml
```

The actual configuration file is:

``` text
D:\mysql-db-lab\flyway.toml
```

The location was found using:

``` cmd
dir D:\mysql-db-lab /s /b | findstr /i "flyway.toml"
```

### Correct distinction

``` text
D:\mysql-db-lab\flyway.toml
        ↑
        Configuration

D:\mysql-db-lab\sql\
        ↑
        Flyway migrations
```

------------------------------------------------------------------------

# 12. Final Flyway Configuration

The working configuration follows this structure:

``` toml
[flyway]
locations = ["filesystem:D:/mysql-db-lab/sql"]

[environments.local]
url = "jdbc:mysql://127.0.0.1:3306/customer_order_management?allowPublicKeyRetrieval=true&useSSL=false"
user = "root"
password = "YOUR_MYSQL_PASSWORD"
```

## `[flyway]`

``` toml
[flyway]
```

Starts the main Flyway configuration section.

## `locations`

``` toml
locations = ["filesystem:D:/mysql-db-lab/sql"]
```

Tells Flyway where the migration files are located.

This points to:

``` text
D:\mysql-db-lab\sql
```

Therefore Flyway scans the `sql` folder for both versioned and
repeatable migration files.

## `[environments.local]`

``` toml
[environments.local]
```

Defines settings for the environment named:

``` text
local
```

The commands therefore use:

``` text
-environment=local
```

## JDBC URL

``` toml
url = "jdbc:mysql://127.0.0.1:3306/customer_order_management?allowPublicKeyRetrieval=true&useSSL=false"
```

Breakdown:

``` text
jdbc:mysql://
```

Use the MySQL JDBC connection.

``` text
127.0.0.1
```

The MySQL server is running on the same computer.

``` text
3306
```

The MySQL server port.

``` text
customer_order_management
```

The database name.

``` text
allowPublicKeyRetrieval=true
```

Allows the JDBC driver to retrieve the MySQL RSA public key when
required for authentication.

``` text
useSSL=false
```

Disables SSL for this local development connection.

### User

``` toml
user = "root"
```

The MySQL username.

### Password

``` toml
password = "YOUR_MYSQL_PASSWORD"
```

The password used by Flyway.

Do not commit the real password to GitHub.

------------------------------------------------------------------------

# 13. First Flyway Connection Test

The main status command is:

``` cmd
"D:\flyway\flyway-13.7.0\flyway.cmd" -configFiles="D:\mysql-db-lab\flyway.toml" -environment=local info
```

Initially Flyway attempted:

``` text
127.0.0.1:3305
```

and failed with:

``` text
Connection refused
```

### Cause

The configuration was still using the old MySQL port.

### Fix

Change:

``` text
3305
```

to:

``` text
3306
```

------------------------------------------------------------------------

# 14. Flyway Authentication Error

After fixing the port, Flyway reported:

``` text
Access denied for user 'root'@'localhost'
(using password: NO)
```

### Meaning

Flyway had:

``` text
user = root
```

but did not have a password configured.

### Fix

Add the password to the local environment:

``` toml
password = "YOUR_MYSQL_PASSWORD"
```

After this, Flyway successfully authenticated with MySQL.

------------------------------------------------------------------------

# 15. Database Not Found

Flyway then reported:

``` text
Unknown database 'customer_order_management'
```

### Cause

The selected MySQL server did not contain the project database.

The database was created in MySQL Workbench:

``` sql
CREATE DATABASE customer_order_management;
```

It was verified using:

``` sql
SHOW DATABASES;
```

------------------------------------------------------------------------

# 16. Initial Migration History

The first version of the project contained three migrations:

``` text
V1
V2
V3
```

Flyway detected them as pending.

`Pending` means:

> Flyway found the migration file, but it has not successfully executed
> it yet.

It does not automatically mean that the migration contains an error.

------------------------------------------------------------------------

# 17. First Migration Attempt

The migration command was:

``` cmd
"D:\flyway\flyway-13.7.0\flyway.cmd" -configFiles="D:\mysql-db-lab\flyway.toml" -environment=local migrate
```

V1 successfully executed.

Then V2 failed with:

``` text
Unknown database 'customers'
```

------------------------------------------------------------------------

# 18. Why V2 Failed

The first statement in the original V2 migration was:

``` sql
USE customers;
```

This was incorrect because:

``` text
Database:
customer_order_management
```

and:

``` text
Table:
customers
```

are different objects.

The correct statement is:

``` sql
USE customer_order_management;
```

Then the table can be accessed with:

``` sql
SELECT * FROM customers;
```

------------------------------------------------------------------------

# 19. Correcting V2

V2 was changed from:

``` sql
USE customers;
```

to:

``` sql
USE customer_order_management;
```

The rest of the V2 migration could then operate on the `customers`
table.

------------------------------------------------------------------------

# 20. Why Migrate Failed Again

After V2 had failed once, running `migrate` again produced a
failed-migration validation error.

Flyway records migration execution in:

``` text
flyway_schema_history
```

Because V2 had failed, Flyway knew there was a failed migration.

The migration history therefore had to be repaired before trying again.

------------------------------------------------------------------------

# 21. Flyway Repair

The repair command was:

``` cmd
"D:\flyway\flyway-13.7.0\flyway.cmd" -configFiles="D:\mysql-db-lab\flyway.toml" -environment=local repair
```

### What `repair` means

`repair` fixes Flyway's recorded migration history after a failed
migration.

It does **not** execute the migration.

The normal recovery sequence is:

``` text
Fix SQL
   ↓
repair
   ↓
migrate
   ↓
info
```

Do not use `repair` as a replacement for `migrate`.

------------------------------------------------------------------------

# 22. Migration History --- V1 to V9

The final repository contains nine versioned migrations.

  Version   File                                     Role indicated by filename
  --------- ---------------------------------------- ----------------------------
  V1        `V1__customers_table.sql`                Customers table
  V2        `V2__customer_details_updation.sql`      Customer details update
  V3        `V3__customer_details_inserted.sql`      Customer data insertion
  V4        `V4__customer_upsert.sql`                Customer upsert
  V5        `V5__create_orders_table.sql`            Orders table creation
  V6        `V6__insert_orders_data.sql`             Orders data insertion
  V7        `V7__created_cust_order_indexes.sql`     Customer/order indexes
  V8        `V8__customer_account_closure.sql`       Customer account closure
  V9        `V9__create_composite_order_index.sql`   Composite order index

> The descriptions above are based on the actual migration filenames in
> the final repository. The README does not infer additional SQL
> behavior that is not established by the available source material.

------------------------------------------------------------------------

# 23. V1 --- Customers Table

Migration:

``` text
V1__customers_table.sql
```

The customer table includes the customer information used by the
project.

The documented structure includes fields such as:

``` text
customer_id
first_name
last_name
email
phone
country_code
date_of_birth
created_at
updated_at
```

The primary customer identifier is:

``` text
customer_id
```

The customer table is the foundation for later customer/order
operations.

------------------------------------------------------------------------

# 24. V2 --- Customer Details Updation

Migration:

``` text
V2__customer_details_updation.sql
```

This migration updates the customer details structure/data.

The major troubleshooting issue encountered with V2 was the incorrect:

``` sql
USE customers;
```

which was corrected to:

``` sql
USE customer_order_management;
```

This was an important database-versus-table naming lesson.

------------------------------------------------------------------------

# 25. V3 --- Customer Details Inserted

Migration:

``` text
V3__customer_details_inserted.sql
```

This migration inserts customer data into the project.

After the V2 problem was corrected and the failed migration history was
repaired, V2 and V3 were successfully applied.

------------------------------------------------------------------------

# 26. V4 --- Customer Upsert

Migration:

``` text
V4__customer_upsert.sql
```

This migration is the project's customer upsert migration.

The project history also included a migration validation/checksum
problem around V4.

When an already-applied migration is modified, Flyway can detect that
the migration checksum no longer matches the checksum stored in
migration history.

The important rule is:

``` text
Do not casually edit an already-applied migration.
```

For new database changes, create a new versioned migration instead.

------------------------------------------------------------------------

# 27. V5 --- Create Orders Table

Migration:

``` text
V5__create_orders_table.sql
```

This migration creates the orders table.

The documented order table structure includes:

``` text
order_id
customer_id
order_date
order_amount
order_status
created_at
updated_at
```

The documented rules include:

-   `order_id` as the primary key
-   Auto-increment order identifier
-   Customer relationship through `customer_id`
-   Decimal order amount
-   Non-negative order amount check
-   Order status values including:
    -   `PENDING`
    -   `COMPLETED`
    -   `CANCELLED`
-   Timestamp fields

The project also encountered a table-already-exists situation during the
V5 migration work, which required understanding the existing database
state before continuing.

------------------------------------------------------------------------

# 28. V6 --- Insert Orders Data

Migration:

``` text
V6__insert_orders_data.sql
```

This migration inserts order data.

The project history included a duplicate-key error during the V6
migration attempt.

The important troubleshooting lesson is:

``` text
Before rerunning an INSERT migration,
check whether some or all of the rows were already inserted.
```

A failed migration does not automatically mean that no data was changed.

------------------------------------------------------------------------

# 29. V7 --- Customer/Order Indexes

Migration:

``` text
V7__created_cust_order_indexes.sql
```

The filename indicates that this migration creates indexes related to
customer/order data.

The repository also contains:

``` text
queries/indexes_explain.sql
```

which is part of the separate query collection.

For exact index definitions, refer to the V7 SQL file itself.

------------------------------------------------------------------------

# 30. V8 --- Customer Account Closure

Migration:

``` text
V8__customer_account_closure.sql
```

The filename indicates that this migration contains the customer account
closure database change.

For the exact SQL behavior and affected columns/objects, refer directly
to the migration file.

------------------------------------------------------------------------

# 31. V9 --- Composite Order Index

Migration:

``` text
V9__create_composite_order_index.sql
```

The filename indicates that this migration creates a composite index
related to orders.

For the exact indexed columns and definition, refer directly to the V9
SQL file.

------------------------------------------------------------------------

# 32. Repeatable Migrations in the Final Project

The `sql` directory also contains four repeatable migrations:

``` text
R__create_customer_order.sql
R__customer_order_history_procedure.sql
R__customer_reporting_view.sql
R__customer_summary_procedure.sql
```

These are different from the numbered V1--V9 migrations.

### Versioned migrations

``` text
V1 → V2 → ... → V9
```

### Repeatable migrations

``` text
R__...
```

Repeatable migrations are identified by the `R__` prefix.

The project uses them for database objects indicated by their filenames,
including procedures and a reporting view.

------------------------------------------------------------------------

# 33. Queries Folder

The project deliberately separates general SQL queries from Flyway
migration files.

The final `queries` directory contains:

``` text
queries/
│
├── Advanced_Sql.sql
├── Aggregation_and_Business_Reporting.sql
├── customer_order_queries.sql
├── customer_service_queries.sql
├── Customer_Summary.sql
├── indexes_explain.sql
├── Procedure_Queries.sql
├── Sorting_Queries.sql
└── Transactions_Queries.sql
```

These files are not part of the V1--V9 migration sequence.

They are organized SQL work for querying, analysis, reporting, database
concepts, and practice.

------------------------------------------------------------------------

# 34. Customer Order Queries

The project includes a dedicated:

``` text
customer_order_queries.sql
```

file.

The reporting work covers customer/order-related queries such as:

-   Customer order history
-   Customers including customers with no orders
-   Customer spending
-   Pending orders with customer information
-   High-value order analysis

These are read/query operations and should be kept separate from
schema-changing Flyway migrations unless they are intentionally being
created as database objects through a migration.

------------------------------------------------------------------------

# 35. Aggregation and Business Reporting

The project contains:

``` text
Aggregation_and_Business_Reporting.sql
```

This file belongs to the `queries` directory.

It is separate from Flyway's migration files and is used for SQL
aggregation and business-reporting work.

------------------------------------------------------------------------

# 36. Advanced SQL

The project contains:

``` text
Advanced_Sql.sql
```

This is part of the query collection.

It is not a numbered Flyway migration.

------------------------------------------------------------------------

# 37. Sorting Queries

The project contains:

``` text
Sorting_Queries.sql
```

This is used for sorting-related SQL practice/query work.

It is stored under:

``` text
queries/
```

rather than:

``` text
sql/
```

------------------------------------------------------------------------

# 38. Transaction Queries

The project contains:

``` text
Transactions_Queries.sql
```

This file is part of the SQL query collection for transaction-related
work.

------------------------------------------------------------------------

# 39. Procedure Queries

The project contains:

``` text
Procedure_Queries.sql
```

This is the query/practice-side procedure file.

The repository also contains repeatable Flyway procedure migrations in
`sql/`, such as:

``` text
R__customer_order_history_procedure.sql
R__customer_summary_procedure.sql
```

These two uses should not be confused:

``` text
queries/
    Procedure_Queries.sql
        ↓
    Query/practice collection

sql/
    R__...procedure.sql
        ↓
    Flyway-managed repeatable database object
```

------------------------------------------------------------------------

# 40. Customer Summary

The project contains:

``` text
Customer_Summary.sql
```

under:

``` text
queries/
```

It is part of the query/reporting collection.

The project also contains:

``` text
R__customer_summary_procedure.sql
```

under:

``` text
sql/
```

The two files should be treated according to their respective folders
and Flyway naming conventions.

------------------------------------------------------------------------

# 41. Index Explanation

The project contains:

``` text
indexes_explain.sql
```

under:

``` text
queries/
```

This is separate from the actual index migrations:

``` text
V7__created_cust_order_indexes.sql
V9__create_composite_order_index.sql
```

The query file can be used to inspect/explain index-related SQL
behavior, while the V7/V9 files belong to the Flyway migration history.

------------------------------------------------------------------------

# 42. Customer Service Queries

The project contains:

``` text
customer_service_queries.sql
```

under:

``` text
queries/
```

This file is part of the separate query collection.

------------------------------------------------------------------------

# 43. MySQL Workbench Verification

Connect to:

``` text
127.0.0.1:3306
```

Select:

``` sql
USE customer_order_management;
```

Check tables:

``` sql
SHOW TABLES;
```

Check customer data:

``` sql
SELECT * FROM customers;
```

Check order data:

``` sql
SELECT * FROM orders;
```

Check Flyway history:

``` sql
SELECT * FROM flyway_schema_history;
```

The `flyway_schema_history` table is the primary place to inspect
Flyway's recorded migration history.

------------------------------------------------------------------------

# 44. Database vs Table --- Important Beginner Concept

One of the main V2 problems came from confusing a database with a table.

Think of the structure as:

``` text
MySQL Server
│
└── Database: customer_order_management
    │
    ├── Table: customers
    │
    ├── Table: orders
    │
    └── Table: flyway_schema_history
```

Therefore:

### Correct

``` sql
USE customer_order_management;
```

Then:

``` sql
SELECT * FROM customers;
```

### Incorrect

``` sql
USE customers;
```

because `customers` is a table, not the database.

------------------------------------------------------------------------

# 45. Flyway Migration Commands

## Check migration status

``` cmd
"D:\flyway\flyway-13.7.0\flyway.cmd" -configFiles="D:\mysql-db-lab\flyway.toml" -environment=local info
```

Use this to see:

-   Current schema version
-   Applied migrations
-   Pending migrations
-   Failed migrations
-   Repeatable migration information

------------------------------------------------------------------------

## Apply migrations

``` cmd
"D:\flyway\flyway-13.7.0\flyway.cmd" -configFiles="D:\mysql-db-lab\flyway.toml" -environment=local migrate
```

Use this to execute pending Flyway migrations.

------------------------------------------------------------------------

## Repair migration history

``` cmd
"D:\flyway\flyway-13.7.0\flyway.cmd" -configFiles="D:\mysql-db-lab\flyway.toml" -environment=local repair
```

Use this when Flyway reports a failed migration or a migration-history
problem that requires repair.

Always understand and correct the underlying SQL/database problem before
using `repair`.

------------------------------------------------------------------------

# 46. Adding a New Versioned Migration

The current versioned migrations end at:

``` text
V9
```

Therefore the next versioned migration should normally be:

``` text
V10__<description>.sql
```

Example:

``` text
V10__add_customer_status.sql
```

Place it in:

``` text
D:\mysql-db-lab\sql
```

Example:

``` sql
USE customer_order_management;

ALTER TABLE customers
ADD COLUMN status VARCHAR(20);
```

Check the migration:

``` cmd
"D:\flyway\flyway-13.7.0\flyway.cmd" -configFiles="D:\mysql-db-lab\flyway.toml" -environment=local info
```

The new migration should appear as:

``` text
Pending
```

Then run:

``` cmd
"D:\flyway\flyway-13.7.0\flyway.cmd" -configFiles="D:\mysql-db-lab\flyway.toml" -environment=local migrate
```

------------------------------------------------------------------------

# 47. Adding a Repeatable Migration

Repeatable migrations use:

``` text
R__<description>.sql
```

Example:

``` text
R__customer_reporting_view.sql
```

The current project already contains repeatable migration files for
database objects.

Use a repeatable migration when the database object is intended to be
managed as a repeatable Flyway object rather than as a numbered schema
change.

The exact SQL object should be defined inside the file.

------------------------------------------------------------------------

# 48. Migration Naming Convention

## Versioned

``` text
V<version>__<description>.sql
```

Examples:

``` text
V1__customers_table.sql
V5__create_orders_table.sql
V9__create_composite_order_index.sql
```

There are **two underscores** between the version and description:

``` text
V9__create
   ^^
```

## Repeatable

``` text
R__<description>.sql
```

Examples:

``` text
R__customer_reporting_view.sql
R__customer_summary_procedure.sql
```

------------------------------------------------------------------------

# 49. Important Flyway Rules

## Rule 1 --- Do not manually change migration status

Do not manually edit:

``` text
Pending
Success
Failed
```

Flyway manages migration status through:

``` text
flyway_schema_history
```

------------------------------------------------------------------------

## Rule 2 --- Do not delete flyway_schema_history unnecessarily

If a migration fails:

1.  Read the error.
2.  Identify the database/SQL problem.
3.  Correct the problem.
4.  Use `repair` if Flyway requires it.
5.  Run `migrate`.
6.  Verify with `info`.

------------------------------------------------------------------------

## Rule 3 --- Be careful changing applied migrations

Once a versioned migration has successfully executed, changing its
contents can cause checksum validation problems.

Normally, create a new migration:

``` text
V10__...
```

instead of modifying an already-applied:

``` text
V9__...
```

------------------------------------------------------------------------

## Rule 4 --- Protect passwords

Never commit a real MySQL password to GitHub.

Use:

-   Environment variables
-   Secure secrets
-   Credential-management solutions

for real deployments.

------------------------------------------------------------------------

## Rule 5 --- Keep query files separate

Do not place general reporting/practice queries into the Flyway
migration folder unless they are intentionally part of a database
migration.

Use:

``` text
queries/
```

for general query work.

Use:

``` text
sql/
```

for Flyway-managed migrations and repeatable database objects.

------------------------------------------------------------------------

# 50. Common Errors Encountered

  -------------------------------------------------------------------------------------
  Error / Situation             Meaning                 Fix
  ----------------------------- ----------------------- -------------------------------
  Configuration file not found  Wrong `flyway.toml`     Use
                                path                    `D:\mysql-db-lab\flyway.toml`

  Connection refused on 3305    Wrong MySQL port        Use `3306`

  `using password: NO`          Flyway has no password  Configure the local password

  Unknown database              Database does not exist Create the database
  `customer_order_management`   on selected MySQL       
                                instance                

  Unknown database `customers`  A table name was used   Use `customer_order_management`
                                as a database name      

  Failed migration validation   A migration previously  Correct SQL, then `repair`,
                                failed                  then `migrate`

  Checksum mismatch             An applied migration    Understand the change and use a
                                was changed             new migration where appropriate

  Table already exists          Database object already Inspect the database before
                                exists                  rerunning the migration

  Duplicate entry / Error 1062  Data being inserted     Check existing rows and
                                conflicts with existing migration state before
                                data                    rerunning

  Schema up to date             No pending versioned    No new migration is required
                                change exists           
  -------------------------------------------------------------------------------------

------------------------------------------------------------------------

# 51. Troubleshooting Workflow

When a Flyway migration fails, do not immediately delete tables or
migration history.

Use this workflow:

``` text
1. Read the Flyway error
        ↓
2. Identify the SQL statement that failed
        ↓
3. Check the MySQL database state
        ↓
4. Check flyway_schema_history
        ↓
5. Correct the underlying SQL/database problem
        ↓
6. Run repair if Flyway requires it
        ↓
7. Run migrate
        ↓
8. Run info
        ↓
9. Verify the result in MySQL Workbench
```

------------------------------------------------------------------------

# 52. Complete Working Workflow

## Step 1 --- Start MySQL

Normally the Windows service should already be running.

If needed:

``` cmd
net start MySQL80
```

------------------------------------------------------------------------

## Step 2 --- Test MySQL

``` cmd
mysql -u root -p
```

Then:

``` sql
SHOW VARIABLES LIKE 'port';
```

Expected:

``` text
3306
```

Exit:

``` sql
exit;
```

------------------------------------------------------------------------

## Step 3 --- Check Flyway

``` cmd
"D:\flyway\flyway-13.7.0\flyway.cmd" -configFiles="D:\mysql-db-lab\flyway.toml" -environment=local info
```

------------------------------------------------------------------------

## Step 4 --- Apply pending migrations

``` cmd
"D:\flyway\flyway-13.7.0\flyway.cmd" -configFiles="D:\mysql-db-lab\flyway.toml" -environment=local migrate
```

------------------------------------------------------------------------

## Step 5 --- Check again

``` cmd
"D:\flyway\flyway-13.7.0\flyway.cmd" -configFiles="D:\mysql-db-lab\flyway.toml" -environment=local info
```

If Flyway reports:

``` text
Schema is up to date.
No migration necessary.
```

then there are no pending versioned migrations.

------------------------------------------------------------------------

## Step 6 --- Verify in Workbench

``` sql
USE customer_order_management;

SHOW TABLES;

SELECT * FROM customers;

SELECT * FROM orders;

SELECT * FROM flyway_schema_history;
```

------------------------------------------------------------------------

# 53. Final Project Flow

The project can now be understood as four connected layers:

``` text
                    MySQL Database Lab
                           │
          ┌────────────────┼────────────────┐
          │                │                │
          ▼                ▼                ▼
      Flyway           Database          Queries
    Configuration      Objects          & Reports
          │                │                │
          ▼                ▼                ▼
    flyway.toml       customers       queries/
                     orders            *.sql
                     indexes
                     procedures
                     views
          │
          ▼
    sql/
    ├── V1
    ├── V2
    ├── V3
    ├── V4
    ├── V5
    ├── V6
    ├── V7
    ├── V8
    ├── V9
    └── R__...
```

------------------------------------------------------------------------

# 54. Final Migration Flow

The versioned migration sequence is:

``` text
V1
 ↓
V2
 ↓
V3
 ↓
V4
 ↓
V5
 ↓
V6
 ↓
V7
 ↓
V8
 ↓
V9
```

The repeatable migrations are maintained separately:

``` text
R__create_customer_order
R__customer_order_history_procedure
R__customer_reporting_view
R__customer_summary_procedure
```

------------------------------------------------------------------------

# 55. Final Project Structure --- Quick Reference

``` text
mysql-db-lab/
│
├── .git/
│
├── flyway.toml
│
├── queries/
│   ├── Advanced_Sql.sql
│   ├── Aggregation_and_Business_Reporting.sql
│   ├── customer_order_queries.sql
│   ├── customer_service_queries.sql
│   ├── Customer_Summary.sql
│   ├── indexes_explain.sql
│   ├── Procedure_Queries.sql
│   ├── Sorting_Queries.sql
│   └── Transactions_Queries.sql
│
└── sql/
    ├── R__create_customer_order.sql
    ├── R__customer_order_history_procedure.sql
    ├── R__customer_reporting_view.sql
    ├── R__customer_summary_procedure.sql
    ├── V1__customers_table.sql
    ├── V2__customer_details_updation.sql
    ├── V3__customer_details_inserted.sql
    ├── V4__customer_upsert.sql
    ├── V5__create_orders_table.sql
    ├── V6__insert_orders_data.sql
    ├── V7__created_cust_order_indexes.sql
    ├── V8__customer_account_closure.sql
    └── V9__create_composite_order_index.sql
```

------------------------------------------------------------------------

# 56. Final Configuration Summary

``` text
Operating System:
Windows 11

MySQL:
8.0.43

MySQL Service:
MySQL80

Host:
127.0.0.1

Port:
3306

User:
root

Database:
customer_order_management

Flyway:
13.7.0

Flyway Installation:
D:\flyway\flyway-13.7.0

Project:
D:\mysql-db-lab

Flyway Configuration:
D:\mysql-db-lab\flyway.toml

Flyway Migration Directory:
D:\mysql-db-lab\sql

Query Directory:
D:\mysql-db-lab\queries
```

------------------------------------------------------------------------

# 57. Final Command Set

## MySQL login

``` cmd
mysql -u root -p
```

## MySQL port

``` sql
SHOW VARIABLES LIKE 'port';
```

## Start MySQL service

``` cmd
net start MySQL80
```

## Flyway status

``` cmd
"D:\flyway\flyway-13.7.0\flyway.cmd" -configFiles="D:\mysql-db-lab\flyway.toml" -environment=local info
```

## Flyway migrate

``` cmd
"D:\flyway\flyway-13.7.0\flyway.cmd" -configFiles="D:\mysql-db-lab\flyway.toml" -environment=local migrate
```

## Flyway repair

``` cmd
"D:\flyway\flyway-13.7.0\flyway.cmd" -configFiles="D:\mysql-db-lab\flyway.toml" -environment=local repair
```

------------------------------------------------------------------------

# 58. Recommended Daily Workflow

For normal project work:

``` text
Start MySQL
    ↓
Open MySQL Workbench
    ↓
Confirm customer_order_management
    ↓
Check Flyway info
    ↓
Review pending migrations
    ↓
Run migrate when required
    ↓
Check Flyway info again
    ↓
Verify database objects/data
    ↓
Use queries/ for reporting and analysis
```

------------------------------------------------------------------------

# 59. What Belongs Where?

  ------------------------------------------------------------------------------------------
  Item                                       Location                Purpose
  ------------------------------------------ ----------------------- -----------------------
  `flyway.toml`                              Project root            Flyway configuration

  `V1`--`V9`                                 `sql/`                  Versioned database
                                                                     migrations

  `R__...`                                   `sql/`                  Repeatable Flyway
                                                                     migrations

  `Advanced_Sql.sql`                         `queries/`              Advanced SQL queries

  `Aggregation_and_Business_Reporting.sql`   `queries/`              Aggregation/reporting

  `customer_order_queries.sql`               `queries/`              Customer/order queries

  `customer_service_queries.sql`             `queries/`              Customer-service
                                                                     queries

  `Customer_Summary.sql`                     `queries/`              Customer summary
                                                                     queries

  `indexes_explain.sql`                      `queries/`              Index/explain work

  `Procedure_Queries.sql`                    `queries/`              Procedure-related
                                                                     queries

  `Sorting_Queries.sql`                      `queries/`              Sorting queries

  `Transactions_Queries.sql`                 `queries/`              Transaction queries
  ------------------------------------------------------------------------------------------

------------------------------------------------------------------------

# 60. Main Lessons From the Project

### Lesson 1 --- Verify the actual MySQL port

Do not assume that the configured port is correct.

Verify with:

``` sql
SHOW VARIABLES LIKE 'port';
```

and:

``` cmd
netstat -ano | findstr :3306
```

------------------------------------------------------------------------

### Lesson 2 --- Database and table are different

``` text
customer_order_management
        ↓
      Database

customers
        ↓
       Table
```

Therefore:

``` sql
USE customer_order_management;
```

not:

``` sql
USE customers;
```

------------------------------------------------------------------------

### Lesson 3 --- Understand Flyway history

Flyway tracks migrations through:

``` text
flyway_schema_history
```

When a migration fails, inspect the history before attempting random
fixes.

------------------------------------------------------------------------

### Lesson 4 --- `repair` does not run SQL

Remember:

``` text
repair ≠ migrate
```

`repair` fixes migration history.

`migrate` executes migrations.

------------------------------------------------------------------------

### Lesson 5 --- Do not casually modify applied migrations

An applied migration is part of the migration history.

Changing it later can cause checksum validation problems.

Prefer a new version:

``` text
V10__new_change.sql
```

rather than changing an already-applied migration.

------------------------------------------------------------------------

### Lesson 6 --- Keep migrations and queries organized

The final repository intentionally separates:

``` text
sql/
```

from:

``` text
queries/
```

This makes it easier to understand which SQL is controlled by Flyway and
which SQL is general query/reporting work.

------------------------------------------------------------------------

# 61. Final State

The final repository contains:

``` text
Flyway configuration
        ↓
flyway.toml
        ↓
sql/
        ↓
V1 → V2 → V3 → V4 → V5 → V6 → V7 → V8 → V9
        +
R__ repeatable migrations
        ↓
MySQL database
        ↓
customer_order_management
        ↓
customers + orders + Flyway history
        ↓
queries/
        ↓
Reporting / aggregation / procedures / sorting /
transactions / advanced SQL / index analysis
```

The project therefore represents a complete learning workflow from:

``` text
MySQL setup
     ↓
Workbench connection
     ↓
Flyway setup
     ↓
Migration troubleshooting
     ↓
Customer database
     ↓
Order database
     ↓
Indexes and later schema changes
     ↓
Repeatable database objects
     ↓
Reporting and SQL queries
```

------------------------------------------------------------------------

# 62. Final Troubleshooting Checklist

When setting up this project again on another Windows machine:

``` text
1. Install MySQL
        ↓
2. Confirm MySQL service
        ↓
3. Confirm MySQL port
        ↓
4. Connect through MySQL Workbench
        ↓
5. Create customer_order_management
        ↓
6. Install Flyway
        ↓
7. Verify flyway.toml location
        ↓
8. Verify sql/ migration directory
        ↓
9. Configure the local MySQL password securely
        ↓
10. Run Flyway info
        ↓
11. Run Flyway migrate
        ↓
12. If a migration fails, read the exact error
        ↓
13. Correct the underlying SQL/database problem
        ↓
14. Run repair only when required
        ↓
15. Run migrate again
        ↓
16. Run info
        ↓
17. Verify objects/data in Workbench
        ↓
18. Use queries/ for reporting and analysis
```

------------------------------------------------------------------------

# 63. Final Reminder for GitHub

Before pushing the project to GitHub, verify that:

-   No real MySQL password is committed.
-   `flyway.toml` does not expose a real password.
-   Migration filenames follow Flyway naming conventions.
-   Versioned migrations are not unnecessarily modified after being
    applied.
-   `sql/` contains Flyway-managed migrations.
-   `queries/` contains general query/reporting work.
-   The README reflects the actual repository structure.
-   The database connection values are clearly identified as
    local-development values.

------------------------------------------------------------------------

## Conclusion

This repository documents the complete MySQL + Flyway database lab
workflow, including the original setup problems, their fixes, the
evolution from V1 through V9, repeatable database migrations, and the
separate SQL query collection.

The key reusable workflow is:

``` text
MySQL
  ↓
Workbench
  ↓
Database
  ↓
Flyway Configuration
  ↓
Versioned Migrations
  ↓
Repeatable Migrations
  ↓
Database Verification
  ↓
Queries & Reporting
```

The most important troubleshooting sequence is:

``` text
Check MySQL
    ↓
Check port
    ↓
Check Workbench connection
    ↓
Check database
    ↓
Check flyway.toml
    ↓
Check Flyway authentication
    ↓
Run info
    ↓
Run migrate
    ↓
If failed → understand error
    ↓
Fix SQL/database state
    ↓
repair if required
    ↓
migrate
    ↓
info
    ↓
verify in Workbench
```

This structure can be reused as a reference for future MySQL + Flyway
projects.


---

# Stage 64 — Push the Completed Project to Your Personal GitHub Repository

This is the final stage of the project.

After completing the MySQL database, Flyway migrations, repeatable migrations, indexes, procedures, views, reports, and SQL query collection, the complete project can be committed and pushed to your **personal GitHub repository**.

The local project directory is:

```text
D:\mysql-db-lab
```

---

## 64.1 Check the Final Project Structure

Open PowerShell:

```powershell
cd D:\mysql-db-lab
```

Check the project files:

```powershell
dir
```

The final project should contain:

```text
D:\mysql-db-lab
│
├── .git
├── flyway.toml
├── queries
└── sql
```

The `queries` directory contains the SQL query collection.

The `sql` directory contains the Flyway versioned and repeatable migrations.

---

## 64.2 Check Git Status

Run:

```powershell
git status
```

This shows:

- Modified files
- New files
- Deleted files
- Untracked files
- Current branch information

Before committing, review the output carefully.

---

## 64.3 Check the Current Branch

Run:

```powershell
git branch
```

If the final personal GitHub repository should use `main`, rename the current branch:

```powershell
git branch -M main
```

Then verify:

```powershell
git branch
```

Expected:

```text
* main
```

---

## 64.4 Check the Existing GitHub Remote

Before adding or changing a remote, check the existing configuration:

```powershell
git remote -v
```

You may see something similar to:

```text
origin  https://github.com/YOUR_USERNAME/mysql-db-lab.git (fetch)
origin  https://github.com/YOUR_USERNAME/mysql-db-lab.git (push)
```

### If the remote is already your personal repository

Do not add another remote.

Continue to the next step.

### If the remote is incorrect

Change it with:

```powershell
git remote set-url origin YOUR_PERSONAL_REPOSITORY_URL
```

Example:

```powershell
git remote set-url origin https://github.com/YOUR_USERNAME/mysql-db-lab.git
```

Then verify:

```powershell
git remote -v
```

---

## 64.5 Create the Personal GitHub Repository

If the personal GitHub repository does not exist yet:

1. Open GitHub.
2. Create a new repository.
3. Give it an appropriate name, for example:

```text
mysql-db-lab
```

4. Choose the required visibility.
5. If the local project already contains its own README and Git history, avoid unnecessarily creating another README in the new repository.
6. Create the repository.

Then connect the local project to the personal repository:

```powershell
git remote add origin YOUR_PERSONAL_REPOSITORY_URL
```

Example:

```powershell
git remote add origin https://github.com/YOUR_USERNAME/mysql-db-lab.git
```

Verify:

```powershell
git remote -v
```

---

## 64.6 Check for Sensitive Information Before Commit

This is an important step.

The project contains a Flyway configuration file:

```text
flyway.toml
```

Make sure it does **not** contain your real MySQL password before pushing to GitHub.

The configuration should use a placeholder such as:

```toml
password = "YOUR_MYSQL_PASSWORD"
```

Do not commit:

```text
real MySQL passwords
private credentials
temporary password files
personal authentication tokens
```

Review the repository before running:

```powershell
git add .
```

---

## 64.7 Review Changes

Run:

```powershell
git status
```

For tracked-file changes, inspect the differences:

```powershell
git diff
```

For a short status view:

```powershell
git status --short
```

This gives you an opportunity to catch accidental files before committing.

---

## 64.8 Stage the Completed Project

Add the project files:

```powershell
git add .
```

Then check what is staged:

```powershell
git status
```

Make sure the staged files represent the project you actually want to publish.

The staged project should include the important files under:

```text
queries/
sql/
flyway.toml
README.md
```

and other intended repository files.

---

## 64.9 Commit the Completed Project

Create the final commit:

```powershell
git commit -m "Complete MySQL database lab with Flyway migrations and SQL queries"
```

The commit message describes the completed database lab and its Flyway/query work.

Check the commit:

```powershell
git log --oneline --max-count=5
```

---

## 64.10 Push the Completed Project

If the personal GitHub repository uses the `main` branch:

```powershell
git push -u origin main
```

The `-u` option establishes the upstream relationship between the local `main` branch and:

```text
origin/main
```

After this, future pushes can normally use:

```powershell
git push
```

---

## 64.11 Verify the Push

After the push completes, run:

```powershell
git status
```

A clean working tree should report:

```text
nothing to commit, working tree clean
```

You can also check:

```powershell
git log --oneline --max-count=5
```

Then open the personal GitHub repository and verify that the files are visible.

---

## 64.12 Verify the Final GitHub Repository Structure

The personal repository should contain the final project structure:

```text
mysql-db-lab/
│
├── .git/
│
├── flyway.toml
│
├── README.md
│
├── queries/
│   ├── Advanced_Sql.sql
│   ├── Aggregation_and_Business_Reporting.sql
│   ├── customer_order_queries.sql
│   ├── customer_service_queries.sql
│   ├── Customer_Summary.sql
│   ├── indexes_explain.sql
│   ├── Procedure_Queries.sql
│   ├── Sorting_Queries.sql
│   └── Transactions_Queries.sql
│
└── sql/
    ├── R__create_customer_order.sql
    ├── R__customer_order_history_procedure.sql
    ├── R__customer_reporting_view.sql
    ├── R__customer_summary_procedure.sql
    ├── V1__customers_table.sql
    ├── V2__customer_details_updation.sql
    ├── V3__customer_details_inserted.sql
    ├── V4__customer_upsert.sql
    ├── V5__create_orders_table.sql
    ├── V6__insert_orders_data.sql
    ├── V7__created_cust_order_indexes.sql
    ├── V8__customer_account_closure.sql
    └── V9__create_composite_order_index.sql
```

> The `.git` directory exists locally but is normally not displayed as a normal tracked project file on GitHub. GitHub stores the repository's Git history separately.

---

## 64.13 If the GitHub Repository Already Contains Files

If the personal GitHub repository was created with an initial README, `.gitignore`, license, or another commit, the remote repository may already have a Git history that is different from the local repository.

First check:

```powershell
git remote -v
```

Then fetch the remote history:

```powershell
git fetch origin
```

Inspect the branches:

```powershell
git branch -a
```

Do not immediately use:

```powershell
git push --force
```

Force-pushing can overwrite remote history.

If the local and remote repositories have unrelated histories, review the situation before choosing whether to merge the histories or recreate the empty GitHub repository.

The safest approach for a new personal repository is generally to create the GitHub repository without an unnecessary initial commit when the project already has its own local Git history.

---

## 64.14 Complete Git Command Sequence

For a project whose personal GitHub repository is already configured correctly:

```powershell
cd D:\mysql-db-lab

git status

git branch

git branch -M main

git remote -v

git status

git add .

git status

git commit -m "Complete MySQL database lab with Flyway migrations and SQL queries"

git log --oneline --max-count=5

git push -u origin main

git status
```

---

## 64.15 Final Git Workflow

The complete project-to-GitHub workflow is:

```text
Complete MySQL + Flyway Project
             ↓
       Check final files
             ↓
        git status
             ↓
       Check branch
             ↓
       Check remote
             ↓
    Check sensitive information
             ↓
        git add .
             ↓
       Review staged files
             ↓
        git commit
             ↓
       git push -u origin main
             ↓
      Verify GitHub repository
             ↓
       git status
             ↓
       Working tree clean
```

---

## 64.16 Final Project Completion Checklist

Before considering the project complete, verify:

```text
[ ] MySQL is working
[ ] MySQL Workbench connects successfully
[ ] customer_order_management exists
[ ] Flyway configuration is correct
[ ] V1–V9 migrations are present
[ ] Repeatable R__ migrations are present
[ ] queries/ contains the SQL query collection
[ ] README.md describes the actual project structure
[ ] No real password is stored in the repository
[ ] git status has been reviewed
[ ] Correct personal GitHub remote is configured
[ ] Final changes are committed
[ ] Project is pushed to main
[ ] GitHub repository was checked
[ ] Local working tree is clean
```

---

## 64.17 Final GitHub Result

After completing Stage 64, the project should exist in both locations:

```text
LOCAL
D:\mysql-db-lab
        │
        │ git push
        ▼
PERSONAL GITHUB REPOSITORY
        │
        ├── README.md
        ├── flyway.toml
        ├── queries/
        └── sql/
```

The final repository therefore contains the complete learning project, its migration history, repeatable database objects, SQL query collection, troubleshooting documentation, and instructions for reproducing the workflow.

---

# Final Project Completion

The complete project workflow is now:

```text
Stage 1–...
    ↓
MySQL Setup
    ↓
MySQL Workbench
    ↓
Flyway Setup
    ↓
V1 → V9
    ↓
Repeatable Migrations
    ↓
Indexes
    ↓
Customer Account Changes
    ↓
Procedures / Views
    ↓
SQL Queries & Reporting
    ↓
Troubleshooting
    ↓
README Documentation
    ↓
Stage 64
    ↓
Git
    ↓
Commit
    ↓
Push
    ↓
Personal GitHub Repository
```

**Stage 64 completes the project publishing workflow.**
