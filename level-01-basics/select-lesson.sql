-- Lesson: SELECT basics

-- 1. Select all columns from users
SELECT * FROM users;

-- 2. Select only name and age
SELECT name, age
FROM users;

-- 3. Filter users from PH
SELECT name, age
FROM users
WHERE country = 'PH';

-- 4. Filter with multiple conditions
SELECT name, age
FROM users
WHERE country = 'PH' AND age > 21;

-- 5. Sort results by age ascending
SELECT name, age
FROM users
WHERE country = 'PH' AND age > 21
ORDER BY age ASC;
