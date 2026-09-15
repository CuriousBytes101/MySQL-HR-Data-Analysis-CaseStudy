-- Queries:

USE hr;

SELECT * FROM Regions;
SELECT * FROM Countries;
SELECT * FROM Locations;
SELECT * FROM Departments;
SELECT * FROM Jobs;
SELECT * FROM Employees;
SELECT * FROM Job_History;

-- ### WHERE CLAUSE  ###

-- Display the first name and department number for all employees whose last name is “De Haan”.
SELECT first_name,department_id 
FROM Employees
WHERE last_name = "De Haan";

-- Display all data from Departments for the Sales department.
SELECT * FROM  Departments
WHERE department_name = "Sales";

-- Display first name, last name, department number and salary for employees earning more than 9700.
SELECT first_name,last_name,department_id,Salary
FROM Employees
WHERE Salary > 9700;

-- Display all employee data for employees hired before January 1, 1992.
SELECT * FROM Employees
WHERE hire_date <='1992-01-01' ;

-- Display employee number, first name, job ID and department number for employees in departments 20, 60 or 80.
SELECT employee_id,first_name,job_id,department_id
FROM Employees 
WHERE department_id IN (20,60,80);

-- Display the same columns for employees not in departments 20, 60 or 80.
SELECT employee_id,first_name,job_id,department_id
FROM Employees 
WHERE department_id NOT IN (20,60,80);

-- Display last name, phone number, salary and manager number for employees whose manager is 100, 102 or 103.
SELECT last_name,phone_number,salary,manager_id
FROM Employees
WHERE Manager_id = 100 OR Manager_id = 102 OR Manager_id = 103 ;

-- Display first name and salary for employees whose first name ends with e.
SELECT first_name,salary
FROM Employees 
WHERE first_name LIKE '%e';

-- Display last name and department number where the second letter of last name is i.
SELECT last_name,department_id
FROM Employees
WHERE last_name LIKE '_i%';

-- Display all employee data where last name contains L, J or H, sorted by salary descending.
SELECT *
FROM Employees
WHERE last_name LIKE '%L%'
  OR last_name LIKE  '%J%'
  OR last_name LIKE '%H%'
ORDER BY Salary DESC;

-- Display first name, hire date, salary and department number where first name doesn't contain A, sorted by department number ascending.
SELECT first_name,hire_date,department_id
FROM Employees
WHERE first_name NOT LIKE  '%A%'
ORDER BY department_id ;

-- Display all employees who don't have a department number.
SELECT * FROM Employees 
WHERE Department_id IS NULL;

-- Display full name and salary for employees whose salary is not between 7000 and 15000, sorted by full name.
SELECT CONCAT(first_name,last_name) AS Full_name,Salary
FROM Employees
WHERE Salary NOT BETWEEN 7000 AND 15000
ORDER BY Full_name ASC;

-- Display full name, phone + email, and salary for employees whose salary is between 5000 and 10000. Rename columns FULL_NAME, CONTACTS, SAL.
SELECT CONCAT(first_name,' ',last_name) AS FULL_NAME, CONCAT(phone_number,' - ',email) AS CONTACTS,Salary AS SAL 
FROM Employees 
WHERE Salary BETWEEN 5000 AND 10000;

-- Display employees satisfying the given salary + commission + department + hire-date conditions.
-- conditions salary is in the range of 6000 and 800 and commission is not null or department number is not equal to 80, 90 and 100 and hire date is before January 1st, 1990.
SELECT * FROM Employees 
WHERE (salary BETWEEN 6000 AND 800 AND commission_pct IS NOT NULL)
       OR (Department_id NOT IN (80,90,100) AND hire_date < '1990-01-01');

-- Display last name, job ID and hire date for employees hired between December 12, 1995 and April 17, 1998.
SELECT last_name,job_id,hire_date 
FROM Employees WHERE hire_date >= '1995-12-12' AND hire_date <= '1998-04-17';

-- Display full name, hire date, commission %, telephone and salary where salary > 10000 OR the third digit of phone number is 5. Sort by first name descending.
SELECT CONCAT(first_name,' ',last_name) AS FullName, hire_date,commission_pct,phone_number,salary
FROM Employees 
WHERE Salary > 10000 OR phone_number LIKE '__5%' 
ORDER BY first_name DESC;

-- Display last name and salary for employees earning more than 12000.
SELECT last_name,salary 
FROM Employees 
WHERE Salary > 12000;

-- Display last name and department number for departments 50 or 80, once using IN and once using OR.

-- using in
SELECT last_name,department_id
FROM Employees
WHERE department_id IN (50,80);

-- using OR
SELECT last_name,department_id
FROM Employees
WHERE department_id = 50 OR department_id = 80;

-- Display first name and salary for employees who don't earn commission.
SELECT first_name,salary 
FROM Employees 
WHERE commission_pct IS NULL ;

-- Display first name, salary and manager number for employees whose manager number is not NULL.
SELECT first_name,salary,manager_id 
FROM Employees
WHERE manager_id IS NOT NULL;

