-- Mission 02
-- Show name and country of users not from PH, ordered by name

SELECT name, country
FROM users
WHERE country != 'PH'
ORDER BY name ASC;
