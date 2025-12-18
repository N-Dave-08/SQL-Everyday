# Level 1 Exercises: SQL Fundamentals

Complete these exercises using the `employees` and `products` tables from the database.

## Exercise 1: Basic SELECT
**Difficulty: Beginner**

Write a query to display the first name, last name, and email of all employees.

**Expected Output Format:**
```
first_name | last_name | email
-----------|-----------|--------------------------
John       | Smith     | john.smith@company.com
...
```

---

## Exercise 2: Filtering with WHERE
**Difficulty: Beginner**

Find all employees who have a salary greater than 75000. Display their first name, last name, and salary.

**Expected Output Format:**
```
first_name | last_name | salary
-----------|-----------|--------
...
```

---

## Exercise 3: Multiple Conditions
**Difficulty: Beginner**

Retrieve all employees who are Software Engineers AND have a salary greater than 70000. Show their full name, job title, and salary.

**Expected Output Format:**
```
first_name | last_name | job_title          | salary
-----------|-----------|--------------------|--------
...
```

---

## Exercise 4: Using IN Operator
**Difficulty: Beginner**

Find all employees whose job title is either 'Data Analyst', 'Marketing Manager', or 'Sales Manager'. Display their name and job title.

**Expected Output Format:**
```
first_name | last_name | job_title
-----------|-----------|------------------
...
```

---

## Exercise 5: Pattern Matching with LIKE
**Difficulty: Intermediate**

Find all employees whose first name starts with the letter 'J'. Display their first name, last name, and email.

**Expected Output Format:**
```
first_name | last_name | email
-----------|-----------|--------------------------
...
```

---

## Exercise 6: Sorting Results
**Difficulty: Beginner**

List all employees sorted by their hire date, with the most recently hired employees first. Display first name, last name, and hire date.

**Expected Output Format:**
```
first_name | last_name | hire_date
-----------|-----------|------------
...
```

---

## Exercise 7: Combining WHERE and ORDER BY
**Difficulty: Intermediate**

Find all employees in department 1, sorted by salary in descending order. Show their name, department ID, and salary. Limit the results to the top 5 highest paid employees in that department.

**Expected Output Format:**
```
first_name | last_name | department_id | salary
-----------|-----------|---------------|--------
...
```

---

## Exercise 8: Using BETWEEN
**Difficulty: Beginner**

Find all products with a price between 50 and 300 (inclusive). Display the product name, category, and price.

**Expected Output Format:**
```
product_name        | category    | price
--------------------|-------------|--------
...
```

---

## Exercise 9: NULL Handling
**Difficulty: Intermediate**

Find all employees who do NOT have a department assigned (department_id IS NULL). Display their first name, last name, and job title.

**Expected Output Format:**
```
first_name | last_name | job_title
-----------|-----------|------------------
...
```

---

## Exercise 10: DISTINCT Values
**Difficulty: Beginner**

Get a list of all unique job titles in the employees table, sorted alphabetically.

**Expected Output Format:**
```
job_title
------------------
...
```

---

## Hints

<details>
<summary>Hint for Exercise 1</summary>
Use SELECT with specific column names from the employees table.
</details>

<details>
<summary>Hint for Exercise 2</summary>
Use WHERE with the > operator to filter by salary.
</details>

<details>
<summary>Hint for Exercise 3</summary>
Combine two conditions using AND in the WHERE clause.
</details>

<details>
<summary>Hint for Exercise 4</summary>
Use the IN operator with a list of job titles.
</details>

<details>
<summary>Hint for Exercise 5</summary>
Use LIKE with the pattern 'J%' to match names starting with J.
</details>

<details>
<summary>Hint for Exercise 6</summary>
Use ORDER BY with DESC to sort dates in descending order.
</details>

<details>
<summary>Hint for Exercise 7</summary>
Combine WHERE (for department), ORDER BY (for salary DESC), and LIMIT (for top 5).
</details>

<details>
<summary>Hint for Exercise 8</summary>
Use BETWEEN to check if price falls within the range.
</details>

<details>
<summary>Hint for Exercise 9</summary>
Use IS NULL to check for missing department_id values.
</details>

<details>
<summary>Hint for Exercise 10</summary>
Use DISTINCT to get unique values and ORDER BY to sort them.
</details>

---

**Good luck!** Try to solve these without looking at the solutions first. If you get stuck, review the lessons or check the hints.
