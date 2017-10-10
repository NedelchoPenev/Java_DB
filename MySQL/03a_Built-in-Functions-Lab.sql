#1
SELECT title FROM books
WHERE substring(title, 1, 3) = 'The';

#2
UPDATE books
SET title = replace(title, 'The', '***')
WHERE substring(title, 1, 3) = 'The';
SELECT title FROM books
WHERE substring(title, 1, 3) = '***';

#3
SELECT truncate(sum(cost), 2) AS total_price FROM books;

#4
SELECT concat(first_name, ' ', last_name) AS `Full name`, timestampdiff(DAY, born, died) AS `Days Lived` 
FROM authors;

#5
SELECT title FROM books
WHERE title LIKE 'Harry Potter%';