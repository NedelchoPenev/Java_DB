#1
SELECT id, first_name, last_name, job_title FROM employees
ORDER BY id;

#2
SELECT id, concat(first_name, ' ', last_name) AS `full_name`, job_title, salary FROM employees
WHERE salary > 1000
ORDER BY id;

#3
UPDATE employees
SET salary = salary + salary * 0.1 WHERE job_title = 'Therapist';
SELECT salary FROM employees
ORDER BY salary;

#4
CREATE VIEW v_top_paid AS 
	SELECT * FROM employees 
	ORDER BY salary DESC LIMIT 1;
SELECT * FROM v_top_paid;

#5
SELECT * FROM employees
WHERE salary >= 1600 AND department_id = 4
ORDER BY id;

#6 
DELETE FROM employees
WHERE department_id = 1 OR department_id = 2
ORDER BY id;
SELECT * FROM employees;