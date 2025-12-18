# Lesson 7.1: Normalization

Normalization is the process of organizing data in a database to reduce redundancy and improve data integrity. It involves dividing large tables into smaller, related tables.

## What is Normalization?

Normalization eliminates data redundancy and ensures data consistency by organizing data into related tables. There are several "normal forms" (1NF, 2NF, 3NF, etc.), each with increasing levels of normalization.

## Why Normalize?

### Problems with Unnormalized Data

**Example of Bad Design:**
```
orders table:
order_id | customer_name | customer_email | product_name | product_price | quantity
---------|---------------|----------------|--------------|---------------|----------
1        | Alice         | alice@email.com| Laptop       | 1299.99       | 1
1        | Alice         | alice@email.com| Mouse        | 29.99         | 2
2        | Bob           | bob@email.com  | Laptop       | 1299.99       | 1
```

**Problems:**
- Data redundancy (customer info repeated)
- Update anomalies (change email in multiple places)
- Insert anomalies (can't add customer without order)
- Delete anomalies (delete order might lose customer data)

### Benefits of Normalization

- **Reduces redundancy**: Data stored once
- **Improves integrity**: Changes made in one place
- **Saves storage**: Less duplicate data
- **Easier maintenance**: Update once, affects all references

## First Normal Form (1NF)

A table is in 1NF if:
1. Each column contains atomic (indivisible) values
2. Each row is unique
3. No repeating groups

### Example: Violating 1NF

```
employees:
employee_id | name      | skills
------------|-----------|------------------
1           | John      | SQL, Python, Java
2           | Sarah     | Python, R
```

**Problem**: `skills` column contains multiple values (not atomic)

### Fix: 1NF Compliant

```
employees:
employee_id | name
------------|-------
1           | John
2           | Sarah

employee_skills:
employee_id | skill
------------|-------
1           | SQL
1           | Python
1           | Java
2           | Python
2           | R
```

## Second Normal Form (2NF)

A table is in 2NF if:
1. It's in 1NF
2. All non-key columns depend on the entire primary key (not just part of it)

### Example: Violating 2NF

```
order_items:
order_id | product_id | product_name | quantity | unit_price
---------|------------|--------------|----------|------------
1        | 101        | Laptop       | 1        | 1299.99
1        | 102        | Mouse        | 2        | 29.99
```

**Problem**: `product_name` depends only on `product_id`, not the full key (order_id, product_id)

### Fix: 2NF Compliant

```
order_items:
order_id | product_id | quantity | unit_price
---------|------------|----------|------------
1        | 101        | 1        | 1299.99
1        | 102        | 2        | 29.99

products:
product_id | product_name
-----------|-------------
101        | Laptop
102        | Mouse
```

## Third Normal Form (3NF)

A table is in 3NF if:
1. It's in 2NF
2. No transitive dependencies (non-key columns don't depend on other non-key columns)

### Example: Violating 3NF

```
employees:
employee_id | name    | department_id | department_name | department_location
------------|--------|---------------|-----------------|--------------------
1           | John    | 1             | Engineering     | Building A
2           | Sarah   | 1             | Engineering     | Building A
3           | Bob     | 2             | Sales           | Building B
```

**Problem**: `department_name` and `department_location` depend on `department_id`, not directly on `employee_id`

### Fix: 3NF Compliant

```
employees:
employee_id | name    | department_id
------------|--------|---------------
1           | John    | 1
2           | Sarah   | 1
3           | Bob     | 2

departments:
department_id | department_name | department_location
--------------|-----------------|--------------------
1             | Engineering     | Building A
2             | Sales           | Building B
```

## Normalization Summary

| Normal Form | Requirement |
|-------------|-------------|
| **1NF** | Atomic values, no repeating groups |
| **2NF** | 1NF + all columns depend on full primary key |
| **3NF** | 2NF + no transitive dependencies |

## When to Denormalize

Sometimes, denormalization (intentionally violating normalization) is acceptable for performance:

### Reasons to Denormalize

1. **Performance**: Fewer JOINs = faster queries
2. **Read-heavy workloads**: Optimize for reads over writes
3. **Reporting**: Pre-calculated values for analytics
4. **Historical data**: Snapshot data that shouldn't change

### Example: Denormalized for Performance

```
orders (denormalized):
order_id | customer_name | total_amount | order_date
---------|---------------|--------------|------------
1        | Alice         | 1359.97      | 2023-05-10
```

**Trade-off**: Faster reads, but if customer name changes, need to update all orders (usually acceptable for historical data).

## Best Practices

1. **Start normalized**: Design in 3NF first
2. **Denormalize carefully**: Only when performance requires it
3. **Document decisions**: Explain why you denormalized
4. **Consider use case**: OLTP (normalized) vs OLAP (may denormalize)
5. **Test performance**: Measure before and after

## Common Patterns

### Pattern 1: One-to-Many

```
customers (1) ──< (many) orders
```

### Pattern 2: Many-to-Many

```
products (many) ──< (many) orders
         (through order_items junction table)
```

### Pattern 3: Self-Referencing

```
employees (1) ──< (many) employees
          (manager relationship)
```

## Next Steps

In the next lesson, you'll learn about indexes and query performance optimization.

---

**Key Takeaways:**
- Normalization reduces redundancy and improves data integrity
- 1NF: Atomic values, no repeating groups
- 2NF: All columns depend on full primary key
- 3NF: No transitive dependencies
- Normalize first, denormalize only when needed for performance
- Understand the trade-offs between normalization and performance