-- ### SELECT ###

-- Employee number, first name, last name, phone number and department number.
SELECT employee_id ,first_name,last_name,phone_number,department_id
FROM Employees;

-- First name, last name, hire date, salary and salary after a 20% raise, named ANNUAL_SAL.
SELECT first_name,last_name,hire_date,salary, (salary + (salary * 20/100) )   AS ANNUAL_SAL
FROM Employees;

-- Last name + first name and telephone + email, named FULL_NAME and CONTACT_DETAILS.
SELECT CONCAT(last_name,' ',first_name) AS FULL_NAME,CONCAT(phone_number,'-',email) AS CONTACT_DETAILS
FROM Employees;

-- Display unique manager numbers.
SELECT DISTINCT manager_id 
FROM Employees;

-- Last name + job ID, named EMPLOYEE_AND_TITLE.
SELECT CONCAT(last_name,'  ',job_id) AS EMPLOYEE_AND_TITLE
FROM Employees;

-- Display first name, last name, salary and hire date with literal "HD".

SELECT CONCAT(last_name,' ',first_name) AS FN,salary AS SAL,hire_date AS HD
FROM Employees;

-- Display unique salaries.
SELECT DISTINCT Salary
FROM Employees;

-- Display unique combinations of department ID + job ID.
SELECT DISTINCT department_id,job_id
FROM Employees;

-- ###        ### 
-- Find the lowest last name alphabetically.
SELECT last_name 
FROM Employees
ORDER BY last_name ASC 
LIMIT 1;

-- Find the highest last name alphabetically.
SELECT last_name 
FROM Employees
ORDER BY last_name DESC 
LIMIT 1;

-- Count the number of rows in Employees.
SELECT COUNT(*) FROM Employees;

-- Count non-NULL values in commission_pct.
SELECT COUNT(commission_pct) FROM Employees;

-- Count NULL values in commission_pct.
-- SELECT COUNT(commission_pct IS NULL) AS Count_of_null
-- FROM Employees ;

SELECT COUNT(*) AS Null_Count FROM Employees
WHERE commission_pct IS NULL;
-- or
SELECT COUNT(*) - COUNT(commission_pct) AS Count_of_null
FROM Employees;

-- Find highest, lowest and average salary.
SELECT MIN(Salary) AS MinimumSalary, MAX(Salary) AS HighestSalary,AVG(Salary) AS AverageSalary
FROM Employees;


-- ### GROUP BY + HAVING  ###
-- Average salary per department:
-- a. All departments.
-- b. Only departments 50 and 80.

-- a.  All departments.
SELECT department_id,AVG(salary) AS Average_Sal
FROM Employees
GROUP BY department_id ;
-- or
SELECT d.department_name,AVG(e.salary) AS Average_sal
FROM Departments d
JOIN Employees e 
ON d.department_id = e.department_id
GROUP BY d.department_name ;

-- b. Only departments 50 and 80.
SELECT department_id,AVG(salary) AS Average_Sal
FROM Employees
WHERE department_id IN (50,80) 
GROUP BY department_id;


-- Number of employees per job ID:
-- a. All jobs.
-- b. Employees earning > 10000.
-- c. Jobs having more than 2 employees.

-- a. All jobs
SELECT job_id,COUNT(employee_id) AS emp_count
FROM Employees
GROUP BY job_id;
-- b. Employees earning > 10000.
SELECT job_id,COUNT(employee_id) AS emp_count
FROM Employees
WHERE Salary > 10000
GROUP BY job_id;                     -- key learning: just salary cannot be used in having sum?? summ of same job_id

-- c. Jobs having more than 2 employees.
SELECT job_id,COUNT(employee_id) AS emp_count
FROM Employees
GROUP BY job_id
HAVING COUNT(employee_id) > 2;

-- Department number, job ID and average salary for each combination.
SELECT department_id,job_id,AVG(Salary) AS Average_Salary
FROM Employees
GROUP BY department_id,job_id;

-- Manager number and highest salary:
-- a. For each manager.
-- b. Only employees earning > 10000.

-- a. For each manager.
SELECT manager_id,MAX(Salary) AS Highest_Salary
FROM Employees
GROUP BY manager_id    
HAVING manager_id IS NOT NULL;      -- 100 TO 205 EXCLUDE manager_id with NULL

-- b. Only employees earning > 10000.
SELECT manager_id,MAX(Salary) AS Highest_Salary
FROM Employees
WHERE Salary > 10000
GROUP BY manager_id   ;    


-- Job ID and minimum salary for jobs whose minimum salary is > 7000.
SELECT job_id,MIN(Salary) AS LowestSalary
FROM Employees 
GROUP BY job_id
HAVING  MIN(Salary) > 7000;     

-- Departments numbered 20–80 whose average salary is > 9000.
SELECT department_id,AVG(Salary) AS Aveg_sal
FROM Employees
WHERE Department_id BETWEEN 20 AND 80
GROUP BY department_id
HAVING AVG(Salary) > 9000; 

