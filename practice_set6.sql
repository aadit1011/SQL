-- Use the company database for all subsequent operations
USE company;

-- Create the 'employee' table to store employee information
CREATE TABLE employee (
  emp_id INT PRIMARY KEY,                  -- Unique ID for each employee
  first_name VARCHAR(40),                  -- Employee's first name
  last_name VARCHAR(40),                   -- Employee's last name
  birth_day DATE,                          -- Employee's date of birth
  sex VARCHAR(1),                          -- Employee's gender ('M' for Male, 'F' for Female)
  salary INT,                              -- Employee's salary
  super_id INT,                            -- Supervisor's employee ID (self-referencing)
  branch_id INT                            -- Branch ID where the employee works (references branch table)
);

-- Create the 'branch' table to store branch details
CREATE TABLE branch (
  branch_id INT PRIMARY KEY,               -- Unique ID for each branch
  branch_name VARCHAR(40),                 -- Name of the branch
  mgr_id INT,                              -- Manager's employee ID (references employee table)
  mgr_start_date DATE,                     -- Date when the manager started
  FOREIGN KEY(mgr_id) REFERENCES employee(emp_id) ON DELETE SET NULL  -- If the manager is deleted, set to NULL
);

-- Add foreign key constraints to 'employee' table for branch and supervisor
ALTER TABLE employee
ADD FOREIGN KEY(branch_id)
REFERENCES branch(branch_id) ON DELETE SET NULL; -- If the branch is deleted, set to NULL in employee

ALTER TABLE employee
ADD FOREIGN KEY(super_id)
REFERENCES employee(emp_id) ON DELETE SET NULL;  -- If supervisor is deleted, set to NULL in employee

-- Create 'client' table to store client information
CREATE TABLE client (
  client_id INT PRIMARY KEY,               -- Unique ID for each client
  client_name VARCHAR(40),                 -- Client name
  branch_id INT,                           -- Branch associated with the client (references branch table)
  FOREIGN KEY(branch_id) REFERENCES branch(branch_id) ON DELETE SET NULL -- If branch is deleted, set to NULL
);

-- Create 'works_with' table to track employee-client relationships and total sales
CREATE TABLE works_with (
  emp_id INT,                              -- Employee ID (references employee table)
  client_id INT,                           -- Client ID (references client table)
  total_sales INT,                         -- Total sales amount made by the employee to the client
  PRIMARY KEY(emp_id, client_id),          -- Composite primary key (employee-client relationship)
  FOREIGN KEY(emp_id) REFERENCES employee(emp_id) ON DELETE CASCADE, -- Delete record if employee is deleted
  FOREIGN KEY(client_id) REFERENCES client(client_id) ON DELETE CASCADE -- Delete record if client is deleted
);

-- Create 'branch_supplier' table to track branch suppliers and the types of supplies provided
CREATE TABLE branch_supplier (
  branch_id INT,                           -- Branch ID (references branch table)
  supplier_name VARCHAR(40),               -- Name of the supplier
  supply_type VARCHAR(40),                 -- Type of supplies provided by the supplier
  PRIMARY KEY(branch_id, supplier_name),   -- Composite primary key (branch and supplier)
  FOREIGN KEY(branch_id) REFERENCES branch(branch_id) ON DELETE CASCADE -- Delete record if branch is deleted
);

-- Insert data into 'employee' and 'branch' tables
-- Corporate branch with manager David Wallace
INSERT INTO employee VALUES(100, 'David', 'Wallace', '1967-11-17', 'M', 250000, NULL, NULL);
INSERT INTO branch VALUES(1, 'Corporate', 100, '2006-02-09');

-- Assign David Wallace to the Corporate branch
UPDATE employee SET branch_id = 1 WHERE emp_id = 100;

-- Add employee Jan Levinson reporting to David Wallace at the Corporate branch
INSERT INTO employee VALUES(101, 'Jan', 'Levinson', '1961-05-11', 'F', 110000, 100, 1);

-- Scranton branch with manager Michael Scott
INSERT INTO employee VALUES(102, 'Michael', 'Scott', '1964-03-15', 'M', 75000, 100, NULL);
INSERT INTO branch VALUES(2, 'Scranton', 102, '1992-04-06');

