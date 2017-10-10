use minions;

CREATE TABLE IF NOT EXISTS minions
(
	id INT NOT NULL AUTO_INCREMENT,
	name VARCHAR(50) NOT NULL,
	age INT NULL,
	CONSTRAINT pk_minions PRIMARY KEY (id)
);
CREATE TABLE IF NOT EXISTS towns
(
	id INT NOT NULL AUTO_INCREMENT,
	name VARCHAR(50) NOT NULL,
	CONSTRAINT pk_towns PRIMARY KEY (id)
);

ALTER TABLE minions
ADD COLUMN town_id INT NOT NULL;
ALTER TABLE minions
ADD CONSTRAINT fk_minions_towns FOREIGN KEY (town_id) REFERENCES towns(id)

insert into towns (id, name) values (1, 'Sofia'), (2, 'Plovdiv'), (3, 'Varna');
insert into minions (id, name, age, town_id) 
values (1, 'Kevin', 22,	1), (2, 'Bob', 15, 3), (3, 'Steward', null, 2);

TRUNCATE TABLE minions;

DROP TABLE minions;
DROP TABLE towns;


CREATE TABLE IF NOT EXISTS people (
	id	INT PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(25) NOT NULL,
	picture BLOB,
	height NUMERIC(10, 2),
	weight NUMERIC(10, 2),
	gender CHAR(1) NOT NULL,
	birthdate DATETIME NOT NULL,
	biography VARCHAR(10000)
);
INSERT INTO people(name, picture, height, weight, gender, birthdate, biography)
VALUES ('Kevin', NULL, 1.82, 82.24, 'm', '2001-02-01', 'Some biography here'),
('Peter', NULL, 1.76, 83.23, 'm', '1982-01-11', NULL),
('Steward', NULL, 1.84, 95.00, 'm', '2001-04-01', 'Some biography here'),
('Bob Bob', NULL, 1.86, 101.99, 'm', '2001-11-06', 'Some biography here'),
('An Ann Annie', NULL, 1.72, 60.22, 'f', '2001-12-01', 'Some biography here');

CREATE TABLE IF NOT EXISTS users (
	id	BIGINT PRIMARY KEY AUTO_INCREMENT,
	username VARCHAR(30) NOT NULL,
	password VARCHAR(26) NOT NULL,
	profile_picture BLOB,
	last_login_time DATETIME,
	is_deleted INT
);
INSERT INTO users(username, password, profile_picture, last_login_time, is_deleted) 
VALUES ('pesho', '123456', NULL, NOW(), 0),
('gosho', '234567', NULL, NOW(), 0),
('ivan', '234562', NULL, NOW(), 0),
('gosho1', '234567', NULL, NOW(), 0),
('bosko', '5678910', NULL, NOW(), 1);

ALTER TABLE users
DROP PRIMARY KEY,
ADD CONSTRAINT pk_users PRIMARY KEY (id, username);

ALTER TABLE users
CHANGE COLUMN last_login_time last_login_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP;

ALTER TABLE users
DROP PRIMARY KEY,
ADD CONSTRAINT pk_users PRIMARY KEY (id),
ADD CONSTRAINT un_username UNIQUE (username);

CREATE DATABASE Movies

CREATE TABLE directors (
	id INT PRIMARY KEY AUTO_INCREMENT,
	director_name VARCHAR(25) NOT NULL, 
	notes VARCHAR(1000)
);

CREATE TABLE genres (
	id INT PRIMARY KEY AUTO_INCREMENT, 
	genre_name VARCHAR(25) NOT NULL, 
	notes VARCHAR(1000)
);

CREATE TABLE categories (
	id INT PRIMARY KEY AUTO_INCREMENT, 
	category_name VARCHAR(25) NOT NULL, 
	notes VARCHAR(1000)
); 

CREATE TABLE movies (
	id INT PRIMARY KEY AUTO_INCREMENT, 
	title VARCHAR(50) NOT NULL, 
	director_id INT , 
	copyright_year YEAR, 
	length INT, 
	genre_id INT, 
	category_id INT, 
	rating FLOAT , 
	notes VARCHAR(1000)
);

INSERT INTO directors (director_name, notes) 
VALUES ('Ben Affleck', 'sample notes'), ('Woody Allen', 'sample notes'), ('Luc Besson', 'sample notes'),
('Cameron Crowe', 'sample notes'), ('Clint Eastwood', 'sample notes');