-- ## Scalar Functions ##

-- First name in lowercase and last name in uppercase for employee numbers 80–150.
SELECT LOWER(first_name) AS fname ,UPPER(last_name) AS lname
FROM Employees
WHERE employee_id BETWEEN 80 AND 150;

-- Find employees with last name King, using a case-insensitive search.
SELECT * FROM Employees
WHERE  LOWER(last_name) ='king';
-- or
SELECT * FROM Employees
WHERE last_name LIKE '%king%';

-- Generate email addresses:
-- a. First letter of first name + first 3 letters of last name + @oracle.com
-- b. First letter of first name + last 3 letters of last name + @oracle.com

SELECT CONCAT(LEFT(first_name,1),LEFT(last_name,3),'@oracle.com') AS email
FROM Employees;
-- OR
SELECT CONCAT(LEFT(first_name,1),SUBSTRING(last_name,1,3),'@oracle.com') AS email
FROM Employees;

-- Using CONCAT():
-- a. Concatenate first name + last name.
-- b. Concatenate first name + last name + hire date.
SELECT CONCAT(first_name,' ',last_name) AS Full_Name
FROM Employees;
SELECT CONCAT(first_name,' ',last_name,' ',hire_date)AS EInfo
FROM Employees;

-- Display last names whose length is greater than 8.
SELECT last_name
FROM Employees 
WHERE length(last_name) > 8;

-- Using REPLACE():
-- a. Replace all occurrences of 515 with 815.
-- b. Replace the prefix 515 with 815.
SELECT  phone_number,REPLACE(phone_number,515,815) AS new_phone_no
FROM Employees;

-- Display:
-- first name
-- salary
-- salary after 12% raise
-- rounded salary after 12% raise
-- rounded-down salary after 12% 
SELECT  first_name,salary,salary + ((salary * 12)/100) as salary_raise,ROUND(salary + ((salary * 12)/100),2) AS rounded,FLOOR(salary + ((salary * 12)/100)) AS rounded_down
FROM Employees;
-- or short cut
SELECT first_name,
       salary,
       salary * 1.12 AS salary_raise,
       ROUND(salary * 1.12) AS rounded,
       FLOOR(salary * 1.12) AS rounded_down
FROM Employees;


-- Display first name, hire date, hire date − 10 days, hire date + 1 month and days since hiring.
SELECT first_name,hire_date, DATE_SUB(hire_date,INTERVAL 10 DAY) AS sub_hiredate,DATE_ADD(hire_date,INTERVAL 1 Month) AS added_hiredate,datediff(now(),hire_date) AS day_since_hired
FROM Employees;

-- Display first name, last name, hire date, months worked and years worked.
-- imp :month worked and years worked
SELECT first_name,last_name,hire_date,TIMESTAMPDIFF(MONTH,hire_date,CURDATE()) AS no_of_month_worked,TIMESTAMPDIFF(YEAR,hire_date,CURDATE()) AS no_of_year_worked
FROM Employees;

-- Display first name, hire date and hire date + 1 year.
SELECT first_name,hire_date,DATE_ADD(hire_date,INTERVAL 1 YEAR) AS updated_date
FROM Employees;

-- Display first name, hire date, hire date rounded to nearest year and nearest month.
-- SELECT first_name,hire_date, CEIL(year(hire_date))   
-- FROM Employees;                         -- recheck

-- Display first name, day of hire and year of hire.
SELECT first_name,DAY(hire_date) AS day_of_hire,YEAR(hire_date) AS year_of_hire
FROM Employees;

-- Display uppercase last name, formatted salary and formatted hire date for employees whose last name starts with D or K.
SELECT UPPER(last_name) AS last_name,
       FORMAT(salary, 2) AS salary,
       DATE_FORMAT(hire_date, '%d/%m/%Y') AS hire_date
FROM Employees
WHERE last_name LIKE 'D%'
   OR last_name LIKE 'K%';

-- HANDLE NULL VALUES IN SQL : coalesce()
-- Commission:
-- a. Replace NULL commission with 0.
-- b. Replace NULL commission with "No Commission".

SELECT commission_pct,ifnull(commission_pct,0) as replace_with_zero   -- commission_pct is numeric, so use numeric 0, not string '0':
FROM Employees;

SELECT commission_pct ,coalesce(commission_pct,'NO COMMISIION') AS replace_null
FROM Employees;

-- CASE
-- Create salary grades:
-- 0–5000 → A
-- 5001–15000 → B
-- 15001–20000 → C
-- Other → D

SELECT first_name,salary,
     CASE 
        WHEN salary BETWEEN 0 AND 5000 THEN 'A'
        WHEN salary BETWEEN 5001 AND 15000 THEN 'B'
        WHEN salary BETWEEN 15001 AND 20000 THEN 'C'
	    ELSE 
        'Other'
	END  AS salary_grades
FROM Employees;

