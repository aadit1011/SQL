-- ============================================
-- Create the Student table if it doesn't already exist.
-- The table includes the following columns:
--   - student_id: Primary key to uniquely identify each student.
--   - name: Name of the student (up to 50 characters).
--   - major: Major field of study (up to 20 characters).
-- ============================================
CREATE TABLE IF NOT EXISTS Student (
    student_id INT PRIMARY KEY,   -- Primary key for unique student identification
    name VARCHAR(50),             -- Student's name
    major VARCHAR(20)             -- Student's major
);

-- ============================================
-- Select all records from the Student table to check its current contents.
-- At this stage, the table should be empty unless it was previously populated.
-- ============================================
SELECT * FROM Student;

-- ============================================
-- Drop the 'gpa' column from the Student table, if it exists.
-- This command is safe to run even if the 'gpa' column is not present.
-- It ensures that the table is clean before adding or re-adding the 'gpa' column.
-- ============================================
ALTER TABLE Student DROP COLUMN gpa;

-- ============================================
-- Verify that the 'gpa' column has been dropped by displaying the table's structure again.
-- This ensures the table is in the desired state before further modifications.
-- ============================================
DESCRIBE Student;

-- ============================================
-- Add a new 'gpa' column to the Student table.
-- The 'gpa' column will store the student's grade point average (GPA).
-- The DECIMAL(3,2) data type is used to store values like 3.40, with one digit before
-- the decimal point and two digits after.
-- ============================================
ALTER TABLE Student ADD COLUMN gpa DECIMAL(3,2);

-- ============================================
-- Verify that the 'gpa' column has been added by displaying the table's structure again.
-- This ensures that the column was added successfully with the correct data type.
-- ============================================
DESCRIBE Student;

-- ============================================
-- Insert sample student records into the Student table.
-- Each record includes a unique student_id, the student's name, major, and gpa.
-- These records will populate the table with initial data for further queries and tests.
-- ============================================
INSERT INTO Student (student_id, name, major, gpa) VALUES
    (1, 'Jack', 'Biology', 3.40),
    (2, 'Kate', 'Sociology', 3.50),
    (3, 'Claire', 'English', 3.60),
    (4, 'Mike', 'Comp. Science', 3.70);

-- ============================================
-- Select all records from the Student table to verify that the data has been inserted correctly.
-- This query will show all the student records, including the newly added 'gpa' values.
-- ============================================
SELECT * FROM Student;

-- ============================================
-- (Optional) Clear all existing data from the Student table.
-- This is useful if you need to reset the table for further testing or re-inserting data.
-- ============================================
TRUNCATE TABLE Student;

-- ============================================
-- (Optional) Uncomment to re-add the 'gpa' column if it was dropped earlier.
-- This step is not necessary since we've already added the 'gpa' column above.
-- ALTER TABLE Student DROP COLUMN gpa;
-- ALTER TABLE Student ADD COLUMN gpa DECIMAL(3,2);
-- ============================================
