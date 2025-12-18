-- Exercise 01
SELECT first_name, last_name, email 
FROM employees;

-- Exercise 02

SELECT first_name, last_name, salary 
FROM employees
WHERE salary > 75000;

-- Exercise 03
SELECT first_name, last_name, job_title, salary
FROM employees
WHERE job_title = 'Software Engineer'
AND salary > 70000;

-- Exercise 04
SELECT first_name, last_name, job_title
FROM employees
WHERE job_title = 'Data Analyst' 
OR job_title ='Marketing Manager' 
OR job_title = 'Sales Manager'

-- Exercise 05
SELECT first_name, last_name, email
FROM employees
WHERE first_name LIKE 'J%';

-- Exercise 06
SELECT first_name, last_name, hire_date
FROM employees
ORDER BY hire_date;

-- Exercise 07
SELECT first_name, last_name, department_id, salary
FROM employees
WHERE department_id = 1
ORDER BY salary DESC
LIMIT 5;

-- Exercise 08
SELECT product_name, category, price
FROM products
WHERE price BETWEEN 50 AND 300;

-- Exercise 09
SELECT first_name, last_name, job_title
FROM employees
WHERE department_id ISNULL;

-- Exercise 10
SELECT DISTINCT job_title
FROM employees
ORDER BY job_title;