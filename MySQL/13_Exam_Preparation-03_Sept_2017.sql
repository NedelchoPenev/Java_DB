CREATE DATABASE instagraph_db;
USE instagraph_db;

CREATE TABLE pictures(
	id INT AUTO_INCREMENT PRIMARY KEY,
	path VARCHAR(255) NOT NULL,
	size DECIMAL(10, 2) NOT NULL
);

CREATE TABLE users(
	id INT AUTO_INCREMENT PRIMARY KEY,
	username VARCHAR(30) UNIQUE NOT NULL,
	password VARCHAR(30) NOT NULL,
	profile_picture_id INT,
	
	CONSTRAINT fk_profile_picture_id FOREIGN KEY(profile_picture_id)
	REFERENCES pictures(id)
);

CREATE TABLE posts(
	id INT AUTO_INCREMENT PRIMARY KEY,
	caption VARCHAR(255) NOT NULL,
	user_id INT NOT NULL,
	picture_id INT NOT NULL,
	
	CONSTRAINT fk_user_id FOREIGN KEY(user_id)
	REFERENCES users(id),
	CONSTRAINT fk_picture_id FOREIGN KEY(picture_id)
	REFERENCES pictures(id)
);

CREATE TABLE comments(
	id INT AUTO_INCREMENT PRIMARY KEY,
	content VARCHAR(255) NOT NULL,
	user_id INT NOT NULL,
	post_id INT NOT NULL,
	
	CONSTRAINT fk_user_id_c FOREIGN KEY(user_id)
	REFERENCES users(id),
	CONSTRAINT fk_post_id FOREIGN KEY(post_id)
	REFERENCES posts(id)
);

CREATE TABLE users_followers(
	user_id INT,
	follower_id INT,
	
	CONSTRAINT fk_user_id_uf FOREIGN KEY(user_id)
	REFERENCES users(id),
	CONSTRAINT fk_follower_id FOREIGN KEY(follower_id)
	REFERENCES users(id)
);

#2
INSERT INTO comments(content, user_id, post_id)
SELECT
	CONCAT('Omg!', u.username, '!This is so cool!'),
	CEIL((p.id * 3) / 2),
	p.id
FROM posts AS p
INNER JOIN users AS u ON p.user_id = u.id
WHERE p.id BETWEEN 1 AND 10;

#3
UPDATE users AS u
SET u.profile_picture_id = 
	IF (u.id NOT IN (SELECT user_id FROM users_followers), 
		u.id,
	   (SELECT COUNT(uf.user_id) FROM users_followers AS uf WHERE uf.user_id = u.id))
WHERE u.profile_picture_id IS NULL;

#4
DELETE FROM users
WHERE id NOT IN (SELECT user_id FROM users_followers)
AND id NOT IN (SELECT follower_id FROM users_followers);

#5
SELECT u.id, u.username FROM users AS u
ORDER BY u.id;

#6
SELECT u.id, u.username FROM users AS u
INNER JOIN users_followers AS uf ON u.id = uf.user_id
WHERE uf.user_id = uf.follower_id
ORDER BY u.id;

#7
SELECT p.id, p.path, p.size FROM pictures AS p
WHERE p.size > 50000 AND (p.path LIKE '%jpeg%' OR p.path LIKE '%png%')
ORDER BY p.size DESC;

#8
SELECT c.id, CONCAT(u.username, ' : ', c.content) FROM comments AS c
INNER JOIN users AS u ON c.user_id = u.id
ORDER BY c.id DESC;

#9
SELECT u.id, u.username, CONCAT(p.size, 'KB') FROM users AS u
INNER JOIN pictures AS p ON u.profile_picture_id = p.id
WHERE u.profile_picture_id IN(SELECT u1.profile_picture_id FROM users AS u1 WHERE u.id != u1.id);

#10
SELECT DISTINCT p.id, p.caption, 
COALESCE((SELECT COUNT(c1.post_id) FROM comments AS c1 WHERE p.id = c1.post_id GROUP BY c1.post_id), 0) AS `comments` 
FROM posts AS p
LEFT JOIN comments AS c ON p.id = c.post_id
ORDER BY `comments` DESC, p.id LIMIT 5;
	
#11
SELECT u.id, u.username, 
	(SELECT COUNT(p.user_id) FROM posts AS p WHERE u.id = p.user_id GROUP BY p.user_id) AS posts,
	 COUNT(us.user_id) AS followers FROM users AS u
LEFT JOIN users_followers AS us ON u.id = us.user_id
GROUP BY us.user_id
ORDER BY followers DESC LIMIT 1;

#12
SELECT DISTINCT u.id, u.username, 
	COALESCE((SELECT COUNT(c1.user_id) FROM comments AS c1 
	LEFT JOIN posts AS p1 ON c1.post_id = p1.id
	LEFT JOIN users AS u1 ON p1.user_id = u1.id
	WHERE p1.user_id = c1.user_id AND u.id = p1.user_id
	GROUP BY c1.user_id), 0) AS my_comments 
FROM users AS u 
LEFT JOIN posts AS p ON u.id = p.user_id
LEFT JOIN comments AS c ON p.id = c.post_id
ORDER BY my_comments DESC, u.id;

#13


#14
SELECT DISTINCT p.id, p.caption, 
	COALESCE((SELECT COUNT(DISTINCT c1.user_id) FROM comments AS c1 
	WHERE c1.post_id = p.id
	GROUP BY c.post_id), 0) AS users 
FROM posts AS p
LEFT JOIN comments AS c ON p.id = c.post_id
ORDER BY users DESC, p.id;

#15
DELIMITER $$
CREATE PROCEDURE udp_post(username VARCHAR(30), password VARCHAR(30), caption VARCHAR(255), path VARCHAR(255))
BEGIN
	IF 
		(SELECT u.password FROM users AS u WHERE u.username = username) != password THEN
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Password is incorrect!';
	ELSEIF
		path NOT IN(SELECT p.path FROM pictures AS p) THEN
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='The picture does not exist!';
	ELSE
		INSERT INTO posts(caption, user_id, picture_id)
		VALUES(
		caption, 
		(SELECT u.id FROM users AS u WHERE u.username = username),
		(SELECT p.id FROM pictures AS p WHERE p.path = path)
		);
	END IF;
END $$

#16
DELIMITER $$
CREATE PROCEDURE udp_filter(hashtag VARCHAR(25))
BEGIN
	SELECT p.id, p.caption, u.username FROM posts AS p
	INNER JOIN users AS u ON p.user_id = u.id
	WHERE p.caption LIKE CONCAT('%', hashtag, '%');
END $$