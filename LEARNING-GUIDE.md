# Learning Guide: How to Use This Course

This guide explains the complete learning workflow: how to progress, where to save solutions, how to run queries, and how to validate your answers.

## 📚 Learning Flow

### Step 1: Set Up Your Environment

1. **Install PostgreSQL** (Recommended)
   - **Download**: https://www.postgresql.org/download/
   - **Windows**: Use the official installer
   - **macOS**: `brew install postgresql` or use Postgres.app
   - **Linux**: `sudo apt-get install postgresql postgresql-contrib` (Ubuntu/Debian)
   
   **Alternative**: If you prefer SQLite for simplicity:
   - **SQLite**: https://www.sqlite.org/download.html
   - Or use online: https://sqliteonline.com/

2. **Set Up the Course Database**

   **For PostgreSQL (Recommended):**
   ```bash
   # Create database
   psql -U postgres
   CREATE DATABASE sql_mastery;
   \q
   
   # Run setup script
   psql -U postgres -d sql_mastery -f database/setup.sql
   ```
   
   **For SQLite (Alternative):**
   ```bash
   cd database
   sqlite3 sql_mastery.db < setup.sql
   ```

3. **Verify Setup**
   ```sql
   -- Run this to check if database is set up correctly
   SELECT COUNT(*) FROM employees;
   -- Should return: 15
   ```
   
   **PostgreSQL:**
   ```bash
   psql -U postgres -d sql_mastery -c "SELECT COUNT(*) FROM employees;"
   ```
   
   **SQLite:**
   ```bash
   sqlite3 database/sql_mastery.db "SELECT COUNT(*) FROM employees;"
   ```

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

**This is the easiest method!** Run SQL queries directly in VS Code/Cursor:

#### Setup for VS Code/Cursor

**For PostgreSQL (Recommended):**

1. **Install MySQL Extension by cweijan**
   - Open Extensions (Ctrl+Shift+X)
   - Search for "MySQL" by `cweijan`
   - Install the extension (despite the name, it supports PostgreSQL, SQLite, and many databases)

2. **Connect to PostgreSQL Database**
   - Click the database icon in the left sidebar (or open Command Palette: Ctrl+Shift+P)
   - Select "Add Connection" or click the "+" button
   - Choose "PostgreSQL" as the database type
   - Enter connection details:
     - **Host**: `localhost`
     - **Port**: `5432` (default PostgreSQL port)
     - **Database**: `sql_mastery`
     - **Username**: `postgres` (or your PostgreSQL username)
     - **Password**: (your PostgreSQL password)
   - Click "Connect" or "Save"

3. **Run Queries**
   - Open your `.sql` file (e.g., `my-solutions-01.sql`)
   - Select the query (or place cursor in it)
   - **Method A**: Right-click → "Run Query" or "Execute Query"
   - **Method B**: Use the "Run" button in the editor toolbar
   - **Method C**: Use keyboard shortcut (check extension settings)
   - **Method D**: Use the extension's query panel

4. **View Results**
   - Results appear in a panel below your editor
   - You can see the data in tabular format
   - Row counts and execution time are displayed
   - You can export results if needed

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

#### Quick Start Example with MySQL Extension (cweijan)

**For PostgreSQL:**

1. **First-time setup:**
   - Install PostgreSQL and create database (see Step 1 above)
   - Install "MySQL" extension by cweijan in VS Code/Cursor
   - Add PostgreSQL connection:
     - Click database icon in sidebar
     - Click "+" or "Add Connection"
     - Select "PostgreSQL"
     - Enter: localhost, 5432, sql_mastery, postgres, (password)
     - Click "Connect"
   - Connection should appear in extension sidebar

2. **Create and run queries:**
   - Create `level-01-fundamentals/my-solutions-01.sql`
   - Write your query:
     ```sql
     SELECT first_name, last_name, email
     FROM employees;
     ```
   - Select the query (or place cursor in it)
   - Right-click → "Run Query" or click "Run" button
   - See results instantly in the results panel!

3. **Quick tips for MySQL extension (cweijan):**
   - Browse tables in the extension sidebar
   - Right-click tables to view data, structure, or generate queries
   - Double-click tables to view all data
   - Results panel shows data in tabular format with sorting/filtering
   - You can export query results
   - Extension supports multiple database types (PostgreSQL, SQLite, MySQL, etc.)

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

3. **Run the query** in your IDE (select query and press Ctrl+Shift+E, or use the SQL extension's run command)

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
