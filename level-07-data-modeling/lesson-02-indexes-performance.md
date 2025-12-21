# Lesson 7.2: Indexes and Performance

Indexes are database structures that improve query performance by allowing faster data retrieval. Understanding indexes is crucial for optimizing database performance.

## What is an Index?

An **index** is a data structure that improves the speed of data retrieval operations. Think of it like an index in a book - instead of scanning every page, you can jump directly to the relevant section.

### How Indexes Work

Without an index, the database must scan every row (full table scan):
```
Table scan: Check row 1, row 2, row 3, ... row 1000 (slow!)
```

With an index, the database can quickly find the relevant rows:
```
Index lookup: Jump directly to row 500, then row 750 (fast!)
```

## Types of Indexes

### Primary Key Index

Automatically created when you define a PRIMARY KEY:

```sql
CREATE TABLE employees (
    employee_id INTEGER PRIMARY KEY,  -- Automatically indexed
    first_name VARCHAR(50)
);
```

### Unique Index

Created automatically for UNIQUE constraints:

```sql
CREATE TABLE employees (
    employee_id INTEGER PRIMARY KEY,
    email VARCHAR(100) UNIQUE  -- Automatically indexed
);
```

### Regular Index

Manually created index:

```sql
CREATE INDEX idx_employees_department 
ON employees(department_id);
```

### Composite Index

Index on multiple columns:

```sql
CREATE INDEX idx_orders_customer_date 
ON orders(customer_id, order_date);
```

## When to Create Indexes

### Good Candidates for Indexing

1. **Foreign keys**: Frequently used in JOINs
   ```sql
   CREATE INDEX idx_employees_department 
   ON employees(department_id);
   ```

2. **Frequently filtered columns**: Used in WHERE clauses
   ```sql
   CREATE INDEX idx_orders_date 
   ON orders(order_date);
   ```

3. **Frequently sorted columns**: Used in ORDER BY
   ```sql
   CREATE INDEX idx_employees_salary 
   ON employees(salary);
   ```

4. **Frequently searched columns**: Used in WHERE with =, <, >
   ```sql
   CREATE INDEX idx_customers_email 
   ON customers(email);
   ```

### When NOT to Index

1. **Small tables**: Index overhead may exceed benefit
2. **Frequently updated columns**: Indexes slow down INSERT/UPDATE/DELETE
3. **Columns with few unique values**: Low selectivity (e.g., gender, status flags)
4. **Columns rarely used in queries**: Unnecessary overhead

## Creating Indexes

### Basic Syntax

```sql
CREATE INDEX index_name 
ON table_name(column_name);
```

### Examples

```sql
-- Single column index
CREATE INDEX idx_employees_department 
ON employees(department_id);

-- Composite index (multiple columns)
CREATE INDEX idx_orders_customer_date 
ON orders(customer_id, order_date);

-- Unique index
CREATE UNIQUE INDEX idx_customers_email 
ON customers(email);
```

## Index Best Practices

### 1. Index Foreign Keys

Foreign keys are frequently used in JOINs:

```sql
CREATE INDEX idx_employees_department 
ON employees(department_id);

CREATE INDEX idx_orders_customer 
ON orders(customer_id);
```

### 2. Index Frequently Queried Columns

```sql
-- If you often filter by salary
CREATE INDEX idx_employees_salary 
ON employees(salary);

-- If you often filter by date range
CREATE INDEX idx_orders_date 
ON orders(order_date);
```

### 3. Composite Indexes for Multiple Columns

If you frequently query multiple columns together:

```sql
-- Good for: WHERE customer_id = X AND order_date > Y
CREATE INDEX idx_orders_customer_date 
ON orders(customer_id, order_date);
```

**Column order matters**: Put the most selective column first.

### 4. Don't Over-Index

Too many indexes:
- Slow down INSERT/UPDATE/DELETE
- Use extra storage
- May confuse the query optimizer

## Query Performance Tips

### 1. Use WHERE to Filter Early

