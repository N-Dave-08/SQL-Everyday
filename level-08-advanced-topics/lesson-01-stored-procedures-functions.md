# Lesson 8.1: Stored Procedures and Functions

Stored procedures and functions allow you to encapsulate SQL logic into reusable, named database objects. This is advanced SQL that's database-specific.

## What are Stored Procedures?

A **stored procedure** is a prepared SQL code that you can save and reuse. Procedures can accept parameters and return results.

### Benefits

- **Reusability**: Write once, use many times
- **Performance**: Pre-compiled and optimized
- **Security**: Control access to data
- **Maintainability**: Centralized business logic

**Note**: This lesson focuses on PostgreSQL syntax. Stored procedures and functions are database-specific features.

## Basic Stored Procedure Syntax

### PostgreSQL Procedures

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
-- Get employees in a department (PostgreSQL)
CREATE OR REPLACE PROCEDURE get_employees_by_department(dept_id INT)
LANGUAGE plpgsql
AS $$
BEGIN
    SELECT first_name, last_name, salary
    FROM employees
    WHERE department_id = dept_id;
END;
$$;

-- Call the procedure
CALL get_employees_by_department(1);
```

## Stored Functions

A **function** is similar to a procedure but returns a value and can be used in SQL expressions. In PostgreSQL, functions are more commonly used than procedures.

### Function Example

```sql
-- Calculate total payroll for a department (PostgreSQL)
CREATE OR REPLACE FUNCTION get_department_payroll(dept_id INT)
RETURNS DECIMAL(10,2)
LANGUAGE plpgsql
AS $$
DECLARE
    total DECIMAL(10,2);
BEGIN
    SELECT SUM(salary) INTO total
    FROM employees
    WHERE department_id = dept_id;
    RETURN total;
END;
$$;

-- Use the function
SELECT 
    department_id,
    get_department_payroll(department_id) AS total_payroll
FROM departments;
```

## Variables

Variables store values temporarily in PostgreSQL functions/procedures:

```sql
-- In a PostgreSQL function/procedure:
CREATE OR REPLACE FUNCTION get_employee_stats()
RETURNS TABLE(total_employees INT, avg_salary DECIMAL(10,2))
LANGUAGE plpgsql
AS $$
DECLARE
    employee_count INT;
    avg_sal DECIMAL(10,2);
BEGIN
    SELECT COUNT(*) INTO employee_count FROM employees;
    SELECT AVG(salary) INTO avg_sal FROM employees;
    
    RETURN QUERY SELECT employee_count, avg_sal;
END;
$$;
```

## Control Flow

### IF-ELSE

```sql
-- PostgreSQL syntax
IF condition THEN
    -- statements
ELSIF condition THEN
    -- statements
ELSE
    -- statements
END IF;
```

### Example

```sql
CREATE OR REPLACE FUNCTION check_employee_count(dept_id INT)
RETURNS TEXT
LANGUAGE plpgsql
AS $$
DECLARE
    emp_count INT;
BEGIN
    SELECT COUNT(*) INTO emp_count
    FROM employees 
    WHERE department_id = dept_id;
    
    IF emp_count > 10 THEN
        RETURN 'Large Department';
    ELSE
        RETURN 'Small Department';
    END IF;
END;
$$;
```

### WHILE Loop

```sql
-- PostgreSQL syntax
WHILE condition LOOP
    -- statements
END LOOP;
```

## Error Handling

```sql
-- PostgreSQL exception handling
BEGIN
    -- SQL statements
EXCEPTION
    WHEN others THEN
        -- Error handling
        RAISE NOTICE 'Error occurred: %', SQLERRM;
        RAISE;
END;
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

## PostgreSQL Features

PostgreSQL provides excellent support for stored procedures and functions:

- **PL/pgSQL language**: Full-featured procedural language
- **Functions**: More commonly used than procedures, can return values
- **Procedures**: Available in PostgreSQL 11+ for operations without return values
- **Multiple languages**: Supports Python, Perl, and other languages via extensions
- **Exception handling**: Robust error handling with EXCEPTION blocks
- **Variables**: Full support for variables and control flow
- **Performance**: Pre-compiled and optimized for better performance

## Next Steps

In the next lesson, you'll learn about Views and Triggers.

---

**Key Takeaways:**
- Stored procedures encapsulate SQL logic for reuse
- Functions return values and can be used in expressions
- PostgreSQL uses PL/pgSQL language for procedures and functions
- Functions are more common than procedures in PostgreSQL
- Use for complex business logic and security
- Test and document procedures thoroughly
