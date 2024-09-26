-- Switch to the 'company' database.
USE company;

-- Create a 'employee' table to store employee details
CREATE TABLE employee (
  emp_id INT PRIMARY KEY,                      -- Unique identifier for each employee
  first_name VARCHAR(40),                      -- Employee's first name
  last_name VARCHAR(40),                       -- Employee's last name
  birth_day DATE,                              -- Employee's birth date
  sex VARCHAR(1),                              -- Employee's gender ('M' for male, 'F' for female)
  salary INT,                                  -- Employee's salary
  super_id INT,                                -- Employee's supervisor, referencing another employee (self-referencing foreign key)
  branch_id INT,                               -- Branch where the employee works, references 'branch' table
  -- Create a foreign key constraint that references the 'branch' table
  FOREIGN KEY(branch_id) REFERENCES branch(branch_id) ON DELETE SET NULL, 
  -- If a branch is deleted, set the employee's branch_id to NULL
  FOREIGN KEY(super_id) REFERENCES employee(emp_id) ON DELETE SET NULL   
  -- If an employee's supervisor is deleted, set the supervisor field to NULL
);

-- Create 'branch' table to store details of each branch
CREATE TABLE branch (
  branch_id INT PRIMARY KEY,                   -- Unique identifier for each branch
  branch_name VARCHAR(40),                     -- Name of the branch
  mgr_id INT,                                  -- Manager's ID, references 'employee' table
  mgr_start_date DATE,                         -- Date when the manager started their role
  -- Create a foreign key that references the 'employee' table for the manager
  FOREIGN KEY(mgr_id) REFERENCES employee(emp_id) ON DELETE SET NULL     
  -- If the manager is deleted, set the manager field to NULL
);

-- Create 'client' table to store client information
CREATE TABLE client (
  client_id INT PRIMARY KEY,                   -- Unique identifier for each client
  client_name VARCHAR(40),                     -- Client's name
  branch_id INT,                               -- Branch associated with the client, references 'branch' table
  -- Create a foreign key that references the 'branch' table
  FOREIGN KEY(branch_id) REFERENCES branch(branch_id) ON DELETE SET NULL 
  -- If a branch is deleted, set the client's branch_id to NULL
);

-- Create 'works_with' table to store relationships between employees and clients
CREATE TABLE works_with (
  emp_id INT,                                  -- Employee's ID, references 'employee' table
  client_id INT,                               -- Client's ID, references 'client' table
  total_sales INT,                             -- Total sales amount between the employee and client
  PRIMARY KEY(emp_id, client_id),              -- Composite primary key for the combination of employee and client
  -- Create foreign key constraints for both 'employee' and 'client'
  FOREIGN KEY(emp_id) REFERENCES employee(emp_id) ON DELETE CASCADE,    -- If an employee is deleted, also delete associated sales
  FOREIGN KEY(client_id) REFERENCES client(client_id) ON DELETE CASCADE -- If a client is deleted, also delete associated sales
);

-- Create 'branch_supplier' table to store information about suppliers to branches
CREATE TABLE branch_supplier (
  branch_id INT,                               -- Branch's ID, references 'branch' table
  supplier_name VARCHAR(40),                   -- Name of the supplier
  supply_type VARCHAR(40),                     -- Type of supplies provided
  PRIMARY KEY(branch_id, supplier_name),       -- Composite primary key for branch and supplier combination
  -- Create a foreign key that references the 'branch' table
  FOREIGN KEY(branch_id) REFERENCES branch(branch_id) ON DELETE CASCADE -- If a branch is deleted, delete its supplier data as well
);

-- Insert the first employee data: David Wallace, Corporate branch manager
INSERT INTO employee (emp_id, first_name, last_name, birth_day, sex, salary)
VALUES (100, 'David', 'Wallace', '1967-11-17', 'M', 250000);

-- Insert Corporate branch details with David Wallace as manager
INSERT INTO branch (branch_id, branch_name, mgr_id, mgr_start_date)
VALUES (1, 'Corporate', 100, '2006-02-09');

-- Assign David Wallace to the Corporate branch
UPDATE employee SET branch_id = 1 WHERE emp_id = 100;

-- Insert Jan Levinson as an employee under David Wallace in the Corporate branch
INSERT INTO employee (emp_id, first_name, last_name, birth_day, sex, salary, super_id, branch_id)
VALUES (101, 'Jan', 'Levinson', '1961-05-11', 'F', 110000, 100, 1);

-- Insert Michael Scott, the Scranton branch manager
INSERT INTO employee (emp_id, first_name, last_name, birth_day, sex, salary, super_id)
VALUES (102, 'Michael', 'Scott', '1964-03-15', 'M', 75000, 100);

-- Insert Scranton branch details with Michael Scott as manager
INSERT INTO branch (branch_id, branch_name, mgr_id, mgr_start_date)
VALUES (2, 'Scranton', 102, '1992-04-06');

-- Assign Michael Scott to the Scranton branch
UPDATE employee SET branch_id = 2 WHERE emp_id = 102;

