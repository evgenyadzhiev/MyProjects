--1
SELECT
	title,
	publisher
FROM
	news
ORDER BY
	title ASC;


--2
SELECT
	*
FROM
	news
WHERE
	category = 'b'
ORDER BY
	timestamp DESC
LIMIT 20;