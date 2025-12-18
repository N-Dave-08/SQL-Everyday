# Lesson 4.3: Self Joins and Multiple Joins

This lesson covers advanced join patterns: joining a table to itself and chaining multiple joins together.

## Self Joins

A **self join** is when you join a table to itself. This is useful when data in a table relates to other data in the same table.

### Common Use Cases

- Employee hierarchies (employees and their managers)
- Product categories and subcategories
- Organizational structures
- Any parent-child relationships within the same table

### Self Join Syntax

You must use table aliases to distinguish between the two instances of the same table:

```sql
SELECT columns
FROM table_name alias1
JOIN table_name alias2
ON alias1.column = alias2.column;
```

### Example: Employee-Manager Relationship

If the employees table has a `manager_id` column that references another employee:

```sql
-- Employees with their managers
SELECT 
    e.first_name AS employee_name,
    e.last_name AS employee_lastname,
    m.first_name AS manager_name,
    m.last_name AS manager_lastname
FROM employees e
INNER JOIN employees m
ON e.manager_id = m.employee_id;
```

**How it works:**
- `e` represents the employee
- `m` represents the manager
- Join condition: employee's manager_id = manager's employee_id

### Finding Employees Without Managers

```sql
-- Employees who don't have a manager (top-level employees)
SELECT 
    e.first_name,
    e.last_name
FROM employees e
LEFT JOIN employees m
ON e.manager_id = m.employee_id
WHERE m.employee_id IS NULL;
```

### Self Join with Different Join Types

```sql
-- All employees, showing manager if they have one
SELECT 
    e.first_name AS employee,
    m.first_name AS manager
FROM employees e
LEFT JOIN employees m
ON e.manager_id = m.employee_id;
```

## Multiple Joins

You can join multiple tables in a single query. The key is understanding the relationships and join order.

### Basic Multiple Join Pattern

```sql
SELECT columns
FROM table1 t1
JOIN table2 t2 ON t1.column = t2.column
JOIN table3 t3 ON t2.column = t3.column;
```

### Example: Order Details with Customer and Product

```sql
-- Complete order information
SELECT 
    o.order_id,
    o.order_date,
    c.first_name AS customer_first_name,
    c.last_name AS customer_last_name,
    p.product_name,
    oi.quantity,
    oi.unit_price,
    (oi.quantity * oi.unit_price) AS line_total
FROM orders o
INNER JOIN customers c
ON o.customer_id = c.customer_id
INNER JOIN order_items oi
ON o.order_id = oi.order_id
INNER JOIN products p
ON oi.product_id = p.product_id;
```

**Join chain:**
1. `orders` → `customers` (get customer info)
2. `orders` → `order_items` (get order line items)
3. `order_items` → `products` (get product details)

### Mixing Join Types

You can mix INNER and OUTER joins:

```sql
-- All customers with their orders and products
-- (including customers with no orders)
SELECT 
    c.first_name,
    c.last_name,
    o.order_id,
    p.product_name
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id
LEFT JOIN order_items oi
ON o.order_id = oi.order_id
LEFT JOIN products p
ON oi.product_id = p.product_id;
```

### Complex Multiple Join Example

```sql
-- Employees with department, manager, and department budget
SELECT 
    e.first_name AS employee_name,
    e.last_name AS employee_lastname,
    d.department_name,
    d.budget AS department_budget,
    m.first_name AS manager_name,
    m.last_name AS manager_lastname
FROM employees e
INNER JOIN departments d
ON e.department_id = d.department_id
LEFT JOIN employees m
ON e.manager_id = m.employee_id;
```

## Join Order and Performance

### Logical Order

SQL processes joins in the order you write them (though the optimizer may reorder for performance):

```sql
-- Join order: orders → customers → order_items → products
SELECT ...
FROM orders o
JOIN customers c ON ...
JOIN order_items oi ON ...
JOIN products p ON ...;
```

### Performance Considerations

- Start with the most selective table (fewest rows)
- Join smaller tables first when possible
- Use INNER JOIN when possible (faster than OUTER JOIN)
- Add indexes on join columns for better performance

## Common Patterns

### Pattern 1: Bridge Tables

When two tables are related through a third "bridge" or "junction" table:

```sql
-- Products and Customers through Orders
SELECT 
    c.first_name,
    c.last_name,
    p.product_name
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id;
```

### Pattern 2: Hierarchical Data

Self joins for parent-child relationships:

```sql
-- Categories and subcategories (if categories table has parent_id)
SELECT 
    parent.category_name AS parent_category,
    child.category_name AS subcategory
FROM categories parent
LEFT JOIN categories child
ON child.parent_id = parent.category_id;
```

### Pattern 3: Aggregating Across Joins

```sql
-- Total sales by customer
SELECT 
    c.first_name,
    c.last_name,
    COUNT(o.order_id) AS total_orders,
    SUM(o.total_amount) AS total_spent
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name;
```

## Common Pitfalls

### 1. Incorrect Join Conditions

```sql
-- ❌ Wrong: Joining on unrelated columns
SELECT ...
FROM orders o
JOIN customers c ON o.order_id = c.customer_id;  -- Wrong!

-- ✅ Correct: Join on related columns
SELECT ...
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id;
```

### 2. Missing Join Conditions

```sql
-- ❌ Wrong: Missing join condition creates CROSS JOIN
SELECT ...
FROM orders o
JOIN customers c;  -- No ON clause!

-- ✅ Correct: Always include ON clause
SELECT ...
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id;
```

### 3. Ambiguous Column References

```sql
-- ❌ Error: Which table's name column?
SELECT name
FROM table1 t1
JOIN table2 t2 ON t1.id = t2.id;

-- ✅ Correct: Specify table
SELECT t1.name
FROM table1 t1
JOIN table2 t2 ON t1.id = t2.id;
```

### 4. Wrong Join Type

```sql
-- ❌ If you want all customers, but use INNER JOIN
SELECT c.first_name, o.order_id
FROM customers c
INNER JOIN orders o ON c.customer_id = o.customer_id;
-- This excludes customers with no orders

-- ✅ Use LEFT JOIN to include all customers
SELECT c.first_name, o.order_id
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id;
```

## Best Practices

1. **Use clear aliases**: `e` for employees, `m` for managers, `c` for customers
2. **Join in logical order**: Follow the data relationships
3. **Test incrementally**: Add one join at a time
4. **Use appropriate join types**: INNER when you need matches, LEFT when you need all from left table
5. **Document complex joins**: Add comments for complicated relationships

## Practice Examples

```sql
-- 1. Self join: Employees and managers
SELECT 
    e.first_name AS employee,
    m.first_name AS manager
FROM employees e
LEFT JOIN employees m
ON e.manager_id = m.employee_id;

-- 2. Multiple joins: Complete order details
SELECT 
    o.order_id,
    c.first_name,
    p.product_name,
    oi.quantity
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id;

-- 3. Complex: Employees with department and manager
SELECT 
    e.first_name,
    d.department_name,
    m.first_name AS manager_name
FROM employees e
JOIN departments d ON e.department_id = d.department_id
LEFT JOIN employees m ON e.manager_id = m.employee_id;
```

## Next Steps

You've now mastered all types of joins! Practice with the exercises to solidify your understanding before moving to Level 5 (Subqueries).

---

**Key Takeaways:**
- Self joins join a table to itself (use aliases!)
- Multiple joins chain tables together
- Join order matters logically (optimizer may reorder)
- Mix INNER and OUTER joins as needed
- Use clear aliases for readability
- Test joins incrementally
- Understand the relationships between tables
