-- Create the 'company' database and switch to it.
CREATE DATABASE company;
USE company;

-- Create the 'employee' table to store employee details.
CREATE TABLE employee (
  emp_id INT PRIMARY KEY,         -- Employee ID (Primary Key)
  first_name VARCHAR(40),         -- Employee's first name
  last_name VARCHAR(40),          -- Employee's last name
  birth_day DATE,                 -- Employee's birth date
  sex VARCHAR(1),                 -- Gender ('M' or 'F')
  salary INT,                     -- Employee's salary
  super_id INT,                   -- Supervisor's Employee ID (Foreign Key to self)
  branch_id INT                   -- Branch ID (Foreign Key to 'branch' table)
);

-- Create the 'branch' table to store branch details.
CREATE TABLE branch (
  branch_id INT PRIMARY KEY,      -- Branch ID (Primary Key)
  branch_name VARCHAR(40),        -- Branch name
  mgr_id INT,                     -- Manager's Employee ID (Foreign Key to 'employee')
  mgr_start_date DATE,            -- Manager's start date
  FOREIGN KEY(mgr_id) REFERENCES employee(emp_id) ON DELETE SET NULL -- If the manager is deleted, set to NULL
);

-- Add foreign key constraints to the 'employee' table for branch_id and super_id.
ALTER TABLE employee
ADD FOREIGN KEY(branch_id)
REFERENCES branch(branch_id)
ON DELETE SET NULL;

ALTER TABLE employee
ADD FOREIGN KEY(super_id)
REFERENCES employee(emp_id)
ON DELETE SET NULL;

-- Create 'client' table to store client details.
CREATE TABLE client (
  client_id INT PRIMARY KEY,      -- Client ID (Primary Key)
  client_name VARCHAR(40),        -- Client name
  branch_id INT,                  -- Branch ID (Foreign Key to 'branch')
  FOREIGN KEY(branch_id) REFERENCES branch(branch_id) ON DELETE SET NULL -- If the branch is deleted, set to NULL
);

-- Create 'works_with' table to track employee-client relationships.
CREATE TABLE works_with (
  emp_id INT,                     -- Employee ID (Foreign Key to 'employee')
  client_id INT,                  -- Client ID (Foreign Key to 'client')
  total_sales INT,                -- Total sales made by the employee to the client
  PRIMARY KEY(emp_id, client_id), -- Composite Primary Key
  FOREIGN KEY(emp_id) REFERENCES employee(emp_id) ON DELETE CASCADE,  -- Delete record if employee is deleted
  FOREIGN KEY(client_id) REFERENCES client(client_id) ON DELETE CASCADE -- Delete record if client is deleted
);

-- Create 'branch_supplier' table to store suppliers for each branch.
CREATE TABLE branch_supplier (
  branch_id INT,                  -- Branch ID (Foreign Key to 'branch')
  supplier_name VARCHAR(40),       -- Supplier's name
  supply_type VARCHAR(40),        -- Type of supply (e.g., paper, forms)
  PRIMARY KEY(branch_id, supplier_name), -- Composite Primary Key
  FOREIGN KEY(branch_id) REFERENCES branch(branch_id) ON DELETE CASCADE -- Delete records if the branch is deleted
);

-- Insert data into the 'employee' table (Corporate level).
INSERT INTO employee VALUES(100, 'David', 'Wallace', '1967-11-17', 'M', 250000, NULL, NULL);

-- Insert data into the 'branch' table (Corporate branch).
INSERT INTO branch VALUES(1, 'Corporate', 100, '2006-02-09');

-- Update 'employee' to assign branch_id to the 'Corporate' branch.
UPDATE employee
SET branch_id = 1
WHERE emp_id = 100;

-- Insert data into the 'employee' table (Managers and Employees).
INSERT INTO employee VALUES(101, 'Jan', 'Levinson', '1961-05-11', 'F', 110000, 100, 1);
INSERT INTO employee VALUES(102, 'Michael', 'Scott', '1964-03-15', 'M', 75000, 100, NULL);