-- Insert employees who report to Michael Scott in the Scranton branch
INSERT INTO employee (emp_id, first_name, last_name, birth_day, sex, salary, super_id, branch_id)
VALUES 
  (103, 'Angela', 'Martin', '1971-06-25', 'F', 63000, 102, 2),
  (104, 'Kelly', 'Kapoor', '1980-02-05', 'F', 55000, 102, 2),
  (105, 'Stanley', 'Hudson', '1958-02-19', 'M', 69000, 102, 2);

-- Insert Josh Porter, the Stamford branch manager
INSERT INTO employee (emp_id, first_name, last_name, birth_day, sex, salary, super_id)
VALUES (106, 'Josh', 'Porter', '1969-09-05', 'M', 78000, 100);

-- Insert Stamford branch details with Josh Porter as manager
INSERT INTO branch (branch_id, branch_name, mgr_id, mgr_start_date)
VALUES (3, 'Stamford', 106, '1998-02-13');

-- Assign Josh Porter to the Stamford branch
UPDATE employee SET branch_id = 3 WHERE emp_id = 106;

-- Insert employees who report to Josh Porter in the Stamford branch
INSERT INTO employee (emp_id, first_name, last_name, birth_day, sex, salary, super_id, branch_id)
VALUES 
  (107, 'Andy', 'Bernard', '1973-07-22', 'M', 65000, 106, 3),
  (108, 'Jim', 'Halpert', '1978-10-01', 'M', 71000, 106, 3);

-- Insert suppliers for the Scranton and Stamford branches
INSERT INTO branch_supplier (branch_id, supplier_name, supply_type)
VALUES 
  (2, 'Hammer Mill', 'Paper'),
  (2, 'Uni-ball', 'Writing Utensils'),
  (3, 'Patriot Paper', 'Paper'),
  (2, 'J.T. Forms & Labels', 'Custom Forms'),
  (3, 'Uni-ball', 'Writing Utensils'),
  (3, 'Hammer Mill', 'Paper'),
  (3, 'Stamford Labels', 'Custom Forms');

-- Insert client data for the Scranton and Stamford branches
INSERT INTO client (client_id, client_name, branch_id)
VALUES 
  (400, 'Dunmore Highschool', 2),
  (401, 'Lackawana County', 2),
  (402, 'FedEx', 3),
  (403, 'John Daly Law, LLC', 3),
  (404, 'Scranton Whitepages', 2),
  (405, 'Times Newspaper', 3),
  (406, 'FedEx', 2);

-- Insert sales data showing which employees have worked with which clients
INSERT INTO works_with (emp_id, client_id, total_sales)
VALUES 
  (105, 400, 55000),
  (102, 401, 267000),
  (108, 402, 22500),
  (107, 403, 5000),
  (108, 403, 12000),
  (105, 404, 33000),
  (107, 405, 26000),
  (102, 406, 15000),
  (105, 406, 130000);

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

-- 5. Find employees who have sold to the client 'FedEx'
SELECT employee.emp_id, first_name, last_name, total_sales 
FROM employee 
JOIN works_with ON employee.emp_id = works_with.emp_id 
JOIN client ON client.client_id = works_with.client_id 
WHERE client.client_name = 'FedEx';

-- 6. Sort employees by salary (ascending), and birth date (ascending) for employees with the same salary
SELECT * FROM employee ORDER BY salary ASC, birth_day ASC;

-- 7. Sort employees by branch_id in descending order, then by salary in ascending order
-- Orders employees by branch_id in descending order (highest first), and within each branch, sorts by salary in ascending order (lowest first)
SELECT * FROM employee ORDER BY branch_id DESC, salary ASC;

-- 8. List employees alphabetically by last name and then first name
-- Orders employees by last name alphabetically, and if employees share the same last name, sorts by first name alphabetically
SELECT * FROM employee ORDER BY last_name ASC, first_name ASC;

-- 9. Retrieve the employee with the oldest birth date
-- Orders employees by birth date in ascending order (oldest first), then limits the result to the oldest employee
SELECT * FROM employee ORDER BY birth_day ASC LIMIT 1;

-- 10. Show employees ordered by salary, and then by birth date for those with the same salary
-- Orders employees by salary in descending order (highest paid first), and if salaries are the same, orders by birth date in ascending order (oldest first)
SELECT * FROM employee ORDER BY salary DESC, birth_day ASC;

-- 11. Get the top 3 highest-paid employees
-- Orders employees by salary in descending order (highest first), and limits the result to the top 3 highest salaries
SELECT * FROM employee ORDER BY salary DESC LIMIT 3;

-- 12. Retrieve the top 2 youngest employees (latest birth dates)
-- Orders employees by birth date in descending order (youngest first) and limits the result to the top 2 youngest employees
SELECT * FROM employee ORDER BY birth_day DESC LIMIT 2;

-- 13. Show the 3 employees with the lowest salary
-- Orders employees by salary in ascending order (lowest first) and limits the result to the 3 lowest paid employees
SELECT * FROM employee ORDER BY salary ASC LIMIT 3;

-- 14. Find the minimum salary in the company
-- Finds the minimum salary across all employees
SELECT MIN(salary) AS company_min_salary FROM employee;

