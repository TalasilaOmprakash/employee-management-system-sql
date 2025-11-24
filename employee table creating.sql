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
