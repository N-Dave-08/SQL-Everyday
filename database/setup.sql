-- SQL Mastery Course Database Setup
-- Optimized for PostgreSQL
-- Run this script to create all tables and sample data

-- ============================================
-- LEVEL 1-2: Basic Tables
-- ============================================

-- Employees table (for Level 1-2 fundamentals)
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (
    employee_id INTEGER PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100),
    phone VARCHAR(20),
    hire_date DATE,
    job_title VARCHAR(100),
    salary DECIMAL(10, 2),
    department_id INTEGER
);

INSERT INTO employees (employee_id, first_name, last_name, email, phone, hire_date, job_title, salary, department_id) VALUES
(1, 'John', 'Smith', 'john.smith@company.com', '555-0101', '2020-01-15', 'Software Engineer', 75000.00, 1),
(2, 'Sarah', 'Johnson', 'sarah.johnson@company.com', '555-0102', '2019-03-20', 'Data Analyst', 68000.00, 2),
(3, 'Michael', 'Williams', 'michael.williams@company.com', '555-0103', '2021-06-10', 'Software Engineer', 72000.00, 1),
(4, 'Emily', 'Brown', 'emily.brown@company.com', '555-0104', '2018-11-05', 'Marketing Manager', 85000.00, 3),
(5, 'David', 'Jones', 'david.jones@company.com', '555-0105', '2022-02-14', 'Junior Developer', 55000.00, 1),
(6, 'Jessica', 'Garcia', 'jessica.garcia@company.com', '555-0106', '2020-09-30', 'Data Analyst', 70000.00, 2),
(7, 'Christopher', 'Miller', 'christopher.miller@company.com', '555-0107', '2019-07-22', 'Senior Engineer', 95000.00, 1),
(8, 'Amanda', 'Davis', 'amanda.davis@company.com', '555-0108', '2021-04-18', 'HR Specialist', 60000.00, 4),
(9, 'James', 'Rodriguez', 'james.rodriguez@company.com', '555-0109', '2020-12-01', 'Software Engineer', 78000.00, 1),
(10, 'Lisa', 'Martinez', 'lisa.martinez@company.com', '555-0110', '2018-05-15', 'Sales Manager', 90000.00, 5),
(11, 'Robert', 'Hernandez', 'robert.hernandez@company.com', '555-0111', '2022-08-20', 'Junior Developer', 56000.00, 1),
(12, 'Maria', 'Lopez', 'maria.lopez@company.com', '555-0112', '2019-10-10', 'Data Analyst', 69000.00, 2),
(13, 'Daniel', 'Wilson', 'daniel.wilson@company.com', '555-0113', '2021-01-25', 'Software Engineer', 74000.00, 1),
(14, 'Jennifer', 'Anderson', 'jennifer.anderson@company.com', '555-0114', '2020-03-12', 'Marketing Specialist', 65000.00, 3),
(15, 'Thomas', 'Thomas', 'thomas.thomas@company.com', '555-0115', '2018-08-08', 'Senior Engineer', 98000.00, 1);

-- Products table (for Level 1-2)
DROP TABLE IF EXISTS products;
CREATE TABLE products (
    product_id INTEGER PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    price DECIMAL(10, 2),
    stock_quantity INTEGER,
    supplier_id INTEGER,
    created_date DATE
);

INSERT INTO products (product_id, product_name, category, price, stock_quantity, supplier_id, created_date) VALUES
(1, 'Laptop Pro 15', 'Electronics', 1299.99, 45, 1, '2023-01-10'),
(2, 'Wireless Mouse', 'Electronics', 29.99, 200, 1, '2023-02-15'),
(3, 'Mechanical Keyboard', 'Electronics', 89.99, 120, 2, '2023-01-20'),
(4, 'Office Chair', 'Furniture', 299.99, 30, 3, '2023-03-01'),
(5, 'Standing Desk', 'Furniture', 599.99, 15, 3, '2023-02-28'),
(6, 'Monitor 27"', 'Electronics', 349.99, 60, 1, '2023-01-05'),
(7, 'USB-C Cable', 'Electronics', 19.99, 500, 2, '2023-04-10'),
(8, 'Desk Lamp', 'Furniture', 49.99, 80, 4, '2023-03-15'),
(9, 'Webcam HD', 'Electronics', 79.99, 90, 2, '2023-02-20'),
(10, 'Noise Cancelling Headphones', 'Electronics', 249.99, 40, 1, '2023-01-30'),
(11, 'Ergonomic Mouse Pad', 'Accessories', 24.99, 150, 4, '2023-04-05'),
(12, 'Laptop Stand', 'Accessories', 39.99, 100, 3, '2023-03-20');

