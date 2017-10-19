#1
DELIMITER $$
CREATE FUNCTION ufn_count_employees_by_town(town_name VARCHAR(20))
RETURNS DOUBLE
BEGIN
	DECLARE e_count DOUBLE;
	SET e_count := (SELECT COUNT(e.employee_id) FROM employees AS e
	INNER JOIN addresses AS a ON e.address_id = a.address_id
	INNER JOIN towns AS t ON a.town_id = t.town_id
	WHERE t.name = town_name);
	RETURN e_count;
END $$

#2
DELIMITER $$
CREATE PROCEDURE usp_raise_salaries(department_name VARCHAR(50)) 
BEGIN
	UPDATE employees AS e 
	INNER JOIN departments AS d ON d.department_id = e.department_id
	SET e.salary = e.salary * 1.05
	WHERE d.name = department_name;
END $$

#3
DELIMITER $$
CREATE PROCEDURE usp_raise_salary_by_id(id INT)
BEGIN
	START TRANSACTION;
	IF((SELECT COUNT(employee_id) FROM employees WHERE employee_id LIKE id)<>1) THEN
		ROLLBACK;
	ELSE
		UPDATE employees AS e SET salary = salary * 1.05 
		WHERE e.employee_id = id;
	END IF; 
END $$

#4
CREATE TABLE deleted_employees(
	employee_id int primary key auto_increment,
	first_name varchar(20),
	last_name varchar(20),
	middle_name varchar(20),
	job_title varchar(50),
	department_id int,
	salary double 
);

DELIMITER $$
CREATE TRIGGER tr_deleted_employees
AFTER DELETE 
ON employees
FOR EACH ROW
BEGIN
	INSERT INTO deleted_employees (first_name, last_name, middle_name, job_title, department_id, salary)
	VALUES(old.first_name, old.last_name, old.middle_name, old.job_title, old.department_id, old.salary);
END $$