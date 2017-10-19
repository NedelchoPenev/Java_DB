CREATE DATABASE the_nerd_herd;
USE the_nerd_herd;

#1
CREATE TABLE credentials (
	id INT(11) PRIMARY KEY AUTO_INCREMENT,
	email VARCHAR(30),
	password VARCHAR(20)
);

CREATE TABLE locations (
	id INT(11) PRIMARY KEY AUTO_INCREMENT,
	latitude FLOAT,
	longitude FLOAT
);

CREATE TABLE users (
	id INT(11) PRIMARY KEY AUTO_INCREMENT,
	nickname VARCHAR(25),
	gender CHAR(1),
	age INT,
	location_id INT,
	credential_id INT UNIQUE,
	
	CONSTRAINT fk_location_id FOREIGN KEY(location_id)
	REFERENCES locations(id),
	CONSTRAINT fk_credential_id FOREIGN KEY(credential_id)
	REFERENCES credentials(id)
);

CREATE TABLE chats (
	id INT(11) PRIMARY KEY AUTO_INCREMENT,
	title VARCHAR(32),
	start_date DATE,
	is_active BIT(1) 
);

CREATE TABLE messages (
	id INT(11) PRIMARY KEY AUTO_INCREMENT,
	content VARCHAR(200),
	sent_on DATE,
	chat_id INT(11),
	user_id INT(11),
	
	CONSTRAINT fk_chat_id FOREIGN KEY(chat_id)
	REFERENCES chats(id),
	CONSTRAINT fk_user_id FOREIGN KEY(user_id)
	REFERENCES users(id)
);

CREATE TABLE users_chats (
	user_id INT(11),
	chat_id INT(11),
	
	CONSTRAINT pk_user_id_chat_id PRIMARY KEY (user_id, chat_id),
	
	CONSTRAINT fk_user_id_uc FOREIGN KEY(user_id)
	REFERENCES users(id),
	
	CONSTRAINT fk_chat_id_uc FOREIGN KEY(chat_id)
	REFERENCES chats(id)
);

#2
INSERT INTO messages(content, sent_on, chat_id, user_id)
	SELECT CONCAT(u.age, '-', u.gender, '-', l.latitude, '-', l.longitude),
	'2016-12-15', 
	IF(u.gender = 'F', CEIL(SQRT(u.age * 2)), CEIL(POW(age / 18, 3))), 
	u.id
	FROM users AS u
	INNER JOIN locations AS l ON u.location_id = l.id
   WHERE u.id >= 10 AND u.id <= 20;

#3
UPDATE chats AS c
INNER JOIN messages AS m ON c.id = m.chat_id
SET c.start_date = m.sent_on
WHERE c.start_date > m.sent_on;

#4
DELETE FROM locations
WHERE id NOT IN (
	SELECT u.location_id FROM users AS u
	 WHERE u.location_id IS NOT NULL
);

#5
SELECT nickname, gender, age FROM users
WHERE age BETWEEN 22 AND 37
ORDER BY id;

#6
SELECT m.content, m.sent_on FROM messages AS m
WHERE m.sent_on > DATE('2014-05-12') AND m.content LIKE '%just%'
ORDER BY m.id DESC;

#7
SELECT c.title, c.is_active FROM chats AS c
WHERE c.is_active = 0 AND LENGTH(c.title) < 5 OR c.title LIKE '__tl%'
ORDER BY c.title DESC;

#8
SELECT m.chat_id AS id, c.title, m.id FROM messages AS m
JOIN chats AS c ON c.id = m.chat_id
WHERE m.sent_on < DATE('2012-03-26') AND RIGHT(c.title, 1) = 'x'
ORDER BY c.id, m.id;

#9
SELECT c.id, COUNT(m.id) AS total_messages FROM chats AS c
INNER JOIN messages AS m ON m.chat_id = c.id
WHERE m.id < 90
GROUP BY c.id
ORDER BY total_messages DESC, c.id LIMIT 5;

#10
SELECT u.nickname, cr.email, cr.password FROM users AS u
INNER JOIN credentials AS cr ON cr.id = u.credential_id
WHERE cr.email LIKE '%co.uk'
ORDER BY cr.email;

#11
SELECT u.id, u.nickname, u.age FROM users AS u
WHERE u.location_id IS NULL
ORDER BY u.id;

#12
SELECT m.id, m.chat_id, u.id FROM messages AS m
INNER JOIN chats AS c ON c.id=m.chat_id
INNER JOIN users AS u ON u.id=m.user_id
WHERE c.id = 17
AND u.id NOT IN (SELECT uc.user_id FROM users_chats AS uc
				WHERE uc.chat_id=17)
ORDER BY m.id DESC;

#13
SELECT u.nickname, c.title, l.latitude, l.longitude FROM users AS u
INNER JOIN locations AS l ON u.location_id = l.id
INNER JOIN users_chats AS uc ON u.id = uc.user_id
INNER JOIN chats AS c ON uc.chat_id = c.id
WHERE l.latitude BETWEEN 41.139999 AND 44.129999 
AND l.longitude BETWEEN 22.209999 AND 28.359999 
ORDER BY c.title;

#14
SELECT c.title, m.content FROM
	(SELECT * FROM chats ORDER BY start_date DESC LIMIT 1) AS c
	LEFT OUTER JOIN messages AS m ON
    m.chat_id = c.id
		AND m.sent_on IS NOT NULL
		AND m.sent_on >= c.start_date
ORDER BY m.sent_on;

#15
DELIMITER $$
CREATE FUNCTION udf_get_radians(degre FLOAT)
RETURNS FLOAT
BEGIN
DECLARE result FLOAT;
	SET result := (PI() * degre) / 180;
RETURN result;
END $$

#16
DELIMITER $$
CREATE PROCEDURE udp_change_password(email VARCHAR(30), new_pass VARCHAR(20))
BEGIN
	IF (email NOT IN (SELECT c.email FROM credentials AS c)) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT="The email does't exist!";
	ELSE
		UPDATE credentials AS c SET c.password = new_pass
		WHERE c.email = email;
		END IF;
END $$

#17
DELIMITER $$
CREATE PROCEDURE udp_send_message(new_user_id INT, new_chat_id INT, new_content VARCHAR(200))
BEGIN
	IF(new_user_id NOT IN(SELECT u.id FROM users AS u)) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'There is no chat with that user!';
	ELSE
		INSERT INTO messages(content, sent_on, chat_id, user_id) 
		VALUES(new_content, '2016-12-15', new_chat_id, new_user_id);
	END IF;	
END $$

#18
CREATE TABLE messages_log(
	id INT(11) PRIMARY KEY AUTO_INCREMENT,
	content VARCHAR(200),
	sent_on DATE,
	chat_id INT(11),
	user_id INT(11)
);

DELIMITER $$
CREATE TRIGGER tr_messages_log
AFTER DELETE ON messages
FOR EACH ROW
BEGIN
	INSERT INTO messages_log (id, content, sent_on, chat_id, user_id)
	VALUES(old.id, old.content, old.sent_on, old.chat_id, old.user_id);
END $$

#19
DELIMITER $$
CREATE TRIGGER tr_delete_user
BEFORE DELETE 
ON users
FOR EACH ROW
BEGIN
	SET FOREIGN_KEY_CHECKS = 0;
	 DELETE FROM messages WHERE user_id=old.id;
    DELETE FROM users_chats WHERE user_id=old.id;
    DELETE FROM messages_log WHERE user_id=old.id;
    SET FOREIGN_KEY_CHECKS = 1;
END $$