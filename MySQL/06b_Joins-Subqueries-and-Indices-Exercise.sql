#1
SELECT e.first_name, e.last_name, e.address_id, a.address_text
FROM employees AS e 
JOIN addresses AS a ON e.address_id = a.address_id
ORDER BY a.address_id LIMIT 5;

#2
SELECT e.first_name, e.last_name, t.name, a.address_text
FROM employees AS e 
INNER JOIN addresses AS a ON e.address_id = a.address_id
INNER JOIN towns as t ON  t.town_id = a.town_id
ORDER BY e.first_name, e.last_name LIMIT 5;

#3
SELECT e.employee_id, e.first_name, e.last_name, d.name
FROM employees AS e
LEFT JOIN departments AS d ON d.department_id = e.department_id
WHERE d.name = "Sales"
ORDER BY e.employee_id DESC;

#4
SELECT e.employee_id, e.first_name, e.salary, d.name AS 'department_name' FROM employees AS e
INNER JOIN departments AS d
ON e.department_id = d.department_id
WHERE e.salary >= 15000
ORDER BY d.department_id DESC
LIMIT 5;

#5
SELECT e.employee_id, e.first_name FROM employees AS e 
LEFT JOIN employees_projects AS p ON e.employee_id = p.employee_id
WHERE p.project_id IS NULL
ORDER BY e.employee_id DESC LIMIT 3;

#6
SELECt e.first_name, e.last_name, e.hire_date, d.name 
FROM employees AS e 
INNER JOIN departments AS d 
ON e.department_id = d.department_id
AND date(e.hire_date) > '1999-01-01' 
WHERE d.name in ("Finance","Sales")
ORDER BY e.hire_date;

#7
SELECT e.employee_id, e.first_name, p.name
FROM employees AS e 
INNER JOIN employees_projects AS ep ON ep.employee_id = e.employee_id
INNER JOIN projects AS p ON p.project_id = ep.project_id
AND date(p.start_date) > '2002-08-13' AND date(p.end_date) IS NULL
ORDER BY e.first_name, p.name LIMIT 5;

#8
SELECT e.employee_id, e.first_name, 
CASE WHEN date(p.start_date) >= '2005-01-01' THEN NULL
ELSE p.name END
FROM employees AS e 
INNER JOIN employees_projects AS ep ON ep.employee_id = e.employee_id
INNER JOIN projects AS p ON p.project_id = ep.project_id
AND e.employee_id = 24
ORDER BY p.name;

#9
SELECT e.employee_id, e.first_name, e.manager_id, m.first_name AS manager_name FROM employees AS e
LEFT JOIN employees AS m ON m.employee_id = e.manager_id
WHERE m.employee_id IN(3, 7)
ORDER BY e.first_name;

#10
SELECT e.employee_id, CONCAT(e.first_name, ' ', e.last_name) AS employee_name, 
CONCAT(m.first_name, ' ', m.last_name) AS manager_name, d.name FROM employees AS e
INNER JOIN employees AS m ON m.employee_id = e.manager_id
JOIN departments AS d ON e.department_id = d.department_id 
ORDER BY e.employee_id LIMIT 5;

#11
SELECT AVG(e.salary) AS min_average_salary FROM employees AS e
GROUP BY e.department_id
ORDER BY min_average_salary LIMIT 1;

#12
SELECT c.country_code, m.mountain_range, p.peak_name, p.elevation FROM countries AS c
JOIN mountains_countries AS mc ON c.country_code = mc.country_code
JOIN mountains AS m ON mc.mountain_id = m.id
JOIN peaks AS p ON m.id = p.mountain_id
WHERE c.country_code = 'BG' AND p.elevation > 2835
ORDER BY p.elevation DESC;

#13
SELECT c.country_code, COUNT(mc.country_code) AS mountain_range 
FROM countries AS c
JOIN mountains_countries AS mc ON c.country_code = mc.country_code
WHERE c.country_code IN('BG', 'US', 'RU')
GROUP BY c.country_code
ORDER BY mountain_range DESC;

#14
SELECT c.country_name, r.river_name FROM countries AS c
LEFT JOIN countries_rivers AS cr ON c.country_code = cr.country_code
LEFT JOIN rivers AS r ON cr.river_id = r.id
WHERE c.continent_code = 'AF'
ORDER BY c.country_name LIMIT 5;

#15
SELECT t1.continent_code,t1.currency_code, t1.currency_usage  FROM 
(SELECT c.continent_code AS continent_code, b.currency_code AS currency_code,
COUNT(b.currency_code) AS currency_usage
FROM continents AS c
JOIN countries AS b ON c.continent_code = b.continent_code
JOIN currencies AS a ON a.currency_code = b.currency_code
GROUP BY c.continent_code,b.currency_code
HAVING currency_usage>1) AS t1
INNER JOIN 
(SELECT sub.continent_code AS code, MAX(currency_usage) AS max_u
FROM
(SELECT c.continent_code AS continent_code,b.currency_code 
AS currency_code,count(b.currency_code) AS currency_usage
FROM continents AS c
JOIN countries AS b ON c.continent_code = b.continent_code
JOIN currencies AS a ON a.currency_code = b.currency_code
GROUP BY c.continent_code,b.currency_code
HAVING currency_usage>1) as sub
GROUP BY code) AS t2 ON t1.continent_code = t2.code
WHERE t1.currency_usage = t2.max_u; 

#16
SELECT COUNT(*) AS country_count
FROM countries AS c
LEFT JOIN mountains_countries AS mc ON c.country_code = mc.country_code
WHERE mc.country_code IS NULL

#17
SELECT c.country_name, MAX(p.elevation), MAX(r.length) AS highest_peak_elevation 
FROM countries AS c
LEFT JOIN mountains_countries AS mc ON c.country_code = mc.country_code
LEFT JOIN mountains AS m ON mc.mountain_id = m.id
LEFT JOIN peaks AS p ON m.id = p.mountain_id
LEFT JOIN countries_rivers AS cr ON c.country_code = cr.country_code
LEFT JOIN rivers AS r ON cr.river_id = r.id
GROUP BY c.country_name
ORDER BY p.elevation DESC, r.length DESC, c.country_name
LIMIT 5;