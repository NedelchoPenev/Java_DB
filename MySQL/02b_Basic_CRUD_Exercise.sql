#2
SELECT * FROM departments
ORDER BY department_id;

#3
SELECT name FROM departments
ORDER BY department_id;

#4
SELECT first_name, last_name, salary FROM employees AS e
ORDER BY e.employee_id;

#5
SELECT first_name, middle_name, last_name FROM employees AS e
ORDER BY e.employee_id;

#6
SELECT concat(first_name, '.', last_name, '@softuni.bg') AS `full_email_address` FROM employees;

#7
SELECT DISTINCT salary FROM employees AS e
ORDER BY e.salary;

#8
SELECT * FROM employees AS e
WHERE e.job_title = 'Sales Representative';

#9
SELECT first_name, last_name, job_title FROM employees AS e
WHERE salary >= 20000 AND salary <= 30000
ORDER BY e.employee_id;

#10
SELECT concat(first_name, ' ', middle_name, ' ', last_name) AS `full_name` FROM employees
WHERE salary in(25000, 14000, 12500, 23600);

#11
SELECT first_name, last_name FROM employees
WHERE manager_id IS NULL;

#12
SELECT first_name, last_name, salary FROM employees
WHERE salary > 50000 ORDER BY salary DESC;

#13
SELECT first_name, last_name FROM employees
ORDER BY salary DESC LIMIT 5;

#14
SELECT first_name, last_name FROM employees
WHERE department_id != 4;

#15
SELECT * FROM employees
ORDER BY salary DESC, first_name, last_name DESC, middle_name;

#16
CREATE VIEW `v_employees_salaries` AS
	SELECT first_name, last_name, salary FROM employees;
SELECT * FROM v_employees_salaries;

#17
CREATE VIEW `v_employees_job_titles` AS 
	SELECT concat(first_name, ' ', if(middle_name IS NULL, '', middle_name), ' ', last_name) 
	AS full_name, job_title FROM employees;
SELECT * FROM v_employees_job_titles;

#18
SELECT DISTINCT job_title FROM employees

#19
SELECT * FROM projects
ORDER BY start_date, name LIMIT 10;

#20 
SELECT first_name, last_name, hire_date FROM employees
ORDER BY hire_date DESC LIMIT 7;

#21
UPDATE employees 
SET salary = salary*1.12
WHERE department_id in(1, 2, 4, 11);
SELECT salary FROM employees;

#22
SELECT peak_name FROM peaks
ORDER BY peak_name;

#23
SELECT country_name, population FROM countries
WHERE continent_code = 'EU'
ORDER BY population DESC, country_name LIMIT 30;

#24
SELECT country_name, country_code, if(currency_code != 'EUR', 'Not Euro', 'Euro') AS currency FROM countries
ORDER BY country_name;

#25
SELECT name FROM characters
ORDER BY name;
