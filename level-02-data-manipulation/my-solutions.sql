-- Active: 1766060078369@@localhost@5432@sql_mastery

-- Exercise 01
INSERT INTO employees (first_name, last_name, email, phone, hire_date, job_title, salary, department_id)
VALUES ('Alex', 'Turner', 'alex.turner@company.com', '555-0116', '2023-06-01', 'Software Engineer', 70000, '1');

-- Exercise 02
INSERT INTO products (product_name, category, price, stock_quantity, supplier_id, created_date)
VALUES
('Gaming Mouse', 'Electronics', 59.99, 75, 2, '2023-05-20'),
('Monitor Stand', 'Accessories', 34.99, 120, 3, '2023-05-21')

--  Exercise 03
UPDATE employees
SET salary = 60000
WHERE employee_id = 5

-- Exercise 04
UPDATE employees
SET job_title = 'Senior HR Specialist', salary = 65000
WHERE employee_id = 8;

-- Exercise 05
UPDATE employees
SET salary = salary * 1.10
WHERE department_id = 1;

-- Exercise 06
UPDATE employees
SET salary = 58000
WHERE job_title = 'Junior Developer' AND salary > 57000


-- Exercise 07

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
DELETE FROM products
WHERE stock_quantity = 0

-- Exercise 09
BEGIN TRANSACTION;

INSERT INTO employees (first_name, last_name, email, job_title, salary, department_id)
VALUES ('Test', 'USer', 'test.user@company.com', 'Tester', 50000, 1)

UPDATE employees
SET salary = 80000
WHERE employee_id = 1

COMMIT;

-- ROLLBACK; if something went wrong


