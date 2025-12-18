-- Lesson: INNER JOIN

-- INNER JOIN combines rows from two tables where a column matches in both tables.
-- Only rows with a match in both tables are returned.

-- 1. Show products for user with id = 1
SELECT users.name, orders.product
FROM users
INNER JOIN orders
ON users.id = orders.user_id
WHERE users.id = 1;

-- 2. Show all products ordered by user with id = 2
SELECT users.name, orders.product
FROM users
INNER JOIN orders
ON users.id = orders.user_id
WHERE users.id = 2;

-- 3. Show all users and their products (basic INNER JOIN)
SELECT users.name, orders.product
FROM users
INNER JOIN orders
ON users.id = orders.user_id;

-- 4. Show all users and products, sorted by user name
SELECT users.name, orders.product
FROM users
INNER JOIN orders
ON users.id = orders.user_id
ORDER BY users.name ASC;

