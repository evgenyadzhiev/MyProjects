--1
SELECT
	"date",
	average_price,
	region
FROM
	avocado_prices

	

--2
SELECT
	*
FROM
	avocado_prices
WHERE
	region = 'California'

	

--3
SELECT
	*
FROM
	avocado_prices
ORDER BY
	"date"


--4
SELECT
	AVG(average_price) AS avg_price
FROM
	avocado_prices


--5
SELECT
	SUM("total_volume") AS sum_volume
FROM
	avocado_prices


--6
SELECT
	*
FROM
	avocado_prices
WHERE 
	average_price BETWEEN 1.00 AND 1.50



--7
SELECT
	*
FROM
	avocado_prices
WHERE year = 2015 AND region = 'Albany'


--8
SELECT
	*
FROM
	avocado_prices
WHERE region ='Boston' OR region = 'Chicago'



--9
SELECT
	*
FROM
	avocado_prices
WHERE
	(average_price BETWEEN 1.00 AND 2.00) AND (type = 'conventional' OR region = 'California')