-- Insert data into the 'branch' table (Scranton branch).
INSERT INTO branch VALUES(2, 'Scranton', 102, '1992-04-06');

-- Update 'employee' to assign branch_id to 'Scranton' branch.
UPDATE employee
SET branch_id = 2
WHERE emp_id = 102;

-- Insert additional employees into the 'Scranton' branch.
INSERT INTO employee VALUES(103, 'Angela', 'Martin', '1971-06-25', 'F', 63000, 102, 2);
INSERT INTO employee VALUES(104, 'Kelly', 'Kapoor', '1980-02-05', 'F', 55000, 102, 2);
INSERT INTO employee VALUES(105, 'Stanley', 'Hudson', '1958-02-19', 'M', 69000, 102, 2);

-- Insert data into the 'employee' table (Stamford branch).
INSERT INTO employee VALUES(106, 'Josh', 'Porter', '1969-09-05', 'M', 78000, 100, NULL);

-- Insert data into the 'branch' table (Stamford branch).
INSERT INTO branch VALUES(3, 'Stamford', 106, '1998-02-13');

-- Update 'employee' to assign branch_id to 'Stamford' branch.
UPDATE employee
SET branch_id = 3
WHERE emp_id = 106;

-- Insert additional employees into the 'Stamford' branch.
INSERT INTO employee VALUES(107, 'Andy', 'Bernard', '1973-07-22', 'M', 65000, 106, 3);
INSERT INTO employee VALUES(108, 'Jim', 'Halpert', '1978-10-01', 'M', 71000, 106, 3);

-- Insert supplier data for branches.
INSERT INTO branch_supplier VALUES(2, 'Hammer Mill', 'Paper');
INSERT INTO branch_supplier VALUES(2, 'Uni-ball', 'Writing Utensils');
INSERT INTO branch_supplier VALUES(3, 'Patriot Paper', 'Paper');
INSERT INTO branch_supplier VALUES(2, 'J.T. Forms & Labels', 'Custom Forms');
INSERT INTO branch_supplier VALUES(3, 'Uni-ball', 'Writing Utensils');
INSERT INTO branch_supplier VALUES(3, 'Hammer Mill', 'Paper');
INSERT INTO branch_supplier VALUES(3, 'Stamford Labels', 'Custom Forms');

-- Insert data into the 'client' table.
INSERT INTO client VALUES(400, 'Dunmore Highschool', 2);
INSERT INTO client VALUES(401, 'Lackawana County', 2);
INSERT INTO client VALUES(402, 'FedEx', 3);
INSERT INTO client VALUES(403, 'John Daly Law, LLC', 3);
INSERT INTO client VALUES(404, 'Scranton Whitepages', 2);
INSERT INTO client VALUES(405, 'Times Newspaper', 3);
INSERT INTO client VALUES(406, 'FedEx', 2);

-- Insert data into the 'works_with' table (Employee-client relationships and sales).
INSERT INTO works_with VALUES(105, 400, 55000);
INSERT INTO works_with VALUES(102, 401, 267000);
INSERT INTO works_with VALUES(108, 402, 22500);
INSERT INTO works_with VALUES(107, 403, 5000);
INSERT INTO works_with VALUES(108, 403, 12000);
INSERT INTO works_with VALUES(105, 404, 33000);
INSERT INTO works_with VALUES(107, 405, 26000);
INSERT INTO works_with VALUES(102, 406, 15000);
INSERT INTO works_with VALUES(105, 406, 130000);

-- Query: Display all employees, ordered by salary in descending order.
SELECT * FROM employee ORDER BY salary DESC;

-- Query: Display all employees, ordered by gender and then by name in ascending order.
SELECT * FROM employee ORDER BY sex, first_name, last_name;

-- Query: Order by gender in descending order and names in ascending order.
SELECT * FROM employee ORDER BY sex DESC, first_name ASC, last_name ASC;

-- Query: Find the first 5 employees from the 'employee' table.
SELECT * FROM employee LIMIT 5;

