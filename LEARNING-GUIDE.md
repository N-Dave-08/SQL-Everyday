# Learning Guide: How to Use This Course

This guide explains the complete learning workflow: how to progress, where to save solutions, how to run queries, and how to validate your answers.

## 📚 Learning Flow

### Step 1: Set Up Your Environment

1. **Install PostgreSQL** (Recommended)
   - **Download**: https://www.postgresql.org/download/
   - **Windows**: Use the official installer
     - During installation, remember the password you set for the `postgres` user
     - You can skip Stack Builder (it's optional)
   - **macOS**: `brew install postgresql` or use Postgres.app
   - **Linux**: `sudo apt-get install postgresql postgresql-contrib` (Ubuntu/Debian)
   
   **Verify PostgreSQL is running:**
   - **Windows**: Open Services (Win+R → `services.msc`) and check for "postgresql-x64-18" (should be Running)
   - **macOS/Linux**: `brew services list` or `sudo systemctl status postgresql`
   
   **Alternative**: If you prefer SQLite for simplicity:
   - **SQLite**: https://www.sqlite.org/download.html
   - Or use online: https://sqliteonline.com/

2. **Set Up the Course Database**

   **Method A: Using MySQL Extension by cweijan (Recommended - Easiest!)**

   This is the easiest method - you can do everything from VS Code/Cursor without using the command line!

   **Step 2A.1: Install the Extension**
   - Open VS Code/Cursor
   - Press `Ctrl+Shift+X` (or `Cmd+Shift+X` on Mac) to open Extensions
   - Search for "MySQL" by `cweijan`
   - Click "Install"
   - **Note**: Despite the name "MySQL", this extension supports PostgreSQL, SQLite, MySQL, and many other databases!

   **Step 2A.2: Connect to PostgreSQL**
   - Click the database icon in the left sidebar (or press `Ctrl+Shift+P` and type "Database")
   - Click the "+" button or "Add Connection"
   - Select "PostgreSQL" as the database type (important: not MySQL!)
   - Enter connection details:
     - **Host**: `localhost`
     - **Port**: `5432` (default PostgreSQL port)
     - **Username**: `postgres` (default PostgreSQL superuser)
     - **Password**: (the password you set during PostgreSQL installation)
     - **Database**: `postgres` (connect to default database first)
   - Click "Connect" or "Save"
   - You should see the connection appear in the extension sidebar

   **Step 2A.3: Create the Course Database**
   - Once connected, you'll see a query panel or can open a new SQL file
   - Run this query to create the database:
     ```sql
     CREATE DATABASE sql_mastery;
     ```
   - Right-click the query → "Run Query" or click the "Run" button
   - You should see a success message

   **Step 2A.4: Connect to the New Database**
   - Disconnect from the current connection (right-click → "Disconnect" or click the disconnect icon)
   - Add a new connection (click "+" again)
   - Use the same settings, but change:
     - **Database**: `sql_mastery` (instead of `postgres`)
   - Click "Connect"
   - You should now see `sql_mastery` in the sidebar

   **Step 2A.5: Run the Setup Script**
   - Open the file `database/setup.sql` in VS Code/Cursor
   - Make sure you're connected to `sql_mastery` database (check the extension sidebar)
   - Select all the SQL in the file (`Ctrl+A` or `Cmd+A`)
   - Right-click → "Run Query" or click the "Run" button
   - Wait for all queries to execute (you'll see progress in the output panel)
   - You should see messages like:
     - "15 rows affected" (for employees table)
     - "12 rows affected" (for products table)
     - etc.

   **Step 2A.6: Verify Setup**
   - In the extension sidebar, expand your `sql_mastery` connection
   - Expand "Tables" - you should see:
     - `customers`
     - `departments`
     - `employees`
     - `order_items`
     - `orders`
     - `products`
     - `sales`
     - `suppliers`
   - Right-click on `employees` → "Open Table" to view the data
   - Or run this query:
     ```sql
     SELECT COUNT(*) FROM employees;
     ```
     - Should return: `15`

   **Method B: Using Command Line (Alternative)**

   If you prefer using the command line or if the extension method doesn't work, you can use `psql` directly.

   **For PostgreSQL:**

   **Step 2B.1: Ensure PostgreSQL is in your PATH**
   - **Windows**: Add PostgreSQL bin directory to PATH:
     - Usually: `C:\Program Files\PostgreSQL\18\bin`
     - Search "Environment Variables" in Windows
     - Edit "Path" → Add → PostgreSQL bin directory
     - Restart your terminal/VS Code after adding to PATH
   - **macOS/Linux**: Usually already in PATH after installation
   - **Verify**: Open terminal and type `psql --version` (should show version number)

   **Step 2B.2: Create the Database**
   
   **Option 1: Single Command (Easiest)**
   ```bash
   # Create database in one command
   psql -U postgres -c "CREATE DATABASE sql_mastery;"
   ```
   - It will prompt for your PostgreSQL password (type it and press Enter - password won't show)
   - You should see: `CREATE DATABASE`
   
   **Option 2: Interactive Session**
   ```bash
   # Connect to PostgreSQL
   psql -U postgres
   
   # You'll be prompted for password, then enter psql prompt
   # In psql, run:
   CREATE DATABASE sql_mastery;
   
   # Exit psql
   \q
   ```

   **Step 2B.3: Run the Setup Script**
   ```bash
   # Navigate to your project directory first
   cd D:\DIRECTORY\projects\SQL-Everyday
   
   # Run the setup script
   psql -U postgres -d sql_mastery -f database/setup.sql
   ```
   - It will prompt for your password
   - You should see output like:
     ```
     CREATE TABLE
     INSERT 0 15
     CREATE TABLE
     INSERT 0 12
     ...
     ```
   - This means all tables and data were created successfully

   **Step 2B.4: Verify Setup (Command Line)**
   ```bash
   # Check if employees table has data
   psql -U postgres -d sql_mastery -c "SELECT COUNT(*) FROM employees;"
   ```
   - Should return: `count` with value `15`

   **Alternative: Using PGPASSWORD Environment Variable**
   
   If you don't want to type the password each time:
   ```bash
   # Windows PowerShell
   $env:PGPASSWORD="your_password"
   psql -U postgres -c "CREATE DATABASE sql_mastery;"
   psql -U postgres -d sql_mastery -f database/setup.sql
   
   # Windows Command Prompt
   set PGPASSWORD=your_password
   psql -U postgres -c "CREATE DATABASE sql_mastery;"
   psql -U postgres -d sql_mastery -f database/setup.sql
   
   # macOS/Linux
   export PGPASSWORD="your_password"
   psql -U postgres -c "CREATE DATABASE sql_mastery;"
   psql -U postgres -d sql_mastery -f database/setup.sql
   ```
   **Note**: This is less secure as the password is visible in command history. Use with caution.

   **For SQLite (Alternative):**
   ```bash
   cd database
   sqlite3 sql_mastery.db < setup.sql
   ```

3. **Verify Setup**

   Run this query to check if the database is set up correctly:
   ```sql
   SELECT COUNT(*) FROM employees;
   -- Should return: 15
   ```

   **Using MySQL Extension (Method A):**
   - Open a new SQL file or use the extension's query panel
   - Run the query above
   - Right-click → "Run Query"
   - Check the results panel - should show `count: 15`
   - Also check the extension sidebar: expand `sql_mastery` → "Tables" to see all 8 tables

   **Using Command Line (Method B):**
   ```bash
   # PostgreSQL
   psql -U postgres -d sql_mastery -c "SELECT COUNT(*) FROM employees;"
   # Should output: count with value 15
   
   # SQLite
   sqlite3 database/sql_mastery.db "SELECT COUNT(*) FROM employees;"
   # Should output: 15
   ```

   **Quick Verification Checklist:**
   - [ ] Database `sql_mastery` exists
   - [ ] Can see 8 tables in extension sidebar (or via `\dt` in psql)
   - [ ] `employees` table has 15 rows
   - [ ] `products` table has 12 rows
   - [ ] `customers` table has 10 rows
   - [ ] Can run queries without errors

### Step 2: Follow the Learning Path

For each level, follow this sequence:

1. **Read the Lessons** (in order)
   - Start with `lesson-01-*.md`
   - Read through all lessons in the level
   - Type out and run the example queries yourself
   - Experiment with modifying the examples

2. **Attempt the Exercises**
   - Open `exercises-*.md`
   - Read each exercise carefully
   - Write your SQL solution in a `.sql` file in the same level folder
   - Run it directly in your IDE (see "How to Run Your SQL Queries" below)

3. **Run Your Solution**
   - Execute your query against the database
   - Check for syntax errors
   - Review the results

4. **Validate Your Solution**
   - Compare your output with expected format
   - Check row counts
   - Verify data correctness
   - Use validation techniques (see below)

5. **Iterate if Needed**
   - If results don't match, debug your query
   - Review relevant lesson sections
   - Check hints (only if stuck)
   - Refine until correct

6. **Move to Next Level**
   - Once all exercises are complete and validated
   - Move to the next level

## 💾 Where to Save Your Solutions

### Recommended: Save in Level Folders

Save your solutions directly in each level's folder:

```
SQL-Everyday/
├── level-01-fundamentals/
│   ├── lesson-01-introduction.md
│   ├── lesson-02-select-basics.md
│   ├── lesson-03-filtering-sorting.md
│   ├── exercises-01.md
│   └── my-solutions-01.sql  ← Your solutions here
├── level-02-data-manipulation/
│   ├── lesson-01-insert-update-delete.md
│   ├── lesson-02-data-types-constraints.md
│   ├── exercises-02.md
│   └── my-solutions-02.sql  ← Your solutions here
└── ... (one solution file per level)
```

### Solution File Format

Save your solutions in `.sql` files with clear comments:

```sql
-- ============================================
-- Level 1: SQL Fundamentals
-- ============================================

-- Exercise 1: Basic SELECT
-- Write a query to display the first name, last name, and email of all employees.

SELECT first_name, last_name, email
FROM employees;

-- Exercise 2: Filtering with WHERE
-- Find all employees who have a salary greater than 75000.

SELECT first_name, last_name, salary
FROM employees
WHERE salary > 75000;

-- Exercise 3: Multiple Conditions
-- ... (continue for all exercises)
```

### Alternative: One File Per Exercise

If you prefer, create separate files in each level folder:

```
level-01-fundamentals/
├── exercises-01.md
├── my-exercise-01.sql
├── my-exercise-02.sql
└── ...
```

## 🚀 How to Run Your SQL Queries

### Recommended: Run SQL Directly in Your IDE

**This is the easiest method!** Run SQL queries directly in VS Code/Cursor using the MySQL extension by cweijan.

#### Complete Guide: Using MySQL Extension by cweijan

**For PostgreSQL (Recommended):**

1. **Install MySQL Extension by cweijan**
   - Open Extensions (`Ctrl+Shift+X` or `Cmd+Shift+X` on Mac)
   - Search for "MySQL" by `cweijan`
   - Click "Install"
   - **Note**: Despite the name "MySQL", this extension supports PostgreSQL, SQLite, MySQL, and many other databases!

2. **Connect to PostgreSQL Database**
   - Click the database icon in the left sidebar (or press `Ctrl+Shift+P` and type "Database")
   - Click the "+" button or "Add Connection"
   - **Important**: Select "PostgreSQL" as the database type (not MySQL!)
   - Enter connection details:
     - **Host**: `localhost`
     - **Port**: `5432` (default PostgreSQL port)
     - **Database**: `sql_mastery`
     - **Username**: `postgres` (or your PostgreSQL username)
     - **Password**: (your PostgreSQL password - the one you set during installation)
   - Click "Connect" or "Save"
   - You should see your connection appear in the extension sidebar with a green indicator

3. **Browse Your Database**
   - In the extension sidebar, expand your `sql_mastery` connection
   - Expand "Tables" to see all tables:
     - `customers`, `departments`, `employees`, `order_items`, `orders`, `products`, `sales`, `suppliers`
   - Right-click any table to:
     - **"Open Table"** - View all data in the table
     - **"View Structure"** - See table columns and types
     - **"Generate Query"** - Auto-generate SELECT queries
   - Double-click a table name to quickly view its data

4. **Run Queries - Multiple Methods**

   **Method 1: Right-Click Menu (Easiest)**
   - Open your `.sql` file (e.g., `level-01-fundamentals/my-solutions-01.sql`)
   - Select the query you want to run (highlight it with your mouse)
   - Right-click on the selected query
   - Choose "Run Query" or "Execute Query"
   - Results appear in a panel below your editor

   **Method 2: Run Button**
   - Place your cursor anywhere in the query
   - Look for a "Run" button in the editor toolbar (usually appears above the query)
   - Click the "Run" button
   - The extension will automatically detect which query to run

   **Method 3: Keyboard Shortcut**
   - Select your query
   - Press `Ctrl+Shift+E` (or check extension settings for custom shortcuts)
   - Query executes immediately

   **Method 4: Extension Query Panel**
   - Click on the database icon in the sidebar
   - Some extensions provide a query panel where you can type and run queries directly
   - Results appear in the same panel

   **Method 5: Run Entire File**
   - To run all queries in a file:
     - Select all (`Ctrl+A` or `Cmd+A`)
     - Right-click → "Run Query"
     - All queries execute sequentially
     - Results appear one after another

5. **View and Work with Results**
   - Results appear in a panel below your editor (or in a separate tab)
   - **Tabular View**: Data displayed in a table format
   - **Sorting**: Click column headers to sort
   - **Filtering**: Some extensions allow filtering results
   - **Row Count**: See how many rows were returned
   - **Execution Time**: See how long the query took
   - **Export**: Right-click results to export as CSV, JSON, etc.
   - **Copy**: Select cells or rows and copy to clipboard

6. **Tips for Running Queries**
   - **Multiple Queries**: You can have multiple queries in one file, separated by semicolons
   - **Comments**: Use `--` for single-line comments (they won't be executed)
   - **Selective Execution**: Only the selected query (or query where cursor is) will run
   - **Save First**: Always save your `.sql` file before running queries
   - **Connection Check**: Make sure you're connected to `sql_mastery` database (check sidebar)
   - **Error Messages**: If a query fails, error messages appear in the output panel

**For SQLite (Alternative):**

1. **Install SQLite Extension**
   - Search for "SQLite" by `alexcvzz`
   - Install the extension

2. **Connect to Database**
   - Right-click on `database/sql_mastery.db` in file explorer
   - Select "Open Database"
   - Database appears in SQLite extension sidebar

3. **Run Queries**
   - Select query and press `Ctrl+Shift+E` or right-click → "Run Query"

#### Quick Start Example: Complete Workflow

**Step-by-Step Example:**

1. **Install PostgreSQL** (if not already installed)
   - Download from https://www.postgresql.org/download/
   - Install and remember your `postgres` user password

2. **Install MySQL Extension by cweijan**
   - Open Extensions (`Ctrl+Shift+X`)
   - Search "MySQL" by `cweijan`
   - Click "Install"

3. **Create Database Connection**
   - Click database icon in left sidebar
   - Click "+" button
   - Select "PostgreSQL" (important!)
   - Enter:
     - Host: `localhost`
     - Port: `5432`
     - Database: `postgres` (connect to default first)
     - Username: `postgres`
     - Password: (your PostgreSQL password)
   - Click "Connect"

4. **Create the Course Database**
   - In a new SQL file or query panel, run:
     ```sql
     CREATE DATABASE sql_mastery;
     ```
   - Right-click → "Run Query"
   - Wait for success message

5. **Connect to sql_mastery Database**
   - Disconnect from `postgres` connection
   - Add new connection with same settings, but:
     - Database: `sql_mastery` (instead of `postgres`)
   - Click "Connect"

6. **Run Setup Script**
   - Open `database/setup.sql`
   - Select all (`Ctrl+A`)
   - Right-click → "Run Query"
   - Wait for all tables to be created (check output panel)

7. **Verify Setup**
   - In extension sidebar, expand `sql_mastery` → "Tables"
   - You should see 8 tables listed
   - Right-click `employees` → "Open Table"
   - Should see 15 employee records

8. **Create and Run Your First Query**
   - Create `level-01-fundamentals/my-solutions-01.sql`
   - Write your query:
     ```sql
     -- Exercise 1: Basic SELECT
     SELECT first_name, last_name, email
     FROM employees;
     ```
   - Select the query text
   - Right-click → "Run Query"
   - See results in the panel below!

9. **Quick Tips for MySQL Extension (cweijan):**
   - **Browse Tables**: Expand connection → Tables in sidebar
   - **View Data**: Right-click table → "Open Table" or double-click table name
   - **View Structure**: Right-click table → "View Structure" to see columns
   - **Generate Queries**: Right-click table → "Generate Query" for auto-SELECT
   - **Results Panel**: 
     - Click column headers to sort
     - Export results as CSV/JSON
     - Copy cells or entire rows
   - **Multiple Connections**: Can connect to multiple databases simultaneously
   - **Query History**: Some versions save your recent queries
   - **Auto-complete**: Extension provides SQL autocomplete as you type

**For SQLite:**

1. **First-time setup:**
   - Right-click `database/sql_mastery.db` in file explorer
   - Select "Open Database"
   - Database appears in SQLite extension sidebar

2. **Create and run queries:**
   - Same as above, but use SQLite extension commands
   - Press `Ctrl+Shift+E` to run queries

#### IDE Workflow Tips

- **Write and test in the same file**: Keep your solutions and test queries together
- **Use comments to separate exercises**: Makes it easy to run individual queries
- **Quick validation**: Write validation queries right below your solution
- **Multiple queries**: You can run multiple queries; results appear sequentially
- **Save before running**: Always save your `.sql` file before executing

#### Example Workflow in IDE

```sql
-- Exercise 1: Basic SELECT
SELECT first_name, last_name, email
FROM employees;

-- Validation: Check row count
SELECT COUNT(*) FROM employees;  -- Should return 15

-- Exercise 2: Filtering with WHERE
SELECT first_name, last_name, salary
FROM employees
WHERE salary > 75000;

-- Validation: Verify all salaries are > 75000
SELECT MIN(salary) FROM employees WHERE salary > 75000;
```

Just select the query you want to run and execute it!

### Alternative Methods

#### Method 1: Command Line (SQLite)

```bash
# Open SQLite database
sqlite3 database/sql_mastery.db

# Run a query file
.read level-01-fundamentals/my-solutions-01.sql

# Or run queries directly
sqlite3 database/sql_mastery.db "SELECT * FROM employees;"
```

#### Method 2: GUI Tool (DB Browser for SQLite)

1. Open DB Browser for SQLite
2. Open Database → Select `database/sql_mastery.db`
3. Go to "Execute SQL" tab
4. Paste your query or open your `.sql` file
5. Click "Execute SQL" (F5)

#### Method 3: Online SQL Editor

1. Go to https://sqliteonline.com/
2. Copy contents of `database/setup.sql`
3. Paste and run to create tables
4. Run your solution queries

## ✅ How to Validate Your Solutions

### Validation Method 1: Compare Output Format

Check if your results match the expected format:

**Expected:**
```
first_name | last_name | email
-----------|-----------|--------------------------
John       | Smith     | john.smith@company.com
Sarah      | Johnson   | sarah.johnson@company.com
```

**Your Output Should:**
- Have the same columns
- Have the same number of rows (or expected range)
- Data should be logically correct

### Validation Method 2: Check Row Counts

```sql
-- Exercise asks for employees with salary > 75000
-- First, check how many should be returned:
SELECT COUNT(*) FROM employees WHERE salary > 75000;
-- Returns: 8

-- Your query should return 8 rows
SELECT first_name, last_name, salary
FROM employees
WHERE salary > 75000;
-- Count the rows in your result
```

### Validation Method 3: Verify Data Correctness

**For filtering exercises:**
```sql
-- Your solution
SELECT * FROM employees WHERE salary > 75000;

-- Validation: Check if all returned rows actually have salary > 75000
SELECT * FROM employees 
WHERE salary > 75000 
AND salary <= 75000;  -- Should return 0 rows (all should be > 75000)
```

**For sorting exercises:**
```sql
-- Your solution
SELECT * FROM employees ORDER BY salary DESC LIMIT 5;

-- Validation: Check if salaries are actually descending
-- Manually verify first salary >= second salary >= third, etc.
```

### Validation Method 4: Use Test Queries

Create validation queries to check your solution:

```sql
-- Exercise: Find employees in department 1
-- Your solution:
SELECT * FROM employees WHERE department_id = 1;

-- Validation query:
SELECT 
    COUNT(*) AS total_rows,
    COUNT(DISTINCT department_id) AS unique_depts,
    MIN(department_id) AS min_dept,
    MAX(department_id) AS max_dept
FROM employees 
WHERE department_id = 1;
-- Should show: total_rows = 6, unique_depts = 1, min_dept = 1, max_dept = 1
```

### Validation Method 5: Compare with Expected Logic

**For JOIN exercises:**
```sql
-- Your solution joins employees and departments
-- Validation: Check if all employees have valid departments
SELECT e.employee_id, e.department_id, d.department_id
FROM employees e
JOIN departments d ON e.department_id = d.department_id
WHERE e.department_id IS NULL OR d.department_id IS NULL;
-- Should return 0 rows (all joins should be valid)
```

**For aggregate exercises:**
```sql
-- Your solution calculates average salary by department
-- Validation: Manually calculate one department's average
SELECT AVG(salary) FROM employees WHERE department_id = 1;
-- Compare with your grouped result for department_id = 1
```

### Validation Method 6: Check for Common Mistakes

**Missing WHERE clause:**
```sql
-- Wrong: Returns all employees
SELECT * FROM employees;

-- Correct: Should filter
SELECT * FROM employees WHERE salary > 75000;
```

**Wrong sort order:**
```sql
-- Check if ORDER BY is correct
-- If exercise says "highest first", verify first row has highest value
```

**Incorrect JOIN:**
```sql
-- Check if you're getting the expected number of rows
-- INNER JOIN should have fewer or equal rows than LEFT JOIN
```

## 📝 Validation Checklist

For each exercise, verify:

- [ ] Query runs without errors
- [ ] Returns expected number of rows
- [ ] Column names match expected output
- [ ] Data values are correct (not just structure)
- [ ] Filtering conditions are met (if applicable)
- [ ] Sorting is correct (if applicable)
- [ ] Aggregations are accurate (if applicable)
- [ ] JOINs return correct relationships (if applicable)

## 🔍 Debugging Tips

### If Your Query Doesn't Work

1. **Check Syntax**
   ```sql
   -- Common errors:
   -- Missing comma between columns
   -- Missing quotes around strings
   -- Wrong table/column names
   ```

2. **Test Incrementally**
   ```sql
   -- Start simple
   SELECT * FROM employees;
   
   -- Add WHERE
   SELECT * FROM employees WHERE department_id = 1;
   
   -- Add specific columns
   SELECT first_name, last_name FROM employees WHERE department_id = 1;
   ```

3. **Verify Table/Column Names**
   ```sql
   -- PostgreSQL (recommended)
   \d employees  -- Shows table structure
   \d+ employees -- Shows detailed structure with indexes
   
   -- Or use SQL query
   SELECT column_name, data_type 
   FROM information_schema.columns 
   WHERE table_name = 'employees';
   
   -- SQLite (alternative)
   PRAGMA table_info(employees);
   
   -- MySQL (alternative)
   DESCRIBE employees;
   ```

4. **Check Data Types**
   ```sql
   -- Make sure you're comparing compatible types
   -- Dates: '2023-01-15' not '01/15/2023'
   -- Numbers: 75000 not '75000' (unless column is text)
   ```

### Troubleshooting MySQL Extension by cweijan

**Connection Issues:**

1. **"ECONNREFUSED" or "Connection failed"**
   - **Check PostgreSQL is running:**
     - Windows: Open Services (`Win+R` → `services.msc`), find "postgresql-x64-18", should be "Running"
     - macOS/Linux: `brew services list` or `sudo systemctl status postgresql`
   - **Verify connection settings:**
     - Host: `localhost` (not `127.0.0.1` or IP address)
     - Port: `5432` (default PostgreSQL port)
     - Username: `postgres` (not `sql_mastery` or `root`)
     - Database: `sql_mastery` (after creating it) or `postgres` (for initial connection)
   - **Check password:** Make sure you're using the password you set during PostgreSQL installation

2. **"Database does not exist"**
   - Connect to `postgres` database first
   - Run: `CREATE DATABASE sql_mastery;`
   - Then disconnect and reconnect with Database set to `sql_mastery`

3. **"Password authentication failed"**
   - Verify you're using the correct password (set during PostgreSQL installation)
   - Try resetting PostgreSQL password if forgotten (see PostgreSQL documentation)

4. **"Server Type" confusion**
   - **Important**: Select "PostgreSQL" as server type, NOT "MySQL"
   - The extension name is "MySQL" but it supports PostgreSQL
   - Make sure you click the PostgreSQL icon in the connection dialog

**Query Execution Issues:**

1. **Query doesn't run / No response**
   - Make sure you're connected (check sidebar for green connection indicator)
   - Verify you're connected to `sql_mastery` database (not `postgres`)
   - Try selecting the query text before running
   - Save the file before running queries
   - Check the output panel for error messages

2. **"Table does not exist"**
   - Verify you ran `database/setup.sql` successfully
   - Check extension sidebar: expand `sql_mastery` → "Tables" to see if tables exist
   - If tables are missing, run `setup.sql` again

3. **Results panel doesn't show**
   - Check if results panel is minimized (look for a panel at the bottom)
   - Try running a simple query: `SELECT 1;`
   - Check extension output panel for errors

4. **Multiple queries in one file**
   - Select the specific query you want to run
   - Or separate queries with semicolons and select all to run sequentially
   - Some extensions run only the query where your cursor is positioned

**Extension Not Working:**

1. **Extension not appearing in sidebar**
   - Reload VS Code/Cursor: `Ctrl+Shift+P` → "Reload Window"
   - Check if extension is enabled in Extensions panel
   - Try uninstalling and reinstalling the extension

2. **"Run Query" option not showing**
   - Make sure you have a `.sql` file open
   - Select the query text first
   - Check if extension is properly installed and enabled

3. **Can't see database tables**
   - Expand your connection in the sidebar
   - Click the refresh icon to reload database structure
   - Verify you're connected to the correct database

**General Tips:**

- **Always check the extension output panel** for detailed error messages
- **Verify connection status** in the sidebar (green = connected, red = disconnected)
- **Test with a simple query first**: `SELECT 1;` to verify connection works
- **Restart VS Code/Cursor** if extension behaves unexpectedly
- **Check extension settings** (`Ctrl+,` → search "mysql") for configuration options

## 🎯 Example: Complete Workflow

### Exercise: "Find employees with salary > 75000"

1. **Read the exercise** in `exercises-01.md`

2. **Write your solution** in `level-01-fundamentals/my-solutions-01.sql`:
   ```sql
   -- Exercise 2: Filtering with WHERE
   SELECT first_name, last_name, salary
   FROM employees
   WHERE salary > 75000;
   ```

3. **Run the query** in your IDE:
   - Make sure you're connected to `sql_mastery` database (check MySQL extension sidebar)
   - Select the query text
   - Right-click → "Run Query" (or click the "Run" button)
   - Results appear in the panel below

4. **Validate:**
   ```sql
   -- Check row count
   SELECT COUNT(*) FROM employees WHERE salary > 75000;
   -- Should match number of rows in your result
   
   -- Verify all salaries are actually > 75000
   SELECT MIN(salary) FROM employees WHERE salary > 75000;
   -- Should be > 75000
   ```

5. **Check output format:**
   - Columns: first_name, last_name, salary ✓
   - All salaries > 75000 ✓
   - Correct number of rows ✓

6. **Mark as complete** and move to next exercise

## 📊 Progress Tracking

Create a simple progress tracker:

```markdown
# My Progress

## Level 1: Fundamentals
- [x] Lesson 1.1: Introduction
- [x] Lesson 1.2: SELECT Basics
- [x] Lesson 1.3: Filtering and Sorting
- [x] Exercises 1-10: Completed

## Level 2: Data Manipulation
- [ ] Lesson 2.1: INSERT, UPDATE, DELETE
- [ ] Lesson 2.2: Data Types and Constraints
- [ ] Exercises 1-10: In Progress
```

## 🆘 Getting Help

If you're stuck:

1. **Review the lesson** - Re-read relevant sections
2. **Check hints** - Expand hints in exercise file
3. **Test with simpler queries** - Break down the problem
4. **Check SQL syntax** - Refer to `resources/sql-cheatsheet.md`
5. **Validate step by step** - Test each part of your query

## 🎓 Next Steps After Completing

1. **Review your solutions** - Look for patterns and improvements
2. **Try variations** - Modify exercises with your own twists
3. **Build projects** - Apply SQL to real problems
4. **Practice online** - Use platforms mentioned in `resources/practice-datasets.md`
5. **Continue learning** - Explore database-specific features

---

**Remember**: The goal is understanding, not speed. Take your time, experiment, and validate thoroughly. Good luck with your SQL learning journey! 🚀
