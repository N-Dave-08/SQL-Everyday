# Level 2 Exercises: Data Manipulation

Complete these exercises using the `employees` and `products` tables from the database.

**Important**: Before running UPDATE or DELETE statements, always test your WHERE clause with a SELECT statement first!

---

## Exercise 1: INSERT - Adding New Employees
**Difficulty: Beginner**

Add a new employee to the database with the following information:
- First name: 'Alex'
- Last name: 'Turner'
- Email: 'alex.turner@company.com'
- Phone: '555-0116'
- Hire date: '2023-06-01'
- Job title: 'Software Engineer'
- Salary: 70000
- Department ID: 1

After inserting, write a SELECT query to verify the employee was added correctly.

---

## Exercise 2: INSERT - Multiple Rows
**Difficulty: Beginner**

Add two new products to the database in a single INSERT statement:
- Product 1:
  - Name: 'Gaming Mouse'
  - Category: 'Electronics'
  - Price: 59.99
  - Stock quantity: 75
  - Supplier ID: 2
  - Created date: '2023-05-20'
  
- Product 2:
  - Name: 'Monitor Stand'
  - Category: 'Accessories'
  - Price: 34.99
  - Stock quantity: 120
  - Supplier ID: 3
  - Created date: '2023-05-21'

Verify both products were added.

---

## Exercise 3: UPDATE - Single Row
**Difficulty: Beginner**

Give employee ID 5 a raise. Update their salary to 60000.

**Before running UPDATE**: First write a SELECT query to see the current salary of employee ID 5.

---

## Exercise 4: UPDATE - Multiple Columns
**Difficulty: Beginner**

Update employee ID 8 (Amanda Davis) to:
- Change job title to 'Senior HR Specialist'
- Increase salary to 65000

Use a single UPDATE statement.

---

## Exercise 5: UPDATE - Multiple Rows with Expression
**Difficulty: Intermediate**

Give all employees in department 1 (Engineering) a 10% salary increase.

**Important**: 
1. First, write a SELECT query to see which employees will be affected
2. Calculate what the new salaries will be
3. Then write and execute the UPDATE statement
4. Verify the changes with a SELECT query

---

## Exercise 6: UPDATE - Using WHERE with Multiple Conditions
**Difficulty: Intermediate**

Update all 'Junior Developer' employees who have a salary less than 57000. Set their salary to 58000.

**Safety check**: Use SELECT first to see which employees will be affected.

---

## Exercise 7: DELETE - Single Row
**Difficulty: Beginner**

Delete the product with product_id = 12 (Laptop Stand).

**Before deleting**: 
1. Write a SELECT query to see the product that will be deleted
2. Then execute the DELETE statement
3. Verify it was deleted with another SELECT query

---

## Exercise 8: DELETE - Multiple Rows
**Difficulty: Intermediate**

Delete all products that have a stock quantity of 0 (if any exist).

**Safety check**: 
1. First, check if any products have stock_quantity = 0
2. If there are any, see which products will be deleted
3. Then execute the DELETE statement

---

## Exercise 9: Transaction Practice
**Difficulty: Advanced**

Use a transaction to:
1. Insert a new employee: 'Test', 'User', 'test.user@company.com', 'Tester', 50000, department_id = 1
2. Update employee ID 1's salary to 80000
3. Check the results with SELECT queries
4. If everything looks correct, COMMIT the transaction
5. If something is wrong, ROLLBACK the transaction

**Note**: Transaction syntax varies by database. Use the appropriate syntax for your database.

---

## Exercise 10: INSERT with SELECT
**Difficulty: Advanced**

Create a backup of all employees from department 2:
1. First, create a new table called `employees_backup` with the same structure as `employees`
   - Hint: `CREATE TABLE employees_backup AS SELECT * FROM employees WHERE 1=0;`
2. Then, insert all employees from department 2 into the backup table
3. Verify the backup was created correctly

---

## Hints

<details>
<summary>Hint for Exercise 1</summary>
Use INSERT INTO with column names and VALUES. Make sure to provide values for all required columns (check which columns allow NULL).
</details>

<details>
<summary>Hint for Exercise 2</summary>
You can insert multiple rows by providing multiple sets of values separated by commas in a single INSERT statement.
</details>

<details>
<summary>Hint for Exercise 3</summary>
Use UPDATE with SET to change the salary, and WHERE to target employee_id = 5.
</details>

<details>
<summary>Hint for Exercise 4</summary>
You can set multiple columns in one UPDATE statement: SET column1 = value1, column2 = value2
</details>

<details>
<summary>Hint for Exercise 5</summary>
Use an expression in SET: salary = salary * 1.10. Filter with WHERE department_id = 1.
</details>

<details>
<summary>Hint for Exercise 6</summary>
Combine conditions with AND in the WHERE clause.
</details>

<details>
<summary>Hint for Exercise 7</summary>
Use DELETE FROM with WHERE to target the specific product_id.
</details>

<details>
<summary>Hint for Exercise 8</summary>
Use DELETE FROM with WHERE stock_quantity = 0. Always SELECT first to see what will be deleted!
</details>

<details>
<summary>Hint for Exercise 9</summary>
Wrap your INSERT and UPDATE statements between BEGIN TRANSACTION (or START TRANSACTION) and COMMIT/ROLLBACK.
</details>

<details>
<summary>Hint for Exercise 10</summary>
Use INSERT INTO ... SELECT to copy data from one table to another. The WHERE 1=0 trick creates an empty table with the same structure.
</details>

---

## Safety Reminders

⚠️ **Always test your WHERE clause with SELECT before UPDATE or DELETE!**

Example:
```sql
-- Step 1: See what will be affected
SELECT * FROM employees WHERE department_id = 5;

-- Step 2: If correct, then update/delete
UPDATE employees SET salary = 80000 WHERE department_id = 5;
```

---

**Good luck!** Write your solutions, test them, and iterate until they work correctly. This hands-on practice is essential for mastering SQL data manipulation.
