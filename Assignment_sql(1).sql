CREATE DATABASE `Assignment : SQL`;
USE `Assignment : SQL`;

CREATE TABLE employees (
    emp_id INT NOT NULL PRIMARY KEY,
    emp_name TEXT NOT NULL,
    age INT CHECK (age >= 18),
    email TEXT UNIQUE,
    salary DECIMAL(10,2) DEFAULT 30000
);

# Q2
# Constraints help maintain data integrity by enforcing rules on table columns.
# Common constraints include:

# PRIMARY KEY: Ensures a unique identifier for each row (e.g., emp_id).
# NOT NULL: Prevents NULL values (e.g., emp_name must always have a value).
# UNIQUE: Ensures distinct values (e.g., email must be unique).
# CHECK: Enforces conditions (e.g., age must be at least 18).
# DEFAULT: Assigns a default value (e.g., salary defaults to 30000).
# FOREIGN KEY: Links tables to maintain referential integrity.

# Q3
# Why apply the NOT NULL constraint to a column?
# - Ensures that a column always has a value, preventing missing or incomplete data.
# - Useful for essential fields like emp_name in an employees table.
# - Prevents accidental insertion of NULL values, improving data reliability.
# - Helps maintain consistency in required fields.

# Can a primary key contain NULL values?
# - No, a primary key cannot contain NULL values because:
#   1. Uniqueness Requirement: The primary key uniquely identifies each row.
#      Allowing NULL would mean multiple rows could have NULL, violating uniqueness.
#   2. Indexing Requirement: MySQL indexes primary keys, and indexes do not function correctly with NULL values.
#   3. Logical Integrity: A NULL primary key means an unidentified row, which contradicts the purpose of a primary key.

# Example: Ensuring NOT NULL and Primary Key Constraints
CREATE TABLE employeess (
    emp_id INT PRIMARY KEY,  # Primary Key is always NOT NULL by default
    emp_name TEXT NOT NULL    # NOT NULL ensures emp_name must have a value
);

# Q4
# In this example:
# - emp_id is a PRIMARY KEY, so it cannot be NULL.
# - emp_name is NOT NULL, ensuring every employee has a name.

# Steps to Add a Constraint on an Existing Table:
# 1. Use the ALTER TABLE command to modify the table structure.
# 2. Specify the type of constraint you want to add, such as PRIMARY KEY, UNIQUE, CHECK, etc.
# 3. Ensure that the new constraint does not conflict with existing data in the table.

# Q5
# Consequences of Attempting to Insert, Update, or Delete Data that Violates Constraints:
# When attempting to insert, update, or delete data that violates constraints, the DBMS will reject the operation
# and generate an error message. Constraints are used to maintain data integrity and ensure consistency.

# 1. Data Integrity Violation:
# - Constraints like UNIQUE, NOT NULL, CHECK, and FOREIGN KEY ensure that data adheres to certain rules.
# - Violating these constraints would result in inconsistent or invalid data, which can cause errors in queries, reports, or downstream processing.

# 2. Transaction Rollback:
# - If a constraint is violated, the DBMS typically cancels the operation and rolls back the transaction.
# - This ensures that no invalid data is stored and that the database remains consistent.

# 3. Error Generation:
# - The DBMS generates an error message indicating the type of constraint violated and provides the reason for failure.

# Example 1: Violation of UNIQUE Constraint (Trying to Insert Duplicate Email):
# If you try to insert two rows with the same email, which violates the UNIQUE constraint on the email column:
INSERT INTO employees (emp_id, emp_name, age, email, salary)
VALUES (1, 'John Doe', 30, 'john.doe@example.com', 35000);

# Attempting to insert a row with the same email:
INSERT INTO employees (emp_id, emp_name, age, email, salary)
VALUES (2, 'Jane Doe', 28, 'john.doe@example.com', 30000);

# This will generate the following error message:
# ERROR 1062 (23000): Duplicate entry 'john.doe@example.com' for key 'email'

# Example 2: Violation of NOT NULL Constraint (Attempting to Insert a NULL emp_name):
# If you try to insert a row without providing a value for a NOT NULL column (like emp_name):
INSERT INTO employees (emp_id, emp_name, age, email, salary)
VALUES (3, NULL, 25, 'jane.doe@example.com', 30000);

# This will generate the following error message:
# ERROR 1048 (23000): Column 'emp_name' cannot be null

# Example 3: Violation of CHECK Constraint (Attempting to Insert Invalid Age):
# If the table has a CHECK constraint (age >= 18), and you attempt to insert an invalid age:
INSERT INTO employees (emp_id, emp_name, age, email, salary)
VALUES (4, 'Tommy', 17, 'tommy@example.com', 25000);

