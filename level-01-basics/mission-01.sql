-- Mission 01
-- Show name and age of users from PH who are older than 21,
-- ordered by age in ascending order

SELECT name, age
FROM users
WHERE country = 'PH'
  AND age > 21
ORDER BY age ASC;
