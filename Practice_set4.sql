-- View all records in the 'staff' table
SELECT * FROM staff;

-- Order the records in 'staff' by First Name in descending order
SELECT * FROM staff ORDER BY First_Name DESC;

-- Order the records in 'staff' by First Name in ascending order
SELECT * FROM staff ORDER BY First_Name;

-- Order the records in 'staff' by Salary in ascending order (lowest to highest)
SELECT * FROM staff ORDER BY Salary;

-- Order the records in 'staff' by Salary in descending order (highest to lowest)
SELECT * FROM staff ORDER BY Salary DESC;

-- Switch to the 'del' database
USE del;

-- View all records in the 'staff' table from the 'del' database
SELECT * FROM staff;

-- Query to retrieve all Manager_IDs in the 'staff' table
SELECT Manager_ID AS manager  
FROM staff;

-- Count the total number of non-null Manager_IDs in the 'staff' table
SELECT COUNT(Manager_ID) AS manager  
FROM staff;

-- Display distinct (unique) Manager_IDs in the 'staff' table
SELECT DISTINCT Manager_ID AS manager  
FROM staff;

-- Count the total number of unique Manager_IDs in the 'staff' table
SELECT COUNT(DISTINCT Manager_ID) AS manager  
FROM staff;


-- Create 'emp' table with necessary columns such as Employee_ID, Name, Department, Position, Salary, and Manager_ID
CREATE TABLE emp(
    Employee_ID INT PRIMARY KEY AUTO_INCREMENT, -- Unique identifier for each employee
    First_Name VARCHAR(50) NOT NULL,            -- Employee's first name
    Last_Name VARCHAR(50) NOT NULL,             -- Employee's last name
    Department VARCHAR(50),                     -- Department where the employee works
    Position VARCHAR(50),                       -- Employee's position within the company
    Salary DECIMAL(10, 2),                      -- Employee's salary
    Manager_ID INT                              -- Employee's manager's ID
);

-- Insert sample data into the 'emp' table
INSERT INTO emp(First_Name, Last_Name, Department, Position, Salary, Manager_ID) VALUES
('John', 'Doe', 'IT', 'Developer', 120000, 3),
('Jane', 'Smith', 'IT', 'Developer', 120000, 3),
('Michael', 'Johnson', 'HR', 'HR Specialist', 90000, NULL),
('Emily', 'Davis', 'HR', 'HR Manager', 150000, NULL),
('Daniel', 'Brown', 'Marketing', 'Marketing Specialist', 100000, 5),
('Sophia', 'Clark', 'Marketing', 'Marketing Manager', 150000, NULL),
('David', 'Lee', 'Sales', 'Sales Representative', 85000, 6),
('Chris', 'Evans', 'Sales', 'Sales Manager', 125000, NULL),
('Ella', 'Williams', 'Finance', 'Finance Analyst', 95000, NULL),
('James', 'Miller', 'Finance', 'Finance Manager', 135000, NULL),
('Olivia', 'Taylor', 'IT', 'Developer', 120000, 3),
('Noah', 'Wilson', 'IT', 'IT Manager', 140000, NULL),
('Liam', 'Moore', 'Marketing', 'Marketing Executive', 115000, 6),
('Emma', 'Johnson', 'Support', 'Support Specialist', 70000, NULL),
('Mason', 'Garcia', 'Support', 'Support Manager', 95000, NULL);

-- Switch to the 'del' database
USE del;

-- View all records in the 'emp' table
SELECT * FROM emp;

-- Exercise-1: List all the distinct departments in the company
SELECT DISTINCT Department FROM emp;

-- Exercise-2: Count the total number of employees working in the company
SELECT COUNT(*) AS Total_Employees 
FROM emp;

-- Exercise-3: Count the distinct number of departments in the company
SELECT COUNT(DISTINCT Department) AS Total_Departments
FROM emp;

-- Exercise-4: Find out how many employees are in each department and order them by department name (ascending order)
SELECT COUNT(*) AS Total_emp, Department
FROM emp
GROUP BY Department
ORDER BY Department ASC;

-- Exercise-5: Get a list of all distinct positions in the company, ordered alphabetically
SELECT DISTINCT Position AS Position
FROM emp 
ORDER BY Position ASC;

-- Exercise-6: Count the total number of distinct positions in the company
SELECT COUNT(DISTINCT Position) AS Total_Distinct_Positions
FROM emp;

-- Exercise-7: Count how many employees report to the same manager (Manager_ID), and order the result by the number of employees per manager in descending order
SELECT DISTINCT Manager_ID, COUNT(*) AS Employees
FROM emp 
WHERE Manager_ID IS NOT NULL
GROUP BY Manager_ID 
ORDER BY Employees DESC;

-- Exercise-8: Display the distinct salaries of employees, ordered from the highest to the lowest
SELECT DISTINCT Salary AS Salaries
FROM emp
ORDER BY Salary DESC;

-- Exercise-9: List distinct Manager_IDs but exclude employees who don't have a manager (Manager_ID is NULL)
SELECT DISTINCT Manager_ID AS Manager_IDs
FROM emp
WHERE Manager_ID IS NOT NULL;

-- Exercise-10: Count how many employees have salaries greater than 100,000, grouped by their department, and order by the number of employees in descending order
SELECT Department, COUNT(*) AS employees
FROM emp 
WHERE Salary > 100000
GROUP BY Department
ORDER BY employees DESC;
