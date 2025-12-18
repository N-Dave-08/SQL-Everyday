# Level 6 Exercises: Advanced Queries (CTEs and Window Functions)

Complete these exercises using CTEs and Window Functions.

---

## Exercise 1: Basic CTE
**Difficulty: Beginner**

Create a CTE that selects all employees with salary greater than 70000, then select all columns from that CTE.

---

## Exercise 2: CTE with JOIN
**Difficulty: Intermediate**

Use a CTE to find all employees in the Engineering department. The CTE should join employees and departments. Then select employee names and department name from the CTE.

---

## Exercise 3: Multiple CTEs
**Difficulty: Intermediate**

Create two CTEs:
1. `high_budget_depts`: Departments with budget > 400000
2. `dept_employees`: Employees in those departments

Then join them to show employee names and department names.

---

## Exercise 4: ROW_NUMBER() Window Function
**Difficulty: Intermediate**

Rank employees within each department by salary (highest first). Use ROW_NUMBER(). Show first_name, last_name, department_id, salary, and rank.

---

## Exercise 5: RANK() vs DENSE_RANK()
**Difficulty: Intermediate**

Write two queries:
1. Use RANK() to rank all employees by salary
2. Use DENSE_RANK() to rank all employees by salary

Compare the results when there are ties.

---

## Exercise 6: AVG() OVER with PARTITION BY
**Difficulty: Intermediate**

Show each employee's salary along with the average salary in their department. Use AVG() OVER with PARTITION BY. Show first_name, salary, department_id, and dept_avg_salary.

---

## Exercise 7: Running Total with SUM() OVER
**Difficulty: Intermediate**

Calculate a running total of salaries, ordered by employee_id. Use SUM() OVER with ORDER BY. Show employee_id, first_name, salary, and running_total.

---

## Exercise 8: LAG() Window Function
**Difficulty: Advanced**

For each employee (ordered by salary), show their salary and the previous employee's salary. Use LAG(). Show first_name, salary, and previous_salary.

---

## Exercise 9: Top N per Group with Window Functions
**Difficulty: Advanced**

Find the top 2 highest paid employees in each department. Use ROW_NUMBER() in a CTE, then filter. Show first_name, last_name, department_id, and salary.

---

## Exercise 10: Complex CTE with Window Function
**Difficulty: Advanced**

Create a query that:
1. Uses a CTE to calculate department statistics (avg salary, employee count)
2. Uses window functions to rank departments by average salary
3. Shows department_name, avg_salary, emp_count, and rank

---

## Hints

<details>
<summary>Hint for Exercise 1</summary>
WITH high_salary AS (SELECT * FROM employees WHERE salary > 70000) SELECT * FROM high_salary;
</details>

<details>
<summary>Hint for Exercise 2</summary>
Create CTE with JOIN, then SELECT from CTE.
</details>

<details>
<summary>Hint for Exercise 3</summary>
Define two CTEs separated by comma, then join them in main query.
</details>

<details>
<summary>Hint for Exercise 4</summary>
Use ROW_NUMBER() OVER (PARTITION BY department_id ORDER BY salary DESC)
</details>

<details>
<summary>Hint for Exercise 5</summary>
Compare RANK() and DENSE_RANK() when there are salary ties.
</details>

<details>
<summary>Hint for Exercise 6</summary>
AVG(salary) OVER (PARTITION BY department_id)
</details>

<details>
<summary>Hint for Exercise 7</summary>
SUM(salary) OVER (ORDER BY employee_id)
</details>

<details>
<summary>Hint for Exercise 8</summary>
LAG(salary) OVER (ORDER BY salary)
</details>

<details>
<summary>Hint for Exercise 9</summary>
Use CTE with ROW_NUMBER(), then filter WHERE rn <= 2
</details>

<details>
<summary>Hint for Exercise 10</summary>
CTE for dept stats, then RANK() OVER in main query.
</details>

---

**Good luck!** These advanced techniques are powerful for analytical queries.
