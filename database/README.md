# Database Setup Instructions

This folder contains the database schema and sample data for the SQL Mastery Course.

## Quick Start

### Option 1: SQLite (Recommended for Beginners)

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

### Option 2: MySQL/MariaDB

1. **Create database**:
   ```sql
   CREATE DATABASE sql_mastery;
   USE sql_mastery;
   ```

2. **Run setup script**:
   ```bash
   mysql -u your_username -p sql_mastery < setup.sql
   ```

### Option 3: PostgreSQL

1. **Create database**:
   ```sql
   CREATE DATABASE sql_mastery;
   \c sql_mastery
   ```

2. **Run setup script**:
   ```bash
   psql -U your_username -d sql_mastery -f setup.sql
   ```

### Option 4: Online SQL Editors

You can copy the contents of `setup.sql` into:
- **SQLite Online**: https://sqliteonline.com/
- **DB Fiddle**: https://www.db-fiddle.com/
- **SQL Fiddle**: http://sqlfiddle.com/

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
- Views and stored procedures

## Resetting the Database

If you need to reset the database to its original state:

**SQLite:**
```bash
rm sql_mastery.db
sqlite3 sql_mastery.db < setup.sql
```

**MySQL/PostgreSQL:**
```sql
DROP DATABASE sql_mastery;
-- Then recreate using the steps above
```

## Notes

- The database is designed to work with SQLite by default (most compatible)
- Some advanced features (stored procedures, triggers) may require MySQL or PostgreSQL
- All sample data is realistic but fictional
- The schema progressively increases in complexity to match course levels