-- ============================================
-- LEVEL 3-4: Relational Tables
-- ============================================

-- Customers table
DROP TABLE IF EXISTS customers;
CREATE TABLE customers (
    customer_id INTEGER PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(20),
    address VARCHAR(200),
    city VARCHAR(50),
    state VARCHAR(50),
    zip_code VARCHAR(10),
    registration_date DATE
);

INSERT INTO customers (customer_id, first_name, last_name, email, phone, address, city, state, zip_code, registration_date) VALUES
(1, 'Alice', 'Thompson', 'alice.thompson@email.com', '555-1001', '123 Main St', 'New York', 'NY', '10001', '2023-01-05'),
(2, 'Bob', 'Chen', 'bob.chen@email.com', '555-1002', '456 Oak Ave', 'Los Angeles', 'CA', '90001', '2023-01-12'),
(3, 'Carol', 'White', 'carol.white@email.com', '555-1003', '789 Pine Rd', 'Chicago', 'IL', '60601', '2023-02-01'),
(4, 'David', 'Lee', 'david.lee@email.com', '555-1004', '321 Elm St', 'Houston', 'TX', '77001', '2023-02-15'),
(5, 'Eva', 'Martinez', 'eva.martinez@email.com', '555-1005', '654 Maple Dr', 'Phoenix', 'AZ', '85001', '2023-03-01'),
(6, 'Frank', 'Taylor', 'frank.taylor@email.com', '555-1006', '987 Cedar Ln', 'Philadelphia', 'PA', '19101', '2023-03-10'),
(7, 'Grace', 'Anderson', 'grace.anderson@email.com', '555-1007', '147 Birch Way', 'San Antonio', 'TX', '78201', '2023-03-20'),
(8, 'Henry', 'Moore', 'henry.moore@email.com', '555-1008', '258 Spruce Ct', 'San Diego', 'CA', '92101', '2023-04-05'),
(9, 'Iris', 'Jackson', 'iris.jackson@email.com', '555-1009', '369 Willow St', 'Dallas', 'TX', '75201', '2023-04-15'),
(10, 'Jack', 'Harris', 'jack.harris@email.com', '555-1010', '741 Ash Ave', 'San Jose', 'CA', '95101', '2023-05-01');

-- Orders table
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
    order_id INTEGER PRIMARY KEY,
    customer_id INTEGER NOT NULL,
    order_date DATE NOT NULL,
    total_amount DECIMAL(10, 2),
    status VARCHAR(20),
    shipping_address VARCHAR(200),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

INSERT INTO orders (order_id, customer_id, order_date, total_amount, status, shipping_address) VALUES
(1, 1, '2023-05-10', 1299.99, 'Delivered', '123 Main St, New York, NY 10001'),
(2, 2, '2023-05-12', 89.99, 'Delivered', '456 Oak Ave, Los Angeles, CA 90001'),
(3, 3, '2023-05-15', 599.99, 'Shipped', '789 Pine Rd, Chicago, IL 60601'),
(4, 1, '2023-05-18', 29.99, 'Delivered', '123 Main St, New York, NY 10001'),
(5, 4, '2023-05-20', 349.99, 'Processing', '321 Elm St, Houston, TX 77001'),
(6, 5, '2023-05-22', 299.99, 'Delivered', '654 Maple Dr, Phoenix, AZ 85001'),
(7, 2, '2023-05-25', 249.99, 'Shipped', '456 Oak Ave, Los Angeles, CA 90001'),
(8, 6, '2023-05-28', 79.99, 'Delivered', '987 Cedar Ln, Philadelphia, PA 19101'),
(9, 3, '2023-06-01', 49.99, 'Processing', '789 Pine Rd, Chicago, IL 60601'),
(10, 7, '2023-06-05', 1299.99, 'Shipped', '147 Birch Way, San Antonio, TX 78201'),
(11, 8, '2023-06-08', 39.99, 'Delivered', '258 Spruce Ct, San Diego, CA 92101'),
(12, 1, '2023-06-10', 19.99, 'Delivered', '123 Main St, New York, NY 10001'),
(13, 9, '2023-06-12', 599.99, 'Processing', '369 Willow St, Dallas, TX 75201'),
(14, 10, '2023-06-15', 89.99, 'Shipped', '741 Ash Ave, San Jose, CA 95101'),
(15, 4, '2023-06-18', 349.99, 'Delivered', '321 Elm St, Houston, TX 77001');

