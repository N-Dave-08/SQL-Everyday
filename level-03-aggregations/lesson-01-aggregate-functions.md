# Lesson 3.1: Aggregate Functions

Aggregate functions perform calculations on a set of rows and return a single value. They're essential for summarizing and analyzing data.

## What are Aggregate Functions?

Aggregate functions operate on multiple rows to produce a single result. They're commonly used with `GROUP BY` (covered in the next lesson) but can also be used on entire tables.

## Common Aggregate Functions

### COUNT

Counts the number of rows.

```sql
-- Count all employees
SELECT COUNT(*) FROM employees;

-- Count employees with a specific condition
SELECT COUNT(*) FROM employees
WHERE department_id = 1;

-- Count non-NULL values in a column
SELECT COUNT(email) FROM employees;  -- Counts only non-NULL emails
SELECT COUNT(*) FROM employees;      -- Counts all rows regardless of NULLs
```

**Key Points:**
- `COUNT(*)` counts all rows, including those with NULL values
- `COUNT(column_name)` counts only non-NULL values in that column
- `COUNT(DISTINCT column_name)` counts unique non-NULL values

### SUM

Calculates the sum of numeric values in a column.

```sql
-- Total salary cost for all employees
SELECT SUM(salary) FROM employees;

-- Total salary for a specific department
SELECT SUM(salary) FROM employees
WHERE department_id = 1;
```

**Note**: SUM ignores NULL values. If all values are NULL, SUM returns NULL.

### AVG

Calculates the average (mean) of numeric values.

```sql
-- Average salary across all employees
SELECT AVG(salary) FROM employees;

-- Average salary in department 1
SELECT AVG(salary) FROM employees
WHERE department_id = 1;
```

**Note**: AVG ignores NULL values in its calculation.

### MIN

Finds the minimum value in a column.

```sql
-- Lowest salary
SELECT MIN(salary) FROM employees;

-- Earliest hire date
SELECT MIN(hire_date) FROM employees;
```

Works with numbers, dates, and strings (alphabetical order for strings).

### MAX

Finds the maximum value in a column.

```sql
-- Highest salary
SELECT MAX(salary) FROM employees;

-- Most recent hire date
SELECT MAX(hire_date) FROM employees;
```

## Using Multiple Aggregate Functions

You can use multiple aggregate functions in a single query:

```sql
SELECT 
    COUNT(*) AS total_employees,
    AVG(salary) AS average_salary,
    MIN(salary) AS min_salary,
    MAX(salary) AS max_salary,
    SUM(salary) AS total_payroll
FROM employees;
```

## Column Aliases

Use `AS` to give columns meaningful names:

```sql
SELECT 
    COUNT(*) AS employee_count,
    AVG(salary) AS average_salary
FROM employees;
```

**Note**: The `AS` keyword is optional but recommended for clarity:
```sql
SELECT COUNT(*) employee_count FROM employees;  -- Works, but AS is clearer
```

## NULL Handling in Aggregates

### How Aggregates Handle NULL

- **COUNT(column)**: Ignores NULL values
- **COUNT(*)**: Counts all rows, including NULLs
- **SUM, AVG**: Ignore NULL values
- **MIN, MAX**: Ignore NULL values

### Example

```sql
-- If some salaries are NULL:
SELECT 
    COUNT(*) AS total_rows,           -- Counts all rows
    COUNT(salary) AS non_null_salaries,  -- Counts only non-NULL salaries
    AVG(salary) AS avg_salary         -- Averages only non-NULL salaries
FROM employees;
```

## COUNT with DISTINCT

Count unique values:

```sql
-- Count unique job titles
SELECT COUNT(DISTINCT job_title) FROM employees;

-- Count unique departments
SELECT COUNT(DISTINCT department_id) FROM employees
WHERE department_id IS NOT NULL;
```

## Combining Aggregates with WHERE

Filter rows before aggregating:

```sql
-- Average salary of Software Engineers
SELECT AVG(salary) FROM employees
WHERE job_title = 'Software Engineer';

-- Total products in Electronics category
SELECT SUM(stock_quantity) FROM products
WHERE category = 'Electronics';
```

## Common Patterns

### Counting with Conditions

```sql
-- Count employees in each department (we'll learn GROUP BY for this later)
-- For now, count specific department:
SELECT COUNT(*) FROM employees WHERE department_id = 1;
```

### Finding Extremes

```sql
-- Employee with highest salary
SELECT first_name, last_name, salary
FROM employees
WHERE salary = (SELECT MAX(salary) FROM employees);
```

(We'll learn subqueries in Level 5, but this shows a common pattern)

## Common Pitfalls

### 1. Mixing Aggregates with Non-Aggregated Columns

```sql
-- ❌ Error: Can't mix aggregate with regular columns without GROUP BY
SELECT first_name, COUNT(*) FROM employees;

-- ✅ Correct: Use aggregate only, or use GROUP BY (next lesson)
SELECT COUNT(*) FROM employees;
```

### 2. Using Aggregates in WHERE

```sql
-- ❌ Error: Can't use aggregates in WHERE clause
SELECT * FROM employees
WHERE salary > AVG(salary);

-- ✅ Correct: Use HAVING (covered in next lesson) or subquery
SELECT * FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);
```

### 3. Forgetting NULL Handling

```sql
-- If some values are NULL, COUNT(column) might be less than COUNT(*)
SELECT COUNT(*) AS total, COUNT(salary) AS with_salary
FROM employees;
```

## Best Practices

1. **Use meaningful aliases**: `AVG(salary) AS average_salary` is clearer than `AVG(salary)`
2. **Be aware of NULLs**: Understand how each aggregate handles NULL values
3. **Use COUNT(*) for row counts**: More reliable than COUNT(column)
4. **Combine with WHERE**: Filter before aggregating for better performance
5. **Use DISTINCT when needed**: `COUNT(DISTINCT column)` for unique counts

## Practice Examples

Try these queries:

```sql
-- 1. Count total employees
SELECT COUNT(*) AS total_employees FROM employees;

-- 2. Average salary
SELECT AVG(salary) AS average_salary FROM employees;

-- 3. Total payroll cost
SELECT SUM(salary) AS total_payroll FROM employees;

-- 4. Salary range (min and max)
SELECT MIN(salary) AS min_salary, MAX(salary) AS max_salary FROM employees;

-- 5. Count unique job titles
SELECT COUNT(DISTINCT job_title) FROM employees;

-- 6. Average salary for Software Engineers
SELECT AVG(salary) FROM employees
WHERE job_title = 'Software Engineer';
```

## Next Steps

In the next lesson, you'll learn how to use `GROUP BY` to aggregate data by groups, which makes aggregate functions much more powerful!

---

**Key Takeaways:**
- Aggregate functions summarize multiple rows into a single value
- Common aggregates: COUNT, SUM, AVG, MIN, MAX
- COUNT(*) counts all rows; COUNT(column) counts non-NULL values
- Aggregates ignore NULL values (except COUNT(*))
- Use column aliases (AS) for clearer results
- Can't mix aggregates with regular columns without GROUP BY
