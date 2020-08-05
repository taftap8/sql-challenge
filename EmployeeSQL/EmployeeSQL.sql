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
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	PRIMARY KEY (emp_no,dept_no)
);

--create department/employee junciton table
CREATE TABLE dept_emp (
    emp_no INT NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
    dept_no VARCHAR NOT NULL,
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
	PRIMARY KEY (emp_no,dept_no)
	);

-- create salary table
CREATE TABLE salaries (
    emp_no INT   NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
    salary INT   NOT NULL
);

-- View Employee number, name, Sex, Salary and create view
CREATE VIEW employee_information AS
SELECT e.emp_no, e.first_name, e.last_name, e.sex, s.salary
FROM employees e
LEFT JOIN salaries s ON e.emp_no = s.emp_no;

--view employees hired before 1986
SELECT first_name, last_name, hire_date
FROM employees 
WHERE hire_date BETWEEN '1986-01-01' AND '1986-12-31';

SELECT *
From employees

---List manager of each department with department name, number, manager's employee number and name & create View
CREATE VIEW manager_departments AS
SELECT dd.dept_no, dd.dept_name, e.emp_no, e.first_name, e.last_name
FROM employees e
LEFT JOIN dept_manager d ON e.emp_no = d.emp_no
LEFT JOIN departments dd ON d.dept_no = dd.dept_no
ORDER BY dept_name;

--DROP VIEW manager_departments

---List employee of each department with employee number, employee name, & department name & create View
CREATE VIEW employee_departments AS
SELECT e.emp_no, e.first_name, e.last_name,dd.dept_name
FROM employees e
LEFT JOIN dept_emp d ON e.emp_no = d.emp_no
LEFT JOIN departments dd ON d.dept_no = dd.dept_no
ORDER BY dept_name;

--DROP VIEW employee_departments
--List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."
SELECT first_name, last_name, sex
FROM employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';

--Sales Department Employees
CREATE VIEW sales_department AS
SELECT e.emp_no, e.first_name, e.last_name,dd.dept_name
FROM employees e
LEFT JOIN dept_emp d ON e.emp_no = d.emp_no
LEFT JOIN departments dd ON d.dept_no = dd.dept_no
WHERE dd.dept_name = 'Sales'
ORDER BY dept_name;


--Sales and Development Department Employees
CREATE VIEW sales_development_department AS
SELECT e.emp_no, e.first_name, e.last_name,dd.dept_name
FROM employees e
LEFT JOIN dept_emp d ON e.emp_no = d.emp_no
LEFT JOIN departments dd ON d.dept_no = dd.dept_no
WHERE dd.dept_name = 'Sales' OR dd.dept_name = 'Development'
ORDER BY dept_name;

--count of unique last names, displayed in descendingorder

SELECT last_name, COUNT(last_name) AS last_count
FROM employees
GROUP BY last_name
ORDER BY last_name DESC;

--Had to check the given Employee ID - very funny
SELECT e.emp_no, e.first_name, e.last_name,s.salary, t.title
FROM employees e
LEFT JOIN salaries s ON e.emp_no = s.emp_no
LEFT JOIN titles t ON e.emp_title_id = t.title_id
WHERE e.emp_no = 499942
ORDER BY t.title;
