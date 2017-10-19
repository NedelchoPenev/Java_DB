CREATE DATABASE airport_management_system;
USE airport_management_system;

#1
CREATE TABLE towns(
	town_id INT AUTO_INCREMENT PRIMARY KEY,
	town_name VARCHAR(30) NOT NULL
);

CREATE TABLE airports(
	airport_id INT AUTO_INCREMENT PRIMARY KEY,
	airport_name VARCHAR(50) NOT NULL,
	town_id INT,
	
	CONSTRAINT fk_town_id FOREIGN KEY(town_id) 
	REFERENCES towns(town_id)
);

CREATE TABLE airlines(
	airline_id INT AUTO_INCREMENT PRIMARY KEY,
	airline_name VARCHAR(30) NOT NULL,
	nationality VARCHAR(30) NOT NULL,
	rating INT DEFAULT 0
);

CREATE TABLE customers(
	customer_id INT AUTO_INCREMENT PRIMARY KEY,
	first_name VARCHAR(20) NOT NULL,
	last_name VARCHAR(20) NOT NULL,
	date_of_birth DATE NOT NULL,
	gender VARCHAR(1),
	home_town_id INT,
	
	CONSTRAINT fk_home_town_id FOREIGN KEY(home_town_id) 
	REFERENCES towns(town_id)
);

CREATE TABLE flights(
	flight_id INT AUTO_INCREMENT PRIMARY KEY,
	departure_time DATETIME NOT NULL,
	arrival_time DATETIME NOT NULL,
	`status` VARCHAR(9) NOT NULL,
	origin_airport_id INT,
	destination_airport_id INT,
	airline_id INT,
	 
	CONSTRAINT fk_rigin_airport_id FOREIGN KEY(origin_airport_id) 
	REFERENCES airports(airport_id),
	CONSTRAINT fk_destination_airport_id FOREIGN KEY(destination_airport_id) 
	REFERENCES airports(airport_id),
	CONSTRAINT fk_airline_id FOREIGN KEY(airline_id) 
	REFERENCES airlines(airline_id)
);

CREATE TABLE tickets(
	ticket_id INT AUTO_INCREMENT PRIMARY KEY,
	price DECIMAL(8,2) NOT NULL,
	class VARCHAR(6) NOT NULL,
	seat VARCHAR(5) NOT NULL,
	customer_id INT,
	flight_id INT,
	
	CONSTRAINT fk_customer_id FOREIGN KEY(customer_id) 
	REFERENCES customers(customer_id),
	CONSTRAINT fk_cflight_id FOREIGN KEY(flight_id) 
	REFERENCES flights(flight_id)
);

#2
INSERT INTO flights(departure_time, arrival_time, `status`, origin_airport_id, destination_airport_id, airline_id)
SELECT '2017-06-19 14:00:00', '2017-06-21 11:00:00', 
CASE
	WHEN MOD(a.airline_id, 4) = 0 THEN 'Departing'
	WHEN MOD(a.airline_id, 4) = 1 THEN 'Delayed'
	WHEN MOD(a.airline_id, 4) = 2 THEN 'Arrived'
	WHEN MOD(a.airline_id, 4) = 3 THEN 'Canceled'
END,
CEIL(SQRT(LENGTH(a.airline_name))),
CEIL(SQRT(LENGTH(a.nationality))),
a.airline_id FROM airlines AS a
WHERE a.airline_id BETWEEN 1 AND 10;

#3
UPDATE flights AS f SET f.airline_id = 1
WHERE f.`status` = 'Arrived';

#4
UPDATE tickets AS t 
INNER JOIN flights AS f ON t.flight_id = f.flight_id
INNER JOIN airlines AS a ON f.airline_id = a.airline_id 
AND a.rating = (SELECT MAX(a1.rating) FROM airlines AS a1)
SET t.price = t.price * 1.5
WHERE t.flight_id = f.flight_id;

#5
SELECT ticket_id, price, class, seat FROM tickets;

#6
SELECT c.customer_id, CONCAT(c.first_name, ' ', c.last_name) AS full_name, c.gender FROM customers AS c
ORDER BY full_name, c.customer_id;

#7
SELECT f.flight_id, f.departure_time, f.arrival_time FROM flights AS f
WHERE f.`status` = 'Delayed';

#8
SELECT a.airline_id, a.airline_name, a.nationality, a.rating FROM airlines AS a
WHERE a.airline_id IN(SELECT f.airline_id FROM flights AS f)
ORDER BY a.rating DESC LIMIT 5;

#9
SELECT t.ticket_id, a.airport_name AS destination,	CONCAT(c.first_name, ' ', c.last_name) 
AS customer_name FROM tickets AS t
INNER JOIN flights AS f ON t.flight_id = f.flight_id
INNER JOIN airports AS a ON f.destination_airport_id = a.airport_id
INNER JOIN customers AS c ON t.customer_id = c.customer_id
WHERE t.price < 5000 AND t.class = 'First';

