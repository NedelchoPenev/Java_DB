#1
CREATE TABLE passports (
	passport_id INT AUTO_INCREMENT PRIMARY KEY, 
	passport_number VARCHAR(20) 
);

CREATE TABLE persons (
	person_id INT AUTO_INCREMENT PRIMARY KEY,
	first_name VARCHAR(20) NOT NULL,
	salary DECIMAL(10, 2) NOT NULL,
	passport_id INT NOT NULL UNIQUE,
	CONSTRAINT fk_passport_id FOREIGN KEY (passport_id) 
	REFERENCES passports (passport_id)
);

ALTER TABLE passports AUTO_INCREMENT = 101;

INSERT INTO passports (passport_number) 
VALUES ('N34FG21B'), ('K65LO4R7'), ('ZE657QP2');

INSERT INTO persons (first_name, salary, passport_id)
VALUES ('Roberto', 43300.00, 102), ('Tom', 56100.00, 103), ('Yana', 60200.00, 101);

#2
CREATE TABLE manufacturers (
	manufacturer_id INT AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(25) NOT NULL,
	established_on DATETIME
);

CREATE TABLE models (
	model_id INT AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(25) NOT NULL,
	manufacturer_id INT,
	CONSTRAINT fk_manufacturer_id FOREIGN KEY (manufacturer_id)
	REFERENCES manufacturers(manufacturer_id)
);

ALTER TABLE models AUTO_INCREMENT = 101;

INSERT INTO manufacturers (name, established_on)
VALUES ('BMW', '1916-03-01'),('Tesla', '2003-01-01'),('Lada', '1966-05-01');

INSERT INTO models (name, manufacturer_id)
VALUES ('X1', 1), ('i6', 1), ('Model S', 2), ('Model X', 2), ('Model 3', 2),('Nova', 3);

#3
CREATE TABLE students(
	student_id INT AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(25) NOT NULL
);

CREATE TABLE exams(
	exam_id INT AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(25) NOT NULL
);

ALTER TABLE exams AUTO_INCREMENT = 101;

CREATE TABLE students_exams(
	student_id INT,
	exam_id INT,
	CONSTRAINT pk_student_exam_id PRIMARY KEY(student_id, exam_id),
	CONSTRAINT fk_student_id FOREIGN KEY (student_id)
	REFERENCES students(student_id),
	CONSTRAINT fk_exam_id FOREIGN KEY (exam_id)
	REFERENCES exams(exam_id)
);

INSERT INTO students (name)
VALUES ('Mila'), ('Toni'), ('Ron');

INSERT INTO exams (name)
VALUES ('Spring MVC'), ('Neo4j'), ('Oracle 11g');

INSERT INTO students_exams (student_id, exam_id)
VALUES (1, 101), (1, 102), (2, 101), (3, 103), (2, 102), (2, 103);

#4
CREATE TABLE teachers (
	teacher_id INT AUTO_INCREMENT PRIMARY KEY, 
	name VARCHAR(30),
	manager_id INT,
	CONSTRAINT fk_manager_id FOREIGN KEY (manager_id)
	REFERENCES teachers (teacher_id)
);

INSERT INTO teachers (teacher_id, name, manager_id)
VALUES (101, 'John', NULL), (105, 'Mark', 101), (106, 'Greta', 101),
(102, 'Maya', 106), (103, 'Silvia', 106), (104 ,'Ted', 105);

#5
CREATE TABLE item_types (
	item_type_id INT AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR (50)
);

CREATE TABLE items (
	item_id INT AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(50) NOT NULL,
	item_type_id INT,
	CONSTRAINT fk_item_type_id FOREIGN KEY (item_type_id)
	REFERENCES item_types(item_type_id)
);

CREATE TABLE cities (
	city_id INT AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR (50) NOT NULL
);

CREATE TABLE customers (
	customer_id INT AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR (50) NOT NULL,
	birthday DATE,
	city_id INT,
	CONSTRAINT fk_city_id FOREIGN KEY (city_id)
	REFERENCES cities(city_id)
);

CREATE TABLE orders (
	order_id INT AUTO_INCREMENT PRIMARY KEY,
	customer_id INT,
	CONSTRAINT fk_customer_id FOREIGN KEY (customer_id)
	REFERENCES customers(customer_id)
);

CREATE TABLE order_items (
	order_id INT,
	item_id INT,
	CONSTRAINT PRIMARY KEY(order_id, item_id),
	CONSTRAINT fk_order_id FOREIGN KEY (order_id)
	REFERENCES orders(order_id),
	CONSTRAINT fk_item_id FOREIGN KEY (item_id)
	REFERENCES items(item_id)
);

#6
CREATE TABLE majors (
	major_id INT AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(50) NOT NULL
);

CREATE TABLE students (
	student_id INT AUTO_INCREMENT PRIMARY KEY,
	student_number VARCHAR(12),
	student_name VARCHAR(50),
	major_id INT,
	CONSTRAINT fk_major_id FOREIGN KEY (major_id)
	REFERENCES majors(major_id)
);

CREATE TABLE payments (
	payment_id INT AUTO_INCREMENT PRIMARY KEY,
	payment_date DATE,
	payment_amount DECIMAL(8, 2) NOT NULL,
	student_id INT,
	CONSTRAINT fk_istudent_id FOREIGN KEY (student_id)
	REFERENCES students(student_id)
);

CREATE TABLE subjects (
	subject_id INT AUTO_INCREMENT PRIMARY KEY,
	subject_name VARCHAR(50)
);

CREATE TABLE agenda (
	student_id INT,
	subject_id INT,
	CONSTRAINT pk_aganda PRIMARY KEY (student_id, subject_id),
	CONSTRAINT fk_student_id FOREIGN KEY (student_id)
	REFERENCES students(student_id),
	CONSTRAINT fk_subject_id FOREIGN KEY (subject_id)
	REFERENCES subjects(subject_id)
);

#9
SELECT mountain_range, peak_name, elevation AS peak_elevation FROM peaks AS p
JOIN mountains AS m ON m.id = p.mountain_id
WHERE m.id = 17
ORDER BY peak_elevation DESC;