# Level 5 Exercises: Subqueries

Complete these exercises using subqueries with the database tables.

---

## Exercise 1: Scalar Subquery in WHERE
**Difficulty: Beginner**

Find all employees who earn more than the average salary. Show first_name, last_name, and salary.

---

## Exercise 2: Scalar Subquery in SELECT
**Difficulty: Beginner**

Display each employee's salary along with the company average salary and the difference between their salary and the average. Show first_name, last_name, salary, average_salary, and difference.

**Expected Output Format:**
```
first_name | last_name | salary | average_salary | difference
-----------|-----------|-------|---------------|------------
...
```

---

## Exercise 3: Column Subquery with IN
**Difficulty: Intermediate**

Find all employees who work in departments with a budget greater than 400000. Show employee first_name, last_name, and department_id.

---

## Exercise 4: Subquery in FROM
**Difficulty: Intermediate**

Create a query that shows each department's average salary compared to the overall company average. Use a subquery in the FROM clause.

**Expected Output Format:**
```
department_id | dept_avg_salary | company_avg_salary
--------------|-----------------|-------------------
...
```

---

## Exercise 5: Correlated Subquery
**Difficulty: Advanced**

Find employees who earn more than the average salary in their own department. Show first_name, last_name, salary, and department_id.

**Hint**: This requires a correlated subquery where the inner query references the outer query's department_id.

---

## Exercise 6: EXISTS - Finding Related Records
**Difficulty: Intermediate**

Find all customers who have placed at least one order. Use EXISTS. Show customer first_name and last_name.

---

## Exercise 7: NOT EXISTS - Finding Unrelated Records
**Difficulty: Intermediate**

Find all products that have never been ordered (no entries in order_items). Use NOT EXISTS. Show product_id and product_name.

---

## Exercise 8: EXISTS vs IN Comparison
**Difficulty: Intermediate**

Write two queries that achieve the same result:
1. Using IN: Find employees in departments with budget > 400000
2. Using EXISTS: Find the same employees

Compare the results and note any differences.

---

## Exercise 9: Subquery with Aggregates
**Difficulty: Advanced**

Find departments where the average salary is greater than the overall company average salary. Show department_id and average_salary.

**Hint**: Use a subquery in HAVING clause.

---

## Exercise 10: Complex Correlated Subquery
**Difficulty: Advanced**

For each customer, show their name and the total number of orders they've placed. Use a correlated subquery in the SELECT clause.

**Expected Output Format:**
```
first_name | last_name | order_count
-----------|-----------|-------------
Alice      | Thompson  | 3
...
```

---

## Exercise 11: Multiple Subqueries
**Difficulty: Advanced**

Display each employee with:
- Their salary
- The minimum salary in their department
- The maximum salary in their department
- Their position relative to department (above/below average)

Show first_name, last_name, salary, dept_min, dept_max, and a calculated field showing if they're above or below department average.

---

## Exercise 12: Subquery with ANY
**Difficulty: Advanced**

Find employees whose salary is greater than any salary in department 2. Show first_name, last_name, and salary.

---

## Hints

<details>
<summary>Hint for Exercise 1</summary>
Use WHERE salary > (SELECT AVG(salary) FROM employees)
</details>

<details>
<summary>Hint for Exercise 2</summary>
Use (SELECT AVG(salary) FROM employees) in the SELECT clause, then calculate the difference.
</details>

<details>
<summary>Hint for Exercise 3</summary>
Use WHERE department_id IN (SELECT department_id FROM departments WHERE budget > 400000)
</details>

<details>
<summary>Hint for Exercise 4</summary>
Create a subquery that calculates department averages, then join it with a subquery for company average.
</details>

<details>
<summary>Hint for Exercise 5</summary>
Use a correlated subquery: WHERE salary > (SELECT AVG(salary) FROM employees e2 WHERE e2.department_id = e1.department_id)
</details>

<details>
<summary>Hint for Exercise 6</summary>
Use WHERE EXISTS (SELECT 1 FROM orders WHERE orders.customer_id = customers.customer_id)
</details>

<details>
<summary>Hint for Exercise 7</summary>
Use WHERE NOT EXISTS (SELECT 1 FROM order_items WHERE order_items.product_id = products.product_id)
</details>

<details>
<summary>Hint for Exercise 8</summary>
IN: WHERE department_id IN (SELECT ...); EXISTS: WHERE EXISTS (SELECT 1 FROM departments WHERE ...)
</details>

<details>
<summary>Hint for Exercise 9</summary>
Use HAVING AVG(salary) > (SELECT AVG(salary) FROM employees)
</details>

<details>
<summary>Hint for Exercise 10</summary>
Use (SELECT COUNT(*) FROM orders WHERE orders.customer_id = customers.customer_id) in SELECT
</details>

<details>
<summary>Hint for Exercise 11</summary>
Use multiple correlated subqueries in SELECT, or use a subquery in FROM with department statistics.
</details>

<details>
<summary>Hint for Exercise 12</summary>
Use WHERE salary > ANY (SELECT salary FROM employees WHERE department_id = 2)
</details>

---

**Good luck!** Subqueries are powerful - practice these patterns to master them.
