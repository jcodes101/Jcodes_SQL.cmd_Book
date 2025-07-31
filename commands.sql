-- ====================================
-- 🟢 BEGINNER COMMANDS
-- ====================================

-- 1. SELECT
-- Retrieves data from a table.
-- Use this when you want to view specific columns or rows.
SELECT * FROM employees;

-- Example: View all data in the "employees" table.


-- 2. SELECT (specific columns)
SELECT first_name, last_name FROM employees;

-- Example: Only display the first and last names of employees.


-- 3. WHERE
-- Filters rows based on a condition.
SELECT * FROM employees WHERE department = 'Sales';

-- Use case: Get all employees who work in the Sales department.


-- 4. INSERT INTO
-- Adds new data to a table.
INSERT INTO employees (first_name, last_name, department)
VALUES ('Lana', 'Smith', 'Marketing');

-- Use when you want to add new rows to your table.


-- 5. UPDATE
-- Modifies existing data in a table.
UPDATE employees
SET department = 'Support'
WHERE employee_id = 7;

-- Use when correcting or changing existing values.


-- 6. DELETE
-- Removes rows from a table.
DELETE FROM employees WHERE employee_id = 7;

-- Use cautiously to remove specific records.


-- 7. CREATE TABLE
-- Defines a new table structure.
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    department VARCHAR(50)
);

-- Use this to create a new table for storing data.


-- 8. DROP TABLE
-- Completely deletes a table and its data.
DROP TABLE employees;

-- Use when you're sure you no longer need the table or its data.

-- ====================================
-- 🟡 INTERMEDIATE COMMANDS
-- ====================================

-- 9. ORDER BY
-- Sorts the result set by one or more columns.
SELECT * FROM employees
ORDER BY last_name ASC;

-- Use to organize output for easier reading.


-- 10. LIMIT / OFFSET
-- Limits number of rows returned, useful for pagination.
SELECT * FROM employees
LIMIT 5 OFFSET 10;

-- Use case: Show 5 employees starting from the 11th row (useful in web apps).


-- 11. LIKE
-- Pattern matching with wildcards.
SELECT * FROM employees
WHERE first_name LIKE 'J%';

-- Use to find names starting with "J".


-- 12. IN
-- Matches any value in a list.
SELECT * FROM employees
WHERE department IN ('Sales', 'HR');

-- Use when filtering for multiple possible values.


-- 13. BETWEEN
-- Selects values in a given range.
SELECT * FROM products
WHERE price BETWEEN 100 AND 500;

-- Use to find products within a certain price range.


-- 14. IS NULL / IS NOT NULL
-- Checks if a column has no value.
SELECT * FROM employees WHERE department IS NULL;

-- Use to find incomplete or missing data.


-- 15. ALTER TABLE
-- Modifies table structure (add, remove, change columns).
ALTER TABLE employees ADD email VARCHAR(100);

-- Use when the table needs to evolve with changing data needs.


-- 16. DISTINCT
-- Returns unique values.
SELECT DISTINCT department FROM employees;

-- Use when you only want to see one instance of each department.


-- 17. COUNT, SUM, AVG, MIN, MAX (Aggregation)
SELECT COUNT(*) FROM employees;
SELECT AVG(salary) FROM employees;

-- Use to perform calculations on groups of data (stats, summaries).


-- 18. GROUP BY + HAVING
-- Groups rows and applies aggregation; HAVING filters groups.
SELECT department, COUNT(*) AS num_employees
FROM employees
GROUP BY department
HAVING COUNT(*) > 5;

-- Use to find departments with more than 5 employees.

-- ====================================
-- 🔵 ADVANCED COMMANDS
-- ====================================

-- 19. JOINS (INNER JOIN)
-- Combines rows from two tables when matching values exist.
SELECT e.first_name, d.department_name
FROM employees e
INNER JOIN departments d ON e.department_id = d.id;

-- Use when data is normalized across multiple tables.


-- 20. LEFT JOIN / RIGHT JOIN / FULL OUTER JOIN
-- Returns all rows from one or both tables, with nulls where no match.
SELECT e.first_name, d.department_name
FROM employees e
LEFT JOIN departments d ON e.department_id = d.id;

-- Use LEFT JOIN to show all employees, even those without a department.


-- 21. CREATE INDEX
-- Speeds up data retrieval by indexing a column.
CREATE INDEX idx_department ON employees(department);

-- Use when querying large tables on specific columns often.


-- 22. CREATE VIEW
-- A virtual table based on a SELECT query.
CREATE VIEW sales_employees AS
SELECT * FROM employees WHERE department = 'Sales';

-- Use for reusable queries or abstracting complex logic.


-- 23. SUBQUERIES
-- A query nested inside another.
SELECT * FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);

-- Use to compare data within the same or different datasets.


-- 24. CASE (Conditional Logic)
SELECT first_name,
       salary,
       CASE
           WHEN salary < 50000 THEN 'Low'
           WHEN salary BETWEEN 50000 AND 100000 THEN 'Medium'
           ELSE 'High'
       END AS salary_level
FROM employees;

-- Use when you need IF/THEN logic in SQL.


-- 25. TRANSACTIONS
-- Ensures multiple SQL statements execute safely together.
START TRANSACTION;
UPDATE accounts SET balance = balance - 100 WHERE id = 1;
UPDATE accounts SET balance = balance + 100 WHERE id = 2;
COMMIT;

