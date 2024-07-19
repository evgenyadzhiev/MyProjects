--1
SELECT
	COUNT(*)
FROM
	fake_apps;

--2
SELECT
	COUNT(*)
FROM
	fake_apps
WHERE
	price = 0.00;

--3
SELECT
	SUM(downloads)
FROM
	fake_apps;

--4
SELECT
	MAX(downloads),
	MIN(downloads),
	AVG(downloads)
FROM
	fake_apps;

--5
SELECT
	name,
	price,
	ROUND(price,0)
FROM
	fake_apps;

--6
SELECT
	ROUND(AVG(price),2)
FROM
	fake_apps;

--7
SELECT
	price,
	COUNT(*)
FROM
	fake_apps
WHERE
	downloads > 20000
GROUP BY
	price;

--8
SELECT
	category,
	SUM(downloads)
FROM
	fake_apps
GROUP BY
	category;

--9
SELECT
	category,
	price,
	AVG(downloads)
FROM
	fake_apps
GROUP BY
	1,2
ORDER BY
	1;