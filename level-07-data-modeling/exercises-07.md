# Level 7 Exercises: Data Modeling and Design

These exercises focus on understanding database design principles.

---

## Exercise 1: Identify Normalization Issues
**Difficulty: Intermediate**

Examine the following table design and identify normalization violations:

```
order_details:
order_id | customer_name | customer_email | product_name | product_price | quantity | order_date
```

List which normal forms are violated and explain why.

---

## Exercise 2: Design Normalized Schema
**Difficulty: Advanced**

Design a normalized schema (3NF) for the following scenario:

A library system needs to track:
- Books (title, author, ISBN, publication year)
- Members (name, email, join date)
- Loans (which member borrowed which book, loan date, return date)
- Authors can write multiple books
- Books can have multiple authors
- Members can borrow multiple books
- Books can be borrowed by multiple members (at different times)

Create the table structures with appropriate primary keys and foreign keys.

---

## Exercise 3: Create Indexes
**Difficulty: Beginner**

Based on our database schema, create indexes for:
1. Foreign key: `employees.department_id`
2. Frequently queried: `orders.order_date`
3. Composite: `orders(customer_id, order_date)` for queries filtering by both

Write the CREATE INDEX statements.

---

## Exercise 4: Analyze Query Performance
**Difficulty: Intermediate**

Consider this query:
```sql
SELECT e.first_name, e.last_name, d.department_name
FROM employees e
JOIN departments d ON e.department_id = d.department_id
WHERE e.salary > 70000
ORDER BY e.salary DESC;
```

What indexes would improve this query's performance? Explain why.

---

## Exercise 5: Denormalization Decision
**Difficulty: Advanced**

You have a normalized `orders` table and `order_items` table. For a reporting dashboard that shows order totals, you're considering adding a `total_amount` column directly to the `orders` table (denormalization).

Discuss the trade-offs:
- What are the benefits?
- What are the risks?
- When would this be acceptable?
- When would you avoid it?

---

## Hints

<details>
<summary>Hint for Exercise 1</summary>
Look for: repeating groups, partial dependencies, transitive dependencies.
</details>

<details>
<summary>Hint for Exercise 2</summary>
You'll need: books, authors, members, loans tables. Consider a junction table for book-authors (many-to-many).
</details>

<details>
<summary>Hint for Exercise 3</summary>
CREATE INDEX idx_name ON table_name(column_name)
</details>

<details>
<summary>Hint for Exercise 4</summary>
Consider indexes on: join columns, WHERE filter columns, ORDER BY columns.
</details>

<details>
<summary>Hint for Exercise 5</summary>
Think about: data consistency, update complexity, query performance, use case (OLTP vs OLAP).
</details>

---

**Good luck!** These exercises focus on design thinking rather than writing queries.
