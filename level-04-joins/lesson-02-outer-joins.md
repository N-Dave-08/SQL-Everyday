# Lesson 4.2: LEFT/RIGHT/FULL OUTER JOIN

While INNER JOIN only returns matching rows, OUTER JOINs include rows even when there's no match in the other table.

## Types of OUTER JOINs

1. **LEFT OUTER JOIN** (or LEFT JOIN): Returns all rows from the left table, plus matching rows from the right table
2. **RIGHT OUTER JOIN** (or RIGHT JOIN): Returns all rows from the right table, plus matching rows from the left table
3. **FULL OUTER JOIN** (or FULL JOIN): Returns all rows from both tables

## LEFT JOIN

`LEFT JOIN` returns all rows from the left table, and matching rows from the right table. If there's no match, NULL values are returned for right table columns.

### LEFT JOIN Syntax

```sql
SELECT columns
FROM table1
LEFT JOIN table2
ON table1.column = table2.column;
```

### Example: Employees with Departments

```sql
-- All employees, even if they don't have a department
SELECT 
    e.first_name,
    e.last_name,
    d.department_name
FROM employees e
LEFT JOIN departments d
ON e.department_id = d.department_id;
```

**Result:**
- Employees with departments: Shows employee name and department name
- Employees without departments: Shows employee name and NULL for department

### When to Use LEFT JOIN

Use LEFT JOIN when you want:
- All rows from the left table
- Matching data from the right table (if it exists)
- To find rows in the left table that don't have matches

### Finding Non-Matching Rows

A common use of LEFT JOIN is finding rows that don't have matches:

```sql
-- Employees without a department assignment
SELECT 
    e.first_name,
    e.last_name,
    e.department_id
FROM employees e
LEFT JOIN departments d
ON e.department_id = d.department_id
WHERE d.department_id IS NULL;
```

**How it works:**
1. LEFT JOIN includes all employees
2. Employees without departments get NULL in `d.department_id`
3. WHERE filters for NULL values
4. Result: Only employees without departments

## RIGHT JOIN

`RIGHT JOIN` returns all rows from the right table, and matching rows from the left table. If there's no match, NULL values are returned for left table columns.

### RIGHT JOIN Syntax

```sql
SELECT columns
FROM table1
RIGHT JOIN table2
ON table1.column = table2.column;
```

### Example: Departments with Employees

```sql
-- All departments, even if they have no employees
SELECT 
    d.department_name,
    e.first_name,
    e.last_name
FROM employees e
RIGHT JOIN departments d
ON e.department_id = d.department_id;
```

**Result:**
- Departments with employees: Shows department and employee names
- Departments without employees: Shows department name and NULL for employee names

### Finding Non-Matching Rows with RIGHT JOIN

```sql
-- Departments with no employees
SELECT 
    d.department_name
FROM employees e
RIGHT JOIN departments d
ON e.department_id = d.department_id
WHERE e.employee_id IS NULL;
```

## LEFT JOIN vs RIGHT JOIN

LEFT JOIN and RIGHT JOIN are essentially the same - just reversed:

```sql
-- These are equivalent:
SELECT * FROM employees e
LEFT JOIN departments d ON e.department_id = d.department_id;

SELECT * FROM departments d
RIGHT JOIN employees e ON d.department_id = e.department_id;
```

