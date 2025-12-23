-- Exercise 01
-- Examine the following table design and identify normalization violations:
-- order_details:
-- order_id | customer_name | customer_email | product_name | product_price | quantity | order_date
-- List which normal forms are violated and explain why.
-- 1NF: ✅ OK
-- 2NF: ❌ Violated
--      Partial dependencies: customer_name, customer_email depend only on order_id; product_price depends only on product_name
-- 3NF: ❌ Violated
--      Transitive dependencies: product_price depends on product_name; customer_email depends on customer_name

-- Exercise 02
-- Design a normalized schema (3NF) for the following scenario:
-- A library system needs to track:
--  Books (title, author, ISBN, publication year)
--  Members (name, email, join date)
--  Loans (which member borrowed which book, loan date, return date)
--  Authors can write multiple books
--  Books can have multiple authors
--  Members can borrow multiple books
--  Books can be borrowed by multiple members (at different times)
-- Create the table structures with appropriate primary keys and foreign keys.

-- Step 1: Identify entities and relationships
-- From the scenario:
-- 1. Books
--      Attributes: title, ISBN, publication_year
--      Key: ISBN (unique identifier)
-- 2. Authors
--      Attributes: author_name (could have author_id for uniqueness)
--      One author can write many books
--      One book can have many authors → many-to-many
-- 3. Members
--      Attributes: name, email, join_date
--      Key: member_id (unique)
-- 4. Loans
--      Which member borrowed which book, plus loan_date and return_date
--      Many-to-many between Members and Books over time

-- Step 2: Resolve many-to-many relationships
-- Books ↔ Authors
-- Need a join table:
--  Book_Authors
--      isbn (FK to Books)
--      author_id (FK to Authors)
--      Primary Key: (isbn, author_id)
-- Books ↔ Members (Loans)
-- Another join table:
--  Loans
--      loan_id (PK)
--      member_id (FK to Members)
--      isbn (FK to Books)
--      loan_date
--      return_date

-- Step 3: Final normalized tables (3NF)
-- 1 Books
CREATE TABLE Books (
    isbn VARCHAR PRIMARY KEY,
    title VARCHAR NOT NULL,
    publication_year INT
);
-- 2 Authors
CREATE TABLE Authors (
    author_id SERIAL PRIMARY KEY,
    author_name VARCHAR NOT NULL
);
-- 3 Book_Authors (resolves many-to-many)
CREATE TABLE Book_Authors (
    isbn VARCHAR REFERENCES Books (isbn),
    author_id INT REFERENCES Authors (author_id),
    PRIMARY KEY (isbn, author_id)
);
-- 4 Members
CREATE TABLE Members (
    member_id SERIAL PRIMARY KEY,
    member_name VARCHAR NOT NULL,
    email VARCHAR UNIQUE NOT NULL,
    join_date DATE
);
-- 5 Loans (tracks which member borrowed which book)
CREATE TABLE Loans (
    loan_id SERIAL PRIMARY KEY,
    member_id INT REFERENCES Members (member_id),
    isbn VARCHAR REFERENCES Books (isbn),
    loan_date DATE NOT NULL,
    return_date DATE
);

-- Step 4: Why this is 3NF
-- 1NF: All columns are atomic, no repeating groups
-- 2NF: All non-key columns fully depend on the whole primary key
-- Example: in Book_Authors, (isbn, author_id) is composite key, no partial dependency
-- 3NF: No transitive dependencies
-- All non-key columns depend only on the primary key of their table

-- Exercise 03
-- Based on our database schema, create indexes for:
--  1. Foreign key: employees.department_id
--  2. Frequently queried: orders.order_date
--  3. Composite: orders(customer_id, order_date) for queries filtering by both
-- Write the CREATE INDEX statements.
-- 1. Foreign key: employees.department_id
CREATE INDEX idx_employees_department_id ON employees (department_id);
--  2. Frequently queried: orders.order_date
CREATE INDEX idx_orders_order_date ON orders (order_date);
--  3. Composite: orders(customer_id, order_date) for queries filtering by both
CREATE INDEX idx_orders_customer_order_date ON orders (customer_id, order_date);

-- Exercise 04
SELECT
    e.first_name,
    e.last_name,
    d.department_name
FROM employees AS e
INNER JOIN departments AS d ON e.department_id = d.department_id
WHERE e.salary > 70000
ORDER BY e.salary DESC;
-- What indexes would improve this query's performance? Explain why.
CREATE INDEX idx_employees_salary_department ON employees (salary DESC, department_id);
-- Why:
--  Speeds up the WHERE e.salary > 70000 filter.
--  Helps the JOIN on department_id.
--  Supports ORDER BY e.salary DESC without extra sorting.
-- No new index needed on departments because department_id is already the primary key.

-- Exercise 05
-- You have a normalized orders table and order_items table. For a reporting dashboard that shows order totals, you're considering adding a total_amount column directly to the orders table (denormalization).
-- Discuss the trade-offs:
--  What are the benefits?
--      Faster queries for dashboards/reports.
--      Simpler queries, no need to JOIN and SUM order_items.
--  What are the risks?
--      Data inconsistency if order_items change.
--      Extra maintenance to keep totals accurate.
--      Storage redundancy.
--  When would this be acceptable?
--      Read-heavy reporting, large datasets, with mechanisms to keep totals updated.
--  When would you avoid it?
--      Write-heavy systems, frequent item updates, or strict consistency requirements.