-- Lesson: Joins with Aggregates

-- You can combine JOINs with aggregate functions like COUNT, SUM, AVG
-- GROUP BY is used to summarize data per category

-- 1. Count orders per user
SELECT users.name, COUNT(orders.order_id) AS total_orders
FROM users
LEFT JOIN orders
ON users.id = orders.user_id
GROUP BY users.name;

-- 2. Sum total price per user
SELECT users.name, SUM(orders.price) AS total_spent
FROM users
LEFT JOIN orders
ON users.id = orders.user_id
GROUP BY users.name;

-- 3. Count orders per user, only users with at least 1 order
SELECT users.name, COUNT(orders.order_id) AS total_orders
FROM users
INNER JOIN orders
ON users.id = orders.user_id
GROUP BY users.name;
