# Lesson 3.2: GROUP BY and HAVING

`GROUP BY` allows you to group rows that have the same values in specified columns and perform aggregate functions on each group. This is one of the most powerful features in SQL.

## GROUP BY Basics

`GROUP BY` divides rows into groups based on one or more columns, then you can apply aggregate functions to each group.

### Basic Syntax

```sql
SELECT column1, aggregate_function(column2)
FROM table_name
WHERE condition
GROUP BY column1;
```

### Simple Example

```sql
-- Count employees in each department
SELECT department_id, COUNT(*) AS employee_count
FROM employees
GROUP BY department_id;
```

**Result:**
```
department_id | employee_count
--------------|----------------
1             | 6
2             | 3
3             | 2
4             | 1
5             | 1
```

### How GROUP BY Works

1. Rows are divided into groups based on the GROUP BY column(s)
2. Aggregate functions are applied to each group
3. One row is returned per group

## Multiple Columns in GROUP BY

You can group by multiple columns:

```sql
-- Count employees by department and job title
SELECT department_id, job_title, COUNT(*) AS count
FROM employees
GROUP BY department_id, job_title;
```

This creates a group for each unique combination of `department_id` and `job_title`.

## Common GROUP BY Patterns

### Aggregating by Category

```sql
-- Average salary by department
SELECT department_id, AVG(salary) AS avg_salary
FROM employees
GROUP BY department_id;

-- Total stock by product category
SELECT category, SUM(stock_quantity) AS total_stock
FROM products
GROUP BY category;
```

### Counting by Groups

```sql
-- Number of employees per job title
SELECT job_title, COUNT(*) AS employee_count
FROM employees
GROUP BY job_title;

-- Number of products per category
SELECT category, COUNT(*) AS product_count
FROM products
GROUP BY category;
```

### Finding Extremes by Group

```sql
-- Highest salary in each department
SELECT department_id, MAX(salary) AS max_salary
FROM employees
GROUP BY department_id;

-- Lowest price in each category
SELECT category, MIN(price) AS min_price
FROM products
GROUP BY category;
```

## GROUP BY Rules

### Rule 1: Selected Columns Must Be in GROUP BY

```sql
-- ❌ Error: first_name not in GROUP BY
SELECT first_name, department_id, COUNT(*)
FROM employees
GROUP BY department_id;

-- ✅ Correct: Only group columns and aggregates
SELECT department_id, COUNT(*)
FROM employees
GROUP BY department_id;

-- ✅ Also correct: Include first_name in GROUP BY (but this changes the grouping!)
SELECT first_name, department_id, COUNT(*)
FROM employees
GROUP BY first_name, department_id;
```

### Rule 2: Aggregate Functions Can Be Used

```sql
-- ✅ Correct: Using aggregate functions
SELECT department_id, COUNT(*), AVG(salary)
FROM employees
GROUP BY department_id;
```

### Rule 3: WHERE Filters Before Grouping

```sql
-- Filter employees first, then group
SELECT department_id, COUNT(*)
FROM employees
WHERE salary > 70000
GROUP BY department_id;
```

**Order of operations:**
1. FROM - Get the table
2. WHERE - Filter rows
3. GROUP BY - Group the filtered rows
4. Aggregate functions - Calculate per group
5. SELECT - Return results

## HAVING - Filtering Groups

`HAVING` filters groups after they've been created, similar to how `WHERE` filters rows.

### HAVING vs WHERE

- **WHERE**: Filters rows **before** grouping
- **HAVING**: Filters groups **after** grouping

### HAVING Syntax

```sql
SELECT column1, aggregate_function(column2)
FROM table_name
WHERE condition
GROUP BY column1
HAVING aggregate_condition;
```

### Example: HAVING with COUNT

```sql
-- Departments with more than 3 employees
SELECT department_id, COUNT(*) AS employee_count
FROM employees
GROUP BY department_id
HAVING COUNT(*) > 3;
```

### Example: HAVING with AVG

```sql
-- Departments with average salary above 75000
SELECT department_id, AVG(salary) AS avg_salary
FROM employees
GROUP BY department_id
HAVING AVG(salary) > 75000;
```

### Example: HAVING with SUM

```sql
-- Product categories with total stock over 200
SELECT category, SUM(stock_quantity) AS total_stock
FROM products
GROUP BY category
HAVING SUM(stock_quantity) > 200;
```

## Combining WHERE and HAVING

You can use both `WHERE` and `HAVING` in the same query:

```sql
-- Average salary by department, but only for employees hired after 2020,
-- and only show departments with average salary > 70000
SELECT department_id, AVG(salary) AS avg_salary, COUNT(*) AS emp_count
FROM employees
WHERE hire_date > '2020-01-01'  -- Filter rows first
GROUP BY department_id
HAVING AVG(salary) > 70000;     -- Filter groups after
```

