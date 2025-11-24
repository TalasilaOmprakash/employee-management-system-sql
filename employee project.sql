-- creating database for project
create database emp_project;
use emp_project;

-- 1.creating table_1 Job Department
create table JobDepartment(
Job_ID INT primary key,
jobdept varchar(50),
name varchar(100),
description TEXT,
salaryrange varchar(50)
);
-- loading data into  table JobDepartment

LOAD DATA LOCAL INFILE 'C:/Users/ompra/Downloads/Employees_data-20251121T174613Z-1-001/Employees_data/JobDepartment.csv'
INTO TABLE JobDepartment
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(Job_ID, jobdept, name, description, salaryrange);
select * from JobDepartment;

-- Table 2: Salary/Bonus 
CREATE TABLE SalaryBonus ( 
    salary_ID INT PRIMARY KEY, 
    Job_ID INT, 
    amount DECIMAL(10,2), 
    annual DECIMAL(10,2), 
    bonus DECIMAL(10,2), 
    CONSTRAINT fk_salary_job FOREIGN KEY (job_ID) REFERENCES JobDepartment(Job_ID) 
        ON DELETE CASCADE ON UPDATE CASCADE 
);
-- loading data into  table SalaryBonus
LOAD DATA LOCAL INFILE 'C:/Users/ompra/Downloads/Employees_data-20251121T174613Z-1-001/Employees_data/Salary_Bonus.csv'
INTO TABLE SalaryBonus
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(Salary_ID, Job_ID, Amount, Annual, Bonus);
select * from SalaryBonus;

-- Table 3: Employee 
CREATE TABLE Employee ( 
    emp_ID INT PRIMARY KEY, 
    firstname VARCHAR(50), 
    lastname VARCHAR(50), 
    gender VARCHAR(10), 
    age INT, 
    contact_add VARCHAR(100), 
    emp_email VARCHAR(100) UNIQUE, 
    emp_pass VARCHAR(50), 
    Job_ID INT, 
    CONSTRAINT fk_employee_job FOREIGN KEY (Job_ID) 
        REFERENCES JobDepartment(Job_ID) 
        ON DELETE SET NULL 
        ON UPDATE CASCADE 
);
-- loading data into  table Employee
LOAD DATA LOCAL INFILE 'C:/Users/ompra/Downloads/Employees_data-20251121T174613Z-1-001/Employees_data/Employee.csv'
INTO TABLE Employee
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(emp_ID, firstname, lastname, gender, age, contact_add, emp_email, emp_pass, Job_ID);
select * from employee;

-- Table 4: Qualification 
CREATE TABLE Qualification ( 
    QualID INT PRIMARY KEY, 
    Emp_ID INT, 
    Position VARCHAR(50), 
    Requirements VARCHAR(255), 
    Date_In DATE, 
    CONSTRAINT fk_qualification_emp FOREIGN KEY (Emp_ID) 
        REFERENCES Employee(emp_ID) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE 
);
-- loading data into table Qualification
LOAD DATA LOCAL INFILE 'C:/Users/ompra/Downloads/Employees_data-20251121T174613Z-1-001/Employees_data/Qualification.csv'
INTO TABLE Qualification
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(QualID, Emp_ID, Position, Requirements, Date_In);
select * from Qualification;

-- Table 5: Leaves 
CREATE TABLE Leaves ( 
    leave_ID INT PRIMARY KEY, 
    emp_ID INT, 
    date DATE, 
    reason TEXT, 
    CONSTRAINT fk_leave_emp FOREIGN KEY (emp_ID) REFERENCES Employee(emp_ID) 
        ON DELETE CASCADE ON UPDATE CASCADE 
);
-- loading data into table Leaves
 LOAD DATA LOCAL INFILE 'C:/Users/ompra/Downloads/Employees_data-20251121T174613Z-1-001/Employees_data/Leaves.csv'
INTO TABLE Leaves
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(leave_ID, emp_ID, date, reason);
select * from Leaves;

