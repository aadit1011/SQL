-- Create the company database
CREATE DATABASE company;

-- Switch to the company database
USE company;

-- Create the employee table
CREATE TABLE employee (
  emp_id INT PRIMARY KEY,            -- Employee ID, the primary key for the employee table
  first_name VARCHAR(40),            -- Employee's first name
  last_name VARCHAR(40),             -- Employee's last name
  birth_day DATE,                    -- Employee's birth date
  sex VARCHAR(1),                    -- Gender (M/F)
  salary INT,                        -- Employee's salary
  super_id INT,                      -- Supervisor ID, foreign key referencing the employee table
  branch_id INT                      -- Branch ID, foreign key referencing the branch table
);

-- Create the branch table
CREATE TABLE branch (
  branch_id INT PRIMARY KEY,         -- Branch ID, primary key for the branch table
  branch_name VARCHAR(40),           -- Name of the branch
  mgr_id INT,                        -- Manager ID, foreign key referencing the employee table
  mgr_start_date DATE,               -- Date the manager started managing the branch
  FOREIGN KEY(mgr_id) REFERENCES employee(emp_id) ON DELETE SET NULL   -- Sets manager ID to NULL if manager is deleted
);

-- Adding foreign key constraints to the employee table
-- Links employee to their respective branch and supervisor
ALTER TABLE employee
ADD FOREIGN KEY(branch_id) REFERENCES branch(branch_id) ON DELETE SET NULL;

ALTER TABLE employee
ADD FOREIGN KEY(super_id) REFERENCES employee(emp_id) ON DELETE SET NULL;

-- Create the client table
CREATE TABLE client (
  client_id INT PRIMARY KEY,         -- Client ID, primary key for the client table
  client_name VARCHAR(40),           -- Client name
  branch_id INT,                     -- Branch ID, foreign key referencing the branch table
  FOREIGN KEY(branch_id) REFERENCES branch(branch_id) ON DELETE SET NULL
);

-- Create the works_with table to track the total sales made by employees to clients
CREATE TABLE works_with (
  emp_id INT,                        -- Employee ID, foreign key referencing the employee table
  client_id INT,                     -- Client ID, foreign key referencing the client table
  total_sales INT,                   -- Total sales made by the employee to the client
  PRIMARY KEY(emp_id, client_id),    -- Composite primary key of employee and client IDs
  FOREIGN KEY(emp_id) REFERENCES employee(emp_id) ON DELETE CASCADE,
  FOREIGN KEY(client_id) REFERENCES client(client_id) ON DELETE CASCADE
);

-- Create the branch_supplier table to track suppliers for each branch
CREATE TABLE branch_supplier (
  branch_id INT,                     -- Branch ID, foreign key referencing the branch table
  supplier_name VARCHAR(40),         -- Supplier name
  supply_type VARCHAR(40),           -- Type of supply provided by the supplier
  PRIMARY KEY(branch_id, supplier_name),   -- Composite primary key of branch ID and supplier name
  FOREIGN KEY(branch_id) REFERENCES branch(branch_id) ON DELETE CASCADE
);

-- Inserting corporate-level employee and branch information
INSERT INTO employee VALUES(100, 'David', 'Wallace', '1967-11-17', 'M', 250000, NULL, NULL);

INSERT INTO branch VALUES(1, 'Corporate', 100, '2006-02-09');

-- Updating the branch ID of the corporate manager
UPDATE employee
SET branch_id = 1
WHERE emp_id = 100;

-- Inserting another corporate-level employee
INSERT INTO employee VALUES(101, 'Jan', 'Levinson', '1961-05-11', 'F', 110000, 100, 1);

-- Inserting Scranton branch and manager information
INSERT INTO employee VALUES(102, 'Michael', 'Scott', '1964-03-15', 'M', 75000, 100, NULL);

INSERT INTO branch VALUES(2, 'Scranton', 102, '1992-04-06');

-- Updating the branch ID of Scranton's manager
UPDATE employee
SET branch_id = 2
WHERE emp_id = 102;