-- Order Items table
DROP TABLE IF EXISTS order_items;
CREATE TABLE order_items (
    order_item_id INTEGER PRIMARY KEY,
    order_id INTEGER NOT NULL,
    product_id INTEGER NOT NULL,
    quantity INTEGER NOT NULL,
    unit_price DECIMAL(10, 2) NOT NULL,
    subtotal DECIMAL(10, 2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, subtotal) VALUES
(1, 1, 1, 1, 1299.99, 1299.99),
(2, 2, 3, 1, 89.99, 89.99),
(3, 3, 5, 1, 599.99, 599.99),
(4, 4, 2, 1, 29.99, 29.99),
(5, 5, 6, 1, 349.99, 349.99),
(6, 6, 4, 1, 299.99, 299.99),
(7, 7, 10, 1, 249.99, 249.99),
(8, 8, 9, 1, 79.99, 79.99),
(9, 9, 8, 1, 49.99, 49.99),
(10, 10, 1, 1, 1299.99, 1299.99),
(11, 11, 12, 1, 39.99, 39.99),
(12, 12, 7, 1, 19.99, 19.99),
(13, 13, 5, 1, 599.99, 599.99),
(14, 14, 3, 1, 89.99, 89.99),
(15, 15, 6, 1, 349.99, 349.99),
(16, 1, 2, 2, 29.99, 59.98),
(17, 2, 7, 1, 19.99, 19.99),
(18, 5, 9, 1, 79.99, 79.99);

-- ============================================
-- LEVEL 5-6: Complex Scenarios
-- ============================================

-- Departments table
DROP TABLE IF EXISTS departments;
CREATE TABLE departments (
    department_id INTEGER PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL,
    location VARCHAR(100),
    budget DECIMAL(12, 2),
    manager_id INTEGER
);

INSERT INTO departments (department_id, department_name, location, budget, manager_id) VALUES
(1, 'Engineering', 'Building A, Floor 3', 500000.00, 7),
(2, 'Data Analytics', 'Building A, Floor 2', 300000.00, 2),
(3, 'Marketing', 'Building B, Floor 1', 400000.00, 4),
(4, 'Human Resources', 'Building B, Floor 2', 200000.00, 8),
(5, 'Sales', 'Building C, Floor 1', 450000.00, 10);

-- Sales table (for time-series and window functions)
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (
    sale_id INTEGER PRIMARY KEY,
    employee_id INTEGER,
    product_id INTEGER,
    sale_date DATE NOT NULL,
    quantity INTEGER NOT NULL,
    unit_price DECIMAL(10, 2) NOT NULL,
    total_amount DECIMAL(10, 2),
    region VARCHAR(50),
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

INSERT INTO sales (sale_id, employee_id, product_id, sale_date, quantity, unit_price, total_amount, region) VALUES
(1, 10, 1, '2024-01-05', 2, 1299.99, 2599.98, 'West'),
(2, 10, 3, '2024-01-06', 1, 89.99, 89.99, 'West'),
(3, 4, 5, '2024-01-07', 1, 599.99, 599.99, 'East'),
(4, 10, 6, '2024-01-08', 3, 349.99, 1049.97, 'West'),
(5, 4, 10, '2024-01-10', 2, 249.99, 499.98, 'East'),
(6, 10, 1, '2024-01-12', 1, 1299.99, 1299.99, 'West'),
(7, 4, 4, '2024-01-15', 2, 299.99, 599.98, 'East'),
(8, 10, 9, '2024-01-18', 4, 79.99, 319.96, 'West'),
(9, 4, 2, '2024-01-20', 5, 29.99, 149.95, 'East'),
(10, 10, 6, '2024-01-22', 2, 349.99, 699.98, 'West'),
(11, 4, 1, '2024-01-25', 1, 1299.99, 1299.99, 'East'),
(12, 10, 3, '2024-01-28', 3, 89.99, 269.97, 'West'),
(13, 4, 5, '2024-02-01', 1, 599.99, 599.99, 'East'),
(14, 10, 10, '2024-02-03', 2, 249.99, 499.98, 'West'),
(15, 4, 4, '2024-02-05', 1, 299.99, 299.99, 'East'),
(16, 10, 1, '2024-02-08', 2, 1299.99, 2599.98, 'West'),
(17, 4, 6, '2024-02-10', 1, 349.99, 349.99, 'East'),
(18, 10, 9, '2024-02-12', 3, 79.99, 239.97, 'West'),
(19, 4, 2, '2024-02-15', 4, 29.99, 119.96, 'East'),
(20, 10, 3, '2024-02-18', 2, 89.99, 179.98, 'West');

-- Update employees table to include department relationships
-- (Note: Some employees may not have departments for NULL handling exercises)

-- ============================================
-- LEVEL 7-8: Advanced Features
-- ============================================

-- Suppliers table (for normalization examples)
DROP TABLE IF EXISTS suppliers;
CREATE TABLE suppliers (
    supplier_id INTEGER PRIMARY KEY,
    supplier_name VARCHAR(100) NOT NULL,
    contact_name VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(20),
    address VARCHAR(200)
);

INSERT INTO suppliers (supplier_id, supplier_name, contact_name, email, phone, address) VALUES
(1, 'TechSupply Co', 'John Supplier', 'contact@techsupply.com', '555-2001', '100 Tech Blvd'),
(2, 'ElectroParts Inc', 'Jane Parts', 'info@electroparts.com', '555-2002', '200 Electronic Ave'),
(3, 'OfficeFurniture Pro', 'Bob Furniture', 'sales@officefurniture.com', '555-2003', '300 Furniture St'),
(4, 'Accessories Plus', 'Alice Accessories', 'hello@accessoriesplus.com', '555-2004', '400 Accessory Rd');

-- Create indexes for performance examples
CREATE INDEX idx_employees_department ON employees(department_id);
CREATE INDEX idx_orders_customer ON orders(customer_id);
CREATE INDEX idx_orders_date ON orders(order_date);
CREATE INDEX idx_sales_date ON sales(sale_date);
CREATE INDEX idx_sales_employee ON sales(employee_id);

-- ============================================
-- Views (for Level 8)
-- ============================================

-- View: Employee Summary
DROP VIEW IF EXISTS employee_summary;
CREATE VIEW employee_summary AS
SELECT 
    e.employee_id,
    CONCAT(e.first_name, ' ', e.last_name) AS full_name,
    e.job_title,
    e.salary,
    d.department_name,
    e.hire_date
FROM employees e
LEFT JOIN departments d ON e.department_id = d.department_id;

-- View: Sales Performance
DROP VIEW IF EXISTS sales_performance;
CREATE VIEW sales_performance AS
SELECT 
    s.sale_date,
    CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
    p.product_name,
    s.quantity,
    s.total_amount,
    s.region
FROM sales s
JOIN employees e ON s.employee_id = e.employee_id
JOIN products p ON s.product_id = p.product_id;

-- ============================================
-- Sample Queries to Verify Setup
-- ============================================

-- Uncomment to run verification queries:
-- SELECT 'Employees' AS table_name, COUNT(*) AS row_count FROM employees
-- UNION ALL
-- SELECT 'Products', COUNT(*) FROM products
-- UNION ALL
-- SELECT 'Customers', COUNT(*) FROM customers
-- UNION ALL
-- SELECT 'Orders', COUNT(*) FROM orders
-- UNION ALL
-- SELECT 'Order Items', COUNT(*) FROM order_items
-- UNION ALL
-- SELECT 'Departments', COUNT(*) FROM departments
-- UNION ALL
-- SELECT 'Sales', COUNT(*) FROM sales
-- UNION ALL
-- SELECT 'Suppliers', COUNT(*) FROM suppliers;
