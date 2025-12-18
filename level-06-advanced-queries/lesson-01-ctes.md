# Lesson 6.1: Common Table Expressions (CTEs)

A **Common Table Expression (CTE)** is a temporary named result set that exists only within the scope of a single SQL statement. CTEs make complex queries more readable and maintainable.

## What is a CTE?

A CTE is defined using the `WITH` clause and can be referenced multiple times in the main query. Think of it as a temporary view that exists only for the duration of the query.

### Basic CTE Syntax

```sql
WITH cte_name AS (
    SELECT ...
)
SELECT * FROM cte_name;
```

## Simple CTE Example

```sql
-- Employees with their department names
WITH employee_depts AS (
    SELECT 
        e.first_name,
        e.last_name,
        d.department_name
    FROM employees e
    JOIN departments d ON e.department_id = d.department_id
)
SELECT * FROM employee_depts;
```

**Benefits:**
- More readable than nested subqueries
- Can be referenced multiple times
- Easier to debug (test the CTE separately)

## Multiple CTEs

You can define multiple CTEs in a single query:

```sql
WITH 
    high_salary_employees AS (
        SELECT * FROM employees WHERE salary > 75000
    ),
    engineering_dept AS (
        SELECT * FROM departments WHERE department_name = 'Engineering'
    )
SELECT 
    e.first_name,
    e.last_name,
    d.department_name
FROM high_salary_employees e
JOIN engineering_dept d ON e.department_id = d.department_id;
```

**Note**: CTEs are separated by commas, except the last one before the main query.

## CTEs vs Subqueries

### Using Subquery

```sql
-- Hard to read with nested subqueries
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

### Using CTE (Clearer)

```sql
-- Much more readable with CTE
WITH dept_stats AS (
    SELECT department_id, AVG(salary) AS avg_salary
    FROM employees
    GROUP BY department_id
),
company_avg AS (
    SELECT AVG(salary) AS avg_salary FROM employees
)
SELECT 
    ds.department_id,
    ds.avg_salary,
    ca.avg_salary AS company_avg
FROM dept_stats ds
CROSS JOIN company_avg ca;
```

## Common CTE Patterns

### Pattern 1: Breaking Down Complex Queries

```sql
-- Step 1: High-budget departments
WITH high_budget_depts AS (
    SELECT department_id, department_name
    FROM departments
    WHERE budget > 400000
),
-- Step 2: Employees in those departments
dept_employees AS (
    SELECT e.*, hbd.department_name
    FROM employees e
    JOIN high_budget_depts hbd ON e.department_id = hbd.department_id
)
-- Step 3: Final result
SELECT 
    department_name,
    COUNT(*) AS employee_count,
    AVG(salary) AS avg_salary
FROM dept_employees
GROUP BY department_name;
```

### Pattern 2: Reusable Calculations

```sql
-- Calculate department stats once, use multiple times
WITH dept_stats AS (
    SELECT 
        department_id,
        AVG(salary) AS avg_salary,
        COUNT(*) AS emp_count
    FROM employees
    GROUP BY department_id
)
SELECT 
    d.department_name,
    ds.avg_salary,
    ds.emp_count,
    CASE 
        WHEN ds.avg_salary > (SELECT AVG(avg_salary) FROM dept_stats) 
        THEN 'Above Average'
        ELSE 'Below Average'
    END AS salary_status
FROM departments d
JOIN dept_stats ds ON d.department_id = ds.department_id;
```

### Pattern 3: Data Preparation

```sql
-- Clean and prepare data before main query
WITH cleaned_orders AS (
    SELECT 
        order_id,
        customer_id,
        order_date,
        COALESCE(total_amount, 0) AS total_amount
    FROM orders
    WHERE order_date >= '2023-01-01'
),
customer_totals AS (
    SELECT 
        customer_id,
        COUNT(*) AS order_count,
        SUM(total_amount) AS total_spent
    FROM cleaned_orders
    GROUP BY customer_id
)
SELECT 
    c.first_name,
    c.last_name,
    ct.order_count,
    ct.total_spent
