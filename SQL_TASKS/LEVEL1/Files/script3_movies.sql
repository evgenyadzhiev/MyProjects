--1
SELECT
	*
FROM
	movies;

--2
SELECT
	name,
	genre,
	year
FROM
	movies;

--3
SELECT
	name AS Titles
FROM
	movies;

--4
SELECT
	DISTINCT genre
FROM
	movies;

--5
SELECT
	*
FROM
	movies
WHERE
	imdb_rating < 5;

--6
SELECT
	*
FROM
	movies
WHERE
	year > 2014;

--7
SELECT
	name
FROM
	movies
WHERE
	imdb_rating IS NOT NULL;

--8
SELECT
	name
FROM
	movies
WHERE
	imdb_rating IS NULL;

--9.1
SELECT
	*
FROM
	movies
WHERE
	year >= 1990 AND year <= 1999; 

--9.2
SELECT
	*
FROM
	movies
WHERE
	year BETWEEN 1990 AND 1999;

--10
SELECT
	*
FROM
	movies
WHERE
	name BETWEEN 'A' AND 'J'
ORDER BY
	name ASC;

--11
SELECT
	*
FROM
	movies
WHERE
	genre = 'romance' 
	AND
	year BETWEEN 1990 AND 1999;

--12
SELECT
	*
FROM
	movies
WHERE
	imdb_rating > 8
	AND
	year BETWEEN 1970 AND 1979;

--13
SELECT
	*
FROM
	movies
WHERE
	genre = 'horror' 
	AND
	year < 1985;

--14
SELECT
	*
FROM
	movies
WHERE
	genre = 'action'
	OR
	year > 2014
ORDER BY
	genre ASC;

--15
SELECT
	*
FROM
	movies
WHERE
	genre = 'romance'
	OR
	genre = 'comedy'
ORDER BY
	genre DESC;

--16
SELECT
	*
FROM
	movies
WHERE
	imdb_rating IS NOT NULL
ORDER BY
	imdb_rating DESC
LIMIT 
	3;

--17
SELECT
	year,
	AVG(imdb_rating)
FROM
	movies
GROUP BY
	year
ORDER BY
	year ASC;

--18.1
SELECT
	ROUND(imdb_rating),
	COUNT(name)
FROM 
	movies
GROUP BY
	ROUND(imdb_rating)
ORDER BY
	ROUND(imdb_rating);

--18.2
SELECT
	ROUND(imdb_rating),
	COUNT(name)
FROM 
	movies
GROUP BY
	1
ORDER BY
	1;

--19
SELECT
	year,
	genre,
	COUNT(name)
FROM
	movies
GROUP BY
	1,2
HAVING(COUNT(name) > 5)
ORDER BY
	1 DESC;