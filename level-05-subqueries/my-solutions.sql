-- Exercise 01
-- Find all employees who earn more than the average salary. Show first_name, last_name, and salary.
SELECT
    e.first_name,
    e.last_name,
    e.salary
FROM employees AS e
WHERE e.salary > (
    SELECT AVG(e_avg.salary)
    FROM employees AS e_avg
);

-- Exercise 02
-- Display each employee's salary along with the company average salary and the difference between their salary and the average. Show first_name, last_name, salary, average_salary, and difference.
SELECT
    e.first_name,
    e.last_name,
    e.salary,
    (SELECT AVG(s.salary) FROM employees AS s) AS average_salary,
    e.salary - (SELECT AVG(s.salary) FROM employees AS s) AS difference
FROM employees AS e;

-- Exercise 03
-- Find all employees who work in departments with a budget greater than 400000. Show employee first_name, last_name, and department_id.
SELECT
    e.first_name,
    e.last_name,
    e.department_id
FROM employees AS e
WHERE e.department_id IN (
    SELECT d.department_id
    FROM departments AS d
    WHERE d.budget > 400000
);

-- Exercise 04
-- Create a query that shows each department's average salary compared to the overall company average. Use a subquery in the FROM clause.
SELECT
    ds.department_id,
    ds.dept_avg_salary,
    (SELECT AVG(e.salary) FROM employees AS e) AS company_avg_salary,
    ds.dept_avg_salary - (SELECT AVG(e.salary) FROM employees AS e) AS difference
FROM (
    SELECT
        department_id,
        AVG(salary) AS dept_avg_salary
    FROM employees
    GROUP BY department_id
) AS ds;

-- Exercise 05
-- Find employees who earn more than the average salary in their own department. Show first_name, last_name, salary, and department_id.
-- Hint: This requires a correlated subquery where the inner query references the outer query's department_id.
SELECT
    e1.first_name,
    e1.last_name,
    e1.salary,
    e1.department_id
FROM employees AS e1
WHERE
    e1.salary > (
        SELECT AVG(e2.salary) AS dept_avg_salary
        FROM employees AS e2
        WHERE e1.department_id = e2.department_id
    );

-- Exercise 06
-- Find all customers who have placed at least one order. Use EXISTS. Show customer first_name and last_name.
SELECT
    first_name,
    last_name
FROM customers AS c
WHERE
    EXISTS (
        SELECT 1
        FROM orders AS o
        WHERE c.customer_id = o.customer_id
    );

-- Exercise 07
-- Find all products that have never been ordered (no entries in order_items). Use NOT EXISTS. Show product_id and product_name.
SELECT
    product_id,
    product_name
FROM products AS p
WHERE
    NOT EXISTS (
        SELECT 1
        FROM order_items AS oi
        WHERE oi.product_id = p.product_id
    );

-- Exercise 08
-- Write two queries that achieve the same result:
--  1. Using IN: Find employees in departments with budget > 400000
--  2. Using EXISTS: Find the same employees
-- Compare the results and note any differences.
SELECT
    e.first_name,
    e.last_name,
    e.department_id
FROM employees AS e
WHERE e.department_id IN (
    SELECT d.department_id
    FROM departments AS d
    WHERE d.budget > 400000
);

SELECT
    e.first_name,
    e.last_name,
    e.department_id
FROM employees AS e
WHERE EXISTS (
    SELECT 1
    FROM departments AS d
    WHERE
        e.department_id = d.department_id
        AND d.budget > 400000
);
-- Exercise 09
-- Find departments where the average salary is greater than the overall company average salary. Show department_id and average_salary.
-- Hint: Use a subquery in HAVING clause.
SELECT
    e.department_id,
    AVG(e.salary) AS avg_salary
FROM employees AS e
GROUP BY e.department_id
HAVING AVG(e.salary) > (
    SELECT AVG(e2.salary)
    FROM employees AS e2
);

-- Exercise 10
-- For each customer, show their name and the total number of orders they've placed. Use a correlated subquery in the SELECT clause.
SELECT
    first_name,
    last_name,
    (
        SELECT COUNT(*)
        FROM orders AS o
        WHERE o.customer_id = c.customer_id
    ) AS total_orders
FROM customers AS c;

-- Exercise 11
-- Display each employee with:
--  Their salary
--  The minimum salary in their department
--  The maximum salary in their department
--  Their position relative to department (above/below average)
-- Show first_name, last_name, salary, dept_min, dept_max, and a calculated field showing if they're above or below department average.
SELECT
    e1.first_name,
    e1.last_name,
    e1.salary,
    (
        SELECT MIN(e2.salary)
        FROM employees AS e2
        WHERE e2.department_id = e1.department_id
    ) AS dept_min,
    (
        SELECT MAX(e2.salary)
        FROM employees AS e2
        WHERE e2.department_id = e1.department_id
    ) AS dept_max
FROM employees AS e1;

-- Exercise 12
-- Find employees whose salary is greater than any salary in department 2. Show first_name, last_name, and salary.
SELECT
    e.first_name,
    e.last_name,
    e.salary
FROM employees AS e
WHERE e.salary > ANY(
    SELECT e2.salary
    FROM employees AS e2
    WHERE e2.department_id = 2
);
