-- Create the database if it does not exist and switch to using it.
CREATE DATABASE IF NOT EXISTS table_creation_practice;
USE table_creation_practice;

-- ===================================================
-- Basic Level: Bookstore Database
-- ===================================================

-- Task:
-- Create two tables: 'book' and 'author'.
-- Each book has one author, but each author can write multiple books.
-- Implement proper relationships using primary and foreign keys.

-- Create the 'book' table to store book details.
CREATE TABLE IF NOT EXISTS book (
    book_id INTEGER PRIMARY KEY,            -- Unique ID for each book
    title VARCHAR(100),                     -- Title of the book
    author_id INTEGER,                      -- Foreign key referencing author_id in 'author' table
    publication_date DATE                   -- Date when the book was published
);

-- Create the 'author' table to store author information.
CREATE TABLE IF NOT EXISTS author (
    author_id INTEGER PRIMARY KEY,          -- Unique ID for each author
    first_name VARCHAR(50),                 -- Author's first name
    last_name VARCHAR(50),                  -- Author's last name
    birth_date DATE                         -- Author's date of birth
);

-- Add a foreign key constraint to the 'book' table to ensure
-- that author_id in 'book' references a valid author_id in 'author'.
ALTER TABLE book
ADD FOREIGN KEY (author_id) 
REFERENCES author(author_id) ON DELETE SET NULL;  -- Set author_id to NULL if the author is deleted.

-- Insert data into the 'author' table.
INSERT INTO author (author_id, first_name, last_name, birth_date)
VALUES 
(101, 'John', 'Doe', '1960-05-12'),
(102, 'Jane', 'Smith', '1978-08-23'),
(103, 'Alan', 'Turing', '1912-06-23'),
(104, 'Grace', 'Hopper', '1906-12-09'),
(105, 'Ada', 'Lovelace', '1815-12-10');

-- Insert data into the 'book' table.
INSERT INTO book (book_id, title, publication_date, author_id)
VALUES 
(1, 'The Great Adventure', '2018-07-21', 101),
(2, 'Learning SQL', '2020-11-05', 102),
(3, 'Mastering Python', '2021-03-15', 102),
(4, 'Data Structures and Algorithms', '2019-09-12', 103),
(5, 'A Journey Through Time', '2017-05-07', 101);

-- Retrieve all data from 'book' and 'author' tables.
SELECT * FROM book;
SELECT * FROM author;


-- ===================================================
-- Intermediate Level: Online Course Platform Database
-- ===================================================

-- Task:
-- Create tables for 'course', 'instructor', 'student', and 'enrollment'.
-- Each course is taught by one instructor, but an instructor can teach multiple courses.
-- Students can enroll in multiple courses, and each course can have multiple students.
-- Many-to-many relationships should be handled between students and courses.

-- Create the 'course' table to store course details.
CREATE TABLE IF NOT EXISTS course (
    course_id INT PRIMARY KEY,              -- Unique ID for each course
    course_name VARCHAR(100) NOT NULL,      -- Name of the course
    start_date DATE,                        -- Date when the course starts
    instructor_id INT                       -- Foreign key referencing the instructor teaching the course
);

-- Create the 'instructor' table to store instructor details.
CREATE TABLE IF NOT EXISTS instructor (
    instructor_id INT PRIMARY KEY,          -- Unique ID for each instructor
    first_name VARCHAR(50) NOT NULL,        -- Instructor's first name
    last_name VARCHAR(50) NOT NULL          -- Instructor's last name
);

-- Create the 'student' table to store student information.
CREATE TABLE IF NOT EXISTS student (
    student_id INT PRIMARY KEY AUTO_INCREMENT, -- Unique ID for each student (auto-incremented)
    first_name VARCHAR(50) NOT NULL,           -- Student's first name
    last_name VARCHAR(50) NOT NULL             -- Student's last name
);

-- Create the 'enrollment' table to track student-course relationships (many-to-many relationship).
CREATE TABLE IF NOT EXISTS enrollment (
    student_id INT,                        -- Foreign key referencing 'student' table
    course_id INT,                         -- Foreign key referencing 'course' table
    enrollment_date DATE,                  -- Date when the student enrolled in the course
    PRIMARY KEY (student_id, course_id),   -- Composite primary key (student_id, course_id)
    FOREIGN KEY (student_id) REFERENCES student(student_id) ON DELETE CASCADE, -- If student is deleted, enrollment records are deleted.
    FOREIGN KEY (course_id) REFERENCES course(course_id) ON DELETE CASCADE    -- If course is deleted, enrollment records are deleted.
);

-- Add a foreign key constraint to the 'course' table to ensure
-- that each course has a valid instructor.
ALTER TABLE course
ADD FOREIGN KEY (instructor_id) 
REFERENCES instructor(instructor_id) ON DELETE SET NULL;  -- Set to NULL if the instructor is deleted.

-- Insert data into the 'instructor' table.
INSERT INTO instructor (instructor_id, first_name, last_name)
VALUES 
(3001, 'Alice', 'Johnson'),
(3002, 'Bob', 'Lee'),
(3003, 'Charlie', 'Kim'),
(3004, 'Diana', 'Thompson'),
(3005, 'Emily', 'Davis');

-- Insert data into the 'student' table.
INSERT INTO student (student_id, first_name, last_name)
VALUES 
(4001, 'Michael', 'Brown'),
(4002, 'Sarah', 'Green'),
(4003, 'Daniel', 'White'),
(4004, 'Jessica', 'Adams'),
(4005, 'Oliver', 'Harris');

