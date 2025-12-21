# Lesson 5.2: EXISTS and IN with Subqueries

This lesson covers the `EXISTS` operator and advanced uses of `IN` with subqueries, including performance considerations.

## EXISTS Operator

`EXISTS` checks whether a subquery returns any rows. It returns TRUE if at least one row exists, FALSE otherwise.

### EXISTS Syntax

```sql
SELECT columns
FROM table1
WHERE EXISTS (SELECT 1 FROM table2 WHERE condition);
```

**Key Points:**
- EXISTS returns TRUE/FALSE, not data
- The SELECT list in EXISTS doesn't matter (often `SELECT 1`)
- EXISTS stops as soon as it finds one matching row (efficient!)

### Basic EXISTS Example

```sql
-- Customers who have placed orders
SELECT first_name, last_name
FROM customers c
WHERE EXISTS (
    SELECT 1 
    FROM orders o 
    WHERE o.customer_id = c.customer_id
);
```

**How it works:**
1. For each customer, check if any orders exist
2. If at least one order exists, include the customer
3. More efficient than JOIN when you only need to check existence

### NOT EXISTS

```sql
-- Customers who have never placed an order
SELECT first_name, last_name
FROM customers c
WHERE NOT EXISTS (
    SELECT 1 
    FROM orders o 
    WHERE o.customer_id = c.customer_id
);
```

## EXISTS vs IN

Both can achieve similar results, but they work differently:

### Using IN

```sql
-- Products that have been ordered
SELECT product_name
FROM products
WHERE product_id IN (
    SELECT DISTINCT product_id 
    FROM order_items
);
```

### Using EXISTS

```sql
-- Same result using EXISTS
SELECT product_name
FROM products p
WHERE EXISTS (
    SELECT 1 
    FROM order_items oi 
    WHERE oi.product_id = p.product_id
);
```

### Key Differences

| Aspect | IN | EXISTS |
|--------|----|----|
| **Returns** | List of values | TRUE/FALSE |
| **NULL handling** | `NOT IN` with NULLs returns no rows | `NOT EXISTS` handles NULLs correctly |
| **Performance** | Can be slow with large lists | Stops at first match (often faster) |
| **Subquery** | Must return one column | Can return any columns (ignored) |

## When to Use EXISTS vs IN