```sql
-- ✅ Good: Filter before JOIN
SELECT e.first_name, d.department_name
FROM employees e
JOIN departments d ON e.department_id = d.department_id
WHERE e.salary > 70000;

-- ❌ Less efficient: JOIN first, then filter
SELECT e.first_name, d.department_name
FROM employees e
JOIN departments d ON e.department_id = d.department_id
WHERE e.salary > 70000;
-- (Actually, optimizer usually handles this, but be explicit)
```

### 2. Use Appropriate JOIN Types

```sql
-- ✅ Use INNER JOIN when you only need matches
SELECT ... FROM employees e
INNER JOIN departments d ON ...

-- ❌ LEFT JOIN when you don't need all rows
SELECT ... FROM employees e
LEFT JOIN departments d ON ...
WHERE d.department_id IS NOT NULL;  -- Should use INNER JOIN
```

### 3. Limit Results

```sql
-- ✅ Use LIMIT when you only need a few rows
SELECT * FROM employees
ORDER BY salary DESC
LIMIT 10;

-- ❌ Don't fetch more than needed
SELECT * FROM employees;  -- Fetches all rows
```

### 4. Avoid SELECT *

```sql
-- ✅ Select only needed columns
SELECT first_name, last_name, salary
FROM employees;

-- ❌ Fetches unnecessary data
SELECT * FROM employees;
```

## EXPLAIN Plans (Concept)

Most databases provide `EXPLAIN` or `EXPLAIN ANALYZE` to see how queries are executed:

```sql
-- See query execution plan
EXPLAIN SELECT * FROM employees WHERE department_id = 1;

-- Analyze actual execution
EXPLAIN ANALYZE SELECT * FROM employees WHERE department_id = 1;
```

**What to look for:**
- "Index Scan" vs "Seq Scan" (sequential scan = slow)
- Number of rows examined
- Execution time

**Note**: Syntax varies by database. This is a conceptual introduction.

## Common Performance Issues

### Issue 1: Missing Indexes

```sql
-- Slow: No index on department_id
SELECT * FROM employees WHERE department_id = 1;

-- Solution: Create index
CREATE INDEX idx_employees_department ON employees(department_id);
```

### Issue 2: Functions in WHERE

```sql
-- ❌ Slow: Can't use index
SELECT * FROM employees 
WHERE UPPER(first_name) = 'JOHN';

-- ✅ Better: Index-friendly
SELECT * FROM employees 
WHERE first_name = 'John';
```

### Issue 3: LIKE with Leading Wildcard

```sql
-- ❌ Slow: Can't use index
SELECT * FROM employees 
WHERE email LIKE '%@company.com';

-- ✅ Better: Trailing wildcard can use index
SELECT * FROM employees 
WHERE email LIKE 'john%@company.com';
```

## Index Maintenance

### Viewing Indexes

```sql
-- List all indexes in PostgreSQL
-- Using psql command:
\di employees

-- Using SQL query:
SELECT 
    indexname, 
    indexdef 
FROM pg_indexes 
WHERE tablename = 'employees';

-- List all indexes for a table:
SELECT 
    schemaname,
    tablename,
    indexname,
    indexdef
FROM pg_indexes
WHERE tablename = 'employees'
ORDER BY indexname;
```

### Dropping Indexes

```sql
DROP INDEX index_name;
```

### When to Rebuild Indexes

- After bulk data loads
- When query performance degrades
- Periodically for maintenance

## Best Practices Summary

1. **Index foreign keys**: Essential for JOIN performance
2. **Index frequently filtered columns**: WHERE clause columns
3. **Index frequently sorted columns**: ORDER BY columns
4. **Use composite indexes wisely**: For multi-column queries
5. **Don't over-index**: Balance read vs write performance
6. **Monitor performance**: Use EXPLAIN to verify index usage
7. **Test changes**: Measure before and after adding indexes

## Next Steps

You've learned about data modeling and performance! Practice with the exercises, then move to Level 8 (Advanced Topics).

---

**Key Takeaways:**
- Indexes speed up data retrieval (like a book index)
- Index foreign keys and frequently queried columns
- Composite indexes for multi-column queries
- Don't over-index (slows down writes)
- Use EXPLAIN to analyze query performance
- Balance between read and write performance
- Test and measure performance improvements
