# Lesson 8.2: Views and Triggers

Views and triggers are powerful database features for simplifying queries and automating actions.

## Views

A **view** is a virtual table based on the result of a SQL query. Views don't store data - they're saved queries that you can query like a table.

### Why Use Views?

- **Simplify complex queries**: Hide complexity from users
- **Security**: Restrict access to specific columns/rows
- **Consistency**: Standardize how data is accessed
- **Abstraction**: Change underlying structure without affecting users

### Creating Views

```sql
CREATE VIEW view_name AS
SELECT columns
FROM tables
WHERE conditions;
```

### Simple View Example

```sql
-- View of employees with department names
CREATE VIEW employee_summary AS
SELECT 
    e.first_name,
    e.last_name,
    e.salary,
    d.department_name
FROM employees e
JOIN departments d ON e.department_id = d.department_id;

-- Use the view like a table
SELECT * FROM employee_summary
WHERE salary > 70000;
```

### View with Aggregates

```sql
-- Department statistics view
CREATE VIEW department_stats AS
SELECT 
    d.department_name,
    COUNT(e.employee_id) AS employee_count,
    AVG(e.salary) AS avg_salary,
    SUM(e.salary) AS total_payroll
FROM departments d
LEFT JOIN employees e ON d.department_id = e.department_id
GROUP BY d.department_name;

-- Query the view
SELECT * FROM department_stats
ORDER BY avg_salary DESC;
```

### Updating Views

```sql
-- Modify existing view
CREATE OR REPLACE VIEW employee_summary AS
SELECT 
    e.first_name,
    e.last_name,
    e.salary,
    d.department_name,
    e.hire_date  -- Added column
FROM employees e
JOIN departments d ON e.department_id = d.department_id;

-- Drop view
DROP VIEW employee_summary;
```

### Views vs Tables

| Aspect | View | Table |
|--------|------|-------|
| **Stores data** | No | Yes |
| **Performance** | Depends on underlying query | Direct access |
| **Updates** | Limited (depends on view definition) | Full CRUD |
| **Storage** | No storage (just query) | Stores data |

### Updatable Views

Some views can be updated (INSERT, UPDATE, DELETE), but with restrictions:

```sql
-- Simple updatable view
CREATE VIEW high_salary_employees AS
SELECT employee_id, first_name, last_name, salary
FROM employees
WHERE salary > 70000;

-- May be updatable (depends on database and view complexity)
UPDATE high_salary_employees
SET salary = 75000
WHERE employee_id = 1;
```

**Restrictions**: Views with JOINs, aggregates, DISTINCT, etc. are usually not updatable.

## Materialized Views

Some databases support **materialized views** that store the query results:

```sql
-- PostgreSQL example
CREATE MATERIALIZED VIEW department_stats_mv AS
SELECT 
    d.department_name,
    COUNT(e.employee_id) AS employee_count,
    AVG(e.salary) AS avg_salary
FROM departments d
LEFT JOIN employees e ON d.department_id = e.department_id
GROUP BY d.department_name;

-- Refresh when needed
REFRESH MATERIALIZED VIEW department_stats_mv;
```

**Benefits**: Faster queries (pre-computed)
**Trade-off**: Data may be stale until refreshed

## Triggers

A **trigger** is a stored procedure that automatically executes when a specific event occurs (INSERT, UPDATE, DELETE).

### Trigger Syntax

```sql
CREATE TRIGGER trigger_name
BEFORE/AFTER INSERT/UPDATE/DELETE
ON table_name
FOR EACH ROW
BEGIN
    -- SQL statements
END;
```

**Note**: Syntax varies significantly by database.

### Trigger Example: Audit Log

