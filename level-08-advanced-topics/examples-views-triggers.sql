-- =========================================================
-- VIEWS
-- =========================================================

-- =========================================================
-- View: employee_summary
-- Purpose: Provide a quick summary of employees
--          including full name, job title, salary, and department
-- =========================================================

-- Drop the view if it already exists
DROP VIEW IF EXISTS employee_summary;

-- Create the view
CREATE OR REPLACE VIEW employee_summary AS
-- =========================================================
-- SELECT statement defines the data returned by the view
-- =========================================================
SELECT
    e.employee_id,                              -- Unique ID of the employee
    e.job_title,                                -- Employee's job title
    e.salary,                                   -- Employee's salary
    d.department_name,                          -- Name of the department
    CONCAT(e.first_name, ' ', e.last_name) AS full_name -- Concatenate first and last name
FROM
    employees AS e                              -- From the employees table
LEFT JOIN
    departments AS d                            -- Join departments table
    ON e.department_id = d.department_id;       -- Match department_id

-- =========================================================
-- Query the view just like a regular table
-- =========================================================
SELECT
    full_name,
    salary,
    department_name,
    job_title
FROM employee_summary
WHERE salary > 70000;


-- =========================================================
-- VIEWS WITH AGGREGATES
-- =========================================================

-- =========================================================
-- View: department_stats
-- Purpose: Provide summary statistics for each department
--          including employee count, average salary, and total payroll
-- =========================================================

-- Drop the view if it already exists
DROP VIEW IF EXISTS department_stats;

-- Create the view
CREATE VIEW department_stats AS
-- =========================================================
-- SELECT statement defines the data returned by the view
-- =========================================================
SELECT
    d.department_name,                   -- Name of the department
    COUNT(e.employee_id) AS employee_count,  -- Total number of employees in the department
    AVG(e.salary) AS avg_salary,         -- Average salary of employees in the department
    SUM(e.salary) AS total_payroll       -- Total payroll (sum of salaries) for the department
FROM
    departments AS d                     -- From the departments table
LEFT JOIN
    employees AS e                        -- Join employees table
    ON d.department_id = e.department_id  -- Match department_id
GROUP BY
    d.department_name;                   -- Group by department name to aggregate statistics

-- =========================================================
-- Querying the view
-- =========================================================

-- Select specific columns explicitly (avoids SQLFluff AM04 warning)
SELECT
    department_name,
    employee_count,
    avg_salary,
    total_payroll
FROM department_stats
ORDER BY avg_salary DESC;    -- Order departments by average salary in descending order


-- =========================================================
-- UPDATING VIEWS
-- =========================================================
-- =========================================================
-- View: employee_summary
-- Purpose: Provide a summary of employees including
--          first name, last name, salary, department, and hire date
-- =========================================================

-- =========================================================
-- Modify or create the view
-- =========================================================
CREATE OR REPLACE VIEW employee_summary AS
SELECT
    e.employee_id,                               -- Unique ID of the employee
    e.job_title,                                 -- Employee's job title
    e.salary,                                    -- Employee's salary
    d.department_name,                           -- Name of the department the employee belongs to
    CONCAT(e.first_name, ' ', e.last_name) AS full_name, -- Combine first and last name
    e.hire_date                                  -- Employee's hire date (newly added column)
FROM
    employees AS e                               -- Base table: employees
INNER JOIN
    departments AS d                             -- Base table: departments
    ON e.department_id = d.department_id;        -- Join employees with departments

-- =========================================================
-- Step 3: Query the view
-- Purpose: Demonstrate how to use the view as a regular table
-- =========================================================
SELECT
    employee_id,
    job_title,
    salary,
    department_name,
    full_name,
    hire_date
FROM employee_summary
ORDER BY salary DESC; -- Example: list employees by highest salary

-- =========================================================
-- Drop the view if no longer needed
-- =========================================================
DROP VIEW employee_summary;


