-- Exercise 01
-- Write a query to display employee names along with their department names. Show first_name, last_name, and department_name.
SELECT
    e.first_name,
    e.last_name,
    d.department_name
FROM employees AS e
INNER JOIN departments AS d
    ON e.department_id = d.department_id;

-- Exercise 02
-- Find all employees who work in the 'Engineering' department. Show their first name, last name, and department name.
SELECT
    e.first_name,
    e.last_name,
    d.department_name
FROM employees AS e
INNER JOIN departments AS d
    ON e.department_id = d.department_id
WHERE d.department_name = 'Engineering';

-- Exercise 03
-- Display order information with customer and product details. 
-- Show:
--  order_id
--  order_date
--  customer first_name
--  customer last_name
--  product_name
--  quantity from order_items
SELECT
    o.order_id,
    o.order_date,
    c.first_name,
    c.last_name,
    p.product_name,
    oi.quantity
FROM orders AS o
INNER JOIN customers AS c
    ON o.customer_id = c.customer_id
INNER JOIN order_items AS oi
    ON o.order_id = oi.order_id
INNER JOIN products AS p
    ON oi.product_id = p.product_id;

-- Exercise 04
-- List all employees and their department names. Include employees even if they don't have a department assigned (should show NULL for department_name).
SELECT
    e.first_name,
    e.last_name,
    d.department_name
FROM employees AS e
LEFT JOIN departments AS d
    ON e.department_id = d.department_id;

-- Exercise 05
-- Find all products that have never been ordered (no entries in order_items). Show the product_id and product_name.
SELECT
    p.product_id,
    p.product_name
FROM products AS p
LEFT JOIN order_items AS oi
    ON p.product_id = oi.product_id
WHERE oi.product_id IS NULL;

-- Exercise 06
-- Show all departments with the count of employees in each department. Include departments that have no employees (should show 0).
SELECT
    d.department_name,
    COUNT(e.employee_id) AS employee_count
FROM departments AS d
LEFT JOIN employees AS e
    ON d.department_id = e.department_id
GROUP BY d.department_name;

-- Exercise 07
-- For each customer, calculate:
--  Total number of orders
--  Total amount spent (sum of order amounts)
-- Show customer first_name, last_name, order count, and total spent. Include customers who have never placed an order (show 0 for counts).
SELECT
    c.first_name,
    c.last_name,
    COUNT(o.order_id) AS order_count,
    SUM(o.total_amount) AS total_spent
FROM customers AS c
LEFT JOIN orders AS o
    ON c.customer_id = o.customer_id
GROUP BY c.first_name, c.last_name;

-- Exercise 08
-- Calculate the average salary for each department. Show department_name and average_salary, sorted by average salary in descending order.
SELECT
    d.department_name,
    AVG(e.salary) AS avg_salary
FROM departments AS d
INNER JOIN employees AS e
    ON d.department_id = e.department_id
GROUP BY d.department_name
ORDER BY avg_salary DESC;

-- Exercise 09
-- Display a detailed order report showing:
--  order_id
--  order_date
--  customer full name (first_name + last_name)
--  product_name
--  quantity
--  unit_price
--  line_total (quantity * unit_price)
-- Sort by order_id, then by product_name.
SELECT
    o.order_id,
    o.order_date,
    c.first_name,
    c.last_name,
    p.product_name,
    oi.quantity,
    oi.unit_price,
    (oi.quantity * oi.unit_price) AS line_total
FROM orders AS o
LEFT JOIN customers AS c
    ON o.customer_id = c.customer_id
LEFT JOIN order_items AS oi
    ON o.order_id = oi.order_id
LEFT JOIN products AS p
    ON oi.product_id = p.product_id
ORDER BY o.order_id, p.product_name;

-- Exercise 10
-- If the employees table had a manager_id column (which it doesn't in our current schema, but practice the pattern), write a query that would show each employee with their manager's name.
-- Note: Since we don't have manager_id, you can practice by:
--  1. First, add a manager_id column to employees (ALTER TABLE)
--  2. Update some employees to have managers
--  3. Write the self join query
-- Or, if you prefer, just write the query structure as practice.
SELECT
    e.first_name AS employee,
    m.first_name AS manager
FROM employees AS e
LEFT JOIN employees AS m
    ON e.manager_id = m.employee_id;
