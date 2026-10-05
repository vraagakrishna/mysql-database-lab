# Common Errors

| Error / Situation | Meaning | Fix |
|---|---|---|
| Flyway configuration not found | Incorrect `flyway.toml` location | Use the project-root `flyway.toml` path. |
| Connection refused | MySQL is not reachable or the port is wrong | Verify the MySQL service and configured port. |
| Access denied | Flyway credentials are invalid or missing | Check the local MySQL username/password without committing the real password. |
| Unknown database | `customer_order_management` does not exist | Create the database before running Flyway. |
| Failed migration | A migration SQL statement failed | Read and fix the underlying SQL/database problem first. Use `repair` only when Flyway requires it. |
| Checksum mismatch | An already-applied versioned migration was changed | Restore the applied migration or create a new versioned migration. |
| Duplicate entry | Inserted data conflicts with existing rows | Check the database state before rerunning an INSERT migration. |

## Recovery Workflow

1. Read the Flyway error.
2. Identify the SQL statement that failed.
3. Check the database state.
4. Check `flyway_schema_history`.
5. Correct the underlying SQL/data problem.
6. Run `repair` only when required.
7. Run `migrate`.
8. Run `info` again.
9. Verify the result in MySQL.
