CREATE TABLE Departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50),
    location VARCHAR(50)
);

CREATE TABLE Employees (
    employee_id INT PRIMARY KEY,
    name VARCHAR(50),
    dob DATE,
    department_id INT,
    salary DECIMAL(10,2),
    FOREIGN KEY (department_id) REFERENCES Departments(department_id)
);

CREATE TABLE Projects (
    project_id INT PRIMARY KEY,
    project_name VARCHAR(50),
    start_date DATE,
    end_date DATE
);

CREATE TABLE Timesheets (
    timesheet_id INT PRIMARY KEY,
    employee_id INT,
    project_id INT,
    work_date DATE,
    hours_worked DECIMAL(2),
    FOREIGN KEY (employee_id) REFERENCES Employees(employee_id),
    FOREIGN KEY (project_id) REFERENCES Projects(project_id)
);

CREATE TABLE WorkReports (
    report_id INT PRIMARY KEY,
    employee_id INT,
    report_date DATE,
    report_content TEXT,
    FOREIGN KEY (employee_id) REFERENCES Employees(employee_id)
);

INSERT INTO Departments VALUES
(1, 'IT Department', 'Floor 3'),
(2, 'HR Department', 'Floor 2');

INSERT INTO Employees VALUES
(1, 'John Doe', '1990-05-15', 1, 5000.00),
(2, 'Jane Smith', '1988-03-20', 2, 4500.00);

INSERT INTO Projects VALUES
(1, 'Website Development', '2024-01-01', '2024-06-30'),
(2, 'HR System', '2024-02-01', '2024-12-31');

INSERT INTO Timesheets VALUES
(1, 1, 1, '2024-02-01', 8),
(2, 2, 2, '2024-02-01', 7);

INSERT INTO WorkReports VALUES
(1, 1, '2024-02-01', 'Completed frontend development'),
(2, 2, '2024-02-01', 'Updated employee policies');

UPDATE Projects 
SET end_date = '2024-08-31' 
WHERE project_id = 1;

DELETE FROM Employees 
WHERE employee_id = 2;