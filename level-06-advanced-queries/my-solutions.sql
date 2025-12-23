-- Exercise 01
-- Create a CTE that selects all employees with salary greater than 70000, then select all columns from that CTE.
WITH high_emp_salary AS (
    SELECT
        first_name,
        last_name,
        salary
    FROM employees
    WHERE salary > 70000
)
SELECT * FROM high_emp_salary;

-- Exercise 02
-- Use a CTE to find all employees in the Engineering department. The CTE should join employees and departments. Then select employee names and department name from the CTE.
WITH eng_employees AS (
    SELECT
        e.first_name,
        e.last_name,
        e.department_id,
        d.department_name
    FROM employees AS e
    INNER JOIN departments AS d ON e.department_id = d.department_id
)
SELECT
    first_name,
    department_name
FROM eng_employees;

-- Exercise 03
-- Create two CTEs:
--  1. high_budget_depts: Departments with budget > 400000
--  2. dept_employees: Employees in those departments
-- Then join them to show employee names and department names.
WITH
high_budget_depts AS (
    SELECT
        department_id,
        department_name,
        budget
    FROM departments
    WHERE budget > 400000
),
dept_employees AS (
    SELECT
        e.first_name,
        e.last_name,
        hbd.department_name
    FROM high_budget_depts AS hbd
    INNER JOIN employees AS e
        ON hbd.department_id = e.department_id
)
SELECT * FROM dept_employees;

-- Exercise 04
-- Rank employees within each department by salary (highest first). Use ROW_NUMBER(). Show first_name, last_name, department_id, salary, and rank.
SELECT
    first_name,
    last_name,
    department_id,
    salary,
    ROW_NUMBER() OVER (PARTITION BY department_id ORDER BY salary DESC) AS salary_rank
FROM employees;

-- Exercise 05
-- Write two queries:
--  1. Use RANK() to rank all employees by salary
--  2. Use DENSE_RANK() to rank all employees by salary
-- Compare the results when there are ties.
SELECT
    first_name,
    last_name,
    salary,
    RANK() OVER (ORDER BY salary DESC) AS salary_rank
FROM employees;

SELECT
    first_name,
    last_name,
    salary,
    DENSE_RANK() OVER (ORDER BY salary DESC) AS salary_rank
FROM employees;

-- Exercise 06
-- Show each employee's salary along with the average salary in their department. Use AVG() OVER with PARTITION BY. Show first_name, salary, department_id, and dept_avg_salary.
SELECT
    first_name,
    salary,
    department_id,
    AVG(salary) OVER (PARTITION BY department_id) AS dept_avg_salary
FROM employees;

-- Exercise 07
-- Calculate a running total of salaries, ordered by employee_id. Use SUM() OVER with ORDER BY. Show employee_id, first_name, salary, and running_total.
SELECT
    employee_id,
    first_name,
    salary,
    SUM(salary) OVER (ORDER BY employee_id) AS running_total
FROM employees;

-- Exercise 08
-- For each employee (ordered by salary), show their salary and the previous employee's salary. Use LAG(). Show first_name, salary, and previous_salary.
SELECT
    first_name,
    salary,
    LAG(salary) OVER (ORDER BY salary) AS previous_salary
FROM employees;

-- Exercise 09
-- Find the top 2 highest paid employees in each department. Use ROW_NUMBER() in a CTE, then filter. Show first_name, last_name, department_id, and salary.
WITH top_salary_emp AS (
    SELECT
        first_name,
        salary,
        department_id,
        ROW_NUMBER() OVER (PARTITION BY department_id ORDER BY salary) AS dept_salary_rank
    FROM employees
)
SELECT * FROM top_salary_emp
WHERE dept_salary_rank <= 2;

-- Exercise 10
-- Create a query that:
--  1. Uses a CTE to calculate department statistics (avg salary, employee count)
--  2. Uses window functions to rank departments by average salary
--  3. Shows department_name, avg_salary, emp_count, and rank
WITH
dept_stats AS (
    SELECT
        department_id,
        AVG(salary) AS dept_avg_salary,
        COUNT(*) AS emp_count
    FROM employees
    GROUP BY department_id
),
dept_rank AS (
    SELECT
        ds.*,
        RANK() OVER (ORDER BY ds.dept_avg_salary DESC) AS dept_salary_rank
    FROM dept_stats AS ds
)
SELECT
    d.department_name,
    dr.dept_avg_salary,
    dr.emp_count,
    dr.dept_salary_rank
FROM dept_rank AS dr
INNER JOIN departments AS d ON dr.department_id = d.department_id
ORDER BY dr.dept_salary_rank;

SELECT
    department_id,
    AVG(salary) OVER (PARTITION BY department_id) AS dept_avg_salary,
    COUNT(*) OVER (PARTITION BY department_id) AS emp_count
FROM employees;
