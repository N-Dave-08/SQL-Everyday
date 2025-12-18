# Lesson 2.1: INSERT, UPDATE, DELETE

So far, you've learned how to **read** data from databases using `SELECT`. Now you'll learn how to **modify** data using `INSERT`, `UPDATE`, and `DELETE` statements.

## INSERT - Adding New Data

The `INSERT` statement adds new rows to a table.

### Basic INSERT Syntax

```sql
INSERT INTO table_name (column1, column2, column3, ...)
VALUES (value1, value2, value3, ...);
```

### Example: Inserting a Single Row

```sql
INSERT INTO employees (first_name, last_name, email, job_title, salary, department_id)
VALUES ('Alice', 'Cooper', 'alice.cooper@company.com', 'Software Engineer', 72000, 1);
```

### Inserting Multiple Rows

You can insert multiple rows in a single statement:

```sql
INSERT INTO employees (first_name, last_name, email, job_title, salary, department_id)
VALUES 
    ('Bob', 'Wilson', 'bob.wilson@company.com', 'Data Analyst', 68000, 2),
    ('Carol', 'Brown', 'carol.brown@company.com', 'Marketing Specialist', 65000, 3);
```

### Inserting Without Column Names

If you provide values for **all columns in the correct order**, you can omit column names:

```sql
-- Only if you know the exact column order and want to provide all values
INSERT INTO employees
VALUES (16, 'David', 'Lee', 'david.lee@company.com', '555-0116', '2023-01-01', 'Developer', 60000, 1);
```

**Warning**: This approach is **not recommended** because:
- It's fragile (breaks if column order changes)
- It's unclear which values go to which columns
- You must provide values for all columns (including those that might have defaults)

### Inserting with Default Values

If a column has a default value or allows NULL, you can omit it:

```sql
-- If phone allows NULL, we can omit it
INSERT INTO employees (first_name, last_name, email, job_title, salary, department_id)
VALUES ('Eva', 'Martinez', 'eva.martinez@company.com', 'HR Specialist', 60000, 4);
```

### INSERT INTO ... SELECT

You can insert data from another table using a SELECT query:

```sql
-- Create a backup table
CREATE TABLE employees_backup AS SELECT * FROM employees WHERE 1=0;

-- Copy employees from department 1 to backup
INSERT INTO employees_backup
SELECT * FROM employees
WHERE department_id = 1;
```

## UPDATE - Modifying Existing Data

The `UPDATE` statement modifies existing rows in a table.

### Basic UPDATE Syntax

```sql
UPDATE table_name
SET column1 = value1, column2 = value2, ...
WHERE condition;
```

**⚠️ CRITICAL**: Always use `WHERE` with `UPDATE` unless you want to update **all rows**!

### Example: Updating a Single Row

```sql
-- Give employee ID 5 a raise
UPDATE employees
SET salary = 60000
WHERE employee_id = 5;
```

### Example: Updating Multiple Columns

```sql
-- Update both salary and job title
UPDATE employees
SET salary = 75000, job_title = 'Senior Engineer'
WHERE employee_id = 3;
```

### Example: Updating Multiple Rows

```sql
-- Give all Software Engineers a 5% raise
UPDATE employees
SET salary = salary * 1.05
WHERE job_title = 'Software Engineer';
```

### Using Expressions in UPDATE

You can use expressions and calculations:

```sql
-- Increase all salaries by 1000
UPDATE employees
SET salary = salary + 1000;

-- Apply a percentage increase
UPDATE employees
SET salary = salary * 1.10  -- 10% increase
WHERE department_id = 1;
```

### Updating with NULL

To set a column to NULL:

```sql
-- Remove department assignment
UPDATE employees
SET department_id = NULL
WHERE employee_id = 10;
```

## DELETE - Removing Data

The `DELETE` statement removes rows from a table.

### Basic DELETE Syntax

```sql
DELETE FROM table_name
WHERE condition;
```

**⚠️ CRITICAL**: Always use `WHERE` with `DELETE` unless you want to delete **all rows**!

### Example: Deleting a Single Row

```sql
-- Delete employee with ID 15
DELETE FROM employees
WHERE employee_id = 15;
```

