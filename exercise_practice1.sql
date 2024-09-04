-- Create a new database named 'Del'
-- CREATE DATABASE Del;

-- Select the 'Del' database to use for subsequent operations
USE Del;

-- Create the 'Employee' table with specified columns
CREATE TABLE Employee (
    Employee_ID INTEGER PRIMARY KEY AUTO_INCREMENT, -- Unique identifier for each employee
    First_Name VARCHAR(50) NOT NULL,                -- Employee's first name, cannot be null
    Last_Name VARCHAR(50) NOT NULL,                 -- Employee's last name, cannot be null
    Position VARCHAR(50) NOT NULL,                  -- Job position of the employee, cannot be null
    Date_of_Birth DATE,                            -- Employee's date of birth
    Hire_Date DATE                                -- Date when the employee was hired
);

-- Display the structure of the 'Employee' table
DESCRIBE Employee;

-- Insert multiple rows into the 'Employee' table
INSERT INTO Employee (First_Name, Last_Name, Position, Date_of_Birth, Hire_Date)
VALUES 
    ('John', 'Doe', 'Software Specialist', '1990-05-15', '2020-06-01'),
    ('Jane', 'Smith', 'Project Manager', '1985-03-22', '2018-07-10'),
    ('Michael', 'Johnson', 'Data Analyst', '1992-11-10', '2019-09-15'),
    ('Emily', 'Davis', 'HR Specialist', '1988-01-17', '2021-02-01'),
    ('Daniel', 'Brown', 'Marketing Manager', '1991-07-25', '2017-08-20'),
    ('Laura', 'Wilson', 'Sales Executive', '1994-04-12', '2022-01-05'),
    ('James', 'Taylor', 'Customer Support', '1993-09-30', '2021-05-12'),
    ('Olivia', 'Anderson', 'Finance Analyst', '1987-12-20', '2019-03-18'),
    ('Christopher', 'Moore', 'Business Analyst', '1990-08-05', '2016-11-11'),
    ('Sophia', 'Thomas', 'Content Writer', '1995-02-14', '2020-09-22');

-- Query to select all data from the 'Employee' table
SELECT * FROM Employee;

-- Query to select the date of birth of the employee named 'Sophia'
-- Format the date to ensure it appears as 'YYYY-MM-DD'
SELECT DATE_FORMAT(Date_of_Birth, '%Y-%m-%d') AS Date_of_Birth
FROM Employee
WHERE First_Name = 'Sophia';

-- Drop the 'Employee' table to remove it from the database
-- DROP TABLE Employee;
