
-- joins and subqueries
USE hr;
-- ## Joins ##
SELECT * FROM Regions;
SELECT * FROM Countries;
SELECT * FROM Locations;
SELECT * FROM Departments;
SELECT * FROM Jobs;
SELECT * FROM Employees;
SELECT * FROM Job_History;
-- INNER JOIN 
-- Employees + Departments
-- For each employee, display first name, last name, department number and department name.
SELECT e.first_name,e.last_name,d.department_id,d.department_name
FROM Employees e 
INNER JOIN Departments d
ON e.department_id  = d.department_id ;

-- Same, but only departments 50 or 90.
SELECT e.first_name,e.last_name,d.department_id,d.department_name
FROM Employees e 
INNER JOIN Departments d
ON e.department_id  = d.department_id 
WHERE e.department_id IN (50,90);

-- Departments + Locations
-- Display department name, city and state/province.
SELECT d.department_name,l.city,l.state_province
FROM Departments d
INNER JOIN Locations l
ON d.location_id = l.location_id ;

-- Display employee full name, department name, city and state/province.
SELECT CONCAT(e.first_name,' ',e.last_name) AS FullName,d.department_name, l.state_province
FROM Employees e 
INNER JOIN Departments d 
ON e.department_id = d.department_id 
INNER JOIN Locations l
ON d.location_id = l.location_id;

-- Same, but only employees whose last name contains a.
SELECT CONCAT(e.first_name,' ',e.last_name) AS FullName,d.department_name, l.state_province
FROM Employees e 
INNER JOIN Departments d 
ON e.department_id = d.department_id 
INNER JOIN Locations l
ON d.location_id = l.location_id
WHERE last_name LIKE '%A';

-- OUTER JOIN 
-- Display first name, last name, department number and department name for all employees, including employees without a department.
SELECT e.first_name,e.last_name,d.department_id,d.department_name
FROM Employees e 
JOIN Departments d
ON e.department_id = d.department_id;

-- Modify it to display all departments, including departments without employees.


-- SELF JOIN 
-- Display each employee's last name and their manager's last name.
SELECT e.last_name,m.last_name
FROM Employees e
JOIN Employees m
ON e.manager_id = m.employee_id ;

-- returns only employees who don't have a manager.
SELECT e.employee_id,e.first_name
FROM Employees e 
LEFT JOIN  Employees m 
ON e.manager_id = m.employee_id
WHERE e.manager_id IS NULL ;

-- Modify it to display all employees, including employees without managers.
SELECT e.employee_id,
       e.first_name,
       m.last_name AS manager
FROM Employees e 
LEFT JOIN Employees m 
    ON e.manager_id = m.employee_id;
    
-- Display first name, last name and department number for employees working in the same department as employee whose last name is King.
-- Display last name and salary for employees earning less than employee 103.

-- CROSS  (No ON condition)
SELECT e.first_name,d.department_name
FROM Employees e 
CROSS JOIN Departments d;

-- ## Subqueries ## 

-- Q1 — Compare with a specific employee
-- Display the first name and salary for all employees who earn more than employee number 103.
SELECT first_name, salary 
FROM Employees
WHERE salary >
(
   SELECT salary
   FROM Employees 
   WHERE employee_id  = 103
);


-- Q2 — Compare department locations
-- Display the department number and department name for all departments whose location number is the same as the location number of department 90.
SELECT 	department_id,department_name
FROM Departments
WHERE location_id =
(
  SELECT location_id
  FROM Departments
  WHERE department_id = 90
);

-- Q3 — Compare hire dates
-- Display the last name and hire date for all employees who were hired after employee number 101.
SELECT last_name,hire_date
FROM Employees
WHERE hire_date >
(
  SELECT hire_date
  FROM Employees
  WHERE employee_id = 101
  
);

