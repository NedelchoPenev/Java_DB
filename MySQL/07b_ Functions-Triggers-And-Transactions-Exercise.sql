#1
DELIMITER $$
CREATE PROCEDURE usp_get_employees_salary_above_35000()
BEGIN
	SELECT e.first_name, e.last_name FROM employees AS e
	WHERE e.salary > 35000
	ORDER BY e.first_name, e.last_name;
END $$

#2
DELIMITER $$
CREATE PROCEDURE usp_get_employees_salary_above(above_salary DOUBLE)
BEGIN
	SELECT e.first_name, e.last_name FROM employees AS e
	WHERE e.salary >= above_salary
	ORDER BY e.first_name, e.last_name;
END $$

#3
DELIMITER $$
CREATE PROCEDURE usp_get_towns_starting_with (start_with VARCHAR(10))
BEGIN
	SELECT name FROM towns
	WHERE name LIKE CONCAT(start_with, '%')
	ORDER BY name;
END $$

#4
DELIMITER $$
CREATE PROCEDURE usp_get_employees_from_town (town VARCHAR(25))
BEGIN
	SELECT e.first_name, e.last_name FROM employees AS e
	INNER JOIN addresses AS a ON a.address_id = e.address_id
	INNER JOIN towns AS t ON t.town_id = a.town_id
	WHERE t.name = town
	ORDER BY e.first_name, e.last_name;
END $$

#5
DELIMITER $$
CREATE FUNCTION ufn_get_salary_level(employee_salary DECIMAL)
RETURNS VARCHAR(10)
BEGIN
	DECLARE salary_level varchar(10);
	if(employee_salary < 30000) then 
		set salary_level := 'Low';
	elseif(employee_salary >= 30000 and employee_salary <= 50000) then 
		set salary_level := 'Average';
	else 
		set salary_level := 'High';
	end if;
	RETURN salary_level;
END $$

#6
CREATE FUNCTION ufn_get_salary_level(employee_salary DECIMAL)
RETURNS VARCHAR(10)
BEGIN
	DECLARE salary_level varchar(10);
	if(employee_salary < 30000) then 
		set salary_level := 'Low';
	elseif(employee_salary >= 30000 and employee_salary <= 50000) then 
		set salary_level := 'Average';
	else 
		set salary_level := 'High';
	end if;
	RETURN salary_level;
END;

DELIMITER $$
CREATE PROCEDURE usp_get_employees_by_salary_level(salary_level VARCHAR(10))
BEGIN
	SELECT e.first_name, e.last_name FROM employees AS e
	WHERE ufn_get_salary_level(e.salary) = salary_level
	ORDER BY e.first_name DESC, e.last_name DESC;
END $$

#7
CREATE FUNCTION ufn_is_word_comprised(set_of_letters VARCHAR(50), word VARCHAR(50))
RETURNS INT
BEGIN
	DECLARE result INT;
	DECLARE ind INT;
	DECLARE val INT;
	DECLARE size INT;
	SET size := LENGTH(word);
	SET ind := 1;
	SET result := 1;
	
	WHILE(ind < size) DO
		SET val := (SELECT INSTR(set_of_letters, SUBSTRING(word, ind, 1)));
			IF(val = 0) THEN 
				SET result = 0;
				RETURN result;
			END IF;
		SET ind = ind +1;
	END WHILE;
	RETURN result;
END

#8
SET FOREIGN_KEY_CHECKS = 0;

DELETE FROM employees
WHERE department_id IN (SELECT d.department_id FROM `departments` AS d
WHERE d.name IN ('Production', 'Production Control'));

DELETE FROM departments
WHERE
  name IN ('Production', 'Production Control');
SET FOREIGN_KEY_CHECKS = 1;

#9
DELIMITER $$
CREATE PROCEDURE usp_get_holders_full_name()
BEGIN
	SELECT CONCAT(ac.first_name, ' ', ac.last_name) AS full_name FROM account_holders AS ac
	ORDER BY full_name;
END $$

#10
DELIMITER $$
CREATE PROCEDURE usp_get_holders_with_balance_higher_than(number DECIMAL)
BEGIN
	SELECT ac.first_name, ac.last_name FROM account_holders AS ac
	JOIN accounts AS a ON ac.id = a.account_holder_id
	GROUP BY ac.first_name, ac.last_name
	HAVING SUM(a.balance) > number;