# This will generate the following error message:
# ERROR 3819 (HY000): Check constraint 'employees_age_check' is violated.

# Summary of Consequences:
# 1. The modification (INSERT, UPDATE, or DELETE) will be rejected.
# 2. The transaction will be rolled back, maintaining consistency.
# 3. An error message will be generated to indicate which constraint was violated.

# Q6
CREATE TABLE products ( 
product_id INT, 
product_name VARCHAR(50), 
price DECIMAL(10, 2));

# Step 1: Add the PRIMARY KEY constraint to product_id.
ALTER TABLE products
ADD CONSTRAINT pk_product_id PRIMARY KEY (product_id);

# Step 2: Modify the price column to have a default value of 50.00.
ALTER TABLE products
ALTER COLUMN price SET DEFAULT 50.00;

# Q7
CREATE TABLE Students (
    student_id INT,
    student_name VARCHAR(50),
    class_id INT
);
INSERT INTO Students (student_id, student_name, class_id)
VALUES
(1, 'alice', 101),
(2, 'bob', 102),
(3, 'charlie', 101);

CREATE TABLE Classes (
    class_id INT,
    class_name VARCHAR(50)
);

INSERT INTO Classes (class_id, class_name)
VALUES
(101, 'math'),
(102, 'science'),
(103, 'history');

SELECT s.student_name, c.class_name
FROM Students s
INNER JOIN Classes c ON s.class_id = c.class_id;

# Q8
CREATE TABLE Orders (
    order_id INT,
    order_date DATE,
    customer_id INT
);

INSERT INTO Orders (order_id, order_date, customer_id)
VALUES
(1, '2024-01-01', 101),
(2, '2024-01-03', 102);

CREATE TABLE Customers (
    customer_id INT,
    customer_name VARCHAR(50)
);

INSERT INTO Customers (customer_id, customer_name)
VALUES
(101, 'Alice'),
(102, 'Bob');

CREATE TABLE Productss (
    product_id INT,
    product_name VARCHAR(50),
    order_id INT
);

INSERT INTO Productss (product_id, product_name, order_id)
VALUES
(1, 'Laptop', 1),
(2, 'Phone', NULL);

SELECT o.order_id, c.customer_name, p.product_name
FROM Productss p
LEFT JOIN Orders o ON p.order_id = o.order_id
LEFT JOIN Customers c ON o.customer_id = c.customer_id;

# Q9
CREATE TABLE Sales (
    sale_id INT,
    product_id INT,
    amount DECIMAL(10, 2)
);

INSERT INTO Sales (sale_id, product_id, amount)
VALUES
(1, 101, 500),
(2, 102, 300),
(3, 101, 700);

SELECT p.product_name, SUM(s.amount) AS total_sales
FROM Sales s
INNER JOIN Productss p ON s.product_id = p.product_id
GROUP BY p.product_name;

#Q10 
CREATE TABLE Order_Details (
    order_id INT,
    product_id INT,
    quantity INT
);

INSERT INTO Order_Details (order_id, product_id, quantity)
VALUES
(1, 101, 2),
(1, 102, 1),
(2, 101, 3);

SELECT o.order_id, c.customer_name, od.quantity
FROM Orders o
INNER JOIN Customers c ON o.customer_id = c.customer_id
INNER JOIN Order_Details od ON o.order_id = od.order_id;

##### SQL COMMANDS #####

CREATE TABLE actors (
    actor_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50)
);

CREATE TABLE customerss (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    active BOOLEAN,
    country VARCHAR(50)
);

CREATE TABLE films (
    film_id INT PRIMARY KEY,
    title VARCHAR(100),
    rental_duration INT,
    replacement_cost DECIMAL(10,2)
);
CREATE TABLE rentals (
    rental_id INT PRIMARY KEY,          -- Primary key for the rental_id
    customer_id INT,                    -- customer_id references the customer who rented the film
    film_id INT,                        -- film_id references the rented film
    rental_date DATE,                   -- Date of rental
    return_date DATE                    -- Date of return
);

INSERT INTO actors (actor_id, first_name, last_name)
VALUES
(1, 'Robert', 'Downey Jr.'),
(2, 'Chris', 'Hemsworth'),
(3, 'Scarlett', 'Johansson');

INSERT INTO customerss (customer_id, first_name, last_name, email, active, country)
VALUES
(1, 'Alice', 'Smith', 'alice@example.com', 1, 'USA'),
(2, 'Bob', 'Jones', 'bob@example.com', 0, 'UK'),
(3, 'Charlie', 'Brown', 'charlie@example.com', 1, 'Canada');

INSERT INTO films (film_id, title, rental_duration, replacement_cost)
VALUES
(1, 'Iron Man', 5, 19.99),
(2, 'Thor', 7, 17.50),
(3, 'Avengers', 3, 22.00);