-- Insert data into the 'course' table.
INSERT INTO course (course_id, course_name, start_date, instructor_id)
VALUES 
(2001, 'Introduction to Programming', '2023-09-01', 3001),
(2002, 'Data Science Basics', '2023-08-20', 3002),
(2003, 'Advanced Machine Learning', '2023-10-15', 3003),
(2004, 'Web Development Bootcamp', '2023-07-05', 3001),
(2005, 'Cloud Computing Fundamentals', '2023-06-22', 3004);

-- Insert data into the 'enrollment' table.
INSERT INTO enrollment (student_id, course_id, enrollment_date)
VALUES 
(4001, 2001, '2023-09-02'),
(4002, 2002, '2023-08-21'),
(4003, 2003, '2023-10-17'),
(4004, 2004, '2023-07-06'),
(4005, 2005, '2023-06-23');

-- Retrieve data from all tables.
SELECT * FROM student;
SELECT * FROM instructor;
SELECT * FROM course;
SELECT * FROM enrollment;


-- ===================================================
-- Advanced Level: International Company Project Management Database
-- ===================================================

-- Task:
-- Design tables for 'employee', 'department', 'project', and 'project_assignment'.
-- Each employee works in one department, and each project is managed by one department.
-- An employee can work on multiple projects, and each project can have multiple employees.
-- Use foreign keys to enforce referential integrity, and apply cascading actions for deletions.

-- Create the 'department' table to store department details.
CREATE TABLE IF NOT EXISTS department (
    department_id INTEGER PRIMARY KEY AUTO_INCREMENT, -- Unique ID for each department (auto-incremented)
    department_name VARCHAR(50) NOT NULL,             -- Name of the department
    region VARCHAR(50) NOT NULL                       -- Region where the department operates
);

-- Create the 'employee' table to store employee details.
CREATE TABLE IF NOT EXISTS employee (
    emp_id INTEGER PRIMARY KEY AUTO_INCREMENT,  -- Unique ID for each employee (auto-incremented)
    first_name VARCHAR(30) NOT NULL,            -- Employee's first name
    last_name VARCHAR(30) NOT NULL,             -- Employee's last name
    birth_day DATE,                             -- Employee's date of birth
    department_id INTEGER                       -- Foreign key referencing department_id in 'department'
);

-- Create the 'project' table to store project details.
CREATE TABLE IF NOT EXISTS project (
    project_id INTEGER PRIMARY KEY,             -- Unique ID for each project
    project_name VARCHAR(100) NOT NULL,         -- Name of the project
    start_date DATE,                            -- Start date of the project
    end_date DATE,                              -- End date of the project
    department_id INTEGER,                      -- Foreign key referencing department_id in 'department'
    FOREIGN KEY (department_id) REFERENCES department(department_id) ON DELETE SET NULL -- Set department_id to NULL if department is deleted.
);

-- Create the 'project_assignment' table to track which employees are assigned to which projects.
CREATE TABLE IF NOT EXISTS project_assignment (
    emp_id INTEGER NOT NULL,                    -- Foreign key referencing emp_id in 'employee'
    project_id INTEGER NOT NULL,                -- Foreign key referencing project_id in 'project'
    assigned_date DATE NOT NULL,                -- Date when the employee was assigned to the project
    worked_hour INTEGER NOT NULL,               -- Number of hours the employee worked on the project
    PRIMARY KEY (emp_id, project_id),           -- Composite primary key (emp_id, project_id)
    FOREIGN KEY (emp_id) REFERENCES employee(emp_id) ON DELETE CASCADE, -- Cascade delete if employee is deleted
    FOREIGN KEY (project_id) REFERENCES project(project_id) ON DELETE CASCADE -- Cascade delete if project is deleted
);

-- Add foreign key constraint to the 'employee' table to link to the 'department' table.
ALTER TABLE employee
ADD FOREIGN KEY (department_id) 
REFERENCES department(department_id) ON DELETE SET NULL ON UPDATE CASCADE;

-- Insert data into the 'department' table.
INSERT INTO department (department_id, department_name, region)
VALUES 
(6001, 'Engineering', 'North America'),
(6002, 'Marketing', 'Europe'),
(6003, 'Sales', 'Asia'),
(6004, 'HR', 'Australia'),
(6005, 'Finance', 'South America');

-- Insert data into the 'employee' table.
INSERT INTO employee (emp_id, first_name, last_name, birth_day, department_id)
VALUES 
(5001, 'John', 'Smith', '1985-03-11', 6001),
(5002, 'Emma', 'Johnson', '1990-07-24', 6002),
(5003, 'Noah', 'Williams', '1988-12-10', 6003),
(5004, 'Olivia', 'Brown', '1995-01-02', 6001),
(5005, 'Liam', 'Jones', '1982-04-05', 6003);

-- Insert data into the 'project' table.
INSERT INTO project (project_id, project_name, start_date, end_date, department_id)
VALUES 
(7001, 'New Website Launch', '2023-01-15', '2023-06-30', 6002),
(7002, 'Product Redesign', '2023-03-01', '2023-09-30', 6001),
(7003, 'Global Sales Campaign', '2023-02-20', '2023-12-31', 6003),
(7004, 'HR Software Upgrade', '2023-04-05', '2023-10-15', 6004),
(7005, 'Budget Planning 2024', '2023-06-01', '2023-12-01', 6005);

-- Insert data into the 'project_assignment' table.
INSERT INTO project_assignment (emp_id, project_id, assigned_date, worked_hour)
VALUES 
(5001, 7002, '2023-03-05', 150),
(5002, 7001, '2023-01-16', 200),
(5003, 7003, '2023-02-21', 100),
(5004, 7004, '2023-04-07', 180),
(5005, 7005, '2023-06-05', 160);

-- Retrieve data from all tables.
SELECT * FROM employee;
SELECT * FROM department;
SELECT * FROM project;
SELECT * FROM project_assignment;

