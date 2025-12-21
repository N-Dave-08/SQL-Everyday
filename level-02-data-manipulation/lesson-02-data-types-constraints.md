# Lesson 2.2: Data Types and Constraints

Understanding data types and constraints is crucial for designing robust databases and ensuring data quality.

## Data Types

Data types define what kind of data can be stored in a column. Different databases support different types, but here are the most common ones.

### Numeric Types

#### INTEGER / INT
Whole numbers (positive, negative, or zero).

```sql
CREATE TABLE products (
    product_id INTEGER,
    stock_quantity INTEGER
);
```

**Examples**: `-100`, `0`, `42`, `1000`

#### DECIMAL / NUMERIC
Exact decimal numbers. Specify precision (total digits) and scale (decimal places).

```sql
CREATE TABLE products (
    price DECIMAL(10, 2)  -- 10 total digits, 2 after decimal
);
```

**Examples**: `99.99`, `1234.56`, `0.50`

#### FLOAT / REAL
Approximate floating-point numbers (for scientific calculations).

```sql
CREATE TABLE measurements (
    temperature FLOAT
);
```

### String Types

#### VARCHAR(n)
Variable-length character string (up to n characters).

```sql
CREATE TABLE employees (
    first_name VARCHAR(50),  -- Max 50 characters
    email VARCHAR(100)
);
```

**Examples**: `'John'`, `'Alice'`, `'test@email.com'`

#### CHAR(n)
Fixed-length character string (always n characters, padded with spaces).

```sql
CREATE TABLE codes (
    status_code CHAR(3)  -- Always exactly 3 characters
);
```

**Note**: `VARCHAR` is usually preferred over `CHAR` unless you need fixed length.

#### TEXT
Large text data (for longer content like descriptions, notes).

```sql
CREATE TABLE articles (
    title VARCHAR(200),
    content TEXT  -- Can store very long text
);
```

### Date and Time Types

#### DATE
Stores dates (year, month, day).

```sql
CREATE TABLE employees (
    hire_date DATE
);
```

**Format**: `'2023-01-15'` (YYYY-MM-DD)

#### TIME
Stores time (hour, minute, second).

```sql
CREATE TABLE events (
    start_time TIME
);
```

**Format**: `'14:30:00'` (HH:MM:SS)

#### DATETIME / TIMESTAMP
Stores both date and time.

```sql
CREATE TABLE orders (
    order_date DATETIME
);
```

**Format**: `'2023-01-15 14:30:00'`

### Boolean Type

#### BOOLEAN / BOOL
Stores true/false values.

```sql
CREATE TABLE users (
    is_active BOOLEAN
);
```

**Note**: Some databases use `TINYINT(1)` or `BIT` instead of BOOLEAN.

### Other Types

#### BLOB
Binary Large Object (for storing binary data like images, files).

```sql
CREATE TABLE documents (
    file_content BLOB
);
```

## Constraints

Constraints are rules that enforce data integrity and validity.

### PRIMARY KEY

Uniquely identifies each row. A table can have only one primary key.

```sql
CREATE TABLE employees (
    employee_id INTEGER PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50)
);
```

**Characteristics:**
- Must be unique
- Cannot be NULL
- Automatically creates an index (for fast lookups)

### FOREIGN KEY

References the primary key of another table, establishing a relationship.

```sql
CREATE TABLE employees (
    employee_id INTEGER PRIMARY KEY,
    department_id INTEGER,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);
```

**Purpose:**
- Ensures referential integrity
- Prevents orphaned records
- Enforces relationships between tables

### NOT NULL

Prevents NULL values in a column.

```sql
CREATE TABLE employees (
    employee_id INTEGER PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100)  -- Can be NULL
);
```

### UNIQUE

Ensures all values in a column are unique (allows NULL, but only one NULL).

```sql
CREATE TABLE employees (
    employee_id INTEGER PRIMARY KEY,
    email VARCHAR(100) UNIQUE,  -- Each email must be unique
    phone VARCHAR(20) UNIQUE
);
```

### CHECK

Enforces a condition on column values.

```sql
CREATE TABLE employees (
    employee_id INTEGER PRIMARY KEY,
    salary DECIMAL(10, 2) CHECK (salary > 0),  -- Salary must be positive
    age INTEGER CHECK (age >= 18 AND age <= 100)
);
```

**Note**: CHECK constraints are fully supported in PostgreSQL and enforce data validation rules at the database level.

### DEFAULT

Provides a default value when no value is specified.

