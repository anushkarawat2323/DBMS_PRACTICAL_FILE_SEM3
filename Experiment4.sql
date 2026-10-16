-- Experiment 4
-- AIM: To perform INNER JOIN, LEFT JOIN, self-join, 3-way join, correlated subqueries, EXISTS, simulated INTERSECT and EXCEPT queries on the Employee schema
-- and compare execution plans using EXPLAIN.

-- INNER JOIN
SELECT e.emp_name, d.dept_name
FROM Employee e INNER JOIN Department d
ON e.dept_id = d.dept_id;

-- LEFT JOIN
SELECT d.dept_name, e.emp_name
FROM Department d LEFT JOIN Employee e
ON d.dept_id = e.dept_id;

-- SELF JOIN: Employee and Manager
SELECT e.emp_name AS Employee, m.emp_name AS Manager
FROM Employee e JOIN Employee m
ON e.manager_id = m.emp_id;

-- 3-WAY JOIN
SELECT e.emp_name, d.dept_name, p.project_name
FROM Employee e
JOIN Department d ON e.dept_id=d.dept_id
JOIN Project p ON d.dept_id=p.dept_id;

-- CORRELATED SUBQUERY
SELECT emp_name, salary, dept_id
FROM Employee e
WHERE salary >
(SELECT AVG(salary) FROM Employee
 WHERE dept_id=e.dept_id);

-- EXISTS
SELECT d.dept_name
FROM Department d
WHERE EXISTS
(SELECT 1 FROM Employee e
 WHERE e.dept_id=d.dept_id);

-- SIMULATED INTERSECT
SELECT emp_id FROM Employee WHERE dept_id=1
AND emp_id IN (SELECT emp_id FROM Employee WHERE salary>60000);

-- SIMULATED EXCEPT
SELECT emp_id FROM Employee
WHERE dept_id=1
AND emp_id NOT IN (SELECT emp_id FROM Employee WHERE salary>60000);

-- EXECUTION PLAN
EXPLAIN SELECT e.emp_name,d.dept_name
FROM Employee e JOIN Department d
ON e.dept_id=d.dept_id;
