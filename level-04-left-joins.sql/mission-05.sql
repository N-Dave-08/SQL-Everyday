-- Mission 5 – Level 4: LEFT JOIN

-- Show all users and the products they ordered
-- Include users even if they have no orders
-- Columns: name (from users) and product (from orders)
-- Use LEFT JOIN
-- Sort by users.name ascending
-- 💡 Hint: Join on users.id = orders.user_id

SELECT users.name, orders.product
FROM users
LEFT JOIN orders
ON users.id = orders.user_id
ORDER BY users.name ASC;