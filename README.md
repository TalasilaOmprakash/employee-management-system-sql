# employee-management-system-sql
📌 Employee Management System

A complete SQL-based relational database project that manages employee records, job roles, qualifications, leaves, salary structures, and payroll processing.

📖 Overview

The Employee Management System (EMS) is designed to demonstrate how organizations can efficiently manage employee details, job departments, salary structures, leave records, qualifications, and monthly payroll.
This project uses MySQL and follows a strong relational database structure with 6 fully validated tables and proper Primary Key – Foreign Key constraints.

The project also includes analysis queries to extract insights about employees, departments, salaries, leaves, and payroll.

📊 Database Structure
Tables Included

JobDepartment

SalaryBonus

Employee

Qualification

Leaves

Payroll

All relationships follow a 1-to-many model and ensure data integrity using constraints like:
✔ ON DELETE CASCADE
✔ ON UPDATE CASCADE
✔ SET NULL

🧩 ER Diagram

The ER diagram includes all 6 tables and their PK–FK relationships.
(Add your ER diagram screenshot here)

📁 Project Files

employee project.sql – Full analysis queries and insights 

employee project

employee table creating.sql – All table creation + data loading scripts 

employee table creating

PPT – Project explanation slides 

Employee Management System_ ppt

ER Model (.mwb) – MySQL Workbench diagram

🛠️ Features
✔ Employee Insights

Total employees

Department-wise employee counts

Top 5 highest-paid employees

Average salary per department

✔ Job Role & Department Analysis

Salary distribution

Job roles per department

Highest paying department

✔ Qualification Analysis

Count of employees with qualifications

Roles requiring most qualifications

Employees with highest skill count

✔ Leave & Absence Trends

Most active leave-taking year

Employees with maximum leave days

Department-wise average leaves

✔ Payroll Analysis

Monthly payroll amounts

Department-wise bonus distribution

Impact of leaves on payroll

📂 How to Run the Project
1️⃣ Import Database
create database emp_project;
use emp_project;

2️⃣ Run the Table Creation File

Execute employee table creating.sql to create all 6 tables.

3️⃣ Load Data

CSV files are loaded using:

LOAD DATA LOCAL INFILE 'path/to/file.csv'
INTO TABLE tableName
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

4️⃣ Run the Analysis Query File

Execute employee project.sql to generate insights.

📈 Key Insights

Strong understanding of relational database design

Use of JOINs, aggregate functions, and constraints

Ability to write efficient reporting queries

Hands-on experience with data cleaning, handling NULL values, and date formats

⚠️ Challenges Faced

Creating accurate PK–FK relationships

Maintaining consistency using cascading rules

Writing multi-table JOIN queries

Ensuring standardized date formats (YYYY-MM-DD)

Preventing duplicate employee email entries

✅ Conclusion

This project showcases how SQL can be used to build a clean, efficient, and scalable Employee Management System. It demonstrates expertise in relational database design, data analysis, constraint handling, and real-world HR data management.