FROM customers c
JOIN customer_totals ct ON c.customer_id = ct.customer_id;
```

## Recursive CTEs

Recursive CTEs can reference themselves, useful for hierarchical data (though not covered in detail here, as it's advanced).

### Basic Recursive CTE Structure

```sql
WITH RECURSIVE cte_name AS (
    -- Anchor member (base case)
    SELECT ...
    
    UNION ALL
    
    -- Recursive member (references cte_name)
    SELECT ... FROM cte_name WHERE condition
)
SELECT * FROM cte_name;
```

**Note**: Recursive CTEs are advanced and database-specific. Focus on regular CTEs first.

## CTEs in Different Clauses

### CTE in FROM

```sql
WITH employee_summary AS (
    SELECT department_id, COUNT(*) AS emp_count
    FROM employees
    GROUP BY department_id
)
SELECT * FROM employee_summary;
```

### CTE with JOINs

```sql
WITH high_salary_emps AS (
    SELECT * FROM employees WHERE salary > 80000
)
SELECT 
    e.first_name,
    e.last_name,
    d.department_name
FROM high_salary_emps e
JOIN departments d ON e.department_id = d.department_id;
```

### CTE with Aggregates

```sql
WITH dept_avgs AS (
    SELECT department_id, AVG(salary) AS avg_salary
    FROM employees
    GROUP BY department_id
)
SELECT 
    d.department_name,
    da.avg_salary
FROM departments d
JOIN dept_avgs da ON d.department_id = da.department_id;
```

## Common Pitfalls

### 1. Forgetting the Main Query

```sql
-- ❌ Error: CTE defined but not used
WITH my_cte AS (
    SELECT * FROM employees
);
-- Missing SELECT statement!

-- ✅ Correct: Use the CTE
WITH my_cte AS (
    SELECT * FROM employees
)
SELECT * FROM my_cte;
```

### 2. CTE Scope

CTEs only exist for the single statement that follows:

```sql
-- ❌ Error: CTE doesn't exist here
WITH my_cte AS (SELECT * FROM employees);
SELECT * FROM my_cte;  -- Works

SELECT * FROM my_cte;  -- Error: CTE doesn't exist anymore
```

### 3. Missing Commas

```sql
-- ❌ Error: Missing comma between CTEs
WITH 
    cte1 AS (SELECT ...)
    cte2 AS (SELECT ...)  -- Missing comma!

-- ✅ Correct: Comma between CTEs
WITH 
    cte1 AS (SELECT ...),
    cte2 AS (SELECT ...)
SELECT ...;
```

## Best Practices

1. **Use CTEs for readability**: Break down complex queries
2. **Name CTEs descriptively**: `high_salary_employees` not `temp1`
3. **Test CTEs independently**: Run the CTE query alone first
4. **Use for reusable logic**: When you need the same subquery multiple times
5. **Keep CTEs focused**: Each CTE should have a clear purpose

## When to Use CTEs

### Use CTEs When:
- Query is complex and hard to read
- Same subquery is used multiple times
- You want to break down logic into steps
- Query needs to be more maintainable

### Consider Alternatives When:
- Query is simple (CTE might be overkill)
- Performance is critical (sometimes subqueries are optimized better)
- You need the result set in multiple separate queries (use a view instead)

## Practice Examples

```sql
-- 1. Simple CTE
WITH emp_depts AS (
    SELECT e.first_name, e.last_name, d.department_name
    FROM employees e
    JOIN departments d ON e.department_id = d.department_id
)
SELECT * FROM emp_depts;

-- 2. Multiple CTEs
WITH 
    high_budget AS (
        SELECT * FROM departments WHERE budget > 400000
    ),
    dept_employees AS (
        SELECT e.* FROM employees e
        WHERE e.department_id IN (SELECT department_id FROM high_budget)
    )
SELECT * FROM dept_employees;

-- 3. CTE with aggregates
WITH dept_stats AS (
    SELECT 
        department_id,
        AVG(salary) AS avg_salary,
        COUNT(*) AS emp_count
    FROM employees
    GROUP BY department_id
)
SELECT 
    d.department_name,
    ds.avg_salary,
    ds.emp_count
FROM departments d
JOIN dept_stats ds ON d.department_id = ds.department_id;
```

## Next Steps

In the next lesson, you'll learn about Window Functions, which are powerful for analytical queries.

---

**Key Takeaways:**
- CTEs are temporary named result sets defined with WITH
- CTEs make complex queries more readable
- Multiple CTEs can be defined, separated by commas
- CTEs only exist for the duration of the query
- Use CTEs to break down complex logic into steps
- CTEs can be referenced multiple times in the main query
- Test CTEs independently before using in main query
