-- Exerice 01
-- Create a view called employee_department_view that shows:
--  employee_id
--  first_name
--  last_name
--  department_name
--  salary
-- The view should join employees and departments tables.
-- Then query the view to find employees with salary > 70000.

CREATE OR REPLACE VIEW employee_department_view AS
SELECT
    e.employee_id,
    e.first_name,
    e.last_name,
    d.department_name,
    e.salary
FROM employees AS e
INNER JOIN departments AS d ON e.department_id = d.department_id;

SELECT
    edv.employee_id,
    edv.first_name,
    edv.last_name,
    edv.department_name,
    edv.salary
FROM employee_department_view AS edv
WHERE edv.salary > 70000;

-- Exercise 01
-- Create a view called department_summary that shows:
--  department_name
--  employee_count
--  average_salary
--  total_payroll
-- Query the view to find departments with more than 3 employees.
CREATE OR REPLACE VIEW department_summary_view AS
SELECT
    d.department_name,
    COUNT(e.employee_id) AS employee_count,
    AVG(e.salary) AS avg_salary,
    SUM(e.salary) AS total_payroll
FROM departments AS d
LEFT JOIN employees AS e ON d.department_id = e.department_id
GROUP BY d.department_name;

SELECT
    dsv.department_name,
    dsv.employee_count,
    dsv.avg_salary,
    dsv.total_payroll
FROM department_summary_view AS dsv
WHERE dsv.employee_count > 3;

-- Exercise 03
-- Write a transaction that:
-- 1. Inserts a new employee
-- 2. Updates the department's employee count (if you have such a column, or just practice the pattern)
-- 3. If both succeed, commit; if either fails, rollback
-- Test the transaction and verify the results.

BEGIN;  -- Start transaction

-- 1. Insert a new employee (auto-generated ID)
INSERT INTO employees (first_name, last_name, department_id, salary, hire_date)
VALUES ('John', 'Doe', 1, 75000, CURRENT_DATE);

-- 2. Practice updating department info using a subquery
-- This doesn't require a real employee_count column
-- Just prints out the current count for demonstration
SELECT
    d.department_id,
    d.department_name,
    (
        SELECT COUNT(*) FROM employees AS e
        WHERE e.department_id = d.department_id
    ) AS employee_count
FROM departments AS d
WHERE d.department_id = 1;

-- Intentional error: update non-existent column
UPDATE departments SET employee_count = employee_count + 1
WHERE department_id = 1;

-- Commit if everything succeeds
COMMIT;

ROLLBACK;

-- verify
SELECT
    employee_id,
    first_name,
    last_name,
    department_id,
    salary,
    hire_date
FROM employees
WHERE first_name = 'John' AND last_name = 'Doe';

SELECT
    d.department_id,
    d.department_name,
    (
        SELECT COUNT(*) FROM employees AS e
        WHERE e.department_id = d.department_id
    ) AS employee_count
FROM departments AS d
WHERE d.department_id = 1;


-- Exercise 05
-- Explain in your own words:
-- 1. What is a dirty read?
-- 2. What is a non-repeatable read?
-- 3. What is a phantom read?
-- 4. How do different isolation levels prevent these issues?

-- 1. Dirty Read: Reading uncommitted changes from another transaction.
-- 2. Non-Repeatable Read: Reading the same row twice in a transaction returns different values because another transaction modified it.
-- 3. Phantom Read: Reading a set of rows twice returns different sets because another transaction inserted or deleted rows.
-- 4. Isolation Levels:
--      Read Uncommitted: All three can happen.
--      Read Committed: Prevents dirty reads.
--      Repeatable Read: Prevents dirty and non-repeatable reads.
--      Serializable: Prevents all three, including phantom reads.


-- Exercise 06
-- Create a view called public_employee_info that shows only:
--  employee_id
--  first_name
--  last_name
--  job_title
-- (Exclude sensitive information like salary and email)
-- Query the view to verify it works.

CREATE OR REPLACE VIEW public_employee_info AS
SELECT
    employee_id,
    first_name,
    last_name,
    job_title
FROM employees;

SELECT
    employee_id,
    first_name,
    last_name,
    job_title
FROM public_employee_info
ORDER BY employee_id
LIMIT 10;

-- Exercise 07
-- Explain when you would use a materialized view vs a regular view. What are the trade-offs?
-- Regular View: Virtual table, always shows current data, no storage used, can be slow for complex queries.
-- Materialized View: Stores query results physically, faster for complex queries, uses storage, data can be stale until refreshed.
-- Trade-off: Regular = always fresh but slower; Materialized = fast but may be outdated and requires refresh.


-- Exercise 08
-- Design a trigger that would:
--  Log changes to employee salaries
--  Store old salary, new salary, employee_id, and timestamp
-- Write the trigger definition (syntax may vary by database).
-- Note: If your database supports triggers, try implementing it. Otherwise, write the conceptual design.

-- ============================================
-- 1️⃣ Create a log table to store salary changes
-- ============================================
CREATE TABLE employee_salary_log (
    log_id SERIAL PRIMARY KEY,           -- Unique ID for each log entry
    employee_id INT NOT NULL,            -- ID of the employee whose salary changed
    old_salary NUMERIC(10, 2),            -- Salary before the change
    new_salary NUMERIC(10, 2),            -- Salary after the change
    changed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP  -- Time of the change
);

-- ============================================
-- 2️⃣ Create a trigger function to log changes
-- ============================================
CREATE OR REPLACE FUNCTION LOG_SALARY_CHANGE()
RETURNS TRIGGER AS $$
BEGIN
    -- Check if the salary actually changed
    IF NEW.salary <> OLD.salary THEN
        -- Insert a new record into the log table
        INSERT INTO employee_salary_log (
            employee_id,    -- Employee ID
            old_salary,     -- Previous salary
            new_salary,     -- Updated salary
            changed_at      -- Current timestamp
        )
        VALUES (
            OLD.employee_id,
            OLD.salary,
            NEW.salary,
            CURRENT_TIMESTAMP
        );
    END IF;

    -- Return the new row so the update can proceed
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- ============================================
-- 3️⃣ Attach the trigger to the employees table
-- ============================================
CREATE TRIGGER trigger_salary_update
AFTER UPDATE OF salary ON employees   -- Trigger fires only when 'salary' column is updated
FOR EACH ROW                           -- Trigger executes for each updated row individually
EXECUTE FUNCTION LOG_SALARY_CHANGE();   -- Calls the function defined above
