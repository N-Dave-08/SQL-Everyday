# Level 3 Exercises: Aggregations and Grouping

Complete these exercises using the `employees`, `products`, `orders`, and `order_items` tables.

---

## Exercise 1: Basic COUNT
**Difficulty: Beginner**

Count the total number of employees in the database.

**Expected Output Format:**
```
total_employees
---------------
15
```

---

## Exercise 2: COUNT with WHERE
**Difficulty: Beginner**

Count how many employees work in department 1 (Engineering).

---

## Exercise 3: AVG and SUM
**Difficulty: Beginner**

Calculate the average salary and total payroll (sum of all salaries) for all employees.

**Expected Output Format:**
```
average_salary | total_payroll
---------------|---------------
...
```

---

## Exercise 4: MIN and MAX
**Difficulty: Beginner**

Find the minimum and maximum salary in the employees table, as well as the earliest and latest hire dates.

**Expected Output Format:**
```
min_salary | max_salary | earliest_hire | latest_hire
-----------|------------|---------------|-------------
...
```

---

## Exercise 5: COUNT DISTINCT
**Difficulty: Beginner**

Count how many unique job titles exist in the employees table.

---

## Exercise 6: GROUP BY - Basic
**Difficulty: Intermediate**

Count the number of employees in each department. Show the department_id and the count.

**Expected Output Format:**
```
department_id | employee_count
--------------|----------------
1             | 6
2             | 3
...
```

---

## Exercise 7: GROUP BY with Aggregate
**Difficulty: Intermediate**

Calculate the average salary for each department. Show department_id and average salary, sorted by average salary in descending order.

**Expected Output Format:**
```
department_id | avg_salary
--------------|------------
...
```

---

## Exercise 8: GROUP BY Multiple Columns
**Difficulty: Intermediate**

Count employees by both department and job title. Show department_id, job_title, and the count.

**Expected Output Format:**
```
department_id | job_title          | count
--------------|--------------------|-------
1             | Software Engineer  | 4
...
```

---

## Exercise 9: HAVING - Filter Groups
**Difficulty: Intermediate**

Find all departments that have more than 2 employees. Show the department_id and employee count.

**Expected Output Format:**
```
department_id | employee_count
--------------|----------------
...
```

---

## Exercise 10: HAVING with Aggregate Condition
**Difficulty: Intermediate**

Find all job titles where the average salary is greater than 70000. Show the job title and average salary.

**Expected Output Format:**
```
job_title          | avg_salary
--------------------|------------
...
```

---

## Exercise 11: WHERE and HAVING Together
**Difficulty: Advanced**

For employees hired after 2020-01-01, find departments that have an average salary greater than 70000. Show department_id, average salary, and employee count.

**Expected Output Format:**
```
department_id | avg_salary | employee_count
--------------|------------|----------------
...
```

---

## Exercise 12: GROUP BY with ORDER BY
**Difficulty: Intermediate**

Count the number of products in each category, and sort the results by count in descending order (categories with most products first).

**Expected Output Format:**
```
category      | product_count
--------------|---------------
...
```

---

## Exercise 13: Multiple Aggregates by Group
**Difficulty: Advanced**

For each department, calculate:
- Number of employees
- Average salary
- Minimum salary
- Maximum salary
- Total payroll

Sort by total payroll in descending order.

**Expected Output Format:**
```
department_id | emp_count | avg_salary | min_salary | max_salary | total_payroll
--------------|-----------|------------|------------|------------|---------------
...
```

---

## Exercise 14: HAVING with COUNT
**Difficulty: Intermediate**

Find all job titles that have exactly 2 employees.

**Expected Output Format:**
```
job_title
------------------
...
```

---

## Exercise 15: Complex Aggregation
**Difficulty: Advanced**

For the orders table:
1. Count the total number of orders
2. Calculate the average order amount
3. Find the minimum and maximum order amounts
4. Calculate the total revenue (sum of all order amounts)

Display all four metrics in a single query.

**Expected Output Format:**
```
total_orders | avg_order_amount | min_order | max_order | total_revenue
-------------|-------------------|-----------|-----------|---------------
...
```

---

## Hints

<details>
<summary>Hint for Exercise 1</summary>
Use COUNT(*) to count all rows in the employees table.
</details>

<details>
<summary>Hint for Exercise 2</summary>
Use COUNT(*) with WHERE to filter by department_id = 1.
</details>

<details>
<summary>Hint for Exercise 3</summary>
Use AVG(salary) and SUM(salary) in the same SELECT statement.
</details>

<details>
<summary>Hint for Exercise 4</summary>
Use MIN and MAX for both salary and hire_date columns.
</details>

<details>
<summary>Hint for Exercise 5</summary>
Use COUNT(DISTINCT job_title) to count unique values.
</details>

<details>
<summary>Hint for Exercise 6</summary>
Use GROUP BY department_id with COUNT(*).
</details>

<details>
<summary>Hint for Exercise 7</summary>
GROUP BY department_id, use AVG(salary), and ORDER BY the average salary DESC.
</details>

<details>
<summary>Hint for Exercise 8</summary>
GROUP BY both department_id and job_title, then COUNT(*).
</details>

<details>
<summary>Hint for Exercise 9</summary>
Use GROUP BY department_id, then HAVING COUNT(*) > 2.
</details>

<details>
<summary>Hint for Exercise 10</summary>
GROUP BY job_title, use AVG(salary), and HAVING AVG(salary) > 70000.
</details>

<details>
<summary>Hint for Exercise 11</summary>
Use WHERE to filter hire_date, GROUP BY department_id, then HAVING to filter by average salary.
</details>

<details>
<summary>Hint for Exercise 12</summary>
GROUP BY category, COUNT(*), and ORDER BY the count DESC.
</details>

<details>
<summary>Hint for Exercise 13</summary>
Use multiple aggregate functions (COUNT, AVG, MIN, MAX, SUM) with GROUP BY department_id.
</details>

<details>
<summary>Hint for Exercise 14</summary>
GROUP BY job_title and use HAVING COUNT(*) = 2.
</details>

<details>
<summary>Hint for Exercise 15</summary>
Use COUNT(*), AVG(total_amount), MIN(total_amount), MAX(total_amount), and SUM(total_amount) all in one SELECT.
</details>

---

**Good luck!** Practice writing these queries and understanding how GROUP BY and HAVING work together.
