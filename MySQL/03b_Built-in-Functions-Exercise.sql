#1
SELECT first_name, last_name FROM employees
WHERE first_name LIKE 'Sa%';

#2
SELECT first_name, last_name FROM employees
WHERE last_name LIKE '%ei%';

#3
SELECT first_name FROM employees
WHERE department_id in(3, 10) AND YEAR(hire_date) BETWEEN 1995 and 2005;

#4
SELECT first_name, last_name FROM employees
WHERE job_title not LIKE '%engineer%';

#5
SELECT name FROM towns
WHERE char_length(name) = 5 || char_length(name) = 6
ORDER BY name;

#6
SELECT * FROM towns
WHERE name LIKE 'M%'OR name LIKE 'K%'OR name LIKE 'B%'OR name LIKE 'E%'
ORDER BY name;

#7
SELECT * FROM towns
WHERE name NOT LIKE 'R%' AND name NOT LIKE 'B%' AND name NOT LIKE 'D%'
ORDER BY name;

#8
CREATE VIEW `v_employees_hired_after_2000` AS
	SELECT first_name, last_name FROM employees
	WHERE YEAR(hire_date) > 2000;
	
#9
SELECT first_name, last_name FROM employees
WHERE char_length(last_name) = 5;

#10
SELECT country_name, iso_code FROM countries
WHERE country_name LIKE '%a%a%a%'
ORDER BY iso_code;

#11
SELECT peak_name, river_name, concat(lower(peak_name), substring(lower(river_name), 2)) AS mix FROM peaks, rivers
WHERE SUBSTRING(peak_name, char_length(peak_name)) = SUBSTRING(river_name, 1, 1)
ORDER BY mix;

#12
SELECT name, DATE_FORMAT(start, '%Y-%m-%d') AS `start` FROM games
WHERE YEAR(`start`) >= 2011 AND YEAR(`start`) <= 2012
ORDER BY `start` LIMIT 50;

#13
SELECT user_name, substring(email, locate('@', email) + 1) AS `Email Provider` FROM users
ORDER BY `Email Provider`, user_name;

#14
SELECT user_name, ip_address FROM users
WHERE ip_address LIKE '___.1%.%.___'
ORDER BY user_name;

#15
SELECT name AS 'game',
CASE 
WHEN HOUR(`start`) BETWEEN 0 and 11 THEN 'Morning'
WHEN HOUR(`start`) BETWEEN 12 and 17 THEN 'Afternoon'
WHEN HOUR(`start`) BETWEEN 18 and 23 THEN 'Evening'
END AS 'Part of the Day',
CASE 
WHEN duration <= 3 THEN'Extra Short'
WHEN duration <= 6 THEN'Short'
WHEN duration <= 10 THEN 'Long'
ELSE 'Extra Long' 
END AS 'Duration' FROM games;

#16
SELECT product_name, order_date, ADDDATE(order_date, INTERVAL 3 DAY) AS `pay_due`, 
ADDDATE(order_date, INTERVAL 1 MONTH) AS `deliver_due`
FROM orders;