-- =========================================================
-- MATERIALIZED VIEWS WITH AGGREGATES
-- =========================================================

-- =========================================================
-- Materialized View: department_stats_mv
-- Purpose: Provide cached summary statistics for each department
--          including employee count and average salary.
--          This materialized view improves performance for
--          reporting and analytics queries.
-- =========================================================

-- Drop the materialized view if it already exists
DROP MATERIALIZED VIEW IF EXISTS department_stats_mv;

-- Create the materialized view
CREATE MATERIALIZED VIEW department_stats_mv AS
-- =========================================================
-- SELECT statement defines the data stored in the materialized view
-- =========================================================
SELECT
    d.department_name,                      -- Name of the department
    COUNT(e.employee_id) AS employee_count, -- Total number of employees per department
    AVG(e.salary) AS avg_salary             -- Average salary of employees per department
FROM
    departments AS d                        -- Base table containing department details
LEFT JOIN
    employees AS e                          -- Employees table
    ON d.department_id = e.department_id    -- Match employees to their departments
GROUP BY
    d.department_name;                      -- Group by department to compute aggregates

-- =========================================================
-- Refreshing the materialized view
-- =========================================================
-- Materialized views do NOT update automatically.
-- Run this command whenever underlying data changes
-- and fresh results are required.
REFRESH MATERIALIZED VIEW department_stats_mv;

-- =========================================================
-- Querying the materialized view
-- =========================================================

-- Select columns explicitly (avoids SQLFluff AM04 warning)
SELECT
    department_name,
    employee_count,
    avg_salary
FROM department_stats_mv
ORDER BY
    avg_salary DESC;    -- Order departments by highest average salary


-- =========================================================
-- TRIGGERS WITH AUDIT LOGGING
-- =========================================================

-- =========================================================
-- Table: employee_audit
-- Purpose: Keep track of changes made to employees table
--          including which employee was updated and the timestamp
-- =========================================================

-- Drop the audit table if it already exists
DROP TABLE IF EXISTS employee_audit;

-- Create audit table
CREATE TABLE employee_audit (
    audit_id SERIAL PRIMARY KEY,          -- Unique ID for each audit record (auto-incremented)
    employee_id INTEGER NOT NULL,         -- ID of the employee that was changed
    action_type VARCHAR(10) NOT NULL,          -- Action performed (e.g., 'UPDATE')
    changed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP  -- Timestamp of when the change occurred
);

-- =========================================================
-- Trigger Function: log_employee_update()
-- Purpose: Automatically insert a record into employee_audit
--          whenever an employee record is updated
-- =========================================================

-- Drop the function if it already exists
DROP FUNCTION IF EXISTS log_employee_update();

-- Create the trigger function
CREATE OR REPLACE FUNCTION LOG_EMPLOYEE_UPDATE()
RETURNS TRIGGER AS $$
BEGIN
    -- Insert a new row into the audit table whenever an update occurs
    INSERT INTO employee_audit (employee_id, action)
    VALUES (NEW.employee_id, 'UPDATE');

    -- RETURN NEW is required for AFTER triggers in PostgreSQL
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- =========================================================
-- Trigger: log_employee_changes
-- Purpose: Attach the trigger function to the employees table
-- =========================================================

-- Drop the trigger if it already exists
DROP TRIGGER IF EXISTS log_employee_changes ON employees;

-- Create the trigger
CREATE TRIGGER log_employee_changes
AFTER UPDATE ON employees              -- Fires after any UPDATE on the employees table
FOR EACH ROW                            -- Executes once for every row affected
EXECUTE FUNCTION LOG_EMPLOYEE_UPDATE(); -- Calls the trigger function

-- =========================================================
-- Querying the audit table
-- =========================================================

-- View all audit records to see employee changes
SELECT
    d.department_name,
    COUNT(e.employee_id) AS employee_count
FROM departments AS d
LEFT JOIN employees AS e ON d.department_id = e.department_id
GROUP BY d.department_name;

