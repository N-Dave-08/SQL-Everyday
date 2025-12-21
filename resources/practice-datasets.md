# Practice Datasets Guide

Additional practice datasets and ideas to reinforce your SQL skills beyond the course exercises.

## Using the Course Database

The course database (`database/setup.sql`) contains comprehensive sample data. Here are ways to practice:

### Practice Ideas

1. **Explore the Data**
   ```sql
   -- Get familiar with each table
   SELECT * FROM employees LIMIT 5;
   SELECT * FROM products LIMIT 5;
   SELECT * FROM orders LIMIT 5;
   ```

2. **Create Your Own Queries**
   - Find patterns in the data
   - Answer business questions
   - Practice different join types
   - Experiment with window functions

3. **Modify the Data**
   - Add new employees, products, orders
   - Update existing records
   - Practice transactions
   - Test constraints

## Additional Practice Scenarios

### Scenario 1: E-Commerce Analysis

Use the `orders`, `order_items`, `products`, and `customers` tables to:
- Calculate customer lifetime value
- Find best-selling products
- Analyze sales trends by month
- Identify customers who haven't ordered recently

### Scenario 2: HR Analytics

Use the `employees` and `departments` tables to:
- Calculate department budgets vs actual payroll
- Find salary distributions
- Identify departments needing more staff
- Analyze hiring trends

### Scenario 3: Sales Performance

Use the `sales` table to:
- Calculate monthly sales totals
- Compare sales by region
- Find top-performing employees
- Analyze product sales trends

## Online Practice Resources

### Free SQL Practice Platforms

1. **Online SQL Practice**
   - https://sqliteonline.com/ (supports PostgreSQL)
   - https://www.db-fiddle.com/ (supports PostgreSQL)
   - Practice with PostgreSQL in your browser

2. **DB Fiddle**
   - https://www.db-fiddle.com/
   - Test queries across different databases

3. **SQL Fiddle**
   - http://sqlfiddle.com/
   - Practice with various database systems

4. **HackerRank SQL**
   - https://www.hackerrank.com/domains/sql
   - SQL challenges and competitions

5. **LeetCode Database Problems**
   - https://leetcode.com/problemset/database/
   - Real interview-style SQL problems

6. **Mode Analytics SQL Tutorial**
   - https://mode.com/sql-tutorial/
   - Interactive SQL tutorial with real datasets

### Public Datasets

1. **Kaggle Datasets**
   - https://www.kaggle.com/datasets
   - Download CSV files and import into your database

2. **GitHub Awesome Public Datasets**
   - https://github.com/awesomedata/awesome-public-datasets
   - Curated list of public datasets

3. **Data.gov**
   - https://www.data.gov/
   - US government open data

## Creating Your Own Practice Database

### Simple Examples

**Library Database:**
```sql
CREATE TABLE books (
    book_id INTEGER PRIMARY KEY,
    title VARCHAR(200),
    author VARCHAR(100),
    isbn VARCHAR(20),
    published_year INTEGER
);

CREATE TABLE members (
    member_id INTEGER PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    join_date DATE
);

CREATE TABLE loans (
    loan_id INTEGER PRIMARY KEY,
    member_id INTEGER,
    book_id INTEGER,
    loan_date DATE,
    return_date DATE,
    FOREIGN KEY (member_id) REFERENCES members(member_id),
    FOREIGN KEY (book_id) REFERENCES books(book_id)
);
```

**Blog Database:**
```sql
CREATE TABLE users (
    user_id INTEGER PRIMARY KEY,
    username VARCHAR(50) UNIQUE,
    email VARCHAR(100),
    created_at TIMESTAMP
);

CREATE TABLE posts (
    post_id INTEGER PRIMARY KEY,
    user_id INTEGER,
    title VARCHAR(200),
    content TEXT,
    published_at TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE comments (
    comment_id INTEGER PRIMARY KEY,
    post_id INTEGER,
    user_id INTEGER,
    content TEXT,
    created_at TIMESTAMP,
    FOREIGN KEY (post_id) REFERENCES posts(post_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);
```

## Practice Project Ideas

1. **Personal Finance Tracker**
   - Track income, expenses, categories
   - Calculate monthly budgets
   - Analyze spending patterns

2. **Fitness Tracker**
   - Log workouts, exercises, sets
   - Track progress over time
   - Calculate statistics

3. **Recipe Database**
   - Store recipes, ingredients, instructions
   - Track nutrition information
   - Plan meals

4. **Book Reading Tracker**
   - Track books read, ratings, reviews
   - Analyze reading habits
   - Recommendations

5. **Expense Sharing App**
   - Track shared expenses
   - Calculate who owes what
   - Split bills

## Practice Exercises by Topic

### Beginner
- Simple SELECT queries
- Filtering with WHERE
- Sorting with ORDER BY
- Basic aggregates

### Intermediate
- JOINs (all types)
- GROUP BY and HAVING
- Subqueries
- Data modification (INSERT, UPDATE, DELETE)

### Advanced
- Window functions
- CTEs
- Complex joins
- Performance optimization

## Tips for Effective Practice

1. **Start Simple**: Begin with basic queries, then add complexity
2. **Read Error Messages**: SQL errors often tell you exactly what's wrong
3. **Test Incrementally**: Build queries step by step
4. **Experiment**: Try different approaches to the same problem
5. **Review Solutions**: Compare your approach with others (after trying yourself!)
6. **Practice Regularly**: Consistency beats intensity
7. **Build Projects**: Apply SQL to real problems you care about

## Next Steps

After completing the course:
1. Work through practice problems on online platforms
2. Build a personal project using SQL
3. Contribute to open-source projects
4. Practice with real-world datasets
5. Continue learning advanced topics specific to your database

---

**Remember**: The best way to master SQL is through consistent practice. Use these resources to continue your learning journey!
