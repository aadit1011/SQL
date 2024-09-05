-- Create a new database named 'Del'
 CREATE DATABASE Del;
USE Del;

-- Create the 'Employee' table with various attributes
CREATE TABLE Employee (
    Employee_ID INTEGER PRIMARY KEY AUTO_INCREMENT,  -- Unique identifier for each employee
    First_Name VARCHAR(50) NOT NULL,                -- Employee's first name
    Last_Name VARCHAR(50) NOT NULL,                 -- Employee's last name
    Position VARCHAR(50) NOT NULL,                  -- Employee's position within the company
    Date_of_Birth DATE,                            -- Employee's date of birth
    Hire_Date DATE                                -- Date when the employee was hired
);

-- Display the structure of the 'Employee' table
DESCRIBE Employee;

-- Insert sample data into the 'Employee' table
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

-- Retrieve all records from the 'Employee' table
SELECT * FROM Employee;

-- Use DATE_FORMAT to display the Date_of_Birth in 'YYYY-MM-DD' format for the employee with First_Name 'Sophia'
SELECT DATE_FORMAT(Date_of_Birth, '%Y-%m-%d') AS Date_of_Birth
FROM Employee
WHERE First_Name = 'Sophia';

-- Clean up: Drop the 'Employee' table
DROP TABLE Employee;

-- Switch to database 'del'
USE del;

-- Create the 'dele' table with student information
CREATE TABLE dele (
    student_id INT PRIMARY KEY AUTO_INCREMENT,     -- Unique identifier for each student
    student_name VARCHAR(50) NOT NULL,           -- Student's name
    student_age INT NOT NULL,                    -- Student's age
    email VARCHAR(50) UNIQUE,                    -- Student's email address (must be unique)
    parent_name VARCHAR(50) NOT NULL,            -- Name of the student's parent
    faculty_name VARCHAR(50) DEFAULT 'Science'  -- Name of the faculty, default is 'Science'
);

-- Display the structure of the 'dele' table
DESCRIBE dele;

-- Insert data into the 'dele' table, omitting faculty_name to use the default value
INSERT INTO dele (student_name, student_age, email, parent_name)
VALUES
    ('John Doe', 20, 'john.doe@example.com', 'Jane Doe'),
    ('Harry Willson', 21, 'harry.willson1@example.com', 'Henry Willson'),  -- Unique email
    ('David Smith', 22, 'davidsmith@example.com', 'Dane Smith');

-- Insert additional data with explicit faculty_name values
INSERT INTO dele (student_name, student_age, email, parent_name, faculty_name)
VALUES
    ('Mark Johnson', 21, 'mark.johnson@example.com', 'Martha Johnson', 'Management'),  -- Specific faculty
    ('Sarah Brown', 22, 'sarah.brown@example.com', 'Samuel Brown', 'Medical');        -- Specific faculty

-- Retrieve all records from the 'dele' table
SELECT * FROM dele;

-- Clean up: Drop the 'dele' table
DROP TABLE dele;

-- Note: If you have already dropped the table, you should not attempt to select or truncate it
-- TRUNCATE TABLE dele;

-- Clean up (if necessary): Drop the 'dele' table (repeated for clarity)
-- DROP TABLE dele;
