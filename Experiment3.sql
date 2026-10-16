-- Experiment 3
--AIM: To create an Employee–Department–Project database schema, insert at least 30 employees across 5 departments and 8 projects, and perform SQL queries 
--demonstrating selection, projection, aggregate functions, GROUP BY, HAVING, CASE expressions, and ORDER BY.
CREATE TABLE Department(
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(30),
    location VARCHAR(30)
);

CREATE TABLE Employee(
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(40),
    salary DECIMAL(10,2),
    dept_id INT,
    manager_id INT NULL,
    FOREIGN KEY(dept_id) REFERENCES Department(dept_id)
);

CREATE TABLE Project(
    project_id INT PRIMARY KEY,
    project_name VARCHAR(40),
    dept_id INT,
    budget DECIMAL(12,2),
    FOREIGN KEY(dept_id) REFERENCES Department(dept_id)
);

CREATE TABLE Employee_Project(
    emp_id INT,
    project_id INT,
    PRIMARY KEY(emp_id,project_id),
    FOREIGN KEY(emp_id) REFERENCES Employee(emp_id),
    FOREIGN KEY(project_id) REFERENCES Project(project_id)
);

INSERT INTO Department VALUES
(1,'IT','Delhi'),(2,'HR','Lucknow'),(3,'Finance','Mumbai'),
(4,'Marketing','Pune'),(5,'AI','Bangalore');

INSERT INTO Employee VALUES
(1,'Aarav',55000,1,NULL),(2,'Ananya',65000,1,1),
(3,'Riya',48000,1,1),(4,'Karan',72000,1,1),
(5,'Neha',45000,1,2),(6,'Rahul',58000,1,2),
(7,'Ishita',62000,2,NULL),(8,'Aditya',52000,2,7),
(9,'Priya',47000,2,7),(10,'Rohan',68000,2,7),
(11,'Sneha',50000,2,8),(12,'Vivek',56000,2,8),
(13,'Meera',75000,3,NULL),(14,'Arjun',60000,3,13),
(15,'Nisha',54000,3,13),(16,'Varun',65000,3,13),
(17,'Kriti',49000,3,14),(18,'Yash',57000,3,14),
(19,'Tanya',70000,4,NULL),(20,'Dev',55000,4,19),
(21,'Pooja',46000,4,19),(22,'Manav',62000,4,19),
(23,'Simran',51000,4,20),(24,'Kabir',59000,4,20),
(25,'Aditi',85000,5,NULL),(26,'Nakul',70000,5,25),
(27,'Ira',68000,5,25),(28,'Aryan',78000,5,25),
(29,'Diya',60000,5,26),(30,'Mohit',65000,5,26);

INSERT INTO Project VALUES
(101,'Website',1,200000),(102,'CloudApp',1,300000),
(103,'Recruitment',2,150000),(104,'Payroll',3,250000),
(105,'Campaign',4,180000),(106,'Analytics',5,400000),
(107,'Chatbot',5,350000),(108,'FinanceAI',3,450000);

INSERT INTO Employee_Project VALUES
(1,101),(2,101),(3,102),(4,102),(5,101),
(7,103),(8,103),(9,103),(13,104),(14,104),
(15,108),(19,105),(20,105),(21,105),(25,106),
(26,106),(27,107),(28,107),(29,106),(30,107);

-- Selection
SELECT * FROM Employee WHERE salary > 60000;

-- Projection
SELECT emp_name, salary FROM Employee;

-- Aggregate
SELECT COUNT(*) AS Total_Employees, AVG(salary) AS Average_Salary,
       MAX(salary) AS Maximum_Salary, MIN(salary) AS Minimum_Salary
FROM Employee;

-- GROUP BY
SELECT dept_id, COUNT(*) AS Employees, AVG(salary) AS Avg_Salary
FROM Employee GROUP BY dept_id;

-- HAVING
SELECT dept_id, AVG(salary) AS Avg_Salary
FROM Employee GROUP BY dept_id
HAVING AVG(salary) > 60000;

-- CASE
SELECT emp_name, salary,
CASE
    WHEN salary >= 70000 THEN 'High'
    WHEN salary >= 55000 THEN 'Medium'
    ELSE 'Low'
END AS Salary_Level
FROM Employee;

-- ORDER BY
SELECT emp_name, salary FROM Employee
ORDER BY salary DESC;
