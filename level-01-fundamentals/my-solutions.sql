-- Exercise 01
-- Write a query to display the first name, last name, and email of all employees.
SELECT first_name, last_name, email 
FROM employees;

-- Exercise 02
-- Find all employees who have a salary greater than 75000. Display their first name, last name, and salary.
SELECT first_name, last_name, salary 
FROM employees
WHERE salary > 75000;

-- Exercise 03
-- Retrieve all employees who are Software Engineers AND have a salary greater than 70000. Show their full name, job title, and salary.
SELECT first_name, last_name, job_title, salary
FROM employees
WHERE job_title = 'Software Engineer'
AND salary > 70000;

-- Exercise 04
-- Find all employees whose job title is either 'Data Analyst', 'Marketing Manager', or 'Sales Manager'. Display their name and job title.
SELECT first_name, last_name, job_title
FROM employees
WHERE job_title = 'Data Analyst' 
OR job_title ='Marketing Manager' 
OR job_title = 'Sales Manager'

-- Exercise 05
-- Find all employees whose first name starts with the letter 'J'. Display their first name, last name, and email.
SELECT first_name, last_name, email
FROM employees
WHERE first_name LIKE 'J%';

-- Exercise 06
-- List all employees sorted by their hire date, with the most recently hired employees first. Display first name, last name, and hire date.
SELECT first_name, last_name, hire_date
FROM employees
ORDER BY hire_date;

-- Exercise 07
-- Find all employees in department 1, sorted by salary in descending order. Show their name, department ID, and salary. Limit the results to the top 5 highest paid employees in that department.
SELECT first_name, last_name, department_id, salary
FROM employees
WHERE department_id = 1
ORDER BY salary DESC
LIMIT 5;

-- Exercise 08
-- Find all products with a price between 50 and 300 (inclusive). Display the product name, category, and price.
SELECT product_name, category, price
FROM products
WHERE price BETWEEN 50 AND 300;

-- Exercise 09
-- Find all employees who do NOT have a department assigned (department_id IS NULL). Display their first name, last name, and job title.
SELECT first_name, last_name, job_title
FROM employees
WHERE department_id ISNULL;

-- Exercise 10
-- Get a list of all unique job titles in the employees table, sorted alphabetically.
SELECT DISTINCT job_title
FROM employees
ORDER BY job_title;