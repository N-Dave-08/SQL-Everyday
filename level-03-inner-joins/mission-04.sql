-- Mission 04 – Level 3: INNER JOIN

-- Show all users and the products they ordered
-- Columns: name (from users) and product (from orders)
-- Use INNER JOIN
-- Sort by name ascending
-- 💡 Hint: Join on users.id = orders.user_id.

SELECT users.name, orders.product
FROM users
INNER JOIN orders
ON users.id = orders.user_id
ORDER BY users.name ASC;