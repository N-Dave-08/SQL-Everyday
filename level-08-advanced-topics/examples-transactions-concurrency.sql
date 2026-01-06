-- =========================================================
-- TRANSACTION EXAMPLE: Updating Employee Department and Job Title
-- =========================================================

-- Start a transaction
BEGIN TRANSACTION;

-- Move employee 5 to a new department
UPDATE employees
SET department_id = 2
WHERE employee_id = 5;

-- Update employee 5's job title
UPDATE employees
SET job_title = 'Senior Data Analyst'
WHERE employee_id = 5;

-- Save changes if everything succeeds
COMMIT;

-- Undo changes if there’s an error
-- ROLLBACK;


-- =========================================================
-- TRANSACTION WITH ERROR HANDLING (PostgreSQL)
-- =========================================================

DO $$
BEGIN
    -- Start a transaction
    BEGIN

        -- Step 1: Insert a new employee
        INSERT INTO employees (first_name, last_name, email)
        VALUES ('John', 'Doe', 'john@company.com');

        -- Step 2: Update employee count in the department
        UPDATE departments
        SET employee_count = employee_count + 1
        WHERE department_id = 1;

        -- Step 3: Commit if both statements succeed
        COMMIT;

    EXCEPTION
        WHEN OTHERS THEN
            -- Step 4: Rollback if any statement fails
            ROLLBACK;
            -- Optional: raise a notice or log the error
            RAISE NOTICE 'An error occurred. Transaction rolled back.';
    END;
END $$;


-- =========================================================
-- SAVEPOINTS
-- =========================================================

-- Start a transaction
DO $$
BEGIN
    -- Start the transaction
    BEGIN;

    -- Insert a new employee
    INSERT INTO employees (first_name, last_name, email)
    VALUES ('John', 'Doe', 'john@company.com');

    -- Create a savepoint after the insert
    SAVEPOINT sp1;

    -- Update the employee's salary
    UPDATE employees
    SET salary = 80000
    WHERE employee_id = 1;

    -- Rollback to savepoint if something goes wrong
    ROLLBACK TO SAVEPOINT sp1;

    -- Commit the transaction
    COMMIT;

END;
$$;