**Execution order:**
1. WHERE filters individual rows
2. GROUP BY creates groups
3. Aggregates are calculated
4. HAVING filters groups
5. SELECT returns results

## ORDER BY with GROUP BY

You can sort grouped results:

```sql
-- Departments sorted by employee count (descending)
SELECT department_id, COUNT(*) AS employee_count
FROM employees
GROUP BY department_id
ORDER BY COUNT(*) DESC;

-- Or use the alias
SELECT department_id, COUNT(*) AS employee_count
FROM employees
GROUP BY department_id
ORDER BY employee_count DESC;
```

## Common Patterns

### Top N by Group

```sql
-- Top 3 departments by employee count
SELECT department_id, COUNT(*) AS employee_count
FROM employees
GROUP BY department_id
ORDER BY employee_count DESC
LIMIT 3;
```

### Groups Meeting Criteria

```sql
-- Job titles with at least 2 employees
SELECT job_title, COUNT(*) AS count
FROM employees
GROUP BY job_title
HAVING COUNT(*) >= 2
ORDER BY count DESC;
```

### Multiple Aggregates

```sql
-- Summary statistics by department
SELECT 
    department_id,
    COUNT(*) AS employee_count,
    AVG(salary) AS avg_salary,
    MIN(salary) AS min_salary,
    MAX(salary) AS max_salary,
    SUM(salary) AS total_payroll
FROM employees
GROUP BY department_id;
```

## Common Pitfalls

### 1. Forgetting GROUP BY

```sql
-- ❌ Error: Can't use aggregate with non-grouped column
SELECT department_id, COUNT(*)
FROM employees;

-- ✅ Correct: Add GROUP BY
SELECT department_id, COUNT(*)
FROM employees
GROUP BY department_id;
```

### 2. Using WHERE Instead of HAVING

```sql
-- ❌ Error: Can't use aggregates in WHERE
SELECT department_id, COUNT(*)
FROM employees
WHERE COUNT(*) > 3
GROUP BY department_id;

-- ✅ Correct: Use HAVING for aggregate conditions
SELECT department_id, COUNT(*)
FROM employees
GROUP BY department_id
HAVING COUNT(*) > 3;
```

### 3. Including Non-Grouped Columns

```sql
-- ❌ Error: first_name not in GROUP BY
SELECT first_name, department_id, COUNT(*)
FROM employees
GROUP BY department_id;

-- ✅ Correct: Remove first_name or add to GROUP BY
SELECT department_id, COUNT(*)
FROM employees
GROUP BY department_id;
```

### 4. Confusing WHERE and HAVING

```sql
-- WHERE: Filter employees with salary > 70000, then group
SELECT department_id, AVG(salary)
FROM employees
WHERE salary > 70000
GROUP BY department_id;

-- HAVING: Group first, then filter groups with avg > 70000
SELECT department_id, AVG(salary)
FROM employees
GROUP BY department_id
HAVING AVG(salary) > 70000;
```

## Best Practices

1. **Use meaningful aliases**: Makes results clearer
2. **Understand WHERE vs HAVING**: WHERE filters rows, HAVING filters groups
3. **Order logically**: WHERE → GROUP BY → HAVING → ORDER BY
4. **Test incrementally**: Start with GROUP BY, then add HAVING
5. **Use ORDER BY**: Sort results for better readability

## Complete Query Structure

The full order of SQL clauses:

```sql
SELECT column1, aggregate_function(column2)
FROM table_name
WHERE condition              -- Filter rows
GROUP BY column1            -- Group rows
HAVING aggregate_condition  -- Filter groups
ORDER BY column1            -- Sort results
LIMIT n;                     -- Limit results
```

## Practice Examples

```sql
-- 1. Count employees by department
SELECT department_id, COUNT(*) AS count
FROM employees
GROUP BY department_id;

-- 2. Average salary by job title
SELECT job_title, AVG(salary) AS avg_salary
FROM employees
GROUP BY job_title;

-- 3. Departments with more than 2 employees
SELECT department_id, COUNT(*) AS count
FROM employees
GROUP BY department_id
HAVING COUNT(*) > 2;

-- 4. Total stock by category, sorted by total
SELECT category, SUM(stock_quantity) AS total_stock
FROM products
GROUP BY category
ORDER BY total_stock DESC;
```

## Next Steps

You've now mastered aggregations! Practice with the exercises to solidify your understanding before moving to Level 4 (Joins).

---

**Key Takeaways:**
- GROUP BY groups rows based on column values
- Aggregate functions are applied to each group
- All selected non-aggregate columns must be in GROUP BY
- WHERE filters rows before grouping
- HAVING filters groups after grouping
- Use ORDER BY to sort grouped results
- Understand the execution order: WHERE → GROUP BY → HAVING → ORDER BY
