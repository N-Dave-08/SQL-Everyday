-- =========================================
-- STORED PROCEDURES
-- =========================================

-- =========================================
-- Procedure: greet_user
-- Purpose: Prints a greeting for a user
-- =========================================

CREATE OR REPLACE PROCEDURE greet_user(name TEXT)
LANGUAGE plpgsql
AS $$
BEGIN
    RAISE NOTICE 'Hello, %!', name;  -- Prints message to console
END;
$$;

-- Call the procedure
CALL greet_user('Ian');
-- Output in console:
-- NOTICE:  Hello, Ian!

-- =========================================
-- Step 1: Drop the procedure if it already exists
-- =========================================
DROP PROCEDURE IF EXISTS get_employees_by_department(INT, REFCURSOR);

-- =========================================
-- Step 2: Create the procedure
-- =========================================
CREATE PROCEDURE get_employees_by_department(
    dept_id INT,           -- Input: department ID
    INOUT ref REFCURSOR    -- INOUT: cursor to return result set
)
LANGUAGE plpgsql
AS $$
BEGIN
    -- Name the cursor
    ref := 'emp_cursor';

    -- Open the cursor for the query
    OPEN ref FOR
    SELECT first_name, last_name, salary
    FROM employees
    WHERE department_id = dept_id;
END;
$$;

-- =========================================
-- Step 3: Procedure usage (run separately)
-- =========================================
/*
   The following block should be run manually or in a runtime script:

   BEGIN;  -- Start transaction

       -- Call the procedure for department_id = 1
       CALL get_employees_by_department(1, 'emp_cursor');

       -- Fetch all rows from the cursor
       FETCH ALL FROM emp_cursor;

   COMMIT;  -- End transaction

   Notes:
   - The procedure itself does not return a table directly.
   - FETCH must be done inside a transaction.
   - Keep this separate from the main SQL script to avoid linter issues.
*/


-- =========================================
-- STORED FUNCTIONS
-- =========================================

-- =========================================
-- Function: add_two_numbers
-- Purpose: Adds two numbers and returns the result
-- =========================================

CREATE OR REPLACE FUNCTION add_two_numbers(a INT, b INT)  -- Function name and input parameters
RETURNS INT                                              -- Returns a single integer (scalar value)
LANGUAGE sql                                             -- Simple SQL function (no procedural logic needed)
AS $$
    -- Return the sum of a and b
    SELECT a + b;
$$;

-- =========================================
-- Usage example: Call the function
-- =========================================

SELECT add_two_numbers(3, 5);  -- Output: 8

-- =========================================
-- Function: get_department_payroll
-- Purpose: Returns total payroll for a given department
-- =========================================

CREATE OR REPLACE FUNCTION get_department_payroll(dept_id INT)
RETURNS DECIMAL(10, 2)  -- The function returns a single number (scalar)
-- DECIMAL(10,2): total 10 digits, 2 after the decimal
LANGUAGE plpgsql          -- Using PostgreSQL procedural language
AS $$
DECLARE
    -- Declare a variable to store the total salary
    total DECIMAL(10, 2);
BEGIN
    -- Calculate the total salary for the given department
    -- SUM(salary) adds up all salaries
    -- INTO total stores the result in the variable 'total'
    SELECT SUM(salary) INTO total
    FROM employees
    WHERE department_id = dept_id;

    -- Return the calculated total as the function output
    RETURN total;
END;
$$;

-- =========================================
-- Usage example: Get total payroll per department
-- =========================================

SELECT
    department_id,                           -- Show department ID
    get_department_payroll(department_id) AS total_payroll  -- Call the function for each department
FROM departments;


-- =========================================
-- VARIABLES
-- =========================================

-- =========================================================
-- Function: get_employee_stats
-- Purpose: Calculate and return statistics for employees
-- Returns: A table with two columns:
--          1. total_employees - total number of employees
--          2. avg_salary - average salary of employees
-- Language: PL/pgSQL
-- =========================================================

CREATE OR REPLACE FUNCTION get_employee_stats()
RETURNS TABLE (
    total_employees INT,       -- Column for total employees count
    avg_salary DECIMAL(10, 2)   -- Column for average salary
)
LANGUAGE plpgsql
AS $$
-- ================================
-- DECLARE block: Local variables
-- ================================
DECLARE
    employee_count INT;        -- Temporary variable to store total employees
    avg_sal DECIMAL(10,2);     -- Temporary variable to store average salary
BEGIN
    -- ===========================================
    -- Calculate total number of employees
    -- ===========================================
    SELECT COUNT(*) 
    INTO employee_count           -- Store the result in the variable employee_count
    FROM employees;              -- From the employees table

    -- ===========================================
    -- Calculate average salary of employees
    -- ===========================================
    SELECT AVG(salary) 
    INTO avg_sal                  -- Store the result in avg_sal
    FROM employees;              -- From the employees table

    -- ===========================================
    -- Return the results as a table
    -- ===========================================
    RETURN QUERY 
    SELECT 
        employee_count,           -- Return total employees
        avg_sal;                  -- Return average salary
END;
$$;
-- Call the function to get employee statistics
SELECT
    total_employees,
    avg_salary
FROM get_employee_stats();


-- =========================================================
-- Function: check_employee_count
-- Purpose: Check the number of employees in a department 
--          and return a descriptive text.
-- Input: dept_id (INT) - the department to check
-- Returns: TEXT
--          - 'Large Department' if employee count > 10
--          - 'Small Department' if employee count <= 10
-- Language: PL/pgSQL
-- =========================================================

CREATE OR REPLACE FUNCTION check_employee_count(dept_id INT)
RETURNS TEXT
LANGUAGE plpgsql
AS $$
-- ================================
-- DECLARE block: Local variables
-- ================================
DECLARE
    emp_count INT;  -- Variable to store the number of employees in the department
BEGIN
    -- ===========================================
    -- Count the number of employees in the given department
    -- ===========================================
    SELECT COUNT(*) 
    INTO emp_count          -- Store the result into emp_count
    FROM employees
    WHERE department_id = dept_id;  -- Filter by input department ID

    -- ===========================================
    -- Conditional logic to return descriptive text
    -- ===========================================
    IF emp_count > 10 THEN
        -- If there are more than 10 employees, it's considered a large department
        RETURN 'Large Department';
    ELSE
        -- Otherwise, it's considered a small department
        RETURN 'Small Department';
    END IF;
END;
$$;
-- Check the size of department with ID 1
SELECT check_employee_count(1) AS department_size;