-- Inserting employees under Scranton branch
INSERT INTO employee VALUES(103, 'Angela', 'Martin', '1971-06-25', 'F', 63000, 102, 2);
INSERT INTO employee VALUES(104, 'Kelly', 'Kapoor', '1980-02-05', 'F', 55000, 102, 2);
INSERT INTO employee VALUES(105, 'Stanley', 'Hudson', '1958-02-19', 'M', 69000, 102, 2);

-- Inserting Stamford branch and manager information
INSERT INTO employee VALUES(106, 'Josh', 'Porter', '1969-09-05', 'M', 78000, 100, NULL);

INSERT INTO branch VALUES(3, 'Stamford', 106, '1998-02-13');

-- Updating the branch ID of Stamford's manager
UPDATE employee
SET branch_id = 3
WHERE emp_id = 106;

-- Inserting employees under Stamford branch
INSERT INTO employee VALUES(107, 'Andy', 'Bernard', '1973-07-22', 'M', 65000, 106, 3);
INSERT INTO employee VALUES(108, 'Jim', 'Halpert', '1978-10-01', 'M', 71000, 106, 3);

-- Inserting branch suppliers for the Scranton and Stamford branches
INSERT INTO branch_supplier VALUES(2, 'Hammer Mill', 'Paper');
INSERT INTO branch_supplier VALUES(2, 'Uni-ball', 'Writing Utensils');
INSERT INTO branch_supplier VALUES(3, 'Patriot Paper', 'Paper');
INSERT INTO branch_supplier VALUES(2, 'J.T. Forms & Labels', 'Custom Forms');
INSERT INTO branch_supplier VALUES(3, 'Uni-ball', 'Writing Utensils');
INSERT INTO branch_supplier VALUES(3, 'Hammer Mill', 'Paper');
INSERT INTO branch_supplier VALUES(3, 'Stamford Lables', 'Custom Forms');

-- Inserting client information and linking them to branches
INSERT INTO client VALUES(400, 'Dunmore Highschool', 2);
INSERT INTO client VALUES(401, 'Lackawana Country', 2);
INSERT INTO client VALUES(402, 'FedEx', 3);
INSERT INTO client VALUES(403, 'John Daly Law, LLC', 3);
INSERT INTO client VALUES(404, 'Scranton Whitepages', 2);
INSERT INTO client VALUES(405, 'Times Newspaper', 3);
INSERT INTO client VALUES(406, 'FedEx', 2);

-- Inserting works_with information to track sales by employees to clients
INSERT INTO works_with VALUES(105, 400, 55000);
INSERT INTO works_with VALUES(102, 401, 267000);
INSERT INTO works_with VALUES(108, 402, 22500);
INSERT INTO works_with VALUES(107, 403, 5000);
INSERT INTO works_with VALUES(108, 403, 12000);
INSERT INTO works_with VALUES(105, 404, 33000);
INSERT INTO works_with VALUES(107, 405, 26000);
INSERT INTO works_with VALUES(102, 406, 15000);
INSERT INTO works_with VALUES(105, 406, 130000);

SELECT * FROM employee;
SELECT * FROM branch;
SELECT * FROM client;
SELECT* FROM works_with;
SELECT * FROM branch_supplier;



-- Retrieve all employee data, sorted by salary in descending order
SELECT * FROM employee ORDER BY salary DESC;

-- Retrieve all employee data, sorted first by gender, then by first name and last name
SELECT * FROM employee ORDER BY sex, first_name, last_name;

-- Retrieve all employee data, sorted by gender in descending order, and first name and last name in ascending order
SELECT * FROM employee ORDER BY sex DESC, first_name ASC, last_name ASC;

-- Retrieve the first 5 employees in the employee table
SELECT * FROM employee LIMIT 5;

-- Retrieve the last 5 employees in the employee table
SELECT * FROM employee ORDER BY emp_id DESC LIMIT 5;

-- Count the total number of employees in the employee table
SELECT COUNT(emp_id) AS total_employees FROM employee;

-- Count the number of female employees born after 1970
SELECT COUNT(emp_id) AS female_born_after_1970
FROM employee
WHERE birth_day > '1970-01-01' AND sex ='F';

