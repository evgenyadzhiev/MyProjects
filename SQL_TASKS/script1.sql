--1
SELECT
	*
FROM
	video_game_sales;

--2	
SELECT
	COUNT(*)
FROM
	video_game_sales;


--3
SELECT
	name, year
FROM
	video_game_sales
WHERE
	-- Change the year column data type from text to numeric to filter correctly.
	CAST((CASE WHEN year='N/A' then '0' else year end) AS int) > 2010
ORDER BY year

--4
SELECT
	*
FROM
	video_game_sales
	ORDER BY
	--replaced the NULL value with 0 when sorting
	(CASE WHEN global_sales IS NULL then 0 else global_sales end)  DESC


--5
SELECT
	DISTINCT platform
FROM
	video_game_sales


--6
SELECT
	*
FROM
	video_game_sales
LIMIT 10



--7
SELECT
	*
FROM
	video_game_sales
WHERE
	global_sales > 1 AND genre = 'Action'



--8
SELECT
	*
FROM
	video_game_sales
WHERE
	genre = 'Adventure' OR genre = 'Action'



--9
SELECT
	*
FROM
	video_game_sales
WHERE
	(global_sales BETWEEN 1 AND 5) AND (year = '2005' OR year = '2006')