END $$

#11
DELIMITER $$
CREATE FUNCTION ufn_calculate_future_value(`sum` DECIMAL(10, 2), interest_rate FLOAT(10, 2), yearly INT)
RETURNS DECIMAL(10, 2)
BEGIN
	DECLARE result DECIMAL(10, 2);
		SET result := `sum` * POW((1 + interest_rate), yearly);
	RETURN result;
END $$

#12
DELIMITER $$
CREATE PROCEDURE usp_calculate_future_value_for_account(id INT, interest DECIMAL(12,2))
BEGIN
SELECT a.id AS 'account_id', ah.first_name, ah.last_name, SUM(a.balance) AS 'current_balance',
ufn_calculate_future_value(sum(a.balance), interest, 5) AS 'balance_in_5_years' FROM accounts AS a
INNER JOIN account_holders AS ah ON a.account_holder_id = ah.id
WHERE a.id = id;
END $$

#13
DELIMITER $$
CREATE PROCEDURE usp_deposit_money (account_id INT, money DECIMAL(19, 4))
BEGIN
	START TRANSACTION;
	UPDATE accounts SET accounts.balance = accounts.balance + money
    WHERE accounts.id=account_id;
    IF (money < 0) THEN
		ROLLBACK;
    ELSE
		COMMIT;
	END IF;
END $$

#14
DELIMITER $$
CREATE PROCEDURE usp_withdraw_money (account_id INT, money DECIMAL(19, 4))
BEGIN
	START TRANSACTION;
	UPDATE accounts AS a SET a.balance = a.balance - money
    WHERE a.id=account_id;
    IF (money < 0 OR (
		SELECT a2.balance FROM accounts AS a2
        WHERE a2.id=account_id
    ) < money) THEN
		ROLLBACK;
    ELSE
		COMMIT;
	END IF;
END $$

#15
DELIMITER $$
CREATE PROCEDURE usp_transfer_money(from_id INT, to_id INT, amount DECIMAL(19,4))
BEGIN
	START TRANSACTION;
    UPDATE accounts SET accounts.balance = accounts.balance + amount
    WHERE accounts.id=to_id;
    UPDATE accounts AS a SET a.balance = a.balance - amount
    WHERE a.id=from_id;
    IF (from_id=to_id) THEN
		ROLLBACK;
	ELSEIF (from_id NOT IN (SELECT a.id FROM accounts AS a)) THEN
		ROLLBACK;
	ELSEIF (to_id NOT IN (SELECT a.id FROM accounts AS a)) THEN
		ROLLBACK;
	ELSEIF (amount < 0) THEN
		ROLLBACK;
	ELSEIF (
    (SELECT a2.balance FROM accounts AS a2
	WHERE a2.id=from_id) < amount ) THEN
		ROLLBACK;
	ELSE 
		COMMIT;
	END IF;
END $$

#16
DELIMITER ;
DROP TABLE logs;
CREATE TABLE `logs` (
	log_id INT PRIMARY KEY AUTO_INCREMENT,
    account_id INT,
    old_sum DECIMAL(19,4),
    new_sum DECIMAL(19,4)
);
CREATE TRIGGER tr_log_change
AFTER UPDATE
ON accounts 
FOR EACH ROW
BEGIN
	INSERT INTO `logs` (account_id, old_sum, new_sum)
    VALUES (new.id, old.balance, new.balance);
END $$

#17
DELIMITER ;
CREATE TABLE `notification_emails` (
	id INT PRIMARY KEY AUTO_INCREMENT,
    recipient INT,
    subject VARCHAR(255),
    body TEXT
);

CREATE TRIGGER tr_email_notification
BEFORE INSERT
ON `logs`
FOR EACH ROW
BEGIN
	INSERT INTO notification_emails(recipient, subject, body)
    VALUES (
    new.account_id,
    concat('Balance for account:', ' ', new.account_id),
    concat(date_format(now(), 'On %b %d %Y at %r'), ' ', 'your balance was changed from '
    , new.old_sum, ' to ', new.new_sum)
    );
END $$