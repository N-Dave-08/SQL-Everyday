-- Lesson: LEFT JOIN

-- LEFT JOIN returns all rows from the left table (users)
-- and the matching rows from the right table (orders).
-- If there is no match, the right table columns will show NULL.

-- 1. Show all users and their products (if any)
SELECT users.name, orders.product
FROM users
LEFT JOIN orders
ON users.id = orders.user_id;

-- 2. Show all users and products, sorted by user name
SELECT users.name, orders.product
FROM users
LEFT JOIN orders
ON users.id = orders.user_id
ORDER BY users.name ASC;

-- 3. Show users without any orders
SELECT users.name, orders.product
FROM users
LEFT JOIN orders
ON users.id = orders.user_id
WHERE orders.product IS NULL;
