# Lesson 1.2: SELECT Basics

## The SELECT Statement

The `SELECT` statement is the most fundamental SQL command. It retrieves data from one or more tables in a database.

### Basic Syntax

```sql
SELECT column1, column2, ...
FROM table_name;
```

## Selecting Columns

### Select All Columns

To retrieve all columns from a table, use the asterisk (`*`):

```sql
SELECT *
FROM employees;
```

**Note**: While convenient, `SELECT *` is generally discouraged in production code because:
- It's less efficient (retrieves unnecessary data)
- It's unclear which columns are being used
- Schema changes can break your code unexpectedly

### Select Specific Columns

Specify the exact columns you need:

```sql
SELECT first_name, last_name, email
FROM employees;
```

### Column Order

The order of columns in your SELECT determines the order in the result set:

```sql
-- Returns: first_name, last_name, email
SELECT first_name, last_name, email
FROM employees;

-- Returns: email, first_name, last_name
SELECT email, first_name, last_name
FROM employees;
```

## Using DISTINCT

The `DISTINCT` keyword removes duplicate rows from the result set:

```sql
-- Get all unique job titles
SELECT DISTINCT job_title
FROM employees;
```

**Example Output:**
```
job_title
-----------
Software Engineer
Data Analyst
Marketing Manager
Junior Developer
Senior Engineer
HR Specialist
Sales Manager
Marketing Specialist
```

## The WHERE Clause

The `WHERE` clause filters rows based on specified conditions. It comes after `FROM`:

```sql
SELECT column1, column2
FROM table_name
WHERE condition;
```

### Comparison Operators

| Operator | Description | Example |
|----------|-------------|---------|
| `=` | Equal to | `salary = 75000` |
| `<>` or `!=` | Not equal to | `salary <> 75000` |
| `>` | Greater than | `salary > 70000` |
| `<` | Less than | `salary < 60000` |
| `>=` | Greater than or equal | `salary >= 75000` |
| `<=` | Less than or equal | `salary <= 60000` |

### Examples

```sql
-- Find employees with salary greater than 70000
SELECT first_name, last_name, salary
FROM employees
WHERE salary > 70000;

-- Find employees with a specific job title
SELECT first_name, last_name, job_title
FROM employees
WHERE job_title = 'Software Engineer';

-- Find employees hired after a specific date
SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date > '2020-01-01';
```

## String Comparisons

When comparing strings, SQL is case-sensitive in most databases:

```sql
-- Exact match (case-sensitive)
SELECT * FROM employees
WHERE job_title = 'Software Engineer';

-- This won't match 'Software Engineer'
SELECT * FROM employees
WHERE job_title = 'software engineer';
```

## Common Pitfalls

### 1. Forgetting the FROM Clause

```sql
-- ❌ Error: Missing FROM clause
SELECT first_name, last_name;

-- ✅ Correct
SELECT first_name, last_name
FROM employees;
```

### 2. Incorrect Column Names

```sql
-- ❌ Error: Column doesn't exist
SELECT firstname, lastname
FROM employees;

-- ✅ Correct (check actual column names)
SELECT first_name, last_name
FROM employees;
```

### 3. Using = with NULL

```sql
-- ❌ This won't work as expected
SELECT * FROM employees
WHERE department_id = NULL;

-- ✅ Use IS NULL instead
SELECT * FROM employees
WHERE department_id IS NULL;
```

## Best Practices

1. **Be specific**: Select only the columns you need
2. **Use meaningful names**: Column aliases can make results clearer (we'll cover this later)
3. **Test incrementally**: Start with simple queries, then add complexity
4. **Format consistently**: Use consistent indentation and capitalization

## Practice Examples

Try these queries on the `employees` table:

```sql
-- 1. Get all employee names and emails
SELECT first_name, last_name, email
FROM employees;

-- 2. Find all unique departments
SELECT DISTINCT department_id
FROM employees
WHERE department_id IS NOT NULL;

-- 3. Find employees with salary above 80000
SELECT first_name, last_name, salary
FROM employees
WHERE salary > 80000;
```

## Next Steps

In the next lesson, you'll learn about combining multiple conditions, pattern matching, and sorting results.

---

**Key Takeaways:**
- `SELECT` retrieves data from tables
- Specify columns explicitly rather than using `*`
- `DISTINCT` removes duplicate rows
- `WHERE` filters rows based on conditions
- Use comparison operators to build conditions
