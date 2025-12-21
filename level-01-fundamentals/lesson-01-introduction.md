# Lesson 1.1: Introduction to SQL and Databases

## What is SQL?

**SQL (Structured Query Language)** is a programming language designed for managing and manipulating relational databases. It's the standard language for interacting with databases and is used by developers, data analysts, and database administrators worldwide.

## Key Concepts

### Relational Database Management System (RDBMS)

A **Relational Database Management System** is software that stores data in tables that are related to each other. Popular RDBMS include:
- PostgreSQL (open-source, advanced features, full SQL standard support)
- MySQL (open-source, widely used)
- SQL Server (Microsoft)
- Oracle (enterprise-level)

**This course uses PostgreSQL**, which provides excellent support for all SQL features covered in these lessons.

### Database Structure

A **database** is a collection of related data organized in a structured way. Think of it as a digital filing cabinet.

#### Tables
A **table** is a collection of related data organized in rows and columns. It's like a spreadsheet.

```
┌─────────────┬──────────────┬─────────────┐
│ employee_id │ first_name   │ last_name   │
├─────────────┼──────────────┼─────────────┤
│ 1           │ John         │ Smith       │
│ 2           │ Sarah        │ Johnson     │
│ 3           │ Michael      │ Williams    │
└─────────────┴──────────────┴─────────────┘
```

#### Rows (Records)
A **row** represents a single record or entry in a table. Each row contains data about one entity (e.g., one employee).

#### Columns (Fields)
A **column** represents a specific attribute or property of the data. Each column has a name and a data type (e.g., `first_name` as VARCHAR, `salary` as DECIMAL).

### Basic Database Terminology

- **Schema**: The structure of the database (tables, columns, relationships)
- **Primary Key**: A unique identifier for each row in a table
- **Foreign Key**: A column that references the primary key of another table
- **Query**: A request for data from a database
- **Statement**: A complete SQL command

## SQL Statement Types

SQL statements are categorized into different types:

1. **DDL (Data Definition Language)**: Create, modify, or delete database structures
   - `CREATE`, `ALTER`, `DROP`

2. **DML (Data Manipulation Language)**: Insert, update, or delete data
   - `SELECT`, `INSERT`, `UPDATE`, `DELETE`

3. **DCL (Data Control Language)**: Control access to data
   - `GRANT`, `REVOKE`

4. **TCL (Transaction Control Language)**: Manage transactions
   - `COMMIT`, `ROLLBACK`

## SQL Syntax Basics

### General Rules

1. **SQL is case-insensitive** for keywords (though conventions vary)
   - `SELECT`, `select`, `Select` are all valid
   - Best practice: Use uppercase for SQL keywords

2. **Semicolons** are used to end statements (required in some databases, optional in others)

3. **Strings** are enclosed in single quotes: `'John Smith'`

4. **Comments** use `--` for single-line or `/* */` for multi-line

### Example Query Structure

```sql
SELECT column1, column2
FROM table_name
WHERE condition
ORDER BY column1;
```

## Why Learn SQL?

- **Universal**: Works with almost every database system
- **Powerful**: Can handle complex data operations
- **In-demand**: Essential skill for data-related careers
- **Foundation**: Understanding SQL helps with NoSQL and other data technologies

## Next Steps

In the next lesson, you'll learn how to retrieve data using the `SELECT` statement, which is the foundation of all SQL queries.

---

**Key Takeaways:**
- SQL is a language for managing relational databases
- Databases contain tables with rows (records) and columns (fields)
- SQL statements are categorized into DDL, DML, DCL, and TCL
- Understanding database structure is essential before writing queries