INSERT INTO genres (genre_name, notes) 
VALUES ('Action', 'sample notes'), ('Comedy', 'sample notes'), ('Horror', 'sample notes'),
('Thriller', 'sample notes'), ('Drama', 'sample notes');

INSERT INTO categories (category_name, notes) 
VALUES ('0-3', 'suitable for infants'), ('7-12', 'suitable for kids'), ('12-16', 'suitable for teenagers'),
('16-18', NULL), ('18+', 'suitable for adults');

INSERT INTO movies (title, director_id, copyright_year, length, genre_id, category_id, rating, notes) 
VALUES ('Titanic', 1, 1998, 181, 1, 4, 8.2, 'sample notes'), 
('Avatar', 4, 2008, 160, 2, 3, 9.22, 'sample notes'),
('Rocky 1', 2, 1980, 90, 3, 1, 9.99, 'sample notes'),
('Rocky 2', 3, 1983, 92, 5, 2, 10.1, 'sample notes'),
('Rocky 3', 1, 1986, 95, 1, 5, 6.2, 'sample notes');

CREATE DATABASE car_rental

CREATE TABLE IF NOT EXISTS categories
(
	id INT NOT NULL AUTO_INCREMENT,
	category VARCHAR(20) NOT NULL,
	daily_rate FLOAT,
	weekly_rate FLOAT,
	monthly_rate FLOAT,
	weekend_rate FLOAT,
	CONSTRAINT pk_categories PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS cars
(
	id INT NOT NULL AUTO_INCREMENT,
	plate_number VARCHAR(8) NOT NULL,
	make VARCHAR(20) NOT NULL,
	model VARCHAR(20) NOT NULL,
	car_year INT,
	category_id INT,
	doors INT,
	picture BLOB,
	car_condition VARCHAR(20),
	available INT,
	CONSTRAINT pk_cars PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS employees
(
	id INT NOT NULL AUTO_INCREMENT,
	first_name VARCHAR(20) NOT NULL,
	last_name VARCHAR(20) NOT NULL,
	title VARCHAR(20),
	notes VARCHAR(200),
	CONSTRAINT pk_employees PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS customers
(
	id INT NOT NULL AUTO_INCREMENT,
	driver_licence_number VARCHAR(15) NOT NULL,
	full_name VARCHAR(100) NOT NULL,
	address VARCHAR(500),
	city VARCHAR(50),
	zip_code VARCHAR(10),
	notes VARCHAR(200),
	CONSTRAINT pk_customers PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS rental_orders
(
	id INT NOT NULL AUTO_INCREMENT,
	employee_id INT NOT NULL,
	customer_id INT NOT NULL,
	car_id INT NOT NULL,
	car_condition VARCHAR(20),
	tank_level DOUBLE(10, 2),
	kilometrage_start INT,
	kilometrage_end INT,
	total_kilometrage INT,
	start_date DATETIME,
	end_date DATETIME,
	total_days INT,
	rate_applied INT,
	tax_rate DOUBLE(10,2),
	order_status VARCHAR(10),
	notes VARCHAR(200),
	CONSTRAINT pk_rental_orders PRIMARY KEY (id)
);

INSERT INTO categories (category) VALUES ('Car');
INSERT INTO categories (category) VALUES ('Truck'); 
INSERT INTO categories (category) VALUES ('Van');

INSERT INTO cars (plate_number, make, model) VALUES ('A1234AA', 'Opel', 'Omega');
INSERT INTO cars (plate_number, make, model) VALUES ('A6542AB', 'Ford', 'Focus');
INSERT INTO cars (plate_number, make, model) VALUES ('OB4444AP', 'Lada', 'Niva');

INSERT INTO employees (first_name, last_name) VALUES ('Ivan', 'Ivanov');
INSERT INTO employees (first_name, last_name) VALUES ('Petar', 'Petrov');
INSERT INTO employees (first_name, last_name) VALUES ('Misha', 'Mishav');

INSERT INTO customers (driver_licence_number, full_name) VALUES ('A12345', 'Ivan Ivanov Ivanov');
INSERT INTO customers (driver_licence_number, full_name) VALUES ('A12346', 'Ivan Ivanov Petrov');
INSERT INTO customers (driver_licence_number, full_name) VALUES ('A12342', 'Petar Ivanov Ivanov');

INSERT INTO rental_orders (employee_id, customer_id, car_id) VALUES (1, 2, 3);
INSERT INTO rental_orders (employee_id, customer_id, car_id) VALUES (2, 3, 1);
INSERT INTO rental_orders (employee_id, customer_id, car_id) VALUES (2, 2, 2);


CREATE DATABASE hotel;
USE hotel;

CREATE TABLE IF NOT EXISTS employees
(
	id INT NOT NULL AUTO_INCREMENT,
	first_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(50) NOT NULL,
	title VARCHAR(20),
	notes VARCHAR(200),
	CONSTRAINT pk_employees PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS customers
(
	account_number BIGINT NOT NULL,
	first_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(50) NOT NULL,
	phone_number VARCHAR(15) NOT NULL,
	emergency_name VARCHAR(50),
	emergency_number VARCHAR(15),
	notes VARCHAR(200),
	CONSTRAINT pk_customers PRIMARY KEY (account_number)
);

CREATE TABLE IF NOT EXISTS room_status
(
	room_status VARCHAR(10) NOT NULL,
	notes VARCHAR(200),
	CONSTRAINT pk_room_status PRIMARY KEY (room_status)
);

CREATE TABLE IF NOT EXISTS room_types
(
	room_type VARCHAR(10) NOT NULL,
	notes VARCHAR(200),
	CONSTRAINT pk_room_types PRIMARY KEY (room_type)
);

CREATE TABLE IF NOT EXISTS bed_types
(
	bed_type VARCHAR(10) NOT NULL,
	notes VARCHAR(200),
	CONSTRAINT pk_bed_types PRIMARY KEY (bed_type)
);

CREATE TABLE IF NOT EXISTS rooms
(
	room_number INT NOT NULL,
	room_type VARCHAR(10) NOT NULL,
	bed_type VARCHAR(10) NOT NULL,
	rate DOUBLE(10, 2),
	room_status VARCHAR(10) NOT NULL,
	notes VARCHAR(200),
	CONSTRAINT pk_rooms PRIMARY KEY (room_number)
);

CREATE TABLE IF NOT EXISTS payments
(
	id INT NOT NULL AUTO_INCREMENT,
	employee_id INT NOT NULL,
	payment_date DATETIME NOT NULL,
	account_number BIGINT NOT NULL,
	first_date_occupied DATETIME,
	last_date_occupied DATETIME,
	total_days INT,
	amount_charged DOUBLE(10,2) NOT NULL,
	tax_rate DOUBLE(10,2),
	tax_amount DOUBLE(10,2),
	payment_total DOUBLE(10,2) NOT NULL,
	notes VARCHAR(200),
	CONSTRAINT pk_payments PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS occupancies
(
	id INT NOT NULL AUTO_INCREMENT,
	employee_id INT NOT NULL,
	date_occupied DATETIME,
	account_number BIGINT NOT NULL,
	room_number INT NOT NULL,
	rate_applied DOUBLE(10,2),
	phone_charge DOUBLE(10,2),
	notes VARCHAR(200),
	CONSTRAINT pk_occupancies PRIMARY KEY (id)
);

INSERT INTO employees (first_name, last_name) VALUES ('Ivan', 'Ivanov');
INSERT INTO employees (first_name, last_name) VALUES ('Petar', 'Petrov');
INSERT INTO employees (first_name, last_name) VALUES ('Mitko', 'Dimitrov');

INSERT INTO customers(account_number, first_name, last_name, phone_number) VALUES (34545674545, 'Ivan', 'Petrov', '+35988999999');
INSERT INTO customers(account_number, first_name, last_name, phone_number) VALUES (35436554234, 'Misho', 'Petrovanov', '+359889965479');
INSERT INTO customers(account_number, first_name, last_name, phone_number) VALUES (12480934333, 'Nikolay', 'Nikov', '+35988999919');

INSERT INTO room_status (room_status) VALUES ('Occupied');
INSERT INTO room_status (room_status) VALUES ('Available');
INSERT INTO room_status (room_status) VALUES ('Cleaning');

INSERT INTO room_types (room_type) VALUES ('Single');
INSERT INTO room_types (room_type) VALUES ('Double');
INSERT INTO room_types (room_type) VALUES ('Apartment');

INSERT INTO bed_types (bed_type) VALUES ('Double');
INSERT INTO bed_types (bed_type) VALUES ('Queen');
INSERT INTO bed_types (bed_type) VALUES ('King');

INSERT INTO rooms (room_number, room_type, bed_type, room_status) VALUES (1, 'Single', 'Double', 'Available');
INSERT INTO rooms (room_number, room_type, bed_type, room_status) VALUES (2, 'Double', 'King', 'Available');
INSERT INTO rooms (room_number, room_type, bed_type, room_status) VALUES (12, 'Apartment', 'Queen', 'Occupied');

INSERT INTO payments (employee_id, payment_date, account_number, amount_charged, payment_total, tax_rate) VALUES (1, NOW(), 34545675676, 10.20, 12.20, 2.4);
INSERT INTO payments (employee_id, payment_date, account_number, amount_charged, payment_total, tax_rate) VALUES (3, NOW(), 34545675676, 220.20, 240.22, 2.1);
INSERT INTO payments (employee_id, payment_date, account_number, amount_charged, payment_total, tax_rate) VALUES (2, NOW(), 34545675676, 190.20, 215.88, 1.1);

INSERT INTO occupancies (employee_id, account_number, room_number) VALUES (1, 34545675676, 2);
INSERT INTO occupancies (employee_id, account_number, room_number) VALUES (2, 34545675676, 1);
INSERT INTO occupancies (employee_id, account_number, room_number) VALUES (2, 34545675676, 12);


CREATE DATABASE soft_uni;
USE soft_uni;

CREATE TABLE IF NOT EXISTS towns (
	id INT NOT NULL AUTO_INCREMENT, 
	name VARCHAR(25) NOT NULL,
	CONSTRAINT pk_towns PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS addresses (
	id INT NOT NULL AUTO_INCREMENT, 
	address_text VARCHAR(100), 
	town_id INT NOT NULL,
	CONSTRAINT pk_addresses PRIMARY KEY (id),
	CONSTRAINT fk_towns FOREIGN KEY (town_id) REFERENCES towns (id)
);

CREATE TABLE IF NOT EXISTS departments (
	id INT PRIMARY KEY AUTO_INCREMENT, 
	name VARCHAR(25) NOT NULL
);

CREATE TABLE IF NOT EXISTS employees (
	id INT PRIMARY KEY AUTO_INCREMENT, 
	first_name VARCHAR(25) NOT NULL, 
	middle_name VARCHAR(25) NOT NULL, 
	last_name VARCHAR(25) NOT NULL, 
	job_title VARCHAR(25) NOT NULL, 
	department_id INT, 
	hire_date DATETIME, 
	salary DOUBLE(10, 2), 
	address_id INT,
	CONSTRAINT fk_department_id FOREIGN KEY (department_id) REFERENCES departments (id),
	CONSTRAINT fk_address_id FOREIGN KEY (address_id) REFERENCES addresses (id)
);

INSERT INTO addresses (address_text, town_id) VALUES ('asdda', 1);
INSERT INTO towns(name) VALUES ('Sofia'), ('Plovdiv'), ('Varna'), ('Burgas');
INSERT INTO departments (name) 
VALUES ('Engineering'), ('Sales'), ('Marketing'), ('Software Development'), ('Quality Assurance'); 
INSERT INTO employees (first_name, middle_name, last_name, job_title, department_id, hire_date, salary, address_id) 
VALUES ('Ivan', 'Ivanov', 'Ivanov', '.NET Developer', 4, '2013-02-01', 3500.00, 1),
('Petar', 'Petrov', 'Petrov', 'Senior Engineer', 1, '2004-03-02', 4000.00, 1),
('Maria', 'Petrova', 'Ivanova', 'Intern', 5, '2016-08-28', 525.25, 1),
('Georgi', 'Terziev', 'Ivanov', 'CEO', 2, '2007-12-09', 3000.00, 1),
('Peter', 'Pan', 'Pan', 'Intern', 3, '2016-08-28', 599.88, 1);

SELECT * FROM towns ORDER BY name;
SELECT * FROM departments ORDER BY name;
SELECT * FROM employees ORDER BY salary DESC;

SELECT name FROM towns ORDER BY name;
SELECT name FROM departments ORDER BY name;
SELECT first_name, last_name, job_title, salary FROM employees ORDER BY salary DESC;

UPDATE employees
SET salary = salary + salary * 0.1; 
SELECT salary FROM employees;

USE hotel;
UPDATE payments
SET tax_rate = tax_rate - tax_rate * 0.03;
SELECT tax_rate FROM payments;

DELETE FROM occupancies;