```sql
-- Create audit table
CREATE TABLE employee_audit (
    audit_id INTEGER PRIMARY KEY,
    employee_id INTEGER,
    action VARCHAR(10),
    changed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Trigger to log employee updates
CREATE TRIGGER log_employee_changes
AFTER UPDATE ON employees
FOR EACH ROW
BEGIN
    INSERT INTO employee_audit (employee_id, action)
    VALUES (NEW.employee_id, 'UPDATE');
END;
```

### BEFORE vs AFTER Triggers

- **BEFORE**: Executes before the event (can modify data before it's saved)
- **AFTER**: Executes after the event (for logging, notifications)

### Trigger Events

- **INSERT**: Fires when rows are inserted
- **UPDATE**: Fires when rows are updated
- **DELETE**: Fires when rows are deleted

### Accessing Row Data

In triggers, you can access:
- **NEW**: New row values (INSERT, UPDATE)
- **OLD**: Old row values (UPDATE, DELETE)

```sql
CREATE TRIGGER update_salary_history
AFTER UPDATE ON employees
FOR EACH ROW
BEGIN
    IF OLD.salary != NEW.salary THEN
        INSERT INTO salary_history (employee_id, old_salary, new_salary, changed_at)
        VALUES (NEW.employee_id, OLD.salary, NEW.salary, CURRENT_TIMESTAMP);
    END IF;
END;
```

## When to Use Views

### Use Views For:
- Simplifying complex queries
- Restricting data access (security)
- Providing consistent data interfaces
- Abstracting schema changes

### Consider Alternatives For:
- Frequently changing queries (use application code)
- Performance-critical queries (may need materialized views or direct queries)

## When to Use Triggers

### Use Triggers For:
- Audit logging
- Enforcing business rules
- Maintaining derived data
- Data validation

### Consider Alternatives For:
- Complex business logic (use application code)
- Cross-database operations (use application code)
- Frequently changing logic (use application code)

## Best Practices

### Views
1. **Name clearly**: Use descriptive names
2. **Document**: Explain what the view represents
3. **Test performance**: Views can be slow if underlying queries are complex
4. **Keep simple**: Complex views can be hard to maintain

### Triggers
1. **Use sparingly**: Can make debugging difficult
2. **Keep logic simple**: Complex triggers are hard to maintain
3. **Document thoroughly**: Explain what triggers do
4. **Test carefully**: Triggers fire automatically - test all scenarios
5. **Avoid cascading**: Triggers that trigger other triggers can be problematic

## PostgreSQL Features

PostgreSQL provides comprehensive support for views and triggers:

- **Views**: Full support for standard and updatable views
- **Materialized Views**: Supported for caching expensive query results
- **Triggers**: Full support with BEFORE/AFTER triggers on INSERT/UPDATE/DELETE
- **Trigger Functions**: Written in PL/pgSQL or other supported languages
- **Row-level and Statement-level Triggers**: Both supported
- **INSTEAD OF Triggers**: Supported for views
- **Triggers**: Full support

## Common Patterns

### Pattern 1: Security View

```sql
-- View that hides sensitive data
CREATE VIEW public_employee_info AS
SELECT 
    employee_id,
    first_name,
    last_name,
    job_title
    -- salary is excluded
FROM employees;
```

### Pattern 2: Audit Trigger

```sql
-- Log all changes to important table
CREATE TRIGGER audit_employees
AFTER UPDATE ON employees
FOR EACH ROW
BEGIN
    INSERT INTO audit_log (table_name, record_id, action, changed_at)
    VALUES ('employees', NEW.employee_id, 'UPDATE', CURRENT_TIMESTAMP);
END;
```

## Next Steps

In the next lesson, you'll learn about Transactions and Concurrency.

---

**Key Takeaways:**
- Views are saved queries that act like virtual tables
- Views simplify complex queries and provide security
- Materialized views store results for performance
- Triggers automatically execute on database events
- Use triggers for audit logging and business rules
- Triggers can access NEW and OLD row values
- Use views and triggers judiciously - they can complicate maintenance
- Syntax varies by database - check your database documentation
