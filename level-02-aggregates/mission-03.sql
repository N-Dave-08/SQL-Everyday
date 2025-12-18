-- Mission 03 – Level 2: Aggregates

-- Count users per country
-- Columns: country, total_users
-- Use COUNT(*) and GROUP BY
-- Save this query as your mission solution

SELECT country, COUNT(*) AS user_count
FROM users
GROUP BY country;