-- Assign Michael Scott to the Scranton branch
UPDATE employee SET branch_id = 2 WHERE emp_id = 102;

-- Add employees reporting to Michael Scott at Scranton
INSERT INTO employee VALUES(103, 'Angela', 'Martin', '1971-06-25', 'F', 63000, 102, 2);
INSERT INTO employee VALUES(104, 'Kelly', 'Kapoor', '1980-02-05', 'F', 55000, 102, 2);
INSERT INTO employee VALUES(105, 'Stanley', 'Hudson', '1958-02-19', 'M', 69000, 102, 2);

-- Stamford branch with manager Josh Porter
INSERT INTO employee VALUES(106, 'Josh', 'Porter', '1969-09-05', 'M', 78000, 100, NULL);
INSERT INTO branch VALUES(3, 'Stamford', 106, '1998-02-13');

-- Assign Josh Porter to the Stamford branch
UPDATE employee SET branch_id = 3 WHERE emp_id = 106;

-- Add employees reporting to Josh Porter at Stamford
INSERT INTO employee VALUES(107, 'Andy', 'Bernard', '1973-07-22', 'M', 65000, 106, 3);
INSERT INTO employee VALUES(108, 'Jim', 'Halpert', '1978-10-01', 'M', 71000, 106, 3);

-- Insert data into 'branch_supplier' table for Scranton and Stamford branches
INSERT INTO branch_supplier VALUES(2, 'Hammer Mill', 'Paper');
INSERT INTO branch_supplier VALUES(2, 'Uni-ball', 'Writing Utensils');
INSERT INTO branch_supplier VALUES(3, 'Patriot Paper', 'Paper');
INSERT INTO branch_supplier VALUES(2, 'J.T. Forms & Labels', 'Custom Forms');
INSERT INTO branch_supplier VALUES(3, 'Uni-ball', 'Writing Utensils');
INSERT INTO branch_supplier VALUES(3, 'Hammer Mill', 'Paper');
INSERT INTO branch_supplier VALUES(3, 'Stamford Labels', 'Custom Forms');

-- Insert data into 'client' table
INSERT INTO client VALUES(400, 'Dunmore Highschool', 2);
INSERT INTO client VALUES(401, 'Lackawana County', 2);
INSERT INTO client VALUES(402, 'FedEx', 3);
INSERT INTO client VALUES(403, 'John Daly Law, LLC', 3);
INSERT INTO client VALUES(404, 'Scranton Whitepages', 2);
INSERT INTO client VALUES(405, 'Times Newspaper', 3);
INSERT INTO client VALUES(406, 'FedEx', 2);

-- Insert data into 'works_with' table (tracking sales between employees and clients)
INSERT INTO works_with VALUES(105, 400, 55000);
INSERT INTO works_with VALUES(102, 401, 267000);
INSERT INTO works_with VALUES(108, 402, 22500);
INSERT INTO works_with VALUES(107, 403, 5000);
INSERT INTO works_with VALUES(108, 403, 12000);
INSERT INTO works_with VALUES(105, 404, 33000);
INSERT INTO works_with VALUES(107, 405, 26000);
INSERT INTO works_with VALUES(102, 406, 15000);
INSERT INTO works_with VALUES(105, 406, 130000);

-- Queries to retrieve and manipulate employee data

-- 1. Find all male employees with a salary greater than 70,000
SELECT * FROM employee WHERE salary > 70000 AND sex = 'M';

-- 2. List employees with a salary between 60,000 and 100,000
SELECT * FROM employee WHERE salary BETWEEN 60000 AND 100000;

-- 3. Show employees whose last name ends with 'n'
SELECT * FROM employee WHERE last_name LIKE '%n';

-- 4. Retrieve employees working in the 'Scranton' branch
SELECT emp_id, first_name, last_name, salary, sex, branch_id 
FROM employee 
WHERE branch_id = (SELECT branch_id FROM branch WHERE branch_name = 'Scranton');

-- 5. Find all female employees with the last name 'Smith'
SELECT * FROM employee WHERE sex = 'F' AND last_name = 'Smith';

