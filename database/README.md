# Database Setup Instructions

This folder contains the database schema and sample data for the SQL Mastery Course.

## Quick Start - PostgreSQL (Recommended)

### Prerequisites

1. **Install PostgreSQL**
   - Download from: https://www.postgresql.org/download/
   - Or use package manager:
     - **Windows**: Use installer from postgresql.org
     - **macOS**: `brew install postgresql`
     - **Linux**: `sudo apt-get install postgresql` (Ubuntu/Debian)

2. **Start PostgreSQL Service**
   - **Windows**: PostgreSQL service should start automatically
   - **macOS/Linux**: `brew services start postgresql` or `sudo systemctl start postgresql`

### Setup Steps

1. **Create the database**:
   ```bash
   # Connect to PostgreSQL
   psql -U postgres
   
   # Create database
   CREATE DATABASE sql_mastery;
   
   # Exit psql
   \q
   ```

2. **Run the setup script**:
   ```bash
   psql -U postgres -d sql_mastery -f setup.sql
   ```
   
   Or if you need to specify password:
   ```bash
   PGPASSWORD=your_password psql -U postgres -d sql_mastery -f setup.sql
   ```

3. **Verify the setup**:
   ```bash
   psql -U postgres -d sql_mastery
   ```
   ```sql
   SELECT COUNT(*) FROM employees;  -- Should return 15
   \dt  -- List all tables
   \q   -- Exit
   ```

### Connecting from VS Code/Cursor

1. **Install MySQL Extension by cweijan** (Recommended)
   - Search for "MySQL" by `cweijan` in VS Code/Cursor Extensions
   - Despite the name, it supports PostgreSQL, SQLite, MySQL, and many other databases
   - Install the extension

2. **Connect to PostgreSQL Database**
   - Click the database icon in the left sidebar (or open Command Palette: Ctrl+Shift+P)
   - Click "+" or "Add Connection"
   - Select "PostgreSQL" as database type
   - Enter connection details:
     - **Host**: `localhost`
     - **Port**: `5432` (default PostgreSQL port)
     - **Database**: `sql_mastery`
     - **Username**: `postgres` (or your PostgreSQL username)
     - **Password**: (your PostgreSQL password)
   - Click "Connect" or "Save"

3. **Run Queries**
   - Open your `.sql` file
   - Select the query (or place cursor in it)
   - Right-click → "Run Query" or use the "Run" button
   - View results in the results panel below

**Alternative Extensions:**
- "PostgreSQL" by Chris Kolkman
- "SQLTools" with PostgreSQL driver

## Alternative Database Options

### Option 2: SQLite (Simpler, but limited features)

1. **Install SQLite** (if not already installed):
   - Download from: https://www.sqlite.org/download.html
   - Or use online SQLite: https://sqliteonline.com/

2. **Create the database**:
   ```bash
   sqlite3 sql_mastery.db < setup.sql
   ```

3. **Verify the setup**:
   ```bash
   sqlite3 sql_mastery.db
   .tables
   SELECT COUNT(*) FROM employees;
   ```

**Note**: Some features (stored procedures, advanced triggers) may not work in SQLite.

### Option 3: MySQL/MariaDB

1. **Create database**:
   ```sql
   CREATE DATABASE sql_mastery;
   USE sql_mastery;
   ```

2. **Run setup script**:
   ```bash
   mysql -u your_username -p sql_mastery < setup.sql
   ```

## Database Schema Overview

The database includes the following tables:

### Level 1-2: Basic Tables
- `employees` - Employee information
- `products` - Product catalog

### Level 3-4: Relational Tables
- `customers` - Customer information
- `orders` - Order records
- `order_items` - Order line items
- `products` - Product details (used in joins)

### Level 5-6: Complex Scenarios
- `departments` - Department information
- `sales` - Sales transactions with dates
- `employees` with department relationships

### Level 7-8: Advanced Features
- Normalized schema examples
- Index examples
- Views and stored procedures (PostgreSQL)

## Resetting the Database

If you need to reset the database to its original state:

**PostgreSQL:**
```sql
DROP DATABASE sql_mastery;
CREATE DATABASE sql_mastery;
-- Then run setup.sql again
psql -U postgres -d sql_mastery -f setup.sql
```

**SQLite:**
```bash
rm sql_mastery.db
sqlite3 sql_mastery.db < setup.sql
```

**MySQL:**
```sql
DROP DATABASE sql_mastery;
CREATE DATABASE sql_mastery;
-- Then run setup.sql again
```

## PostgreSQL-Specific Features

This course uses PostgreSQL-specific features in advanced levels:
- **Stored Procedures**: Full PL/pgSQL support
- **Materialized Views**: Available in PostgreSQL
- **Advanced Window Functions**: Full support
- **JSON Support**: Available for advanced topics
- **Full-Text Search**: Available for advanced topics

## Notes

- The database is optimized for PostgreSQL
- All sample data is realistic but fictional
- The schema progressively increases in complexity to match course levels
- Foreign key constraints are enforced in PostgreSQL
- Indexes are created for performance examples

## Troubleshooting

### Connection Issues

**"password authentication failed"**
- Check your PostgreSQL username and password
- Verify PostgreSQL service is running

**"database does not exist"**
- Create the database first: `CREATE DATABASE sql_mastery;`

**"permission denied"**
- Make sure you're using a user with CREATE privileges
- Default `postgres` user should work

### Port Issues

- Default PostgreSQL port is `5432`
- Check if port is in use: `netstat -an | grep 5432` (Linux/Mac)
