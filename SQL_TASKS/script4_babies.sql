--1
SELECT
	name,
	year,
	number
FROM
	babies
WHERE
	name = 'Lillian' AND gender = 'F';

--2
SELECT
	name,
	gender,
	number
FROM
	babies
WHERE
	year = 1880
ORDER BY
	number DESC
LIMIT
	10;