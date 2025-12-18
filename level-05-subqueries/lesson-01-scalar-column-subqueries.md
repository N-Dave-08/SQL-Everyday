# Lesson 5.1: Scalar and Column Subqueries

A **subquery** (also called a nested query or inner query) is a SQL query nested inside another query. Subqueries are powerful tools for writing complex queries.

## What is a Subquery?

A subquery is a SELECT statement embedded within another SQL statement. The outer query uses the result of the inner query.

### Basic Structure

```sql
SELECT column1
FROM table1
WHERE column2 = (SELECT column FROM table2 WHERE condition);
```

The part in parentheses `(SELECT ...)` is the subquery.

## Types of Subqueries

1. **Scalar subquery**: Returns a single value
2. **Column subquery**: Returns a single column with multiple rows
3. **Row subquery**: Returns a single row with multiple columns
4. **Table subquery**: Returns a full table (used in FROM clause)

## Scalar Subqueries

A **scalar subquery** returns exactly one row and one column (a single value).

### Scalar Subquery in WHERE

```sql
-- Find employees who earn more than the average salary
SELECT first_name, last_name, salary
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);
```

**How it works:**
1. Subquery calculates average salary
2. Outer query compares each employee's salary to that average
3. Returns employees above average

### Scalar Subquery in SELECT

```sql
-- Show each employee's salary and how it compares to the average
SELECT 
    first_name,
    last_name,
    salary,
    (SELECT AVG(salary) FROM employees) AS average_salary,
    salary - (SELECT AVG(salary) FROM employees) AS difference_from_avg
FROM employees;
```

### Scalar Subquery in HAVING

```sql
-- Departments with average salary above company average
SELECT department_id, AVG(salary) AS dept_avg
FROM employees
GROUP BY department_id
HAVING AVG(salary) > (SELECT AVG(salary) FROM employees);
```

## Column Subqueries

A **column subquery** returns a single column with multiple rows. Used with operators like `IN`, `ANY`, `ALL`.

### Column Subquery with IN

```sql
-- Employees in departments with budget > 400000
SELECT first_name, last_name, department_id
FROM employees
WHERE department_id IN (
    SELECT department_id 
    FROM departments 
    WHERE budget > 400000
);
```

**How it works:**
1. Subquery returns list of department_ids with high budgets
2. Outer query finds employees in those departments
3. `IN` checks if employee's department_id is in the list

### Column Subquery with NOT IN

```sql
-- Products that have never been ordered
SELECT product_name
FROM products
WHERE product_id NOT IN (
    SELECT DISTINCT product_id 
    FROM order_items
);
```

**Warning**: `NOT IN` with NULL values can give unexpected results. If the subquery returns NULL, `NOT IN` returns no rows. Use `NOT EXISTS` instead (covered in next lesson).

## Subqueries in FROM Clause

You can use a subquery as a table (called a **derived table** or **inline view**):

```sql
-- Average salary by department, compared to overall average
SELECT 
    dept_stats.department_id,
    dept_stats.avg_salary,
    (SELECT AVG(salary) FROM employees) AS company_avg
FROM (
    SELECT department_id, AVG(salary) AS avg_salary
    FROM employees
    GROUP BY department_id
) AS dept_stats;
```

**Note**: Subqueries in FROM must have an alias.

## Correlated vs Non-Correlated Subqueries

### Non-Correlated Subquery

The subquery can run independently - it doesn't reference the outer query:

```sql
-- Non-correlated: subquery doesn't need outer query
SELECT * FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);
```

### Correlated Subquery

The subquery references columns from the outer query:

```sql
-- Employees who earn more than their department's average
SELECT e1.first_name, e1.last_name, e1.salary
FROM employees e1
WHERE e1.salary > (
    SELECT AVG(e2.salary)
    FROM employees e2
    WHERE e2.department_id = e1.department_id
);
```

**How it works:**
- For each employee in the outer query
- The subquery calculates the average salary for that employee's department
- Compares the employee's salary to their department's average