-- 15. Find the total number of employees reporting to Josh Porter
-- Counts the number of employees reporting to the branch managed by Josh Porter by retrieving Josh's branch and counting the employees in that branch
SELECT COUNT(*) AS total_emp_who_report_to_josh_porter 
FROM employee 
WHERE branch_id = (SELECT branch_id FROM branch WHERE mgr_id = (SELECT emp_id FROM employee WHERE first_name = 'Josh' AND last_name = 'Porter'));

-- 16. Find the maximum salary among female employees
-- Finds the maximum salary for female employees (sex = 'F')
SELECT MAX(salary) AS max_female_salary FROM employee WHERE sex = 'F';

-- 17. Find the average salary of male employees
-- Calculates the average salary for male employees (sex = 'M')
SELECT AVG(salary) AS average_male_salary FROM employee WHERE sex = 'M';

-- 18. Calculate the total salary expenditure of the 'Scranton' branch
-- Calculates the total salary paid to all employees in the Scranton branch by summing the salaries of employees assigned to that branch
SELECT SUM(salary) AS scranton_branch_total_salary 
FROM employee 
WHERE branch_id = (SELECT branch_id FROM branch WHERE branch_name = 'Scranton');

-- 19. Determine the average salary of all employees
-- Calculates the average salary for all employees
SELECT AVG(salary) AS average_salary_employee FROM employee;

-- 20. Group employees by their branch_id and find the average salary per branch
-- Groups employees by branch_id and calculates the average salary for each branch
SELECT branch_id, AVG(salary) AS average_salary_per_branch FROM employee GROUP BY branch_id;

-- 21. Count the number of employees in each branch
-- Groups employees by branch_id and counts the number of employees in each branch
SELECT branch_id, COUNT(*) AS total_employees FROM employee GROUP BY branch_id;

-- 22. Calculate the average salary per gender
-- Groups employees by gender (sex) and calculates the average salary for each gender
SELECT sex, AVG(salary) AS average_salary_per_sex FROM employee GROUP BY sex;

-- 23. List all employees along with their respective branch names
-- Joins the employee table with the branch table to retrieve the branch name for each employee
SELECT e.emp_id, e.first_name, e.last_name, b.branch_name 
FROM employee e 
JOIN branch b ON e.branch_id = b.branch_id;

-- 24. Show the employee name and their supervisor's name
-- Creates a supervisor table (if it doesn't already exist) with employees who are supervisors (employees whose emp_id is referenced as a super_id in the employee table)
CREATE TABLE IF NOT EXISTS supervisor AS 
SELECT emp_id, first_name, last_name FROM employee WHERE emp_id IN (SELECT DISTINCT super_id FROM employee);

-- Joins the employee table with the supervisor table to display the employee's name and their supervisor's name
SELECT e.emp_id, e.first_name AS employee_first_name, e.last_name AS employee_last_name,
       s.first_name AS supervisor_first_name, s.last_name AS supervisor_last_name
FROM employee e
JOIN supervisor s ON e.super_id = s.emp_id;

-- 25. Find employees who earn more than the average salary
-- Retrieves employees whose salary is higher than the average salary of all employees
SELECT * FROM employee WHERE salary > (SELECT AVG(salary) FROM employee);

-- 26. Show employees who have the same last name as their supervisor
-- Joins the employee table with the supervisor table and retrieves employees who share the same last name as their supervisor
SELECT e.emp_id, e.first_name AS employee_first_name, e.last_name AS employee_last_name,
       s.first_name AS supervisor_first_name, s.last_name AS supervisor_last_name
FROM employee e
JOIN supervisor s ON e.super_id = s.emp_id
WHERE e.last_name = s.last_name;

-- 27. Add a new employee named 'John Doe' with a salary of 75,000 and assign him to the 'Scranton' branch
-- Inserts a new employee named John Doe with a salary of 75,000 into the employee table, assigning him to the branch with the name 'Scranton'
INSERT INTO employee (first_name, last_name, salary, branch_id)
VALUES ('John', 'Doe', 75000, (SELECT branch_id FROM branch WHERE branch_name = 'Scranton'));




-- Remove 'Micheal Scott' from organization


DELETE FROM employee
WHERE first_name = 'Michael' AND last_name = 'Scott';



-- Appoint 'Angela Martin' as new branch manager in Scranton 

UPDATE branch
    SET mgr_id = (SELECT emp_id FROM employee WHERE first_name = 'Angela' AND last_name = 'Martin')
    WHERE branch_name = 'Scranton';


UPDATE branch
    SET mgr_id = (SELECT emp_id FROM employee WHERE first_name = 'David' AND last_name = 'Wallace')
    WHERE branch_name = 'Corporate';


UPDATE branch
    SET mgr_id = (SELECT emp_id FROM employee WHERE first_name = 'Josh' AND last_name = 'Porter')
    WHERE branch_name = 'Stamford';



-- set super_id to all the employee of new branch manager

UPDATE employee
SET super_id =(
     SELECT s_id FROM (
     SELECT emp_id AS s_id FROM employee
     WHERE first_name = 'Angela' AND last_name = 'Martin')
     as s_id
)
WHERE super_id IS NULL;
