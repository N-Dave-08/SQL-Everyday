# Lesson 4.1: INNER JOIN

Joins are one of the most powerful features in SQL. They allow you to combine data from multiple tables based on related columns.

## What is a JOIN?

A **JOIN** combines rows from two or more tables based on a related column between them. This allows you to query data across multiple tables in a single query.

## Understanding Relationships

### Primary Key and Foreign Key

- **Primary Key**: A unique identifier for each row in a table (e.g., `employee_id` in the `employees` table)
- **Foreign Key**: A column in one table that references the primary key of another table (e.g., `department_id` in `employees` references `department_id` in `departments`)

### Relationship Example

```
employees table              departments table
-----------------            ------------------
employee_id (PK)             department_id (PK)
first_name                   department_name
last_name                    location
department_id (FK) ──────────> department_id
```

The `department_id` in `employees` is a foreign key that references `department_id` in `departments`.

## INNER JOIN

`INNER JOIN` returns only the rows that have matching values in both tables. If there's no match, the row is excluded.

### Basic INNER JOIN Syntax

```sql
SELECT columns
FROM table1
INNER JOIN table2
ON table1.column = table2.column;
```

The `INNER` keyword is optional - `JOIN` by itself means `INNER JOIN`.

### Simple Example

```sql
-- Get employee names with their department names
SELECT 
    e.first_name,
    e.last_name,
    d.department_name
FROM employees e
INNER JOIN departments d
ON e.department_id = d.department_id;
```

**What happens:**
1. SQL matches rows where `employees.department_id` = `departments.department_id`
2. Only rows with matches are returned
3. Employees without a department (NULL department_id) are excluded

### Using Table Aliases

Table aliases make queries shorter and clearer:

```sql
-- Without aliases (verbose)
SELECT 
    employees.first_name,
    employees.last_name,
    departments.department_name
FROM employees
INNER JOIN departments
ON employees.department_id = departments.department_id;

-- With aliases (cleaner)
SELECT 
    e.first_name,
    e.last_name,
    d.department_name
FROM employees e
INNER JOIN departments d
ON e.department_id = d.department_id;
```

**Best Practice**: Use short, meaningful aliases (e.g., `e` for employees, `d` for departments, `o` for orders).

## Common JOIN Patterns

### Joining Two Tables

```sql
-- Employees with their department information
SELECT 
    e.first_name,
    e.last_name,
    e.job_title,
    d.department_name,
    d.location
FROM employees e
INNER JOIN departments d
ON e.department_id = d.department_id;
```

### Selecting Specific Columns

You can select columns from either table:

```sql
-- Mix columns from both tables
SELECT 
    e.employee_id,
    e.first_name,
    e.salary,
    d.department_name
FROM employees e
INNER JOIN departments d
ON e.department_id = d.department_id;
```

### Using WHERE with JOINs

You can filter joined results:

```sql
-- Employees in Engineering department
SELECT 
    e.first_name,
    e.last_name,
    d.department_name
FROM employees e
INNER JOIN departments d
ON e.department_id = d.department_id
WHERE d.department_name = 'Engineering';
```

### Using ORDER BY with JOINs

Sort joined results:

```sql
-- Employees with departments, sorted by salary
SELECT 
    e.first_name,
    e.last_name,
    e.salary,
    d.department_name
FROM employees e
INNER JOIN departments d
ON e.department_id = d.department_id
ORDER BY e.salary DESC;
```

## Multiple JOINs

You can join multiple tables in a single query:

```sql
-- Orders with customer and product information
SELECT 
    o.order_id,
    o.order_date,
    c.first_name AS customer_first_name,
    c.last_name AS customer_last_name,
    p.product_name,
    oi.quantity,
    oi.unit_price
FROM orders o
INNER JOIN customers c
ON o.customer_id = c.customer_id
INNER JOIN order_items oi
ON o.order_id = oi.order_id
INNER JOIN products p
ON oi.product_id = p.product_id;
```

**Join order matters for performance**, but logically you can think of it as:
1. Start with `orders`
2. Join `customers` to get customer info
3. Join `order_items` to get order details
4. Join `products` to get product names

## JOIN with Aggregates

You can combine JOINs with aggregate functions:

```sql
-- Total sales by department
SELECT 
    d.department_name,
    COUNT(e.employee_id) AS employee_count,
    AVG(e.salary) AS avg_salary
FROM departments d
INNER JOIN employees e
ON d.department_id = e.department_id
GROUP BY d.department_name;
```

## Common JOIN Patterns

### Finding Related Data

```sql
-- Which products were ordered?
SELECT DISTINCT p.product_name
FROM products p
INNER JOIN order_items oi
ON p.product_id = oi.product_id;
```

### Filtering with JOINs

```sql
-- Employees in departments with budget > 400000
SELECT 
    e.first_name,
    e.last_name,
    d.department_name,
    d.budget
FROM employees e
INNER JOIN departments d
ON e.department_id = d.department_id
WHERE d.budget > 400000;
```

## Common Pitfalls

### 1. Forgetting the ON Clause

```sql
-- ❌ Error: Missing ON clause
SELECT e.first_name, d.department_name
FROM employees e
INNER JOIN departments d;

-- ✅ Correct: Include ON clause
SELECT e.first_name, d.department_name
FROM employees e
INNER JOIN departments d
ON e.department_id = d.department_id;
```

### 2. Ambiguous Column Names

```sql
-- ❌ Error: Ambiguous - which table's department_id?
SELECT first_name, department_id
FROM employees e
INNER JOIN departments d
ON e.department_id = d.department_id;

-- ✅ Correct: Specify table
SELECT e.first_name, e.department_id
FROM employees e
INNER JOIN departments d
ON e.department_id = d.department_id;
```

### 3. Wrong Join Condition

```sql
-- ❌ Wrong: Joining on unrelated columns
SELECT e.first_name, d.department_name
FROM employees e
INNER JOIN departments d
ON e.employee_id = d.department_id;  -- Wrong relationship!

-- ✅ Correct: Join on related columns
SELECT e.first_name, d.department_name
FROM employees e
INNER JOIN departments d
ON e.department_id = d.department_id;
```

### 4. NULL Values Excluded

Remember: INNER JOIN excludes rows where the join condition doesn't match. If an employee has `department_id = NULL`, they won't appear in the results.

## Best Practices

1. **Use table aliases**: Makes queries cleaner and easier to read
2. **Be explicit with column names**: Use `table.column` or `alias.column` to avoid ambiguity
3. **Understand the relationship**: Know which columns link the tables
4. **Test incrementally**: Start with simple joins, then add complexity
5. **Use meaningful aliases**: `e`, `d`, `o` are better than `t1`, `t2`, `t3`

## Visualizing INNER JOIN

```
Table A          Table B          Result (INNER JOIN)
--------         --------         -------------------
A1 | B1          B1 | X           A1 | B1 | X
A2 | B2          B2 | Y           A2 | B2 | Y
A3 | B3          B3 | Z           A3 | B3 | Z
A4 | B4          B5 | W           (A4 excluded - no match)
                                 (B5 excluded - no match)
```

Only rows with matching values in the join column appear in the result.

## Practice Examples

```sql
-- 1. Basic join: Employees with departments
SELECT e.first_name, e.last_name, d.department_name
FROM employees e
INNER JOIN departments d
ON e.department_id = d.department_id;

-- 2. Join with filtering: Engineering employees
SELECT e.first_name, e.last_name, e.salary
FROM employees e
INNER JOIN departments d
ON e.department_id = d.department_id
WHERE d.department_name = 'Engineering';

-- 3. Multiple joins: Order details
SELECT o.order_id, c.first_name, p.product_name, oi.quantity
FROM orders o
INNER JOIN customers c ON o.customer_id = c.customer_id
INNER JOIN order_items oi ON o.order_id = oi.order_id
INNER JOIN products p ON oi.product_id = p.product_id;
```

## Next Steps

In the next lesson, you'll learn about OUTER JOINs (LEFT, RIGHT, FULL), which include rows even when there's no match.

---

**Key Takeaways:**
- JOINs combine data from multiple tables
- INNER JOIN returns only matching rows
- Use table aliases for cleaner queries
- The ON clause specifies how tables are related
- NULL values in join columns result in excluded rows
- You can join multiple tables in one query
- JOINs work with WHERE, ORDER BY, and aggregates
