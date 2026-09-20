# HR SQL Case Study

## Overview

A completed SQL case study based on an HR database, focusing on employee, department, job, salary, manager, and location analysis using MySQL.

## Project Objectives

* Analyze employee information using SQL queries and filtering techniques.
* Retrieve and organize employee data based on departments, salaries, job roles, and other conditions.
* Perform salary analysis using aggregate and numeric functions.
* Analyze department-wise employee and salary information using `GROUP BY` and `HAVING`.
* Use subqueries to solve multi-level business problems.
* Apply correlated subqueries to perform comparisons within departments.
* Understand and implement different types of SQL joins.
* Analyze manager–employee relationships using SELF JOIN.
* Connect information across departments, jobs, locations, countries, and regions.
* Solve practical HR business problems such as average salary, highest salary, second-highest salary, and department-level comparisons.
* Strengthen SQL problem-solving and query-writing skills through a structured case study.

## Original Case Study Author

**Andrei N. CIOBANU**

The original case study allows the work to be copied, modified, distributed, and performed, including for commercial purposes, without requesting permission.

## Database Details

**Database:** HR Database

### Main Tables

* **Employees** — Employee personal, salary, job, manager, and department information
* **Departments** — Department names, managers, and locations
* **Jobs** — Job titles and salary ranges
* **Job_History** — Historical employee job and department records
* **Locations** — Office locations and cities
* **Countries** — Country information
* **Regions** — Regional information

### Database Relationships

The database connects employees with their departments, jobs, managers, and locations. Departments are connected to locations, which connect to countries and regions. Employee-manager relationships are handled through a self-reference in the Employees table.

## SQL Concepts Covered

* Basic SELECT and Filtering
* WHERE Clause
* Scalar and Numeric Functions
* GROUP BY
* GROUP BY with HAVING
* Subqueries
* Nested Subqueries
* Correlated Subqueries
* INNER JOIN
* OUTER JOIN
* SELF JOIN
* CROSS JOIN
* Aggregate Functions
* Salary and Employee Analysis

## Key Analysis

* Employee and department filtering
* Salary comparisons
* Department-wise salary analysis
* Average, minimum, and maximum salary analysis
* Manager–employee relationships
* Second-highest salary
* Highest salary within each department
* Location and department analysis

## Setup

1. Install **MySQL** and **MySQL Workbench**.
2. Create the HR database.
3. Create the required tables.
4. Load the HR dataset.
5. Run the SQL practice files.

## Tools & Technologies

* MySQL
* MySQL Workbench
* SQL

## Casestudy Structure
HR-SQL-Case-Study/
│
├── 01_hr-schema-mysql.sql
├── 02_Basic_EDA.sql
├── 03_Basic_Analysis.sql
├── 04_Advanced_Analysis.sql
│
└── README.md

## Author

**Saniya Godikat**

SQL Practice & Analysis
