# Level 4 Exercises: Joins

Complete these exercises using the `employees`, `departments`, `customers`, `orders`, `order_items`, and `products` tables.

---

## Exercise 1: Basic INNER JOIN
**Difficulty: Beginner**

Write a query to display employee names along with their department names. Show first_name, last_name, and department_name.

**Expected Output Format:**
```
first_name | last_name | department_name
-----------|-----------|------------------
John       | Smith     | Engineering
...
```

---

## Exercise 2: INNER JOIN with WHERE
**Difficulty: Beginner**

Find all employees who work in the 'Engineering' department. Show their first name, last name, and department name.

---

## Exercise 3: INNER JOIN Multiple Tables
**Difficulty: Intermediate**

Display order information with customer and product details. Show:
- order_id
- order_date
- customer first_name
- customer last_name
- product_name
- quantity from order_items

**Hint**: You'll need to join orders, customers, order_items, and products tables.

---

## Exercise 4: LEFT JOIN - Include All Employees
**Difficulty: Intermediate**

List all employees and their department names. Include employees even if they don't have a department assigned (should show NULL for department_name).

**Expected Output Format:**
```
first_name | last_name | department_name
-----------|-----------|------------------
John       | Smith     | Engineering
...
```

---

## Exercise 5: LEFT JOIN - Find Missing Relationships
**Difficulty: Intermediate**

Find all products that have never been ordered (no entries in order_items). Show the product_id and product_name.

**Hint**: Use LEFT JOIN and filter for NULL values.

---

## Exercise 6: LEFT JOIN with Aggregates
**Difficulty: Intermediate**

Show all departments with the count of employees in each department. Include departments that have no employees (should show 0).

**Expected Output Format:**
```
department_name | employee_count
----------------|----------------
Engineering     | 6
...
```

---

## Exercise 7: Multiple JOINs with Aggregates
**Difficulty: Advanced**

For each customer, calculate:
- Total number of orders
- Total amount spent (sum of order amounts)

Show customer first_name, last_name, order count, and total spent. Include customers who have never placed an order (show 0 for counts).

**Expected Output Format:**
```
first_name | last_name | order_count | total_spent
-----------|-----------|-------------|-------------
Alice      | Thompson  | 3           | 1349.97
...
```

---

## Exercise 8: JOIN with GROUP BY
**Difficulty: Intermediate**

Calculate the average salary for each department. Show department_name and average_salary, sorted by average salary in descending order.

**Expected Output Format:**
```
department_name | avg_salary
----------------|------------
...
```

---

## Exercise 9: Complex Multiple JOINs
**Difficulty: Advanced**

Display a detailed order report showing:
- order_id
- order_date
- customer full name (first_name + last_name)
- product_name
- quantity
- unit_price
- line_total (quantity * unit_price)

Sort by order_id, then by product_name.

---

## Exercise 10: Self Join Pattern
**Difficulty: Advanced**

If the employees table had a `manager_id` column (which it doesn't in our current schema, but practice the pattern), write a query that would show each employee with their manager's name.

**Note**: Since we don't have manager_id, you can practice by:
1. First, add a manager_id column to employees (ALTER TABLE)
2. Update some employees to have managers
3. Write the self join query

Or, if you prefer, just write the query structure as practice.

---

## Hints

<details>
<summary>Hint for Exercise 1</summary>
Use INNER JOIN between employees and departments tables. Join on department_id.
</details>

<details>
<summary>Hint for Exercise 2</summary>
Add WHERE clause after the JOIN to filter by department_name = 'Engineering'.
</details>

<details>
<summary>Hint for Exercise 3</summary>
Join orders → customers, orders → order_items, then order_items → products.
</details>

<details>
<summary>Hint for Exercise 4</summary>
Use LEFT JOIN instead of INNER JOIN to include all employees.
</details>

<details>
<summary>Hint for Exercise 5</summary>
LEFT JOIN products to order_items, then WHERE order_items.product_id IS NULL.
</details>

<details>
<summary>Hint for Exercise 6</summary>
LEFT JOIN departments to employees, then use COUNT with GROUP BY. COUNT will return 0 for departments with no employees.
</details>

<details>
<summary>Hint for Exercise 7</summary>
LEFT JOIN customers to orders, use COUNT and SUM with GROUP BY customer_id.
</details>

<details>
<summary>Hint for Exercise 8</summary>
JOIN employees to departments, then GROUP BY department_name and use AVG(salary).
</details>

<details>
<summary>Hint for Exercise 9</summary>
Join orders → customers, orders → order_items, order_items → products. Calculate line_total as quantity * unit_price.
</details>

<details>
<summary>Hint for Exercise 10</summary>
Join employees table to itself using aliases (e for employee, m for manager). Join on e.manager_id = m.employee_id.
</details>

---

**Good luck!** Practice these joins - they're fundamental to working with relational databases.
