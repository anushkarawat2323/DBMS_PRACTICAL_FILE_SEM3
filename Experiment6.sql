-- exp 6
-- AIM: To create a stored procedure transfer_employee(emp_id, new_dept_id) with validation and error handling, and implement triggers for salary validation 
-- and audit logging. Test the procedure and trigger using valid and invalid cases.

-- Create audit table
CREATE TABLE IF NOT EXISTS Salary_Audit (
    audit_id INT AUTO_INCREMENT PRIMARY KEY,
    emp_id INT,
    old_salary DECIMAL(10,2),
    new_salary DECIMAL(10,2),
    action_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Remove existing triggers
DROP TRIGGER IF EXISTS salary_check;
DROP TRIGGER IF EXISTS salary_audit;

-- Salary validation trigger
CREATE TRIGGER salary_check
BEFORE UPDATE ON Employee
FOR EACH ROW
SET NEW.salary = IF(NEW.salary < 10000, NULL, NEW.salary);

-- Salary audit trigger
CREATE TRIGGER salary_audit
AFTER UPDATE ON Employee
FOR EACH ROW
INSERT INTO Salary_Audit(emp_id, old_salary, new_salary)
SELECT OLD.emp_id, OLD.salary, NEW.salary
WHERE OLD.salary <> NEW.salary;

-- Remove existing procedure
DROP PROCEDURE IF EXISTS transfer_employee;

-- Employee transfer procedure
CREATE PROCEDURE transfer_employee(
    IN p_emp_id INT,
    IN p_new_dept_id INT
)
UPDATE Employee
SET dept_id = p_new_dept_id
WHERE emp_id = p_emp_id
AND p_new_dept_id IN (
    SELECT dept_id FROM Department
);

-- Test valid transfer
CALL transfer_employee(5,2);

SELECT emp_id, emp_name, dept_id
FROM Employee
WHERE emp_id = 5;

-- Test invalid employee
CALL transfer_employee(999,2);

-- Test invalid department
CALL transfer_employee(5,99);

-- Test salary validation
UPDATE Employee
SET salary = 5000
WHERE emp_id = 5;

-- Test audit logging
UPDATE Employee
SET salary = 60000
WHERE emp_id = 5;

SELECT * FROM Salary_Audit;