#10
SELECT DISTINCT c.customer_id, CONCAT(c.first_name, ' ', c.last_name) AS full_name, t.town_name FROM customers AS c
INNER JOIN tickets AS tc ON c.customer_id = tc.customer_id
INNER JOIN flights AS f ON tc.flight_id = f.flight_id
INNER JOIN airports AS a ON a.airport_id = f.origin_airport_id
INNER JOIN towns AS t ON a.town_id = t.town_id
WHERE f.`status` = 'Departing' AND c.home_town_id = t.town_id
ORDER BY c.customer_id;

#11
SELECT DISTINCT c.customer_id, CONCAT(c.first_name, ' ', c.last_name) AS full_name, 2016 - YEAR(c.date_of_birth) AS age
FROM customers AS c
INNER JOIN tickets AS tc ON c.customer_id = tc.customer_id
INNER JOIN flights AS f ON tc.flight_id = f.flight_id AND f.`status` = 'Departing'
ORDER BY age, c.customer_id;

#12
SELECT c.customer_id, CONCAT(c.first_name, ' ', c.last_name) AS full_name, 
MAX(tc.price) AS ticket_price, a.airport_name AS destination FROM customers AS c
INNER JOIN tickets AS tc ON c.customer_id = tc.customer_id
INNER JOIN flights AS f ON tc.flight_id = f.flight_id AND f.`status` = 'Delayed'
INNER JOIN airports AS a ON f.destination_airport_id = a.airport_id
GROUP BY c.customer_id 
ORDER BY ticket_price DESC, c.customer_id LIMIT 3;

#13
SELECT f.flight_id, f.departure_time, f.arrival_time, 
a1.airport_name AS origin, a2.airport_name AS destination FROM (
SELECT * FROM flights AS f1 WHERE f1.`status` = 'Departing' ORDER BY f1.departure_time DESC LIMIT 5) AS f
INNER JOIN airports AS a1 ON f.origin_airport_id = a1.airport_id
INNER JOIN airports AS a2 ON f.destination_airport_id = a2.airport_id
ORDER BY f.departure_time, f.flight_id;

#14
SELECT DISTINCT c.customer_id, CONCAT(c.first_name, ' ', c.last_name) AS full_name, 2016 - YEAR(c.date_of_birth) AS age 
FROM customers AS c
INNER JOIN tickets AS t ON c.customer_id = t.customer_id
INNER JOIN flights AS f ON t.flight_id = f.flight_id AND f.`status` = 'Arrived'
WHERE 2016 - YEAR(c.date_of_birth) < 21
ORDER BY age DESC, c.customer_id;

#15
SELECT DISTINCT a.airport_id, a.airport_name, COUNT(t.customer_id) AS passengers FROM airports AS a
INNER JOIN flights AS f ON a.airport_id = f.origin_airport_id AND f.`status` = 'Departing'
INNER JOIN tickets AS t ON f.flight_id = t.flight_id
GROUP BY a.airport_id;

#16
CREATE PROCEDURE udp_submit_review(c_id INT, r_content VARCHAR(255), r_grade INT, a_name VARCHAR(50))
BEGIN 
	IF(a_name NOT IN(SELECT a.airline_name FROM airlines AS a)) THEN 
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Airline does not exist';
	ELSE 
		INSERT INTO customer_reviews(review_content, review_grade, airline_id, customer_id)
		VALUES(r_content, r_grade, (SELECT a.airline_id FROM airlines AS a WHERE a_name = a.airline_name), c_id);
	END IF;
END

#17
CREATE PROCEDURE udp_purchase_ticket
(customer_id INT, flight_id INT, ticket_price DECIMAL(10,2), class VARCHAR(10), seat VARCHAR(10))
BEGIN
	IF(ticket_price > (SELECT balance FROM customer_bank_accounts  WHERE customer_id = customer_id)) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Insufficient bank account balance for ticket purchase.';
	ELSE
		UPDATE customer_bank_accounts 
		SET balance = balance - ticket_price;
		INSERT INTO flights(price, class, seat, customer_id, flight_id)
		VALUES(ticket_price, class, seat, customer_id, flight_id);
	END IF;
END

#18
CREATE TRIGGER tr_update_flights
BEFORE UPDATE
ON flights
FOR EACH ROW
BEGIN
    DECLARE origin VARCHAR(50);
    DECLARE destination VARCHAR(50);
    DECLARE passengers INT;
    
    SET origin:=(SELECT a1.airport_name FROM airports AS a1 WHERE new.origin_airport_id=a1.airport_id);
    SET destination:=(SELECT a1.airport_name FROM airports AS a1 WHERE new.destination_airport_id=a1.airport_id);
    SET passengers := (SELECT count(t.ticket_id) FROM tickets AS t WHERE t.flight_id=new.flight_id );
    
    IF (new.status='Arrived' AND 
    old.status != 'Arrived' AND
    old.status != 'Cancelled' ) THEN
		INSERT INTO `arrived_flights`(`flight_id`,`arrival_time`,`origin`,`destination`,`passengers`)
			VALUES (new.flight_id, new.arrival_time, origin, destination, passengers);
	END IF;
END