## Common Patterns

### Pattern 1: Finding Maximum/Minimum Related Records

```sql
-- Employee with highest salary
SELECT first_name, last_name, salary
FROM employees
WHERE salary = (SELECT MAX(salary) FROM employees);
```

### Pattern 2: Comparing to Aggregate

```sql
-- Employees earning above average
SELECT first_name, last_name, salary
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);
```

### Pattern 3: Filtering with Subquery

```sql
-- Orders from customers in New York
SELECT order_id, order_date, total_amount
FROM orders
WHERE customer_id IN (
    SELECT customer_id 
    FROM customers 
    WHERE city = 'New York'
);
```

### Pattern 4: Subquery in SELECT

```sql
-- Each order with customer's total order count
SELECT 
    o.order_id,
    o.order_date,
    (
        SELECT COUNT(*) 
        FROM orders o2 
        WHERE o2.customer_id = o.customer_id
    ) AS customer_order_count
FROM orders o;
```

## Common Pitfalls

### 1. Subquery Returns Multiple Rows

```sql
-- ❌ Error: Subquery returns multiple rows, but = expects one value
SELECT * FROM employees
WHERE department_id = (SELECT department_id FROM departments);

-- ✅ Correct: Use IN for multiple values
SELECT * FROM employees
WHERE department_id IN (SELECT department_id FROM departments);
```

### 2. Subquery Returns No Rows

```sql
-- If subquery returns no rows, comparison returns NULL (no matches)
SELECT * FROM employees
WHERE salary > (SELECT MAX(salary) FROM employees WHERE department_id = 99);
-- Returns no rows if department 99 doesn't exist
```

### 3. Performance Issues

Correlated subqueries can be slow because they execute once per row:

```sql
-- Slow: Runs subquery for each employee
SELECT first_name, salary,
    (SELECT AVG(salary) FROM employees e2 
     WHERE e2.department_id = e1.department_id) AS dept_avg
FROM employees e1;

-- Faster: Use JOIN instead
SELECT e1.first_name, e1.salary, dept_avg.avg_salary
FROM employees e1
JOIN (
    SELECT department_id, AVG(salary) AS avg_salary
    FROM employees
    GROUP BY department_id
) dept_avg ON e1.department_id = dept_avg.department_id;
```

## Best Practices

1. **Use JOINs when possible**: Often faster than subqueries
2. **Test subqueries independently**: Run the subquery alone first
3. **Use appropriate operators**: `=` for scalar, `IN` for column subqueries
4. **Consider performance**: Correlated subqueries can be slow
5. **Use aliases**: Makes correlated subqueries clearer

## When to Use Subqueries vs JOINs

### Use Subqueries When:
- You need a single aggregate value (e.g., average, max)
- The relationship is one-way (don't need data from the subquery table)
- The logic is clearer with a subquery

### Use JOINs When:
- You need columns from multiple tables
- Performance is critical
- The relationship is bidirectional

## Practice Examples

```sql
-- 1. Employees above average salary
SELECT first_name, last_name, salary
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);

-- 2. Products in high-budget departments (if products had dept_id)
-- This is a conceptual example

-- 3. Orders from specific cities
SELECT * FROM orders
WHERE customer_id IN (
    SELECT customer_id FROM customers WHERE city = 'New York'
);

-- 4. Department averages with overall average
SELECT 
    department_id,
    AVG(salary) AS dept_avg,
    (SELECT AVG(salary) FROM employees) AS company_avg
FROM employees
GROUP BY department_id;
```

## Next Steps

In the next lesson, you'll learn about EXISTS and more advanced subquery patterns.

---

**Key Takeaways:**
- Subqueries are queries nested inside other queries
- Scalar subqueries return a single value
- Column subqueries return multiple rows (use with IN, ANY, ALL)
- Correlated subqueries reference the outer query
- Subqueries can be used in SELECT, WHERE, HAVING, and FROM
- Consider performance: JOINs are often faster than subqueries
- Test subqueries independently before using in outer query
