# SQL Quick Reference Cheatsheet

A quick reference guide for common SQL syntax and patterns.

## Basic Queries

### SELECT
```sql
SELECT column1, column2
FROM table_name
WHERE condition
ORDER BY column1 DESC
LIMIT 10;
```

### DISTINCT
```sql
SELECT DISTINCT column_name FROM table_name;
```

## Filtering

### WHERE Operators
```sql
WHERE column = value
WHERE column > value
WHERE column < value
WHERE column >= value
WHERE column <= value
WHERE column <> value  -- Not equal
WHERE column != value  -- Not equal
WHERE column BETWEEN value1 AND value2
WHERE column IN (value1, value2, value3)
WHERE column LIKE 'pattern%'  -- % = any chars
WHERE column LIKE '_pattern'  -- _ = single char
WHERE column IS NULL
WHERE column IS NOT NULL
```

### Logical Operators
```sql
WHERE condition1 AND condition2
WHERE condition1 OR condition2
WHERE NOT condition
```

## Sorting and Limiting

```sql
ORDER BY column1 ASC, column2 DESC
LIMIT 10
LIMIT 10 OFFSET 20  -- Skip first 20, get next 10
```

## Data Modification

### INSERT
```sql
INSERT INTO table_name (col1, col2) VALUES (val1, val2);
INSERT INTO table_name VALUES (val1, val2, val3);
INSERT INTO table1 SELECT * FROM table2;
```

### UPDATE
```sql
UPDATE table_name
SET column1 = value1, column2 = value2
WHERE condition;
```

### DELETE
```sql
DELETE FROM table_name WHERE condition;
```

## Aggregates

```sql
SELECT 
    COUNT(*) AS total,
    COUNT(DISTINCT column) AS unique_count,
    SUM(column) AS total_sum,
    AVG(column) AS average,
    MIN(column) AS minimum,
    MAX(column) AS maximum
FROM table_name;
```

## GROUP BY and HAVING

```sql
SELECT column1, aggregate_function(column2)
FROM table_name
WHERE condition
GROUP BY column1
HAVING aggregate_condition
ORDER BY column1;
```

## Joins

### INNER JOIN
```sql
SELECT columns
FROM table1 t1
INNER JOIN table2 t2
ON t1.column = t2.column;
```

### LEFT JOIN
```sql
SELECT columns
FROM table1 t1
LEFT JOIN table2 t2
ON t1.column = t2.column;
```

### RIGHT JOIN
```sql
SELECT columns
FROM table1 t1
RIGHT JOIN table2 t2
ON t1.column = t2.column;
```

### FULL OUTER JOIN
```sql
SELECT columns
FROM table1 t1
FULL OUTER JOIN table2 t2
ON t1.column = t2.column;
```

### Multiple Joins
```sql
SELECT columns
FROM table1 t1
JOIN table2 t2 ON t1.col = t2.col
JOIN table3 t3 ON t2.col = t3.col;
```

## Subqueries

### Scalar Subquery
```sql
SELECT * FROM table1
WHERE column > (SELECT AVG(column) FROM table1);
```

### Column Subquery with IN
```sql
SELECT * FROM table1
WHERE column IN (SELECT column FROM table2);
```

### EXISTS
```sql
SELECT * FROM table1 t1
WHERE EXISTS (SELECT 1 FROM table2 t2 WHERE t2.col = t1.col);
```

## Common Table Expressions (CTEs)

```sql
WITH cte_name AS (
    SELECT columns FROM table_name
)
SELECT * FROM cte_name;

-- Multiple CTEs
WITH 
    cte1 AS (SELECT ...),
    cte2 AS (SELECT ...)
SELECT ... FROM cte1 JOIN cte2 ...;
```

## Window Functions

### Ranking
```sql
ROW_NUMBER() OVER (PARTITION BY col1 ORDER BY col2)
RANK() OVER (PARTITION BY col1 ORDER BY col2)
DENSE_RANK() OVER (PARTITION BY col1 ORDER BY col2)
```

### Aggregates as Window Functions
```sql
AVG(column) OVER (PARTITION BY col1)
SUM(column) OVER (ORDER BY col1)
COUNT(*) OVER (PARTITION BY col1)
```

### Value Functions
```sql
LAG(column) OVER (ORDER BY col1)
LEAD(column) OVER (ORDER BY col1)
FIRST_VALUE(column) OVER (PARTITION BY col1 ORDER BY col2)
LAST_VALUE(column) OVER (PARTITION BY col1 ORDER BY col2)
```

## Data Types

```sql
INTEGER
DECIMAL(10, 2)
VARCHAR(50)
CHAR(10)
TEXT
DATE
TIME
DATETIME / TIMESTAMP
BOOLEAN
```

## Constraints

```sql
PRIMARY KEY
FOREIGN KEY (col) REFERENCES table(col)
NOT NULL
UNIQUE
CHECK (condition)
DEFAULT value
```

## Creating Tables

```sql
CREATE TABLE table_name (
    id INTEGER PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (dept_id) REFERENCES departments(id)
);
```

## Indexes

```sql
CREATE INDEX idx_name ON table_name(column_name);
CREATE UNIQUE INDEX idx_name ON table_name(column_name);
CREATE INDEX idx_name ON table_name(col1, col2);  -- Composite
DROP INDEX idx_name;
```

## Views

```sql
CREATE VIEW view_name AS
SELECT columns FROM tables WHERE conditions;

CREATE OR REPLACE VIEW view_name AS SELECT ...;
DROP VIEW view_name;
```

## Transactions

```sql
BEGIN TRANSACTION;
-- SQL statements
COMMIT;
-- or
ROLLBACK;
```

## Useful Functions

### String Functions
```sql
CONCAT(str1, str2)
SUBSTRING(str, start, length)
UPPER(str)
LOWER(str)
LENGTH(str)
TRIM(str)
```

### Date Functions
```sql
CURRENT_DATE
CURRENT_TIMESTAMP
DATE('2023-01-15')
CURRENT_DATE + INTERVAL '1 day'  -- PostgreSQL
EXTRACT(YEAR FROM date_column)
DATE_PART('year', date_column)  -- PostgreSQL
```

### Math Functions
```sql
ABS(number)
ROUND(number, decimals)
CEIL(number)
FLOOR(number)
```

### NULL Handling
```sql
COALESCE(col1, col2, 'default')  -- Returns first non-NULL
ISNULL(col, 'default')  -- SQL Server
IFNULL(col, 'default')  -- MySQL
```

## Common Patterns

### Top N per Group
```sql
WITH ranked AS (
    SELECT *, ROW_NUMBER() OVER (PARTITION BY group_col ORDER BY sort_col DESC) AS rn
    FROM table_name
)
SELECT * FROM ranked WHERE rn <= N;
```

### Running Total
```sql
SELECT 
    column,
    SUM(column) OVER (ORDER BY sort_col) AS running_total
FROM table_name;
```

### Compare to Average
```sql
SELECT 
    column,
    AVG(column) OVER () AS overall_avg,
    column - AVG(column) OVER () AS diff_from_avg
FROM table_name;
```

## Query Execution Order

1. FROM
2. WHERE
3. GROUP BY
4. HAVING
5. SELECT
6. ORDER BY
7. LIMIT

---

**Note**: Syntax may vary by database. This cheatsheet provides common patterns. Refer to your database documentation for specific syntax.
