# Lesson 6.2: Window Functions

Window functions perform calculations across a set of rows related to the current row, without collapsing rows like GROUP BY does. They're powerful for analytical queries.

## What are Window Functions?

Window functions compute values based on a "window" of rows around the current row. Unlike aggregate functions with GROUP BY, window functions don't collapse rows - they add calculated columns to each row.

### Key Difference: Aggregates vs Window Functions

```sql
-- Aggregate: Collapses rows (one row per group)
SELECT department_id, AVG(salary)
FROM employees
GROUP BY department_id;

-- Window Function: Keeps all rows (adds calculated column)
SELECT 
    first_name,
    last_name,
    salary,
    AVG(salary) OVER (PARTITION BY department_id) AS dept_avg_salary
FROM employees;
```

## Window Function Syntax

```sql
function_name() OVER (
    [PARTITION BY column1, column2, ...]
    [ORDER BY column1 [ASC|DESC], ...]
    [ROWS/RANGE BETWEEN ...]
)
```

### OVER Clause Components

- **PARTITION BY**: Divides rows into groups (like GROUP BY, but doesn't collapse)
- **ORDER BY**: Orders rows within each partition
- **ROWS/RANGE**: Defines the window frame (advanced)

## Ranking Functions

### ROW_NUMBER()

Assigns a unique sequential number to each row within a partition.

```sql
-- Number employees within each department by salary
SELECT 
    first_name,
    last_name,
    salary,
    department_id,
    ROW_NUMBER() OVER (PARTITION BY department_id ORDER BY salary DESC) AS salary_rank
FROM employees;
```

**Result:**
```
first_name | salary | department_id | salary_rank
-----------|-------|---------------|-------------
John       | 75000 | 1             | 1
Michael    | 72000 | 1             | 2
David      | 55000 | 1             | 3
```

### RANK()

Assigns rank with gaps (same values get same rank, next rank is skipped).

```sql
SELECT 
    first_name,
    salary,
    RANK() OVER (ORDER BY salary DESC) AS salary_rank
FROM employees;
```

**If two employees have the same salary:**
- Both get rank 2
- Next employee gets rank 4 (rank 3 is skipped)

### DENSE_RANK()

Assigns rank without gaps (same values get same rank, next rank is consecutive).

```sql
SELECT 
    first_name,
    salary,
    DENSE_RANK() OVER (ORDER BY salary DESC) AS salary_rank
FROM employees;
```

**If two employees have the same salary:**
- Both get rank 2
- Next employee gets rank 3 (no gap)

### Comparison

```sql
-- Salary: 100000, 90000, 90000, 80000
ROW_NUMBER(): 1, 2, 3, 4
RANK():       1, 2, 2, 4      (gaps)
DENSE_RANK(): 1, 2, 2, 3      (no gaps)
```

## Aggregate Window Functions

Use aggregate functions as window functions with OVER:

### AVG() OVER

```sql
-- Each employee's salary vs department average
SELECT 
    first_name,
    last_name,
    salary,
    department_id,
    AVG(salary) OVER (PARTITION BY department_id) AS dept_avg_salary
FROM employees;
```

### SUM() OVER

```sql
-- Running total of salaries
SELECT 
    first_name,
    salary,
    SUM(salary) OVER (ORDER BY employee_id) AS running_total
FROM employees;
```

### COUNT() OVER

```sql
-- Count of employees in each department
SELECT 
    first_name,
    department_id,
    COUNT(*) OVER (PARTITION BY department_id) AS dept_employee_count
FROM employees;
```

## Value Functions

### LAG() and LEAD()

Access values from previous or next rows.

```sql
-- Compare each employee's salary to previous employee's salary
SELECT 
    first_name,
    salary,
    LAG(salary) OVER (ORDER BY salary) AS previous_salary,
    LEAD(salary) OVER (ORDER BY salary) AS next_salary
FROM employees;
```

**LAG(column, offset, default)**: Gets value from previous row
**LEAD(column, offset, default)**: Gets value from next row

### FIRST_VALUE() and LAST_VALUE()

Get first or last value in the window.

```sql
-- First and last salary in each department
SELECT 
    first_name,
    salary,
    department_id,
    FIRST_VALUE(salary) OVER (
        PARTITION BY department_id 
        ORDER BY salary 
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS dept_min_salary,
    LAST_VALUE(salary) OVER (
        PARTITION BY department_id 
        ORDER BY salary 
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS dept_max_salary
FROM employees;
```

## PARTITION BY

PARTITION BY divides rows into groups, similar to GROUP BY but without collapsing:

```sql
-- Average salary per department (but keep all employee rows)
SELECT 
    first_name,
    salary,
    department_id,
    AVG(salary) OVER (PARTITION BY department_id) AS dept_avg
FROM employees;
```

### Multiple PARTITION BY Columns

```sql
-- Average by department and job title
SELECT 
    first_name,
    salary,
    department_id,
    job_title,
    AVG(salary) OVER (PARTITION BY department_id, job_title) AS dept_job_avg
FROM employees;
```

## ORDER BY in Window Functions

ORDER BY determines the order of rows within the window:

```sql
-- Running total ordered by hire date
SELECT 
    first_name,
    hire_date,
    salary,
    SUM(salary) OVER (ORDER BY hire_date) AS running_total
FROM employees;
```

## Common Patterns

### Pattern 1: Top N per Group

```sql
-- Top 3 highest paid employees in each department
WITH ranked_employees AS (
    SELECT 
        first_name,
        last_name,
        salary,
        department_id,
        ROW_NUMBER() OVER (PARTITION BY department_id ORDER BY salary DESC) AS rn
    FROM employees
)
SELECT * FROM ranked_employees WHERE rn <= 3;
```

### Pattern 2: Percentiles

```sql
-- Employees in top 10% by salary
WITH salary_percentiles AS (
    SELECT 
        first_name,
        salary,
        PERCENT_RANK() OVER (ORDER BY salary) AS pct_rank
    FROM employees
)
SELECT * FROM salary_percentiles WHERE pct_rank >= 0.9;
```

### Pattern 3: Moving Averages

```sql
-- 3-month moving average (if we had monthly data)
SELECT 
    sale_date,
    total_amount,
    AVG(total_amount) OVER (
        ORDER BY sale_date 
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS moving_avg_3months
FROM sales;
```

### Pattern 4: Comparing to Group

```sql
-- Each employee compared to department average
SELECT 
    first_name,
    salary,
    department_id,
    AVG(salary) OVER (PARTITION BY department_id) AS dept_avg,
    salary - AVG(salary) OVER (PARTITION BY department_id) AS diff_from_avg
FROM employees;
```

## Window Frame Specification

Defines which rows to include in the window:

```sql
-- Current row and previous 2 rows
ROWS BETWEEN 2 PRECEDING AND CURRENT ROW

-- All previous rows
ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW

-- Current row and next 2 rows
ROWS BETWEEN CURRENT ROW AND 2 FOLLOWING

-- All rows in partition
ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
```

## Common Pitfalls

### 1. Forgetting PARTITION BY

```sql
-- ❌ Calculates overall average, not per department
SELECT 
    first_name,
    AVG(salary) OVER () AS avg_salary
FROM employees;

-- ✅ Correct: Use PARTITION BY for per-group calculation
SELECT 
    first_name,
    AVG(salary) OVER (PARTITION BY department_id) AS dept_avg
FROM employees;
```

### 2. Confusing with GROUP BY

```sql
-- GROUP BY: Collapses to one row per group
SELECT department_id, AVG(salary)
FROM employees
GROUP BY department_id;

-- Window Function: Keeps all rows, adds calculated column
SELECT first_name, department_id, AVG(salary) OVER (PARTITION BY department_id)
FROM employees;
```

### 3. ORDER BY in Window vs Query

```sql
-- ORDER BY in OVER: Affects window calculation
SELECT salary, SUM(salary) OVER (ORDER BY salary) AS running_total
FROM employees;

-- ORDER BY at end: Affects result ordering
SELECT salary FROM employees ORDER BY salary;
```

## Best Practices

1. **Use PARTITION BY**: For per-group calculations
2. **Use ORDER BY in OVER**: For running totals, rankings
3. **Combine with CTEs**: Makes complex window functions readable
4. **Test incrementally**: Start simple, add complexity
5. **Understand the window frame**: Know which rows are included

## Practice Examples

```sql
-- 1. Rank employees by salary
SELECT 
    first_name,
    salary,
    RANK() OVER (ORDER BY salary DESC) AS salary_rank
FROM employees;

-- 2. Department average for each employee
SELECT 
    first_name,
    salary,
    department_id,
    AVG(salary) OVER (PARTITION BY department_id) AS dept_avg
FROM employees;

-- 3. Running total
SELECT 
    first_name,
    salary,
    SUM(salary) OVER (ORDER BY employee_id) AS running_total
FROM employees;
```

## Next Steps

You've mastered advanced querying techniques! Practice with the exercises, then move to Level 7 (Data Modeling).

---

**Key Takeaways:**
- Window functions add calculated columns without collapsing rows
- OVER clause defines the window (PARTITION BY, ORDER BY, frame)
- ROW_NUMBER(), RANK(), DENSE_RANK() for rankings
- Aggregate functions can be window functions with OVER
- LAG() and LEAD() access previous/next row values
- PARTITION BY divides rows into groups (like GROUP BY but doesn't collapse)
- ORDER BY in OVER determines calculation order
- Window functions are powerful for analytical queries
