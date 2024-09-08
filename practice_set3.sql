-- Create the 'staff' table with appropriate columns and constraints
CREATE TABLE staff (
    Employee_ID INT PRIMARY KEY AUTO_INCREMENT, -- Unique identifier for each employee
    First_Name VARCHAR(50) NOT NULL,            -- Employee's first name (cannot be NULL)
    Last_Name VARCHAR(50) NOT NULL,             -- Employee's last name (cannot be NULL)
    Position VARCHAR(50) NOT NULL,              -- Employee's position within the company
    Department VARCHAR(50),                     -- Department where the employee works
    Salary DECIMAL(10, 2) NOT NULL,             -- Employee's salary (with two decimal precision)
    Date_of_Birth DATE,                         -- Employee's date of birth
    Hire_Date DATE,                             -- Date when the employee was hired
    Manager_ID INT                              -- Employee's manager ID (foreign key to Employee_ID)
);

-- Insert sample records into the 'staff' table
-- This data represents a variety of employees across different departments
INSERT INTO staff (First_Name, Last_Name, Position, Department, Salary, Date_of_Birth, Hire_Date, Manager_ID)
VALUES 
    ('John', 'Doe', 'Software Specialist', 'IT', 1200000.00, '1990-05-15', '2020-06-01', 3),
    ('Jane', 'Smith', 'Project Manager', 'IT', 1500000.00, '1985-03-22', '2018-07-10', 5),
    ('Michael', 'Johnson', 'Data Analyst', 'IT', 950000.00, '1992-11-10', '2019-09-15', 3),
    ('Emily', 'Davis', 'HR Specialist', 'HR', 800000.00, '1988-01-17', '2021-02-01', NULL),
    ('Daniel', 'Brown', 'Marketing Manager', 'Marketing', 1600000.00, '1991-07-25', '2017-08-20', NULL),
    ('Laura', 'Wilson', 'Sales Executive', 'Sales', 700000.00, '1994-04-12', '2022-01-05', 8),
    ('James', 'Taylor', 'Customer Support', 'Support', 600000.00, '1993-09-30', '2021-05-12', 9),
    ('Olivia', 'Anderson', 'Finance Analyst', 'Finance', 1300000.00, '1987-12-20', '2019-03-18', 10),
    ('Christopher', 'Moore', 'Business Analyst', 'Business', 1400000.00, '1990-08-05', '2016-11-11', 7),
    ('Sophia', 'Thomas', 'Content Writer', 'Marketing', 750000.00, '1995-02-14', '2020-09-22', NULL),
    ('David', 'Miller', 'Software Specialist', 'IT', 1250000.00, '1993-06-15', '2020-01-10', 1),
    ('Ella', 'Harris', 'HR Manager', 'HR', 1100000.00, '1989-07-30', '2015-04-15', NULL),
    ('Mason', 'Clark', 'Sales Manager', 'Sales', 1450000.00, '1986-02-28', '2013-12-05', NULL),
    ('Ava', 'Lewis', 'Support Specialist', 'Support', 670000.00, '1994-11-19', '2021-08-16', 7),
    ('Ethan', 'Walker', 'Marketing Specialist', 'Marketing', 900000.00, '1992-10-11', '2017-06-25', 5);

-- Query to display all records in the 'staff' table.
SELECT * FROM staff;

-- Exercise-1: Increase the salary of all employees in the IT department by 15%
UPDATE staff
SET salary = salary + 0.15 * salary
WHERE Department = 'IT';

-- Verify the update by selecting all records from the 'IT' department.
SELECT * FROM staff WHERE Department = 'IT';

-- Exercise-2: Give a 5% raise to all employees hired before 2020
UPDATE staff 
SET Salary = Salary + 0.05 * Salary
WHERE Hire_Date < '2020-01-01';

-- Verify the update by selecting all records of employees hired before 2020
SELECT * FROM staff 
WHERE Hire_Date < '2020-01-01';

-- Exercise-3: Set the salary of the employee with Employee_ID = 10 to 1,400,000
UPDATE staff 
SET salary = 1400000.00
WHERE Employee_ID = 10;

-- Verify the update by selecting the record of Employee_ID = 10
SELECT * FROM staff WHERE Employee_ID = 10;

-- Exercise-4: Promote employees to 'Senior' positions if their salary exceeds 1,300,000
UPDATE staff 
SET Position = CONCAT('Senior ', Position)
WHERE Salary >= 1300000.00;

-- Verify the update by selecting all records from the 'staff' table
SELECT * FROM staff;

-- Exercise-5: Transfer all employees from the 'Support' department to the 'Customer Service' department
UPDATE staff 
SET Department = 'Customer Service' 
WHERE Department = 'Support';

-- Verify the update by selecting all records from the 'Customer Service' department
SELECT * FROM staff WHERE Department = 'Customer Service';

-- Exercise-6: Change the position of the employee with the highest salary to 'Chief Officer'
UPDATE staff  
SET Position = 'Chief Officer'   
WHERE Salary = (
    SELECT max_salary FROM (SELECT MAX(Salary) AS max_salary FROM staff) AS new_value
);

-- Verify the update by selecting all records from the 'staff' table
SELECT * FROM staff;

-- Exercise-7: Delete records of employees from the 'Marketing' department with a salary less than 1,400,000
DELETE FROM staff 
WHERE Department = 'Marketing' 
AND Salary < 1400000.00;

-- Verify the deletion by selecting all records from the 'staff' table
SELECT * FROM staff;

-- Exercise-8: Remove the employee who has been with the company the longest (earliest hire date)
DELETE FROM staff 
WHERE Hire_Date = (
    SELECT hire FROM (SELECT MIN(Hire_Date) AS hire 
    FROM staff) AS d_hire
);

-- Verify the deletion by selecting all records from the 'staff' table
SELECT * FROM staff;

-- Exercise-9: Delete all employees without a manager (Manager_ID is NULL)
DELETE FROM staff 
WHERE Manager_ID IS NULL;

-- Verify the deletion by selecting all records from the 'staff' table
SELECT * FROM staff;

-- Exercise-10: Select first and last names, and the position of employees with a salary greater than or equal to 1,400,000
SELECT First_Name, Last_Name, Position 
FROM staff 
WHERE Salary >= 1400000.00;

-- Exercise-11: Retrieve all records for employees who report to 'John Doe' (Manager_ID corresponding to John Doe's Employee_ID)
SELECT * FROM staff 
WHERE Manager_ID = 1;

-- Exercise-12: Find the total salary paid to all employees in the 'IT' department
SELECT SUM(Salary) AS TOTAL_IT_SALARY 
FROM staff 
WHERE Department = 'IT';

-- Exercise-13: Count of total employees working in the 'IT' department
SELECT COUNT(*) AS TOTAL_IT_EMPLOYEES 
FROM staff 
WHERE Department = 'IT';

-- Exercise-14: Count the total number of employees working in each department
SELECT COUNT(*) AS TOTAL_EMPLOYEES, Department 
FROM staff 
GROUP BY Department;