-- Table 6: Payroll 
CREATE TABLE Payroll ( 
    payroll_ID INT PRIMARY KEY, 
    emp_ID INT, 
    job_ID INT, 
    salary_ID INT, 
    leave_ID INT, 
    date DATE, 
    report TEXT, 
    total_amount DECIMAL(10,2), 
    CONSTRAINT fk_payroll_emp FOREIGN KEY (emp_ID) REFERENCES Employee(emp_ID) 
        ON DELETE CASCADE ON UPDATE CASCADE, 
    CONSTRAINT fk_payroll_job FOREIGN KEY (job_ID) REFERENCES JobDepartment(job_ID) 
        ON DELETE CASCADE ON UPDATE CASCADE, 
    CONSTRAINT fk_payroll_salary FOREIGN KEY (salary_ID) REFERENCES SalaryBonus(salary_ID) 
        ON DELETE CASCADE ON UPDATE CASCADE, 
    CONSTRAINT fk_payroll_leave FOREIGN KEY (leave_ID) REFERENCES Leaves(leave_ID) 
        ON DELETE SET NULL ON UPDATE CASCADE 
);
-- loading data into table Payroll
LOAD DATA LOCAL INFILE 'C:/Users/ompra/Downloads/Employees_data-20251121T174613Z-1-001/Employees_data/Payroll.csv'
INTO TABLE Payroll
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(payroll_ID, emp_ID, job_ID, salary_ID, leave_ID, date, report, total_amount);
select * from Payroll;

-- Analysis Questions 
-- 1. EMPLOYEE INSIGHTS 

-- How many unique employees are currently in the system? 
 select count(distinct emp_id)as Total_employees
 from EMPLOYEE;
 
-- Which departments have the highest number of employees? 
select JD.jobdept as department,
count(E.emp_id) as employee_count
from employee E 
join jobdepartment JD on E.Job_ID = JD.Job_ID
Group By JD.jobdept
order by employee_count desc;

-- What is the average salary per department? 
select JD.jobdept as department,
AVG(SB.amount) as avg_salary
from jobdepartment JD
join salarybonus SB on JD.job_id = SB.job_id
Group by JD.jobdept
order by avg_salary desc;

-- Who are the top 5 highest-paid employees? 
select E.firstname, E.lastname,
SB.amount as salary
from employee E
join SalaryBonus SB on E.job_id = SB.job_id
order by sb.amount desc
limit 5;

-- What is the total salary expenditure across the company?
select SUM(SB.amount) as total_salary_expenditure
from salarybonus sb;

-- 2. JOB ROLE AND DEPARTMENT ANALYSIS 

-- How many different job roles exist in each department? 
 select jobdept as department,
 count(job_id) as total_job_roles
 from jobdepartment
 group by jobdept
 order by total_job_roles desc;

-- What is the average salary range per department? 
select JD.jobdept as department,
avg(SB.amount) as avg_salary
from jobdepartment JD
join salarybonus sb on jd.job_id = sb.Job_ID
group by jd.jobdept
order by avg_salary desc;

-- Which job roles offer the highest salary? 
select jd.jobdept,
jd.name as job_role,
sb.amount as salary
from jobdepartment jd
join salarybonus sb on jd.Job_ID = sb.job_id
order by sb.amount desc; 

-- Which departments have the highest total salary allocation?
select jd.jobdept as department,
sum(sb.amount) as total_salary_allocation
from jobdepartment jd
join salarybonus sb on jd.job_id = sb.Job_ID
group by jd.jobdept
order by total_salary_allocation desc;

-- 3. QUALIFICATION AND SKILLS ANALYSIS 

-- How many employees have at least one qualification listed? 
 select count(distinct Emp_id) as Employees_with_qualification
 from qualification;

-- Which positions require the most qualifications? 
SELECT Position,
       COUNT(*) AS qualification_record_count
FROM Qualification
GROUP BY Position
ORDER BY qualification_record_count DESC;

-- Which employees have the highest number of qualifications?
SELECT E.emp_ID,
       E.firstname,
       E.lastname,
       COUNT(Q.QualID) AS num_qualifications
FROM Employee E
JOIN Qualification Q ON E.emp_ID = Q.Emp_ID
GROUP BY E.emp_ID, E.firstname, E.lastname
ORDER BY num_qualifications DESC
LIMIT 10;

-- 4. LEAVE AND ABSENCE PATTERNS 

-- Which year had the most employees taking leaves? 
select year(date) as leave_year,
count(DISTINCT emp_id) as employees_took_leave
from leaves
group by year(date)
order by employees_took_leave desc;