INSERT INTO rentals (rental_id, customer_id, film_id, rental_date, return_date)
VALUES
(1, 1, 1, '2024-01-01', '2024-01-05'),
(2, 2, 2, '2024-01-02', '2024-01-07'),
(3, 1, 3, '2024-01-03', '2024-01-06');


-- 1. Identify the primary keys and foreign keys in the maven movies DB.
-- (Assuming "movies_db" as the database name)
-- Use the following command to view the structure:
SHOW CREATE TABLE actors;
SHOW CREATE TABLE customerss;
SHOW CREATE TABLE films;
SHOW CREATE TABLE rentals;

-- 2. List all details of actors
SELECT * FROM actors;

-- 3. List all customer information from DB
SELECT * FROM customerss;

-- 4. List different countries
SELECT DISTINCT country FROM customerss;

-- 5. Display all active customers
SELECT * FROM customerss WHERE active = 1;

-- 6. List of all rental IDs for customer with ID 1
SELECT rental_id FROM rentals WHERE customer_id = 1;

-- 7. Display all the films whose rental duration is greater than 5
SELECT * FROM films WHERE rental_duration > 5;

-- 8. List the total number of films whose replacement cost is greater than $15 and less than $20
SELECT COUNT(*) 
FROM films 
WHERE replacement_cost > 15 AND replacement_cost < 20;



-- 9. Display the count of unique first names of actors
SELECT COUNT(DISTINCT first_name) FROM actors;

-- 10. Display the first 10 records from the customer table
SELECT * FROM customers LIMIT 10;

-- 11. Display the first 3 records from the customer table whose first name starts with ‘b’.
SELECT * 
FROM customerss 
WHERE first_name LIKE 'b%' 
LIMIT 3;

-- 12. Display the names of the first 5 movies which are rated as ‘G’.

ALTER TABLE films
ADD COLUMN rating VARCHAR(10);
UPDATE films
SET rating = 'G'
WHERE film_id = 1;

UPDATE films
SET rating = 'PG'
WHERE film_id = 2;

UPDATE films
SET rating = 'PG-13'
WHERE film_id = 3;

SELECT title 
FROM films 
WHERE rating = 'G' 
LIMIT 5;

-- 13. Find all customers whose first name starts with "a".
SELECT * 
FROM customerss 
WHERE first_name LIKE 'a%';

-- 14. Find all customers whose first name ends with "a".
SELECT * 
FROM customerss 
WHERE first_name LIKE '%a';

-- 15. Display the list of first 4 cities which start and end with ‘a’.

ALTER TABLE customerss
ADD COLUMN city VARCHAR(100);

UPDATE customerss
SET city = 'Atlanta'
WHERE customer_id = 1;

UPDATE customerss
SET city = 'Amsterdam'
WHERE customer_id = 2;

SELECT DISTINCT city 
FROM customerss
WHERE city LIKE 'a%' AND city LIKE '%a' 
LIMIT 4;

-- 16. Find all customers whose first name has "NI" in any position.

SELECT * 
FROM customerss
WHERE first_name LIKE '%NI%';

-- 17. Find all customers whose first name has "r" in the second position.
SELECT * 
FROM customerss
WHERE first_name LIKE '_r%';

-- 18. Find all customers whose first name starts with "a" and are at least 5 characters in length.
SELECT * 
FROM customerss 
WHERE first_name LIKE 'a____%';

-- 19. Find all customers whose first name starts with "a" and ends with "o".
SELECT * 
FROM customerss 
WHERE first_name LIKE 'a%o';

-- 20. Get the films with "PG" and "PG-13" ratings using IN operator.
SELECT * 
FROM films 
WHERE rating IN ('PG', 'PG-13');

-- 21. Get the films with length between 50 to 100 using BETWEEN operator.
ALTER TABLE films

ADD COLUMN length INT; 
UPDATE films
SET length = 90
WHERE film_id = 1;

UPDATE films
SET length = 120
WHERE film_id = 2;

SELECT * 
FROM films 
WHERE length BETWEEN 50 AND 100;

-- 22. Get the top 50 actors using LIMIT operator.
SELECT * 
FROM actors 
LIMIT 50;

-- 23. Get the distinct film ids from inventory table.
CREATE TABLE inventory (
    inventory_id INT PRIMARY KEY,
    film_id INT,
    store_id INT,               -- Assuming there is a store_id if it's part of a multi-store system
    quantity INT
);
INSERT INTO inventory (inventory_id, film_id, store_id, quantity)
VALUES
(1, 1, 1, 10),
(2, 2, 1, 5),
(3, 3, 2, 8);

SELECT DISTINCT film_id 
FROM inventory;
