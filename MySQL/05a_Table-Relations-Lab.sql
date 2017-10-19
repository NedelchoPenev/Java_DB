#1
CREATE TABLE mountains (
	id INT AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(20) NOT NULL
);

CREATE TABLE peaks (
	id INT AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(20) NOT NULL,
	mountain_id INT NOT NULL,
	CONSTRAINT fk_mountain_id FOREIGN KEY(mountain_id) 
	REFERENCES mountains (id)
);

#2
CREATE TABLE authors (
	id INT AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(20) NOT NULL
);

CREATE TABLE books (
	id INT AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(20) NOT NULL,
	author_id INT NOT NULL,
	CONSTRAINT fk_author_id FOREIGN KEY (author_id)
	REFERENCES authors(id) ON DELETE CASCADE
);

#3
SELECT driver_id, vehicle_type, CONCAT (first_name, ' ', last_name) AS driver_name FROM vehicles AS v
JOIN campers AS c ON v.driver_id = c.id;

#4
SELECT starting_point, end_point, leader_id, CONCAT (first_name, ' ', last_name) AS leader_name 
FROM routes AS r
JOIN campers AS c ON r.leader_id = c.id;

#5
CREATE TABLE clients(
	id INT(11) AUTO_INCREMENT PRIMARY KEY,
	client_name VARCHAR(100) NOT NULL,
	project_id INT NOT NULL
);

CREATE TABLE projects(
	id INT(11) AUTO_INCREMENT PRIMARY KEY,
	client_id INT(11) NOT NULL,
	project_lead_id INT(11) NOT NULL
);

CREATE TABLE employees(
	id INT(11) AUTO_INCREMENT PRIMARY KEY,
	first_name VARCHAR(30) NOT NULL,
	last_name VARCHAR(30) NOT NULL,
	project_id INT NOT NULL
);

ALTER TABLE clients
ADD CONSTRAINT fk_project_id FOREIGN KEY (project_id) 
REFERENCES projects(id);

ALTER TABLE projects
ADD CONSTRAINT fk_client_id FOREIGN KEY (client_id) 
REFERENCES clients(id);

ALTER TABLE projects
ADD CONSTRAINT fk_project_lead_id FOREIGN KEY (project_lead_id) 
REFERENCES employees(id);

ALTER TABLE employees
ADD CONSTRAINT fk_emp_project_id FOREIGN KEY (project_id) 
REFERENCES projects(id);