### Use EXISTS When:
- Checking for existence (don't need the actual values)
- Dealing with NULL values (NOT EXISTS handles NULLs better)
- Performance matters (EXISTS can be faster)
- The subquery might return NULLs

### Use IN When:
- You have a small, known list of values
- You need the actual values for comparison
- The list is static or comes from a simple subquery

## NULL Handling: NOT IN vs NOT EXISTS

### The NULL Problem with NOT IN

```sql
-- ⚠️ Problem: If subquery returns NULL, NOT IN returns no rows
SELECT product_name
FROM products
WHERE product_id NOT IN (
    SELECT product_id FROM order_items
    -- If this returns NULL, NOT IN fails!
);
```

**Why it fails:**
- `NOT IN` with NULL means "not equal to any value, including NULL"
- SQL's three-valued logic: `value NOT IN (NULL, 1, 2)` evaluates to UNKNOWN, not TRUE
- UNKNOWN in WHERE clause means the row is excluded

### Solution: Use NOT EXISTS

```sql
-- ✅ Correct: NOT EXISTS handles NULLs properly
SELECT product_name
FROM products p
WHERE NOT EXISTS (
    SELECT 1 
    FROM order_items oi 
    WHERE oi.product_id = p.product_id
);
```

## Advanced EXISTS Patterns

### Pattern 1: Correlated EXISTS

```sql
-- Employees who have made sales (if sales table had employee_id)
SELECT e.first_name, e.last_name
FROM employees e
WHERE EXISTS (
    SELECT 1 
    FROM sales s 
    WHERE s.employee_id = e.employee_id
);
```

### Pattern 2: Multiple Conditions in EXISTS

```sql
-- Customers who ordered specific products
SELECT c.first_name, c.last_name
FROM customers c
WHERE EXISTS (
    SELECT 1 
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    WHERE o.customer_id = c.customer_id
    AND oi.product_id = 1  -- Specific product
);
```

### Pattern 3: EXISTS with Aggregates

```sql
-- Departments with more than 3 employees
SELECT department_name
FROM departments d
WHERE EXISTS (
    SELECT 1 
    FROM employees e 
    WHERE e.department_id = d.department_id
    GROUP BY e.department_id
    HAVING COUNT(*) > 3
);
```

## ANY and ALL Operators

### ANY Operator

`ANY` returns TRUE if the comparison is true for **any** value returned by the subquery.

```sql
-- Employees with salary greater than any salary in department 2
SELECT first_name, last_name, salary
FROM employees
WHERE salary > ANY (
    SELECT salary 
    FROM employees 
    WHERE department_id = 2
);
-- Equivalent to: salary > MIN(salary from dept 2)
```

### ALL Operator

`ALL` returns TRUE if the comparison is true for **all** values returned by the subquery.

```sql
-- Employees with salary greater than all salaries in department 2
SELECT first_name, last_name, salary
FROM employees
WHERE salary > ALL (
    SELECT salary 
    FROM employees 
    WHERE department_id = 2
);
-- Equivalent to: salary > MAX(salary from dept 2)
```

### ANY/ALL vs EXISTS/IN

- `IN` is equivalent to `= ANY`
- `EXISTS` checks for existence, `ANY/ALL` compare values
- `ANY/ALL` require the subquery to return one column

## Performance Considerations

### EXISTS Performance

```sql
-- Fast: EXISTS stops at first match
SELECT * FROM customers c
WHERE EXISTS (
    SELECT 1 FROM orders o 
    WHERE o.customer_id = c.customer_id
);
```

### IN Performance

```sql
-- May be slower: Must evaluate entire subquery first
SELECT * FROM customers
WHERE customer_id IN (
    SELECT customer_id FROM orders
);
```

**Note**: Modern query optimizers often convert IN to EXISTS automatically, but it's good to be explicit.

## Common Patterns

### Pattern 1: Finding Related Records

```sql
-- Products that have been ordered
SELECT product_name
FROM products p
WHERE EXISTS (
    SELECT 1 FROM order_items oi 
    WHERE oi.product_id = p.product_id
);
```

### Pattern 2: Finding Unrelated Records

```sql
-- Products never ordered
SELECT product_name
FROM products p
WHERE NOT EXISTS (
    SELECT 1 FROM order_items oi 
    WHERE oi.product_id = p.product_id
);
```

### Pattern 3: Complex Conditions

```sql
-- Customers who ordered in the last 30 days
SELECT first_name, last_name
FROM customers c
WHERE EXISTS (
    SELECT 1 FROM orders o
    WHERE o.customer_id = c.customer_id
    AND o.order_date >= CURRENT_DATE - INTERVAL '30 days'  -- PostgreSQL syntax
);
```

## Best Practices

1. **Use EXISTS for existence checks**: More semantic and often faster
2. **Use NOT EXISTS instead of NOT IN**: Handles NULLs correctly
3. **Use IN for small, known lists**: Simpler and clearer
4. **Test subqueries independently**: Verify they return expected results
5. **Consider performance**: EXISTS can be faster for large datasets
6. **Be explicit**: Use EXISTS when checking existence, IN when comparing values

## Common Pitfalls

### 1. Using IN with NULLs

```sql
-- ❌ Problem: If subquery returns NULL, NOT IN fails
SELECT * FROM table1
WHERE id NOT IN (SELECT id FROM table2 WHERE condition);
-- If table2 returns NULL, this returns no rows

-- ✅ Solution: Use NOT EXISTS
SELECT * FROM table1 t1
WHERE NOT EXISTS (SELECT 1 FROM table2 t2 WHERE t2.id = t1.id);
```

### 2. Confusing EXISTS with IN

```sql
-- EXISTS checks existence (returns TRUE/FALSE)
WHERE EXISTS (SELECT 1 FROM ...)

-- IN compares values (returns matching values)
WHERE column IN (SELECT column FROM ...)
```

### 3. Unnecessary DISTINCT in EXISTS

```sql
-- ❌ Unnecessary: EXISTS doesn't care about duplicates
WHERE EXISTS (SELECT DISTINCT column FROM ...)

-- ✅ Correct: DISTINCT not needed
WHERE EXISTS (SELECT 1 FROM ...)
```

## Practice Examples

```sql
-- 1. Customers with orders
SELECT first_name, last_name
FROM customers c
WHERE EXISTS (
    SELECT 1 FROM orders o 
    WHERE o.customer_id = c.customer_id
);

-- 2. Products never ordered
SELECT product_name
FROM products p
WHERE NOT EXISTS (
    SELECT 1 FROM order_items oi 
    WHERE oi.product_id = p.product_id
);

-- 3. Employees in high-budget departments
SELECT first_name, last_name
FROM employees e
WHERE EXISTS (
    SELECT 1 FROM departments d
    WHERE d.department_id = e.department_id
    AND d.budget > 400000
);
```

## Next Steps

You've mastered subqueries! Practice with the exercises, then move to Level 6 (Advanced Queries: CTEs and Window Functions).

---

**Key Takeaways:**
- EXISTS checks if subquery returns any rows (returns TRUE/FALSE)
- NOT EXISTS is safer than NOT IN when dealing with NULLs
- EXISTS stops at first match (often faster than IN)
- IN compares values, EXISTS checks existence
- ANY/ALL compare against all values in subquery
- Use EXISTS for existence checks, IN for value comparisons
- Test subqueries independently before using in outer query
