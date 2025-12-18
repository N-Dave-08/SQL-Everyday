# Lesson 8.3: Transactions and Concurrency

Transactions ensure data integrity by grouping related operations. Understanding transactions is crucial for building reliable database applications.

## What is a Transaction?

A **transaction** is a sequence of database operations that are treated as a single unit. Either all operations succeed, or all are rolled back.

### ACID Properties

Transactions follow ACID principles:

- **Atomicity**: All or nothing - either all operations succeed or all fail
- **Consistency**: Database remains in a valid state
- **Isolation**: Concurrent transactions don't interfere with each other
- **Durability**: Committed changes are permanent

## Transaction Control

### BEGIN TRANSACTION

Starts a transaction:

```sql
BEGIN TRANSACTION;
-- or
BEGIN;
-- or (SQLite)
BEGIN IMMEDIATE;
```

### COMMIT

Saves all changes permanently:

```sql
COMMIT;
-- or
COMMIT TRANSACTION;
```

### ROLLBACK

Undoes all changes in the transaction:

```sql
ROLLBACK;
-- or
ROLLBACK TRANSACTION;
```

## Basic Transaction Example

```sql
-- Transfer money between accounts (conceptual)
BEGIN TRANSACTION;

UPDATE accounts SET balance = balance - 100 WHERE account_id = 1;
UPDATE accounts SET balance = balance + 100 WHERE account_id = 2;

-- If both succeed, commit; if either fails, rollback
COMMIT;
-- or ROLLBACK; if there was an error
```

## Transaction Example: Employee Transfer

```sql
BEGIN TRANSACTION;

-- Transfer employee to new department
UPDATE employees
SET department_id = 2
WHERE employee_id = 5;

-- Update their job title
UPDATE employees
SET job_title = 'Senior Data Analyst'
WHERE employee_id = 5;

-- If both succeed, commit
COMMIT;

-- If there's an error, rollback
-- ROLLBACK;
```

## Error Handling in Transactions

```sql
BEGIN TRANSACTION;

BEGIN TRY
    INSERT INTO employees (first_name, last_name, email)
    VALUES ('John', 'Doe', 'john@company.com');
    
    UPDATE departments SET employee_count = employee_count + 1
    WHERE department_id = 1;
    
    COMMIT;
END TRY
BEGIN CATCH
    ROLLBACK;
    -- Handle error
END CATCH;
```

**Note**: Syntax varies by database. SQLite has simpler error handling.

## Savepoints

Savepoints allow you to rollback to a specific point within a transaction:

```sql
BEGIN TRANSACTION;

INSERT INTO employees (...) VALUES (...);
SAVEPOINT sp1;

UPDATE employees SET salary = 80000 WHERE employee_id = 1;
-- If this fails, rollback to savepoint
ROLLBACK TO SAVEPOINT sp1;

COMMIT;
```

## Concurrency Issues

When multiple transactions run simultaneously, issues can arise:

### Problem 1: Dirty Read

Reading uncommitted data from another transaction:

```
Transaction A: UPDATE employees SET salary = 100000 WHERE id = 1;
Transaction B: SELECT salary FROM employees WHERE id = 1;  -- Reads 100000
Transaction A: ROLLBACK;  -- Change is undone
Transaction B: Has incorrect data!
```

### Problem 2: Non-Repeatable Read

Reading the same data twice and getting different results:

```
Transaction A: SELECT salary FROM employees WHERE id = 1;  -- Returns 50000
Transaction B: UPDATE employees SET salary = 60000 WHERE id = 1; COMMIT;
Transaction A: SELECT salary FROM employees WHERE id = 1;  -- Returns 60000 (different!)
```

### Problem 3: Phantom Read

New rows appear during a transaction:

```
Transaction A: SELECT COUNT(*) FROM employees WHERE dept_id = 1;  -- Returns 5
Transaction B: INSERT INTO employees (dept_id, ...) VALUES (1, ...); COMMIT;
Transaction A: SELECT COUNT(*) FROM employees WHERE dept_id = 1;  -- Returns 6 (phantom row!)
```

