# Lesson 1.3: Filtering and Sorting

## Multiple Conditions with AND, OR, NOT

You can combine multiple conditions using logical operators.

### AND Operator

`AND` requires **all** conditions to be true:

```sql
SELECT first_name, last_name, salary, job_title
FROM employees
WHERE salary > 70000 AND job_title = 'Software Engineer';
```

**Result**: Employees who are Software Engineers **AND** have salary > 70000

### OR Operator

`OR` requires **at least one** condition to be true:

```sql
SELECT first_name, last_name, salary, job_title
FROM employees
WHERE job_title = 'Data Analyst' OR job_title = 'Marketing Manager';
```

**Result**: Employees who are Data Analysts **OR** Marketing Managers

### Combining AND and OR

Use parentheses to control the order of evaluation:

```sql
-- Find Software Engineers with salary > 70000 OR Data Analysts
SELECT first_name, last_name, salary, job_title
FROM employees
WHERE (job_title = 'Software Engineer' AND salary > 70000)
   OR job_title = 'Data Analyst';
```

**Without parentheses** (different meaning):
```sql
-- This means: (Software Engineer) OR (Data Analyst AND salary > 70000)
SELECT first_name, last_name, salary, job_title
FROM employees
WHERE job_title = 'Software Engineer' 
   OR (job_title = 'Data Analyst' AND salary > 70000);
```

### NOT Operator

`NOT` negates a condition:

```sql
-- Employees who are NOT Software Engineers
SELECT first_name, last_name, job_title
FROM employees
WHERE NOT job_title = 'Software Engineer';

-- Alternative (more common):
SELECT first_name, last_name, job_title
FROM employees
WHERE job_title <> 'Software Engineer';
```

## The IN Operator

`IN` checks if a value matches any value in a list:

```sql
-- Find employees with specific job titles
SELECT first_name, last_name, job_title
FROM employees
WHERE job_title IN ('Software Engineer', 'Data Analyst', 'Senior Engineer');
```

**Equivalent to:**
```sql
SELECT first_name, last_name, job_title
FROM employees
WHERE job_title = 'Software Engineer'
   OR job_title = 'Data Analyst'
   OR job_title = 'Senior Engineer';
```

**Using NOT IN:**
```sql
-- Employees who are NOT in these departments
SELECT first_name, last_name, department_id
FROM employees
WHERE department_id NOT IN (1, 2);
```

## The BETWEEN Operator

`BETWEEN` checks if a value falls within a range (inclusive):

```sql
-- Employees with salary between 60000 and 80000
SELECT first_name, last_name, salary
FROM employees
WHERE salary BETWEEN 60000 AND 80000;
```

**Equivalent to:**
```sql
SELECT first_name, last_name, salary
FROM employees
WHERE salary >= 60000 AND salary <= 80000;
```

**BETWEEN with dates:**
```sql
-- Employees hired in 2020
SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date BETWEEN '2020-01-01' AND '2020-12-31';
```

## The LIKE Operator

`LIKE` is used for pattern matching with strings. It uses wildcards:

- `%` - Matches any sequence of characters (including zero characters)
- `_` - Matches exactly one character

### Examples

```sql
-- Names starting with 'J'
SELECT first_name, last_name
FROM employees
WHERE first_name LIKE 'J%';
-- Matches: John, James, Jessica, Jennifer

-- Names ending with 'son'
SELECT first_name, last_name
FROM employees
WHERE last_name LIKE '%son';
-- Matches: Johnson, Wilson, etc.

-- Names containing 'mi'
SELECT first_name, last_name
FROM employees
WHERE first_name LIKE '%mi%';
-- Matches: Michael, Emily, etc.

-- Names with exactly 5 characters
SELECT first_name
FROM employees
WHERE first_name LIKE '_____';
-- Matches: David, James, etc. (5 underscores = 5 characters)
```

### Case Sensitivity

`LIKE` is case-sensitive in most databases:

```sql
-- Matches 'John' but not 'john'
SELECT * FROM employees
WHERE first_name LIKE 'J%';
```

## NULL Handling

`NULL` represents missing or unknown data. Special operators are needed:

### IS NULL

```sql
-- Employees without a department
SELECT first_name, last_name, department_id
FROM employees
WHERE department_id IS NULL;
```

### IS NOT NULL

```sql
-- Employees with a department assigned
SELECT first_name, last_name, department_id
FROM employees
WHERE department_id IS NOT NULL;
```

**Important**: `NULL = NULL` is not true! Always use `IS NULL` or `IS NOT NULL`.

## ORDER BY - Sorting Results

`ORDER BY` sorts the result set by one or more columns:

### Basic Sorting

```sql
-- Sort by salary (ascending - default)
SELECT first_name, last_name, salary
FROM employees
ORDER BY salary;

-- Sort by salary (descending)
SELECT first_name, last_name, salary
FROM employees
ORDER BY salary DESC;
```

### Sorting by Multiple Columns

```sql
-- Sort by department, then by salary within each department
SELECT first_name, last_name, department_id, salary
FROM employees
ORDER BY department_id, salary DESC;
```

### Sorting by Column Position

You can reference columns by their position in the SELECT list:

```sql
-- Sort by the 3rd column (salary)
SELECT first_name, last_name, salary
FROM employees
ORDER BY 3 DESC;
```

**Note**: Using column names is more readable and maintainable.

## LIMIT - Restricting Results

`LIMIT` restricts the number of rows returned:

### PostgreSQL

```sql
-- Get top 5 highest paid employees
SELECT first_name, last_name, salary
FROM employees
ORDER BY salary DESC
LIMIT 5;
```

### SQL Server (uses TOP)

```sql
SELECT TOP 5 first_name, last_name, salary
FROM employees
ORDER BY salary DESC;
```

## Combining Clauses

The order of SQL clauses matters:

```sql
SELECT column1, column2
FROM table_name
WHERE condition
ORDER BY column1
LIMIT 10;
```

**Correct order:**
1. SELECT
2. FROM
3. WHERE
4. ORDER BY
5. LIMIT

## Common Patterns

### Top N Records

```sql
-- Top 3 highest salaries
SELECT first_name, last_name, salary
FROM employees
ORDER BY salary DESC
LIMIT 3;
```

### Filtering and Sorting

```sql
-- Software Engineers, sorted by hire date (newest first)
SELECT first_name, last_name, hire_date
FROM employees
WHERE job_title = 'Software Engineer'
ORDER BY hire_date DESC;
```

### Pattern Matching

```sql
-- Employees with email addresses from a specific domain
SELECT first_name, last_name, email
FROM employees
WHERE email LIKE '%@company.com';
```

## Best Practices

1. **Use parentheses** with multiple AND/OR conditions for clarity
2. **Prefer IN** over multiple OR conditions when possible
3. **Use BETWEEN** for range checks (more readable)
4. **Always sort** when order matters (don't rely on default order)
5. **Use LIMIT** when you only need a subset of results

## Next Steps

You've now learned the fundamentals of querying data! Practice with the exercises to reinforce these concepts before moving to Level 2.

---

**Key Takeaways:**
- Use `AND`, `OR`, `NOT` to combine conditions
- `IN` checks membership in a list
- `BETWEEN` checks ranges (inclusive)
- `LIKE` performs pattern matching with `%` and `_`
- Use `IS NULL` / `IS NOT NULL` for NULL checks
- `ORDER BY` sorts results (ASC/DESC)
- `LIMIT` restricts the number of rows returned
