-- Lesson: Aggregates and GROUP BY

-- Aggregates summarize data: COUNT, SUM, AVG, MIN, MAX
-- GROUP BY allows us to calculate aggregates per category

-- 1. Count all users
SELECT COUNT(*) AS total_users
FROM users;

-- 2. Count users from PH only
SELECT COUNT(*) AS ph_users
FROM users
WHERE country = 'PH';

-- 3. Sum of ages
SELECT SUM(age) AS total_age
FROM users;

-- 4. Average age
SELECT AVG(age) AS average_age
FROM users;

-- 5. Count users per country using GROUP BY
SELECT country, COUNT(*) AS total_users
FROM users
GROUP BY country;

-- 6. Count users per country with condition (HAVING)
SELECT country, COUNT(*) AS total_users
FROM users
GROUP BY country
HAVING COUNT(*) > 1;
