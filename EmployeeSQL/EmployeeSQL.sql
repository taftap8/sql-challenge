--drop tables
DROP TABLE dept_emp
DROP TABLE dept_manager
DROP TABLE titles
DROP TABLE employees
DROP TABLE salaries
DROP TABLE departments

-- create Titles Table
CREATE TABLE titles (
    title_id VARCHAR PRIMARY KEY,
    title VARCHAR   NOT NULL
    );

--Create Employees Table and reference Titles
CREATE TABLE employees (
    emp_no INT PRIMARY KEY,
	emp_title_id VARCHAR NOT NULL,
    FOREIGN KEY (emp_title_id) REFERENCES titles(title_id),
    birth_date DATE   NOT NULL,
    first_name VARCHAR   NOT NULL,
    last_name VARCHAR   NOT NULL,
    sex VARCHAR   NOT NULL,
    hire_date DATE   NOT NULL
);

--create department table
CREATE TABLE departments (
    dept_no VARCHAR  PRIMARY KEY,
    dept_name VARCHAR   NOT NULL
     );
	 
-- create Department/Manager junction table
CREATE TABLE dept_manager (
    dept_no VARCHAR NOT NULL,
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
    emp_no INT NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);

--create department/employee junciton table
CREATE TABLE dept_emp (
    emp_no INT NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
    dept_no VARCHAR NOT NULL,
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
);

-- create salary table
CREATE TABLE salaries (
    emp_no INT   NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
    salary INT   NOT NULL
);

SELECT *
FROM dept_emp