### Example: Deleting Multiple Rows

```sql
-- Delete all employees in a specific department
DELETE FROM employees
WHERE department_id = 5;
```

### Deleting All Rows

```sql
-- ⚠️ DANGER: This deletes ALL rows!
DELETE FROM employees;

-- Alternative (faster, but resets auto-increment in some databases):
-- TRUNCATE TABLE employees;
```

## Transactions and Data Integrity

### What is a Transaction?

A **transaction** is a sequence of database operations that are treated as a single unit. Either all operations succeed, or all are rolled back.

### Transaction Control

```sql
-- Start a transaction (syntax varies by database)
BEGIN TRANSACTION;  -- or START TRANSACTION;

-- Perform operations
INSERT INTO employees (first_name, last_name, email, job_title, salary)
VALUES ('Test', 'User', 'test@company.com', 'Tester', 50000);

UPDATE employees
SET salary = salary + 1000
WHERE employee_id = 1;

-- Commit the transaction (save changes)
COMMIT;

-- OR rollback (undo all changes)
ROLLBACK;
```

### Why Use Transactions?

1. **Data Integrity**: Ensures related changes happen together
2. **Error Recovery**: If something fails, you can rollback
3. **Consistency**: Database stays in a valid state

### Example: Transferring Data

```sql
BEGIN TRANSACTION;

-- Transfer employee to new department
UPDATE employees
SET department_id = 2
WHERE employee_id = 5;

-- Update their job title
UPDATE employees
SET job_title = 'Senior Data Analyst'
WHERE employee_id = 5;

-- If both succeed, commit; if either fails, rollback
COMMIT;
```

## Common Pitfalls

### 1. Forgetting WHERE in UPDATE/DELETE

```sql
-- ❌ DANGER: Updates ALL employees!
UPDATE employees
SET salary = 100000;

-- ✅ Correct: Updates only specific employee
UPDATE employees
SET salary = 100000
WHERE employee_id = 1;
```

### 2. Incorrect WHERE Conditions

```sql
-- ❌ This might update more rows than intended
UPDATE employees
SET salary = 80000
WHERE job_title = 'Engineer';  -- Might match multiple job titles

-- ✅ Be more specific
UPDATE employees
SET salary = 80000
WHERE employee_id = 3;
```

### 3. String Values Without Quotes

```sql
-- ❌ Error: Missing quotes
INSERT INTO employees (first_name, last_name)
VALUES (John, Smith);

-- ✅ Correct
INSERT INTO employees (first_name, last_name)
VALUES ('John', 'Smith');
```

### 4. Date Format Issues

```sql
-- Format depends on database, but ISO format usually works:
INSERT INTO employees (first_name, hire_date)
VALUES ('John', '2023-01-15');  -- YYYY-MM-DD format
```

## Best Practices

1. **Always use WHERE** with UPDATE and DELETE (unless intentionally updating all rows)
2. **Test with SELECT first**: Before updating/deleting, run a SELECT with the same WHERE condition
3. **Use transactions** for multiple related operations
4. **Backup before bulk operations**: Especially important for DELETE
5. **Be specific**: Use primary keys in WHERE when possible
6. **Double-check conditions**: Review your WHERE clause before executing

## Safety Tips

### Test Your WHERE Clause First

```sql
-- Step 1: See what will be affected
SELECT * FROM employees
WHERE department_id = 5;

-- Step 2: If results look correct, then delete
DELETE FROM employees
WHERE department_id = 5;
```

### Use Transactions for Safety

```sql
BEGIN TRANSACTION;

-- Make your changes
UPDATE employees SET salary = salary * 1.1;

-- Review the changes
SELECT * FROM employees;

-- If satisfied, commit; if not, rollback
COMMIT;  -- or ROLLBACK;
```

## Next Steps

In the next lesson, you'll learn about data types and constraints, which help ensure data quality and integrity.

---

**Key Takeaways:**
- `INSERT` adds new rows to a table
- `UPDATE` modifies existing rows (always use WHERE!)
- `DELETE` removes rows (always use WHERE!)
- Use transactions to group related operations
- Test with SELECT before UPDATE/DELETE
- Always be careful with WHERE clauses to avoid unintended changes
