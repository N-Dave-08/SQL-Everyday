-- Exercise 01
-- Count the total number of employees in the database.
SELECT COUNT(*) AS total_employees
FROM employees;

-- Exercise 02
-- Count how many employees work in department 1 (Engineering).
SELECT
    department_id,
    COUNT(*) AS employee_count
FROM employees
WHERE department_id = 1
GROUP BY department_id;

-- Exercise 03
-- Calculate the average salary and total payroll (sum of all salaries) for all employees.
SELECT
    AVG(salary) AS avg_salary,
    SUM(salary) AS total_salary
FROM employees;

-- Exercise 04
-- Find the minimum and maximum salary in the employees table, as well as the earliest and latest hire dates.
SELECT
    MIN(salary) AS min_salary,
    MAX(salary) AS max_salary,
    MIN(hire_date) AS earliest_hire,
    MAX(hire_date) AS latest_hire
FROM employees;

-- Exercise 05
-- Count how many unique job titles exist in the employees table.
SELECT COUNT(DISTINCT job_title) AS unique_job
FROM employees;

-- Exercise 06
-- Count the number of employees in each department. Show the department_id and the count.
SELECT
    department_id,
    COUNT(*) AS employee_count
FROM employees
GROUP BY department_id;

-- Exercise 07
-- Calculate the average salary for each department. Show department_id and average salary, sorted by average salary in descending order.
SELECT
    department_id,
    AVG(salary) AS avg_salary
FROM employees
GROUP BY department_id
ORDER BY avg_salary DESC;

-- Exercise 08
-- Count employees by both department and job title. Show department_id, job_title, and the count.
SELECT
    department_id,
    job_title,
    COUNT(*) AS job_count
FROM employees
GROUP BY department_id, job_title;

-- Exercise 09
-- Find all departments that have more than 2 employees. Show the department_id and employee count.
SELECT
    department_id,
    COUNT(*) AS employee_count
FROM employees
GROUP BY department_id
HAVING COUNT(*) > 2;

-- Exercise 10
-- Find all job titles where the average salary is greater than 70000. Show the job title and average salary.
SELECT
    job_title,
    AVG(salary) AS avg_salary
FROM employees
GROUP BY job_title
HAVING AVG(salary) > 70000;

-- Exercise 11
-- For employees hired after 2020-01-01, find departments that have an average salary greater than 70000. Show department_id, average salary, and employee count.
SELECT
    department_id,
    AVG(salary) AS avg_salary,
    COUNT(*) AS employee_count
FROM employees
WHERE hire_date > '2020-01-01'
GROUP BY department_id
HAVING AVG(salary) > 70000;

-- Exercise 12
-- Count the number of products in each category, and sort the results by count in descending order (categories with most products first).
SELECT
    category,
    COUNT(*) AS product_count
FROM products
GROUP BY category
ORDER BY product_count;

-- Exercise 13
-- For each department, calculate:

-- Number of employees
-- Average salary
-- Minimum salary
-- Maximum salary
-- Total payroll
-- Sort by total payroll in descending order.
SELECT
    department_id,
    COUNT(*) AS employee_count,
    AVG(salary) AS avg_salary,
    MIN(salary) AS min_salary,
    MAX(salary) AS max_salary,
    SUM(salary) AS total_payroll
FROM employees
GROUP BY department_id;

-- Exercise 14 
-- Find all job titles that have exactly 2 employees.
SELECT job_title
FROM employees
GROUP BY job_title
HAVING COUNT(*) = 2;

-- Exercise 15
-- For the orders table:

-- Count the total number of orders
-- Calculate the average order amount
-- Find the minimum and maximum order amounts
-- Calculate the total revenue (sum of all order amounts)
-- Display all four metrics in a single query.
SELECT
    COUNT(*) AS total_orders,
    AVG(total_amount) AS avg_order_amount,
    MIN(total_amount) AS min_order,
    MAX(total_amount) AS max_order,
    SUM(total_amount) AS total_revenue
FROM orders;