**Best Practice**: Use LEFT JOIN consistently (it's more common and easier to read). You can always rearrange tables to use LEFT JOIN instead of RIGHT JOIN.

## FULL OUTER JOIN

`FULL OUTER JOIN` returns all rows from both tables. If there's no match, NULL values are returned for the missing side.

### FULL OUTER JOIN Syntax

```sql
SELECT columns
FROM table1
FULL OUTER JOIN table2
ON table1.column = table2.column;
```

### Example

```sql
-- All employees and all departments
SELECT 
    e.first_name,
    e.last_name,
    d.department_name
FROM employees e
FULL OUTER JOIN departments d
ON e.department_id = d.department_id;
```

**Result includes:**
- Employees with departments (matched rows)
- Employees without departments (NULL for department)
- Departments without employees (NULL for employee)

**Note**: FULL OUTER JOIN is not supported in MySQL. Use LEFT JOIN + RIGHT JOIN with UNION instead.

## Visualizing OUTER JOINs

### LEFT JOIN
```
Left Table     Right Table    Result (LEFT JOIN)
-----------    -----------    -------------------
A1 | B1        B1 | X         A1 | B1 | X
A2 | B2        B2 | Y         A2 | B2 | Y
A3 | B3        B3 | Z         A3 | B3 | Z
A4 | B4        B5 | W         A4 | B4 | NULL
                              (B5 excluded - not in left table)
```

### RIGHT JOIN
```
Left Table     Right Table    Result (RIGHT JOIN)
-----------    -----------    -------------------
A1 | B1        B1 | X         A1 | B1 | X
A2 | B2        B2 | Y         A2 | B2 | Y
A3 | B3        B3 | Z         A3 | B3 | Z
A4 | B4        B5 | W         NULL | B5 | W
                              (A4 excluded - not in right table)
```

### FULL OUTER JOIN
```
Left Table     Right Table    Result (FULL OUTER JOIN)
-----------    -----------    -------------------------
A1 | B1        B1 | X         A1 | B1 | X
A2 | B2        B2 | Y         A2 | B2 | Y
A3 | B3        B3 | Z         A3 | B3 | Z
A4 | B4        B5 | W         A4 | B4 | NULL
                              NULL | B5 | W
```

## Common Use Cases

### Finding Missing Relationships

```sql
-- Products that have never been ordered
SELECT p.product_name
FROM products p
LEFT JOIN order_items oi
ON p.product_id = oi.product_id
WHERE oi.product_id IS NULL;
```

### Including Optional Data

```sql
-- All customers with their orders (including customers with no orders)
SELECT 
    c.first_name,
    c.last_name,
    o.order_id,
    o.order_date
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id;
```

### Complete Data View

```sql
-- All departments with employee counts (including departments with 0 employees)
SELECT 
    d.department_name,
    COUNT(e.employee_id) AS employee_count
FROM departments d
LEFT JOIN employees e
ON d.department_id = e.department_id
GROUP BY d.department_name;
```

## Handling NULL Values

When using OUTER JOINs, you'll get NULL values for non-matching rows. Handle them appropriately:

```sql
-- Use COALESCE to provide default values
SELECT 
    e.first_name,
    e.last_name,
    COALESCE(d.department_name, 'No Department') AS department
FROM employees e
LEFT JOIN departments d
ON e.department_id = d.department_id;
```

## Common Pitfalls

### 1. Filtering Too Early

```sql
-- ❌ Wrong: Filters out NULLs before the join completes
SELECT e.first_name, d.department_name
FROM employees e
LEFT JOIN departments d
ON e.department_id = d.department_id
WHERE d.department_name = 'Engineering';  -- This acts like INNER JOIN!

-- ✅ Correct: Use WHERE after LEFT JOIN, or use subquery
SELECT e.first_name, d.department_name
FROM employees e
LEFT JOIN departments d
ON e.department_id = d.department_id
WHERE d.department_name = 'Engineering' OR d.department_name IS NULL;
```

### 2. Confusing LEFT and RIGHT

Remember: LEFT JOIN keeps all rows from the **left** table. The table order matters!

```sql
-- Different results:
SELECT * FROM employees e LEFT JOIN departments d ON ...
SELECT * FROM departments d LEFT JOIN employees e ON ...
```

### 3. Using WHERE Instead of ON

```sql
-- ❌ Wrong: This creates a CROSS JOIN, then filters
SELECT * FROM employees e
LEFT JOIN departments d
WHERE e.department_id = d.department_id;

-- ✅ Correct: Use ON for join condition
SELECT * FROM employees e
LEFT JOIN departments d
ON e.department_id = d.department_id;
```

## Best Practices

1. **Prefer LEFT JOIN**: More common and readable than RIGHT JOIN
2. **Use ON for join conditions**: Keep WHERE for filtering
3. **Handle NULLs**: Be aware that OUTER JOINs produce NULL values
4. **Test with small data**: Understand the results before scaling up
5. **Use meaningful aliases**: Makes complex joins easier to read

## Practice Examples

```sql
-- 1. All employees with department (or NULL)
SELECT e.first_name, e.last_name, d.department_name
FROM employees e
LEFT JOIN departments d
ON e.department_id = d.department_id;

-- 2. Employees without departments
SELECT e.first_name, e.last_name
FROM employees e
LEFT JOIN departments d
ON e.department_id = d.department_id
WHERE d.department_id IS NULL;

-- 3. All departments with employee counts
SELECT 
    d.department_name,
    COUNT(e.employee_id) AS employee_count
FROM departments d
LEFT JOIN employees e
ON d.department_id = e.department_id
GROUP BY d.department_name;
```

## Next Steps

In the next lesson, you'll learn about self joins and chaining multiple joins together.

---

**Key Takeaways:**
- LEFT JOIN returns all rows from left table + matches from right
- RIGHT JOIN returns all rows from right table + matches from left
- FULL OUTER JOIN returns all rows from both tables
- OUTER JOINs produce NULL values for non-matching rows
- Use LEFT JOIN to find rows without matches (WHERE right_table.column IS NULL)
- Prefer LEFT JOIN over RIGHT JOIN for consistency
- Use ON for join conditions, WHERE for filtering
