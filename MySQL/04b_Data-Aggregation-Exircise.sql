#1
SELECT COUNT(id) AS `count` FROM wizzard_deposits;

#2
SELECT MAX(magic_wand_size) AS `longest_magic_wand` FROM wizzard_deposits;

#3
SELECT deposit_group, MAX(magic_wand_size) AS `longest_magic_wand` FROM wizzard_deposits
GROUP BY deposit_group
ORDER BY `longest_magic_wand`, deposit_group;

#4
SELECT deposit_group FROM wizzard_deposits
GROUP BY deposit_group
ORDER BY AVG(magic_wand_size) LIMIT 1;

#5
SELECT deposit_group, SUM(deposit_amount) AS `total_sum` FROM wizzard_deposits
GROUP BY deposit_group
ORDER BY `total_sum`;

#6
SELECT deposit_group, SUM(deposit_amount) AS `total_sum` FROM wizzard_deposits
WHERE magic_wand_creator = 'Ollivander family'
GROUP BY deposit_group
ORDER BY deposit_group; 

#7
SELECT deposit_group, SUM(deposit_amount) AS `total_sum` FROM wizzard_deposits
WHERE magic_wand_creator = 'Ollivander family'
GROUP BY deposit_group
HAVING `total_sum` < 150000
ORDER BY `total_sum` DESC;

#8
SELECT deposit_group, magic_wand_creator, MIN(deposit_charge) AS min_deposit_charge FROM wizzard_deposits
GROUP BY magic_wand_creator, deposit_group;

#9
SELECT a.age_group, COUNT(*) AS `wizard_count` FROM
(SELECT
	CASE
		WHEN wd.age BETWEEN 0 AND 10 THEN '[0-10]'
		WHEN wd.age BETWEEN 11 AND 20 THEN '[11-20]'			
		WHEN wd.age BETWEEN 21 AND 30 THEN '[21-30]'
		WHEN wd.age BETWEEN 31 AND 40 THEN '[31-40]'
		WHEN wd.age BETWEEN 41 AND 50 THEN '[41-50]'
		WHEN wd.age BETWEEN 51 AND 60 THEN '[51-60]'
		ELSE '[61+]'
	END AS `age_group`
	
		FROM `wizzard_deposits` AS `wd`) AS `a`
		GROUP BY a.age_group;
		
#10
SELECT SUBSTRING(first_name, 1, 1) AS first_letter FROM wizzard_deposits
WHERE deposit_group = 'Troll Chest'
GROUP BY first_letter
ORDER BY first_letter;

#11
SELECT deposit_group, is_deposit_expired, AVG(deposit_interest) AS `average_interest` FROM wizzard_deposits
WHERE deposit_start_date > '1985-01-01'
GROUP BY deposit_group, is_deposit_expired
ORDER BY deposit_group DESC, is_deposit_expired;

#12
SELECT SUM(diff.next) AS sum_difference
FROM (
   SELECT deposit_amount - 
			  (SELECT deposit_amount 
			     FROM wizzard_deposits 
			    WHERE id = wd.id + 1) AS next   
     FROM wizzard_deposits as wd) AS diff
     
#13
SELECT department_id, MIN(salary) AS minimum_salary FROM employees
WHERE department_id IN(2, 5, 7) AND hire_date > '2000-01-01'
GROUP BY department_id;

#14
CREATE TABLE newtable SELECT * FROM employees 
WHERE salary > 30000;
DELETE FROM newtable
WHERE manager_id = 42;
UPDATE newtable
SET salary = salary + 5000
WHERE department_id = 1;
SELECT department_id, AVG(salary) AS avg_salary FROM newtable
GROUP BY department_id;

#15
SELECT department_id, MAX(salary) AS max_salary FROM employees
GROUP BY department_id
HAVING MAX(salary) < 30000 OR MAX(salary) > 70000;

#16
SELECT COUNT(*) FROM employees
WHERE manager_id IS NULL;

#17
SELECT t.department_id, t.third_highest_salary FROM
(
	SELECT department_id, 
		(
			SELECT DISTINCT salary FROM employees AS e2
			WHERE e1.department_id = e2.department_id
			ORDER BY salary DESC
			LIMIT 2, 1
		) AS third_highest_salary FROM employees AS e1
) AS t
WHERE third_highest_salary IS NOT NULL
GROUP BY department_id;

#18
SELECT e.first_name, e.last_name, e.department_id FROM employees AS e,
(SELECT e.department_id, AVG(e.salary) AS avg_salary FROM employees AS e GROUP BY e.department_id) AS e1
WHERE e.department_id = e1.department_id AND e.salary > e1.avg_salary
ORDER BY department_id LIMIT 10;


#19
SELECT department_id, SUM(salary) AS total_salary FROM employees
GROUP BY department_id;