## Isolation Levels

Isolation levels control how transactions interact:

### READ UNCOMMITTED

- Lowest isolation
- Allows dirty reads
- Fastest but least safe

### READ COMMITTED

- Prevents dirty reads
- Allows non-repeatable reads
- Default in many databases

### REPEATABLE READ

- Prevents dirty reads and non-repeatable reads
- May allow phantom reads
- More isolation, slower

### SERIALIZABLE

- Highest isolation
- Prevents all concurrency issues
- Slowest but safest
- Transactions execute as if serialized

### Setting Isolation Level

```sql
-- SQL Server
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

-- MySQL
SET SESSION TRANSACTION ISOLATION LEVEL REPEATABLE READ;

-- PostgreSQL
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
```

**Note**: SQLite only supports SERIALIZABLE (simplified model).

## Locking

Locks prevent concurrent access to data:

### Types of Locks

- **Shared Lock (Read Lock)**: Multiple transactions can read
- **Exclusive Lock (Write Lock)**: Only one transaction can write

### Lock Granularity

- **Row-level locks**: Lock individual rows (most common)
- **Table-level locks**: Lock entire table (less common, can cause contention)

## Deadlocks

A **deadlock** occurs when two transactions are waiting for each other:

```
Transaction A: Locks row 1, wants row 2
Transaction B: Locks row 2, wants row 1
-- Both wait forever = deadlock!
```

### Preventing Deadlocks

1. **Lock order**: Always acquire locks in the same order
2. **Short transactions**: Keep transactions brief
3. **Timeout**: Set lock timeouts
4. **Retry logic**: Handle deadlock errors and retry

## Best Practices

1. **Keep transactions short**: Long transactions hold locks longer
2. **Commit promptly**: Don't leave transactions open
3. **Handle errors**: Always rollback on error
4. **Use appropriate isolation**: Balance safety vs performance
5. **Avoid long-running transactions**: Can cause lock contention
6. **Test concurrency**: Test with multiple simultaneous users

## Common Patterns

### Pattern 1: All-or-Nothing Updates

```sql
BEGIN TRANSACTION;
UPDATE table1 SET ...;
UPDATE table2 SET ...;
UPDATE table3 SET ...;
COMMIT;  -- All succeed or all fail
```

### Pattern 2: Conditional Commit

```sql
BEGIN TRANSACTION;
-- Perform operations
IF condition THEN
    COMMIT;
ELSE
    ROLLBACK;
END IF;
```

### Pattern 3: Nested Transactions

Some databases support nested transactions (savepoints):

```sql
BEGIN TRANSACTION;
-- Outer transaction
    BEGIN TRANSACTION;
    -- Inner transaction (savepoint)
    COMMIT;  -- Releases savepoint
COMMIT;  -- Commits outer transaction
```

## Database-Specific Notes

### SQLite

- Simple transaction model
- SERIALIZABLE isolation (default)
- `BEGIN IMMEDIATE` for write transactions
- Limited concurrent writes

### MySQL (InnoDB)

- Full ACID support
- Multiple isolation levels
- Row-level locking
- Deadlock detection

### PostgreSQL

- Full ACID support
- Advanced isolation levels
- MVCC (Multi-Version Concurrency Control)
- Excellent concurrency

### SQL Server

- Full ACID support
- Multiple isolation levels
- Locking hints available
- Deadlock detection and resolution

## Next Steps

Congratulations! You've completed all 8 levels of the SQL Mastery Course. Practice with real-world scenarios and continue building your SQL skills!

---

**Key Takeaways:**
- Transactions group operations as atomic units
- ACID: Atomicity, Consistency, Isolation, Durability
- COMMIT saves changes, ROLLBACK undoes them
- Isolation levels control concurrency behavior
- Locks prevent concurrent access issues
- Deadlocks occur when transactions wait for each other
- Keep transactions short to avoid lock contention
- Handle errors and always rollback on failure
- Test concurrency scenarios