-- Retrieve details of female employees born after 1970
SELECT birth_day, first_name, last_name, emp_id AS female_born_after_1970
FROM employee
WHERE birth_day > '1970-01-01' AND sex ='F'
GROUP BY birth_day, first_name, last_name, emp_id
ORDER BY emp_id ASC;

-- Calculate the average salary of all employees
SELECT AVG(salary) AS Avg_salary FROM employee;

-- Calculate the average salary of male employees
SELECT AVG(salary) AS Male_avg_salary FROM employee WHERE sex = 'M';

-- Calculate the average salary of female employees
SELECT AVG(salary) AS Female_avg_salary FROM employee WHERE sex = 'F';

-- Calculate the total sum of all employees' salaries
SELECT SUM(salary) AS Total_salary FROM employee;

-- Count the total number of male and female employees
SELECT COUNT(emp_id) AS Total_male_female, sex FROM employee GROUP BY sex;

-- Retrieve total sales per employee, ordered by total sales in descending order
SELECT emp_id, SUM(total_sales) AS TOTAL_sales
FROM works_with
GROUP BY emp_id
ORDER BY TOTAL_sales DESC;

-- Retrieve total amount spent by each client, ordered by total spending in descending order
SELECT client_id, SUM(total_sales) AS TOTAL_expenses
FROM works_with
GROUP BY client_id
ORDER BY TOTAL_expenses DESC;

-- Retrieve all employees whose first name starts with 'J'
SELECT * FROM employee WHERE first_name LIKE 'J%';

-- Retrieve all employees whose first name ends with 'y'
SELECT * FROM employee WHERE first_name LIKE '%y';

-- Retrieve all employees whose second letter in their first name is 'i'
SELECT * FROM employee WHERE first_name LIKE '_i%';

-- Retrieve employees whose name has three letters, with the second letter as 'i'
SELECT * FROM employee WHERE first_name LIKE '_i_';

-- Retrieve the union of all client names and supplier names
SELECT client.client_name AS total_clients_and_suppliers
FROM client
UNION
SELECT branch_supplier.supplier_name
FROM branch_supplier;

-- Delete the branch named 'Buffalo'
DELETE FROM branch WHERE branch_name = 'Buffalo';

-- Display all remaining branches
SELECT * FROM branch;

-- Perform a NATURAL JOIN between the client and branch tables
SELECT * FROM client NATURAL JOIN branch;

-- List the name of all managers with their respective branch names using INNER JOIN
SELECT employee.emp_id, employee.first_name, employee.last_name, branch.branch_name
FROM employee
JOIN branch ON employee.emp_id = branch.mgr_id;

-- List all managers and their respective branch names using LEFT JOIN
SELECT employee.emp_id, employee.first_name, employee.last_name, branch.branch_name
FROM employee
LEFT JOIN branch ON employee.emp_id = branch.mgr_id;

-- List all managers and their respective branch names using RIGHT JOIN
SELECT employee.emp_id, employee.first_name, employee.last_name, branch.branch_name
FROM employee
RIGHT JOIN branch ON employee.emp_id = branch.mgr_id;

-- List all managers and their respective branch names using INNER JOIN
SELECT employee.emp_id, employee.first_name, employee.last_name, branch.branch_name
FROM employee
INNER JOIN branch ON employee.emp_id = branch.mgr_id;

-- Nested query
----------------------------------

-- find the name of all the employees who have sold over 30000 to a single client

SELECT e.emp_id,e.first_name,e.last_name
FROM employee e 
WHERE e.emp_id IN (
     SELECT w.emp_id
     FROM works_with w 
     WHERE total_sales>30000
);

-- find all the clients who are handled by the brach that Michael Scott manages.

     SELECT c.client_id,c.client_name
     FROM client c
     WHERE C.branch_id in (
     SELECT b.branch_id
     FROM branch b 
     WHERE b.mgr_id   in (     
          SELECT e.emp_id
          FROM employee e
          WHERE e.first_name='Michael' AND e.last_name='Scott')
);
