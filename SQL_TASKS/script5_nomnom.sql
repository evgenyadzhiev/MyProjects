--1
SELECT
	*
FROM
	nomnom
WHERE
	cuisine = 'Japanese'
	AND
	price = '$$';


--2
SELECT
	*
FROM
	nomnom
WHERE
	health IS NULL;