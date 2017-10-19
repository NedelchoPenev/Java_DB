CREATE DATABASE closed_judge_system;
USE closed_judge_system;

#1
CREATE TABLE users(
	id INT PRIMARY KEY,
	username VARCHAR(30) NOT NULL UNIQUE,
	password VARCHAR(30) NOT NULL,
	email VARCHAR(50)
);

CREATE TABLE categories(
	id INT PRIMARY KEY,
	name VARCHAR(50) NOT NULL,
	parent_id INT,
	
	CONSTRAINT fk_parent_id FOREIGN KEY(parent_id)
	REFERENCES categories(id)
);

CREATE TABLE contests (
	id INT PRIMARY KEY,
	name VARCHAR(50) NOT NULL,
	category_id INT,
	
	CONSTRAINT fk_category_id FOREIGN KEY(category_id)
	REFERENCES categories(id)
);

CREATE TABLE problems(
	id INT PRIMARY KEY,
	name VARCHAR(100) NOT NULL,
	points INT NOT NULL,
	tests INT DEFAULT 0,
	contest_id INT,
	
	CONSTRAINT fk_contest_id FOREIGN KEY(contest_id)
	REFERENCES contests(id)
);

CREATE TABLE submissions(
	id INT PRIMARY KEY AUTO_INCREMENT,
	passed_tests INT NOT NULL,
	problem_id INT,
	user_id INT,
	
	CONSTRAINT fk_problem_id FOREIGN KEY(problem_id)
	REFERENCES problems(id),
	CONSTRAINT fk_user_id FOREIGN KEY(user_id)
	REFERENCES users(id)
);

CREATE TABLE users_contests(
	user_id INT,
	contest_id INT,
	
	CONSTRAINT pk_users_contests PRIMARY KEY (user_id, contest_id),
	CONSTRAINT fk_user_id_uc FOREIGN KEY(user_id)
	REFERENCES users(id),
	CONSTRAINT fk_contest_id_uc FOREIGN KEY(contest_id)
	REFERENCES contests(id)
);

#2
INSERT INTO submissions(passed_tests, problem_id, user_id)
SELECT
	CEIL(SQRT(POW(LENGTH(p.name), 3)) - LENGTH(p.name)),
	p.id,
	CEIL((p.id * 3) / 2)
FROM problems AS p
WHERE p.id BETWEEN 1 AND 10;

#3
UPDATE problems AS p 
INNER JOIN contests AS c ON p.contest_id = c.id
INNER JOIN categories AS ct ON c.category_id = ct.id
INNER JOIN submissions AS s ON p.id = s.problem_id
SET p.tests = 
CASE p.id % 3
	WHEN 0 THEN LENGTH(ct.name)
	WHEN 1 THEN (SELECT SUM(s1.id) FROM submissions AS s1 WHERE p.id = s1.problem_id)
	WHEN 2 THEN LENGTH(c.name)
END
WHERE p.tests = 0;

#4
DELETE FROM users
WHERE id NOT IN (SELECT uc.user_id FROM users_contests AS uc);

#5
SELECT u.id, u.username, u.email FROM users AS u;

#6
SELECT c.id, c.name FROM categories AS c 
WHERE c.parent_id IS NULL;

#7
SELECT p.id, p.name, p.tests FROM problems AS p 
WHERE p.tests > p.points AND p.name LIKE '% %'
ORDER BY p.id DESC;

#8
SELECT p.id,CONCAT(ct.name, ' - ', c.name, ' - ', p.name) AS full_path FROM problems AS p
INNER JOIN contests AS c ON p.contest_id = c.id
INNER JOIN categories AS ct ON c.category_id = ct.id
ORDER BY p.id;

#9
SELECT c.id, c.name FROM categories AS c
WHERE c.id NOT IN(SELECT c2.parent_id FROM categories AS c2 WHERE c2.parent_id IS NOT NULL)
ORDER BY c.name ASC, c.id ASC;

#10
SELECT u.id, u.username, u.password FROM users AS u
WHERE u.password IN(SELECT u1.password FROM users AS u1 WHERE u.id != u1.id)
ORDER BY u.username, u.id;

#11
SELECT * FROM
(SELECT c.id, c.name, COUNT(uc.contest_id) AS contestants FROM contests AS c
LEFT JOIN users_contests AS uc ON c.id = uc.contest_id
GROUP BY uc.contest_id
ORDER BY contestants DESC LIMIT 5) AS c1 
ORDER BY c1.contestants, c1.id;

#12
SELECT s.id, u.username, p.name, CONCAT(s.passed_tests, ' / ', p.tests) AS result FROM submissions AS s
INNER JOIN users AS u ON s.user_id = u.id
INNER JOIN problems AS p ON s.problem_id = p.id
WHERE u.id = (SELECT uc.user_id FROM users_contests AS uc GROUP BY uc.user_id ORDER BY COUNT(*) DESC LIMIT 1)
ORDER BY s.id DESC;

#13
SELECT c.id, c.name, SUM(p.points) AS maximum_points FROM contests AS c
INNER JOIN problems AS p ON c.id = p.contest_id
GROUP BY c.id
ORDER BY maximum_points DESC, c.id;

#14
SELECT c.id, c.name, COUNT(s.problem_id) AS submissions FROM contests AS c
INNER JOIN problems AS p ON c.id = p.contest_id
INNER JOIN submissions AS s ON p.id = s.problem_id
WHERE s.user_id IN
(SELECT uc.user_id FROM users_contests AS uc WHERE uc.contest_id = c.id)
GROUP BY c.id, c.name
ORDER BY `submissions` DESC, c.id ASC;

#15
DELIMITER $$
CREATE PROCEDURE udp_login(username VARCHAR(20), password VARCHAR(30))
BEGIN
	IF username NOT IN(SELECT u.username FROM users AS u) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Username does not exist!';
	ELSEIF (password NOT IN(SELECT u.password FROM users AS u WHERE username = u.username)) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Password is incorrect!';
	ELSEIF (username IN(SELECT lu.username FROM logged_in_users AS lu)) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='User is already logged in!';
	ELSE 
		INSERT INTO logged_in_users(id, username, password, email)
		SELECT u.id, u.username, u.password, u.email
				FROM `users` AS u
				WHERE u.username = username;
	END IF;
END $$

#16
DELIMITER $$
CREATE PROCEDURE udp_evaluate(id_sub INT)
BEGIN
	IF id_sub NOT IN(SELECT s.id FROM submissions AS s) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Submission does not exist!';
	ELSE
		INSERT INTO evaluated_submissions(id, problem, user, result)
		SELECT s.id, p.name, u.username, CEIL(p.points / p.tests * s.passed_tests) FROM submissions AS s
		INNER JOIN problems AS p ON s.problem_id = p.id
		INNER JOIN users AS u ON s.user_id = u.id
		WHERE id_sub = s.id;
	END IF;
END $$

#17
DELIMITER $$
CREATE TRIGGER tr_insert_problems
BEFORE INSERT
ON problems
FOR EACH ROW
BEGIN
	IF (new.name NOT LIKE '% %') THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='The given name is invalid!';
	ELSEIF (new.points <= 0) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='The problem’s points cannot be less or equal to 0!';
	ELSEIF (new.tests <= 0) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='The problem’s tests cannot be less or equal to 0!';
	END IF;
END $$