-- Use to protect data integrity during multiple updates (bank transfers, etc.).


-- 26. USER MANAGEMENT (MySQL Example)
CREATE USER 'devuser'@'localhost' IDENTIFIED BY 'pass123';
GRANT SELECT, INSERT ON mydb.* TO 'devuser'@'localhost';
REVOKE INSERT ON mydb.* FROM 'devuser'@'localhost';
DROP USER 'devuser'@'localhost';

-- Use when setting up DB users with specific privileges.

-- ====================================
-- 🔐 SECURITY & PERMISSIONS
-- ====================================

-- 27. GRANT / REVOKE (PostgreSQL & MySQL)
GRANT SELECT, INSERT ON employees TO some_user;
REVOKE INSERT ON employees FROM some_user;

-- Use to manage permissions per table, per user.


-- ====================================
-- 🧱 CONSTRAINTS
-- ====================================

-- 28. PRIMARY KEY (enforced unique identifier)
CREATE TABLE departments (
    id INT PRIMARY KEY,
    name VARCHAR(100)
);

-- 29. FOREIGN KEY (ensures referential integrity)
CREATE TABLE employees (
    id INT PRIMARY KEY,
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES departments(id)
);

-- Use to ensure valid relationships between tables.

-- 30. CHECK (data rule constraint)
ALTER TABLE employees
ADD CONSTRAINT chk_salary CHECK (salary >= 0);

-- Use to prevent invalid data entry at table level.


-- ====================================
-- 🔃 STORED PROCEDURES & FUNCTIONS
-- ====================================

-- 31. CREATE PROCEDURE (MySQL example)
DELIMITER //
CREATE PROCEDURE GetEmployeesByDept(IN dept_name VARCHAR(50))
BEGIN
    SELECT * FROM employees WHERE department = dept_name;
END //
DELIMITER ;

-- Use to encapsulate logic you want to reuse with input/output.


-- 32. CREATE FUNCTION
CREATE FUNCTION get_full_name(f_name VARCHAR(50), l_name VARCHAR(50))
RETURNS VARCHAR(100)
RETURN CONCAT(f_name, ' ', l_name);

-- Use for reusable logic that returns a value.


-- ====================================
-- ⚙️ TRIGGERS
-- ====================================

-- 33. CREATE TRIGGER (automatic action on insert/update/delete)
CREATE TRIGGER before_insert_employees
BEFORE INSERT ON employees
FOR EACH ROW
SET NEW.created_at = NOW();

-- Use when you need automatic behaviors (e.g., logging, timestamps).


-- ====================================
-- 🔄 UPSERT / MERGE
-- ====================================

-- 34. INSERT ... ON DUPLICATE KEY UPDATE (MySQL)
INSERT INTO products (id, name, price)
VALUES (1, 'Book', 20)
ON DUPLICATE KEY UPDATE price = 20;

-- 35. MERGE (standard in SQL Server, Oracle)
MERGE INTO target_table t
USING source_table s ON (t.id = s.id)
WHEN MATCHED THEN UPDATE SET t.name = s.name
WHEN NOT MATCHED THEN INSERT (id, name) VALUES (s.id, s.name);

-- Use to combine insert and update logic into one operation.


-- ====================================
-- 🧪 TEMPORARY TABLES
-- ====================================

-- 36. CREATE TEMPORARY TABLE
CREATE TEMPORARY TABLE temp_sales (
    id INT,
    revenue DECIMAL(10,2)
);

-- Use to store intermediate results (only exists during session).


-- ====================================
-- 🧊 CTEs (Common Table Expressions)
-- ====================================

-- 37. WITH (CTE)
WITH top_employees AS (
    SELECT * FROM employees WHERE salary > 100000
)
SELECT * FROM top_employees;

-- Use for breaking down complex queries or improving readability.


-- ====================================
-- 🧮 WINDOW FUNCTIONS (Advanced Analytics)
-- ====================================

-- 38. ROW_NUMBER(), RANK(), DENSE_RANK()
SELECT first_name, salary,
       RANK() OVER (ORDER BY salary DESC) AS salary_rank
FROM employees;

-- Use to rank or number rows *within partitions*.

-- 39. LAG() / LEAD()
SELECT name, revenue,
       LAG(revenue) OVER (ORDER BY year) AS prev_year_revenue
FROM sales;

-- Use for comparing values across rows (like year-over-year analysis).


-- ====================================
-- 💾 BACKUPS & RESTORE (platform-specific)
-- ====================================

-- 40. PostgreSQL: pg_dump (command line)
-- Backup
pg_dump -U username dbname > backup.sql

-- Restore
psql -U username dbname < backup.sql

-- Use when exporting/importing full databases.

-- 41. MySQL: mysqldump
mysqldump -u root -p database_name > backup.sql

-- Restore
mysql -u root -p database_name < backup.sql


-- ====================================
-- 🕵️‍♂️ INFORMATION SCHEMA & METADATA
-- ====================================

-- 42. View all tables
SELECT table_name FROM information_schema.tables
WHERE table_schema = 'your_database_name';

-- 43. View all columns in a table
SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'employees';

-- Use when introspecting or documenting your database.

