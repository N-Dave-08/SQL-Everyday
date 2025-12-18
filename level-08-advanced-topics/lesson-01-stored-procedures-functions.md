# Lesson 8.1: Stored Procedures and Functions

Stored procedures and functions allow you to encapsulate SQL logic into reusable, named database objects. This is advanced SQL that's database-specific.

## What are Stored Procedures?

A **stored procedure** is a prepared SQL code that you can save and reuse. Procedures can accept parameters and return results.

### Benefits

- **Reusability**: Write once, use many times
- **Performance**: Pre-compiled and optimized
- **Security**: Control access to data
- **Maintainability**: Centralized business logic

**Note**: Syntax varies significantly between databases. This lesson provides conceptual understanding and examples that may need adjustment for your database.

## Basic Stored Procedure Syntax

### SQL Server / SQLite (Limited Support)

```sql
CREATE PROCEDURE procedure_name
AS
BEGIN
    -- SQL statements
END;
```

### MySQL

```sql
DELIMITER //
CREATE PROCEDURE procedure_name()
BEGIN
    -- SQL statements
END //
DELIMITER ;
```

### PostgreSQL

```sql
CREATE OR REPLACE PROCEDURE procedure_name()
LANGUAGE plpgsql
AS $$
BEGIN
    -- SQL statements
END;
$$;
```

## Simple Procedure Example

```sql
-- Get employees in a department
CREATE PROCEDURE GetEmployeesByDepartment
    @DeptID INT  -- Parameter
AS
BEGIN
    SELECT first_name, last_name, salary
    FROM employees
    WHERE department_id = @DeptID;
END;

-- Call the procedure
EXEC GetEmployeesByDepartment @DeptID = 1;
```

## Stored Functions

A **function** is similar to a procedure but returns a value and can be used in SQL expressions.

### Function Example

```sql
-- Calculate total payroll for a department
CREATE FUNCTION GetDepartmentPayroll(@DeptID INT)
RETURNS DECIMAL(10,2)
AS
BEGIN
    DECLARE @Total DECIMAL(10,2);
    SELECT @Total = SUM(salary)
    FROM employees
    WHERE department_id = @DeptID;
    RETURN @Total;
END;

-- Use the function
SELECT 
    department_id,
    GetDepartmentPayroll(department_id) AS total_payroll
FROM departments;
```

## Variables

Variables store values temporarily:

```sql
-- Declare variable
DECLARE @EmployeeCount INT;
DECLARE @AvgSalary DECIMAL(10,2);

-- Set variable
SET @EmployeeCount = (SELECT COUNT(*) FROM employees);
SET @AvgSalary = (SELECT AVG(salary) FROM employees);

-- Use variable
SELECT @EmployeeCount AS total_employees, @AvgSalary AS avg_salary;
```

## Control Flow

### IF-ELSE

```sql
IF condition
BEGIN
    -- statements
END
ELSE
BEGIN
    -- statements
END;
```

### Example

```sql
CREATE PROCEDURE CheckEmployeeCount
    @DeptID INT
AS
BEGIN
    DECLARE @Count INT;
    SELECT @Count = COUNT(*) 
    FROM employees 
    WHERE department_id = @DeptID;
    
    IF @Count > 10
    BEGIN
        SELECT 'Large Department' AS status;
    END
    ELSE
    BEGIN
        SELECT 'Small Department' AS status;
    END;
END;
```

### WHILE Loop

```sql
WHILE condition
BEGIN
    -- statements
END;
```

## Error Handling

```sql
BEGIN TRY
    -- SQL statements
END TRY
BEGIN CATCH
    -- Error handling
    SELECT ERROR_MESSAGE();
END CATCH;
```

## When to Use Stored Procedures

### Good Use Cases

1. **Complex business logic**: Multi-step operations
2. **Security**: Control data access
3. **Performance**: Pre-compiled queries
4. **Consistency**: Enforce business rules

### Consider Alternatives

1. **Application code**: For complex logic that changes frequently
2. **Views**: For simple reusable queries
3. **Functions**: When you need a return value in expressions

## Best Practices

1. **Name clearly**: Use descriptive names
2. **Document**: Add comments explaining logic
3. **Handle errors**: Include error handling
4. **Test thoroughly**: Test with various inputs
5. **Version control**: Store procedures in version control

## Database-Specific Notes

### SQLite

SQLite has **limited support** for stored procedures. Consider using:
- Application-level functions
- Views for reusable queries
- Triggers for automation

### MySQL

Full support with `DELIMITER` syntax for multi-statement procedures.

### PostgreSQL

Uses `plpgsql` language. Functions are more common than procedures.

### SQL Server

Full support with T-SQL language.

## Next Steps

In the next lesson, you'll learn about Views and Triggers.

---

**Key Takeaways:**
- Stored procedures encapsulate SQL logic for reuse
- Functions return values and can be used in expressions
- Syntax varies significantly by database
- Use for complex business logic and security
- SQLite has limited support (use application code instead)
- Test and document procedures thoroughly