```sql
CREATE TABLE orders (
    order_id INTEGER PRIMARY KEY,
    order_date DATE DEFAULT CURRENT_DATE,
    status VARCHAR(20) DEFAULT 'Pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

## Creating Tables with Constraints

### Example: Complete Table Definition

```sql
CREATE TABLE employees (
    employee_id INTEGER PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    hire_date DATE NOT NULL,
    job_title VARCHAR(100) NOT NULL,
    salary DECIMAL(10, 2) NOT NULL CHECK (salary > 0),
    department_id INTEGER,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);
```

## Modifying Tables

### Adding Constraints to Existing Tables

```sql
-- Add NOT NULL constraint
ALTER TABLE employees
ALTER COLUMN email SET NOT NULL;

-- Add UNIQUE constraint
ALTER TABLE employees
ADD CONSTRAINT unique_email UNIQUE (email);

-- Add FOREIGN KEY
ALTER TABLE employees
ADD CONSTRAINT fk_department
FOREIGN KEY (department_id) REFERENCES departments(department_id);
```

**Note**: Syntax varies by database. Some databases don't allow adding NOT NULL to existing columns with NULL values.

### Removing Constraints

```sql
-- Remove a constraint (syntax varies)
ALTER TABLE employees
DROP CONSTRAINT unique_email;
```

## Common Constraint Patterns

### Composite Primary Key

A primary key made of multiple columns:

```sql
CREATE TABLE order_items (
    order_id INTEGER,
    product_id INTEGER,
    quantity INTEGER,
    PRIMARY KEY (order_id, product_id)  -- Combination must be unique
);
```

### Multiple Constraints on One Column

```sql
CREATE TABLE users (
    user_id INTEGER PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,  -- Both NOT NULL and UNIQUE
    email VARCHAR(100) NOT NULL UNIQUE
);
```

### Self-Referencing Foreign Key

A table that references itself:

```sql
CREATE TABLE employees (
    employee_id INTEGER PRIMARY KEY,
    manager_id INTEGER,
    FOREIGN KEY (manager_id) REFERENCES employees(employee_id)
);
```

## Data Type Best Practices

1. **Choose appropriate sizes**: Don't use `VARCHAR(1000)` if you only need 50 characters
2. **Use DECIMAL for money**: Never use FLOAT for currency (precision issues)
3. **Be consistent**: Use the same date/time format throughout
4. **Consider storage**: Larger data types use more storage space

## Constraint Best Practices

1. **Always use PRIMARY KEY**: Every table should have one
2. **Use FOREIGN KEY**: Maintain referential integrity
3. **Use NOT NULL**: For required fields
4. **Use UNIQUE**: For fields that must be unique (like emails, usernames)
5. **Use DEFAULT**: For commonly repeated values
6. **Name your constraints**: Makes them easier to manage later

```sql
-- Named constraint (better practice)
CREATE TABLE employees (
    employee_id INTEGER,
    email VARCHAR(100),
    CONSTRAINT pk_employees PRIMARY KEY (employee_id),
    CONSTRAINT uq_email UNIQUE (email)
);
```

## Common Errors

### Error: Violating NOT NULL

```sql
-- ❌ Error: first_name cannot be NULL
INSERT INTO employees (last_name, email)
VALUES ('Smith', 'john@company.com');

-- ✅ Correct: Provide all NOT NULL columns
INSERT INTO employees (first_name, last_name, email)
VALUES ('John', 'Smith', 'john@company.com');
```

### Error: Violating UNIQUE

```sql
-- ❌ Error: Email already exists
INSERT INTO employees (first_name, last_name, email)
VALUES ('Jane', 'Doe', 'john@company.com');  -- Duplicate email

-- ✅ Correct: Use unique email
INSERT INTO employees (first_name, last_name, email)
VALUES ('Jane', 'Doe', 'jane@company.com');
```

### Error: Violating FOREIGN KEY

```sql
-- ❌ Error: department_id 99 doesn't exist in departments table
INSERT INTO employees (first_name, last_name, department_id)
VALUES ('John', 'Smith', 99);

-- ✅ Correct: Use existing department_id
INSERT INTO employees (first_name, last_name, department_id)
VALUES ('John', 'Smith', 1);
```

## Next Steps

You've now learned how to modify data and understand data types and constraints. Practice with the exercises to reinforce these concepts before moving to Level 3!

---

**Key Takeaways:**
- Data types define what kind of data can be stored
- Common types: INTEGER, DECIMAL, VARCHAR, DATE, BOOLEAN
- PRIMARY KEY uniquely identifies rows
- FOREIGN KEY maintains relationships between tables
- NOT NULL prevents missing values
- UNIQUE ensures column values are unique
- Constraints enforce data integrity and quality