-- 6. Sort employees by birth date in ascending order
SELECT * FROM employee ORDER BY birth_day ASC;

-- 7. Sort employees by branch_id in descending order, then by salary in ascending order
SELECT * FROM employee ORDER BY branch_id DESC, salary ASC;

-- 8. List employees alphabetically by last name and then first name
SELECT * FROM employee ORDER BY last_name ASC, first_name ASC;

-- 9. Retrieve the employee with the oldest birth date
SELECT * FROM employee ORDER BY birth_day ASC LIMIT 1;

-- 10. Show employees ordered by salary, and then by birth date for those with the same salary
SELECT * FROM employee ORDER BY salary DESC, birth_day ASC;

-- 11. Get the top 3 highest-paid employees
SELECT * FROM employee ORDER BY salary DESC LIMIT 3;

-- 12. Retrieve the top 2 youngest employees (latest birth dates)
SELECT * FROM employee ORDER BY birth_day DESC LIMIT 2;

-- 13. Show the 3 employees with the lowest salary
SELECT * FROM employee ORDER BY salary ASC LIMIT 3;

-- 14. Find the minimum salary in the company
SELECT MIN(salary) AS company_min_salary FROM employee;

-- 15. Find the total number of employees reporting to Josh Porter
SELECT COUNT(*) AS total_emp_who_report_to_josh_porter 
FROM employee 
WHERE branch_id = (SELECT branch_id FROM branch WHERE mgr_id = (SELECT emp_id FROM employee WHERE first_name = 'Josh' AND last_name = 'Porter'));

-- 16. Find the maximum salary among female employees
SELECT MAX(salary) AS max_female_salary FROM employee WHERE sex = 'F';

-- 17. Find the average salary of male employees
SELECT AVG(salary) AS average_male_salary FROM employee WHERE sex = 'M';

-- 18. Calculate the total salary expenditure of the 'Scranton' branch
SELECT SUM(salary) AS scranton_branch_total_salary FROM employee WHERE branch_id = (SELECT branch_id FROM branch WHERE branch_name = 'Scranton');

-- 19. Determine the average salary of all employees
SELECT AVG(salary) AS average_salary_employee FROM employee;

-- 20. Group employees by their branch_id and find the average salary per branch
SELECT branch_id, AVG(salary) AS average_salary_per_branch FROM employee GROUP BY branch_id;

-- 21. Count the number of employees in each branch
SELECT branch_id, COUNT(*) AS total_employees FROM employee GROUP BY branch_id;

-- 22. Calculate the average salary per gender
SELECT sex, AVG(salary) AS average_salary_per_sex FROM employee GROUP BY sex;

-- 23. List all employees along with their respective branch names
SELECT e.emp_id, e.first_name, e.last_name, b.branch_name 
FROM employee e JOIN branch b ON e.branch_id = b.branch_id;

-- 24. Show the employee name and their supervisor's name
CREATE TABLE IF NOT EXISTS supervisor AS 
SELECT emp_id, first_name, last_name FROM employee WHERE emp_id IN (SELECT DISTINCT super_id FROM employee);

SELECT e.emp_id, e.first_name AS employee_first_name, e.last_name AS employee_last_name,
       s.first_name AS supervisor_first_name, s.last_name AS supervisor_last_name
FROM employee e
JOIN supervisor s ON e.super_id = s.emp_id;

-- 25. Find employees who earn more than the average salary
SELECT * FROM employee WHERE salary > (SELECT AVG(salary) FROM employee);

-- 26. Show employees who have the same last name as their supervisor
SELECT e.emp_id, e.first_name AS employee_first_name, e.last_name AS employee_last_name,
       s.first_name AS supervisor_first_name, s.last_name AS supervisor_last_name
FROM employee e
JOIN supervisor s ON e.super_id = s.emp_id
WHERE e.last_name = s.last_name;

-- 27. Add a new employee named 'John Doe' with a salary of 75,000 and assign him to the 'Scranton' branch
INSERT INTO employee (first_name, last_name, salary, branch_id)
VALUES ('John', 'Doe', 75000, (SELECT branch_id FROM branch WHERE branch_name = 'Scranton'));