-- Q4 — Employee's department
-- Display the first name, last name, and department number for all employees who work in the Sales department.
SELECT e.first_name,e.last_name,e.department_id 
FROM Employees e 
JOIN Departments d 
ON e.department_id = d.department_id
WHERE d.department_name =
(
  SELECT department_name
  FROM Departments
  WHERE department_name = "Sales"

);
-- or better version
SELECT first_name, last_name, department_id
FROM Employees
WHERE department_id =
(
    SELECT department_id
    FROM Departments
    WHERE department_name = 'Sales'
);

-- Q5 — Department location
-- Display the department number and department name for all departments located in Toronto.
SELECT department_id, department_name
FROM Departments
WHERE location_id IN
(
    SELECT location_id
    FROM Locations
    WHERE city = 'Toronto'
);

-- Q6 — Same department as employee
-- Display the first name, salary, and department number for all employees who work in the same department as employee number 124.
SELECT first_name,salary,department_id 
FROM Employees e 
WHERE department_id IN
(
  SELECT department_id
  FROM Employees
  WHERE employee_id = 124

);

-- Q7 — Above average salary
-- Display the first name, salary, and department number for all employees who earn more than the average salary.
SELECT first_name,salary,department_id
FROM Employees 
WHERE Salary > 
(
  SELECT AVG(Salary)
  FROM Employees
);

-- Q8 — Salaries from another department
-- Display the first name, salary, and department number for all employees whose salary equals one of the salaries in department 20.
SELECT first_name,salary,department_id 
FROM Employees
WHERE Salary IN 
(
  SELECT Salary 
  FROM Employees
  WHERE department_id = 20

);

-- Q9 — Greater than department maximum
-- Display the first name, salary, and department number for all employees who earn more than the maximum salary in department 50.
SELECT first_name,salary,department_id 
FROM Employees
WHERE Salary > 
(
  SELECT MAX(Salary)
  FROM Employees
  WHERE department_id = 50
 
);

-- Q10 — Greater than department minimum
-- Display the first name, salary, and department number for all employees who earn more than the minimum salary in department 60.
SELECT first_name,salary,department_id 
FROM Employees
WHERE Salary > 
(
  SELECT MIN(Salary)
  FROM Employees
  WHERE department_id = 60
 
);

-- Q11 — Less than department minimum
-- Display the first name, salary, and department number for all employees who earn less than the minimum salary in department 90.
SELECT first_name,salary,department_id 
FROM Employees
WHERE Salary <
(
  SELECT MIN(Salary)
  FROM Employees
  WHERE department_id = 90
 
);
-- Q12 — Department located in Seattle
-- Display the first name, salary, and department number for all employees whose department is located in Seattle.
SELECT  e.first_name,e.salary,e.department_id
FROM Employees e 
JOIN Departments d  
ON e.department_id = d.department_id
JOIN Locations l
on d.location_id = l.location_id
WHERE l.city = "Seattle";      -- without subquery 

-- with NESTED subquery
SELECT first_name, salary, department_id
FROM Employees
WHERE department_id IN
(
    SELECT department_id
    FROM Departments
    WHERE location_id IN
    (
        SELECT location_id
        FROM Locations
        WHERE city = 'Seattle'
    )
);

-- CO-RELATED SUBQUERY
-- Q13 Highest salary in each department -- on cond for department
SELECT e.first_name,e.department_id
FROM Employees e 
WHERE e.Salary =
(
   SELECT  MAX(e1.salary)
   from employees e1
   where e.department_id = e1.department_id

);


-- Q14 Employee with Second Highest salary
SELECT first_name,Salary
FROM Employees
WHERE Salary =
(
    SELECT MAX(Salary)
    FROM Employees
    WHERE salary<
   (
   SELECT MAX(Salary)
   FROM Employees )
);

-- Q15 — Two conditions together
-- Display the first name, salary, and department number for all employees who:
-- a.Earn less than the average salary, and
-- b.Work in the same department as the employee whose first name is Kevin.

-- SUBQUERY + AND
SELECT first_name,salary,department_id 
FROM Employees 
WHERE Salary <
(  
  SELECT  AVG(Salary)
  FROM Employees  )
  AND department_id IN
  (
  SELECT department_id 
  FROM Employees
  WHERE first_name = "kevin"
  );

