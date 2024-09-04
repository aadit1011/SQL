-- Create the Student table if it doesn't already exist.
-- The table includes columns for student_id, name, and major.
CREATE TABLE IF NOT EXISTS Student (
    student_id INT PRIMARY KEY,   -- Primary key to uniquely identify each student
    name VARCHAR(50),             -- Name of the student (up to 50 characters)
    major VARCHAR(20)             -- Major field of study (up to 20 characters)
);

-- Display the structure of the Student table.
DESCRIBE Student;

-- Select all records from the Student table to verify its current contents.
SELECT * FROM Student;

-- Drop the 'gpa' column from the Student table if it exists.
-- This is just an example, and since the 'gpa' column isn't present, this command is safe.
ALTER TABLE Student DROP COLUMN gpa;

-- Verify that the 'gpa' column has been dropped by displaying the table structure.
DESCRIBE Student;

-- Optionally, you can add a 'gpa' column to the Student table.
-- This command is currently commented out.
-- ALTER TABLE Student ADD COLUMN gpa FLOAT;

-- Optionally, you can insert some sample records into the Student table.
-- This command is also commented out to avoid re-inserting data.
-- INSERT INTO Student (student_id, name, major) VALUES
--     (1, 'Jack', 'Biology'),
--     (2, 'Kate', 'Sociology'),
--     (3, 'Claire', 'English'),
--     (4, 'Mike', 'Comp. Science');

-- Select all records from the Student table after making changes (if any).
-- This command can be uncommented if you want to check the table's contents after modifications.
-- SELECT * FROM Student;
