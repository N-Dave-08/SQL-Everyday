# Level 8 Exercises: Advanced Topics

These exercises cover stored procedures, views, triggers, and transactions.

---

## Exercise 1: Create a View
**Difficulty: Beginner**

Create a view called `employee_department_view` that shows:
- employee_id
- first_name
- last_name
- department_name
- salary

The view should join employees and departments tables.

Then query the view to find employees with salary > 70000.

---

## Exercise 2: View with Aggregates
**Difficulty: Intermediate**

Create a view called `department_summary` that shows:
- department_name
- employee_count
- average_salary
- total_payroll

Query the view to find departments with more than 3 employees.

---

## Exercise 3: Transaction Practice
**Difficulty: Intermediate**

Write a transaction that:
1. Inserts a new employee
2. Updates the department's employee count (if you have such a column, or just practice the pattern)
3. If both succeed, commit; if either fails, rollback

Test the transaction and verify the results.

---

## Exercise 4: Transaction with Error Handling
**Difficulty: Advanced**

Create a transaction that attempts to:
1. Update an employee's salary
2. Insert a record into an audit log table

Include error handling to rollback if either operation fails.

**Note**: You may need to create an audit log table first.

---

## Exercise 5: Understanding Isolation
**Difficulty: Advanced (Conceptual)**

Explain in your own words:
1. What is a dirty read?
2. What is a non-repeatable read?
3. What is a phantom read?
4. How do different isolation levels prevent these issues?

---

## Exercise 6: View for Security
**Difficulty: Intermediate**

Create a view called `public_employee_info` that shows only:
- employee_id
- first_name
- last_name
- job_title

(Exclude sensitive information like salary and email)

Query the view to verify it works.

---

## Exercise 7: Materialized View Concept
**Difficulty: Intermediate (Conceptual)**

Explain when you would use a materialized view vs a regular view. What are the trade-offs?

---

## Exercise 8: Trigger Concept
**Difficulty: Advanced (Conceptual)**

Design a trigger that would:
- Log changes to employee salaries
- Store old salary, new salary, employee_id, and timestamp

Write the trigger definition (syntax may vary by database).

**Note**: If your database supports triggers, try implementing it. Otherwise, write the conceptual design.

---

## Hints

<details>
<summary>Hint for Exercise 1</summary>
CREATE VIEW view_name AS SELECT ... FROM ... JOIN ...
</details>

<details>
<summary>Hint for Exercise 2</summary>
Use GROUP BY in the view definition, then query the view with WHERE.
</details>

<details>
<summary>Hint for Exercise 3</summary>
BEGIN TRANSACTION; ... operations ...; COMMIT; (or ROLLBACK on error)
</details>

<details>
<summary>Hint for Exercise 4</summary>
Wrap operations in TRY-CATCH block (syntax varies by database).
</details>

<details>
<summary>Hint for Exercise 5</summary>
Research ACID properties and isolation levels.
</details>

<details>
<summary>Hint for Exercise 6</summary>
CREATE VIEW with SELECT of only non-sensitive columns.
</details>

<details>
<summary>Hint for Exercise 7</summary>
Consider: performance vs data freshness, storage vs computation.
</details>

<details>
<summary>Hint for Exercise 8</summary>
CREATE TRIGGER ... AFTER UPDATE ... FOR EACH ROW ... (syntax varies)
</details>

---

**Good luck!** These advanced topics require understanding your specific database's features and syntax.