-- Query: Find the last 5 employees by ordering employee IDs in descending order.
SELECT * FROM employee ORDER BY emp_id DESC LIMIT 5;

-- Query: Find the total number of employees.
SELECT COUNT(emp_id) AS total_employees FROM employee;

-- Query: Find the number of female employees born after 1970.
SELECT COUNT(emp_id) AS female_born_after_1970 
FROM employee 
WHERE birth_day > '1970-01-01' AND sex = 'F';

-- Query: Display female employees born before 1970.
SELECT birth_day, first_name, last_name, emp_id 
FROM employee 
WHERE birth_day < '1970-01-01' AND sex = 'F';

-- Query: Find the average salary of all employees.
SELECT AVG(salary) AS avg_salary FROM employee;

-- Query: Find the average salary of male employees.
SELECT AVG(salary) AS male_avg_salary FROM employee WHERE sex = 'M';

-- Query: Find the average salary of female employees.
SELECT AVG(salary) AS female_avg_salary FROM employee WHERE sex = 'F';

-- Query: Find the total sum of all employees' salaries.
SELECT SUM(salary) AS total_salary FROM employee;

-- Query: Find the total number of males and females.
SELECT COUNT(emp_id) AS total_count, sex FROM employee GROUP BY sex;

-- Query: Find the total sales by each employee.
SELECT emp_id, SUM(total_sales) AS total_sales
FROM works_with
GROUP BY emp_id
ORDER BY total_sales DESC;

-- Query: Find the total money spent by each client.
SELECT client_id, SUM(total_sales) AS total_expenses
FROM works_with
GROUP BY client_id
ORDER BY total_expenses DESC;

-- Query: Find employees whose first name starts with 'J'.
SELECT * FROM employee WHERE first_name LIKE 'J%';

-- Query: Find employees whose first name ends with 'y'.
SELECT * FROM employee WHERE first_name LIKE '%y';

-- Query: Find employees whose second letter is 'i' in their first name.
SELECT * FROM employee WHERE first_name LIKE '_i%';

-- Query: Find employees whose second letter is 'i' and their name is exactly 3 letters long.
SELECT * FROM employee WHERE first_name LIKE '_i_';

-- Query: Union of client names and supplier names.
SELECT client_name AS name FROM client 
UNION 
SELECT supplier_name FROM branch_supplier;

-- Query: Delete a branch named 'Buffalo'.
DELETE FROM branch WHERE branch_name = 'Buffalo';

-- Query: Display all branches to confirm deletion.
SELECT * FROM branch;

-- Query: Perform a NATURAL JOIN between 'client' and 'branch'.
SELECT * 
FROM client
NATURAL JOIN branch;

-- Query: List the name of all managers along with their respective branch names (INNER JOIN).
SELECT employee.emp_id, employee.first_name, employee.last_name, branch.branch_name
FROM employee 
INNER JOIN branch ON employee.emp_id = branch.mgr_id;

-- Query: List managers and their branches using a LEFT JOIN.
SELECT employee.emp_id, employee.first_name, employee.last_name, branch.branch_name
FROM employee 
LEFT JOIN branch ON employee.emp_id = branch.mgr_id;

-- Query: List managers and their branches using a RIGHT JOIN.
SELECT employee.emp_id, employee.first_name, employee.last_name, branch.branch_name
FROM employee 
RIGHT JOIN branch ON employee.emp_id = branch.mgr_id;

-- Nested Query: Find the names of employees who have sold over 30,000 to a single client.
SELECT emp_id, first_name, last_name
FROM employee 
WHERE emp_id IN (
  SELECT emp_id
  FROM works_with
  WHERE total_sales > 30000
);

-- Nested Query: Find all clients handled by branches managed by Michael Scott.
SELECT client_id, client_name
FROM client 
WHERE branch_id IN (
  SELECT branch_id
  FROM branch 
  WHERE mgr_id IN (
    SELECT emp_id
    FROM employee
    WHERE first_name = 'Michael' AND last_name = 'Scott'
  )
);
