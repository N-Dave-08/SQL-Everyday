-- Active: 1766060078369@@localhost@5432@sql_mastery

-- Exercise 01
-- Add a new employee to the database with the following information:

-- First name: 'Alex'
-- Last name: 'Turner'
-- Email: 'alex.turner@company.com'
-- Phone: '555-0116'
-- Hire date: '2023-06-01'
-- Job title: 'Software Engineer'
-- Salary: 70000
-- Department ID: 1

-- After inserting, write a SELECT query to verify the employee was added correctly.
INSERT INTO employees (first_name, last_name, email, phone, hire_date, job_title, salary, department_id)
VALUES ('Alex', 'Turner', 'alex.turner@company.com', '555-0116', '2023-06-01', 'Software Engineer', 70000, '1');

-- Exercise 02
-- Add two new products to the database in a single INSERT statement:

-- Product 1:
-- Name: 'Gaming Mouse'
-- Category: 'Electronics'
-- Price: 59.99
-- Stock quantity: 75
-- Supplier ID: 2
-- Created date: '2023-05-20'

-- Product 2:
-- Name: 'Monitor Stand'
-- Category: 'Accessories'
-- Price: 34.99
-- Stock quantity: 120
-- Supplier ID: 3
-- Created date: '2023-05-21'

-- Verify both products were added.
INSERT INTO products (product_name, category, price, stock_quantity, supplier_id, created_date)
VALUES
('Gaming Mouse', 'Electronics', 59.99, 75, 2, '2023-05-20'),
('Monitor Stand', 'Accessories', 34.99, 120, 3, '2023-05-21')

--  Exercise 03
-- Give employee ID 5 a raise. Update their salary to 60000.
UPDATE employees
SET salary = 60000
WHERE employee_id = 5

-- Exercise 04
-- Update employee ID 8 (Amanda Davis) to:

-- Change job title to 'Senior HR Specialist'
-- Increase salary to 65000

-- Use a single UPDATE statement.
UPDATE employees
SET job_title = 'Senior HR Specialist', salary = 65000
WHERE employee_id = 8;

-- Exercise 05
-- Give all employees in department 1 (Engineering) a 10% salary increase.

-- Important:
--  1. First, write a SELECT query to see which employees will be affected
--  2. Calculate what the new salaries will be
--  3. Then write and execute the UPDATE statement
--  4. Verify the changes with a SELECT query
UPDATE employees
SET salary = salary * 1.10
WHERE department_id = 1;

-- Exercise 06
-- Update all 'Junior Developer' employees who have a salary less than 57000. Set their salary to 58000.
-- Safety check: Use SELECT first to see which employees will be affected.
UPDATE employees
SET salary = 58000
WHERE job_title = 'Junior Developer' AND salary > 57000


-- Exercise 07
-- Delete the product with product_id = 12 (Laptop Stand).

-- Before deleting:
-- Write a SELECT query to see the product that will be deleted
-- Then execute the DELETE statement
-- Verify it was deleted with another SELECT query
-- For deleting a row with relations

-- solution 01
-- deleting dependent rows first (manual)
 DELETE FROM order_items
 WHERE product_id = 12;

 DELETE FROM products
 WHERE product_id = 12;

-- solution 02
-- using ON CASCADE (automatic)
ALTER TABLE order_items
DROP CONSTRAINT order_items_product_id_fkey;

ALTER TABLE order_items
ADD CONSTRAINT order_items_product_id_fkey
FOREIGN KEY (product_id)
REFERENCES products(product_id)
ON DELETE CASCADE;

DELETE FROM products
WHERE product_id = 12;

-- Exercise 08
-- Delete all products that have a stock quantity of 0 (if any exist).
-- Safety check:
--  1. First, check if any products have stock_quantity = 0
--  2. If there are any, see which products will be deleted
--  3. Then execute the DELETE statement

DELETE FROM products
WHERE stock_quantity = 0

-- Exercise 09
-- Use a transaction to:
--  1. Insert a new employee: 'Test', 'User', 'test.user@company.com', 'Tester', 50000, department_id = 1
--  2. Update employee ID 1's salary to 80000
--  3. Check the results with SELECT queries
--  4. If everything looks correct, COMMIT the transaction
--  5.  If something is wrong, ROLLBACK the transaction
-- Note: Transaction syntax varies by database. Use the appropriate syntax for your database.
BEGIN TRANSACTION;

INSERT INTO employees (first_name, last_name, email, job_title, salary, department_id)
VALUES ('Test', 'USer', 'test.user@company.com', 'Tester', 50000, 1)

UPDATE employees
SET salary = 80000
WHERE employee_id = 1

COMMIT;

-- ROLLBACK; if something went wrong

-- Exercise 10
-- Create a backup of all employees from department 2:

--  1. First, create a new table called employees_backup with the same structure as employees
--      Hint: CREATE TABLE employees_backup AS SELECT * FROM employees WHERE 1=0;
--  2. Then, insert all employees from department 2 into the backup table
--  3. Verify the backup was created correctly