-- What is the average number of leave days taken by its employees per department? 
 select jd.jobdept as department,
 avg(leave_count) as avg_leave_days
 from(
 select E.emp_id, count(L.Leave_id) as leave_count
 from employee E
left join leaves L on E.emp_id = L.emp_id
group by E.emp_id
) as emp_leave
join Employee E ON emp_leave.emp_id = E.emp_id
join jobdepartment jd on e.job_id = jd.job_id
group by jd.jobdept;

-- Which employees have taken the most leaves? 
select E.emp_id,
E.firstname,
E.lastname,
count(L.leave_id) as total_leaves
from Employee E 
join leaves L on E.emp_id = L.emp_id
group by e.emp_id, E.firstname, E.lastname
order by total_leaves desc;

-- What is the total number of leave days taken company-wide? 
select count(*) as total_leave_days
from leaves;

-- How do leave days correlate with payroll amounts?
select p.emp_id,
count(L.leave_id) as total_leaves,
sum(p.total_amount) as total_payroll_amount
from payroll p 
left join leaves L on p.leave_id = l.leave_id
group by p.emp_id
order by total_leaves desc;
-- This gives insight such as:
-- Employees with more leave → may have reduced payroll
-- Employees with fewer leaves → higher payroll amount

-- 5. PAYROLL AND COMPENSATION ANALYSIS 

-- What is the total monthly payroll processed? 
 select Year(date) AS year,
 month(date) AS month,
sum(total_amount) AS total_monthly_payroll
From Payroll
group by year(date), month(date)
order by year, month;

-- What is the average bonus given per department? 
select jd.jobdept as department,
avg(sb.bonus) as avg_bonus
from jobdepartment jd
join salarybonus sb on jd.Job_ID = sb.Job_ID
group by jd.jobdept
order by avg_bonus desc;
-- Which department receives the highest total bonuses? 
select jd.jobdept as department,
sum(sb.bonus) AS total_bonus
from jobdepartment jd
join salarybonus sb on jd.job_id = sb.job_id
group by jd.jobdept
order by total_bonus desc
limit 1;

-- What is the average value of total_amount after considering leave deductions? 
SELECT JD.jobdept AS department,
       AVG(P.total_amount) AS avg_final_pay
FROM Payroll P
JOIN Employee E ON P.emp_ID = E.emp_ID
JOIN JobDepartment JD ON E.Job_ID = JD.Job_ID
GROUP BY JD.jobdept;

-- Challenges in the Employee Management System Project.
-- 1. Defining correct table relationships and ensuring accurate use of foreign keys

-- Designing the right relationships between tables such as Employee, JobDepartment, SalaryBonus, Leaves, Qualification, and Payroll is challenging because each table depends on another.
-- Choosing the correct primary keys, foreign keys, and the right ON DELETE / ON UPDATE rules is essential to maintain proper data flow across modules.

-- 2. Maintaining data consistency with cascading updates and deletes

-- Using constraints like ON DELETE CASCADE, ON UPDATE CASCADE, and SET NULL requires careful planning.
-- A small mistake can lead to accidental deletion of multiple related records or inconsistent data across tables.
-- Ensuring that dependent data updates automatically without breaking relationships is a key challenge.

-- 3. Writing complex joins for reports involving employee roles, leaves, and payroll

-- Reports such as payroll calculations, leave trends, department-wise salaries, and employee insights require joining multiple tables.
-- Queries often include 3–5 table joins, which can become complex and error-prone.
-- Ensuring accuracy while combining data from Employee → JobDepartment → SalaryBonus → Leaves → Payroll is a major challenge.

-- 4. Ensuring all date fields follow the YYYY-MM-DD format for reliable time-based analysis

-- Time-based analysis such as monthly payroll, yearly leave trends, or qualification history requires a consistent date format.
-- If the date format is incorrect or inconsistent, SQL functions like YEAR(), MONTH(), and sorting fail or produce wrong results.
-- Ensuring clean and standardized date values throughout the system is crucial.

-- 5. Preventing duplicate entries using unique constraints, especially on email fields

-- Employee emails must be unique, but without proper UNIQUE constraints, duplicate records can be inserted.
-- Duplicates create major issues in authentication, payroll processing, and employee identification.
-- Enforcing uniqueness requires thoughtful schema design and validation at both database and application levels.