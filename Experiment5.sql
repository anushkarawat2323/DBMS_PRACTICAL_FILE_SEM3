-- Experiment 5
-- AIM: To create SQL views for department salary summary and employee hierarchy, test their updatability, and implement a recursive CTE to display employee 
-- reporting chains.

-- Department Salary View
CREATE VIEW dept_salary_summary AS
SELECT d.dept_id, d.dept_name,
       COUNT(e.emp_id) AS total_employees,
       AVG(e.salary) AS average_salary
FROM Department d LEFT JOIN Employee e
ON d.dept_id=e.dept_id
GROUP BY d.dept_id,d.dept_name;

SELECT * FROM dept_salary_summary;

-- Employee Hierarchy View
CREATE VIEW employee_hierarchy AS
SELECT e.emp_id, e.emp_name, e.manager_id,
       m.emp_name AS manager_name
FROM Employee e LEFT JOIN Employee m
ON e.manager_id=m.emp_id;

SELECT * FROM employee_hierarchy;

-- Test view updatability
UPDATE employee_hierarchy
SET emp_name='Aarav Sharma'
WHERE emp_id=1;

-- Recursive CTE
WITH RECURSIVE reporting_chain AS (
    SELECT emp_id, emp_name, manager_id, 1 AS level
    FROM Employee
    WHERE manager_id IS NULL

    UNION ALL

    SELECT e.emp_id,e.emp_name,e.manager_id,rc.level+1
    FROM Employee e
    JOIN reporting_chain rc
    ON e.manager_id=rc.emp_id
)
SELECT * FROM reporting_chain
ORDER BY level, emp_id;

