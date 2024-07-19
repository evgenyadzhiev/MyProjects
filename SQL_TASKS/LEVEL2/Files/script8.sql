--1
CREATE SCHEMA IF NOT EXISTS songify

--2
SELECT
	pu.user_id,
	p.description
FROM
	songify.premium_users AS pu
JOIN
	songify.plans AS p
		ON pu.membership_plan_id = p.id;
--3
SELECT
	p.user_id,
	p.play_date,
	s.title
FROM
	songify.plays AS p
JOIN
	songify.songs AS s
		ON p.song_id = s.id;

--4
SELECT
	u.id
FROM
	songify.users AS u
LEFT JOIN
	songify.premium_users AS pu
		ON u.id = pu.user_id
WHERE
	pu.user_id IS NULL;

--5
WITH january AS
	(SELECT
		*
	FROM
		songify.plays
	WHERE
		EXTRACT(MONTH FROM play_date) = 1),
	
february AS
	(SELECT
		*
	FROM
		songify.plays
	WHERE
		EXTRACT(MONTH FROM play_date) = 2)

SELECT
	j.user_id
FROM
	january AS j
LEFT JOIN
	february AS f
		ON j.user_id = f.user_id 
WHERE
	f.user_id IS NULL;

--6
SELECT
	pu.user_id,
	pu.purchase_date::date AS purchase_date,
	pu.cancel_date::date AS cancel_date,
	m.months::date
FROM
	songify.months AS m
CROSS JOIN
	songify.premium_users AS pu;

--7
SELECT
	pu.user_id,
  	m.months,
	CASE
    	WHEN (pu.purchase_date <= m.months)
      		AND
      		(pu.cancel_date >= m.months OR pu.cancel_date IS NULL)
    	THEN 'active'
    	ELSE 'not_active'
  	END AS status
FROM
	songify.months AS m
CROSS JOIN
	songify.premium_users AS pu;

--8
SELECT
	*
FROM
	songify.songs
UNION
SELECT
	*
FROM
	songify.bonus_songs
LIMIT
	10;

--9
SELECT '2017-01-01' as month
UNION
SELECT '2017-02-01' as month
UNION
SELECT '2017-03-01' as month
ORDER BY
	1;

--10
WITH play_count AS
	(SELECT
		p.song_id,
		COUNT(*) AS "times_played"
	FROM
		songify.plays AS p
	GROUP BY
		p.song_id)
SELECT
	s.title,
	s.artist,
	pc.times_played
FROM
	play_count AS pc
JOIN
	songify.songs AS s
		ON pc.song_id = s.id;

--10
CREATE SCHEMA IF NOT EXISTS metropolitan

--12
SELECT
	*
FROM
	metropolitan.met
LIMIT
	10;

--13
SELECT
	COUNT(*)
FROM
	metropolitan.met;

--14
	COUNT(*)
FROM
	metropolitan.met
WHERE
	category ILIKE '%celery%';

--15
SELECT
	COUNT(*)
FROM
	metropolitan.met
WHERE
	category ILIKE '%celery%';

--15
SELECT
	MIN(date)
FROM
	metropolitan.met;

--final
SELECT
	date,
	title,
	medium
FROM
	metropolitan.met
WHERE
	date LIKE '%1600%';

--17
SELECT
	country,
	COUNT(*)
FROM
	metropolitan.met
WHERE
	country IS NOT NULL
GROUP BY
	country
ORDER BY
	2 DESC
LIMIT
	10;

--18
SELECT
	category,
	COUNT(*)
FROM
	metropolitan.met
GROUP BY
	category
HAVING
	COUNT(*) > 100;

--19
SELECT
	medium,
	COUNT(*)
FROM
	metropolitan.met
WHERE
	medium ILIKE '%gold%' OR medium ILIKE '%silver%'
GROUP BY
	medium
ORDER BY
	2 DESC;

--better solution
WITH gold_silver AS
	(SELECT
		CASE
			WHEN medium ILIKE '%gold%' THEN 'Gold'
			WHEN medium ILIKE '%silver%' THEN 'Silver'
			ELSE NULL
		END AS Bling,
		COUNT(*)
	FROM
		metropolitan.met
	GROUP BY
		1
	ORDER BY
		2 DESC)
SELECT
	*
FROM
	gold_silver AS gs
WHERE
	gs.Bling IS NOT NULL;


--20
CREATE SCHEMA IF NOT EXISTS vr_startup

--21
SELECT
	*
FROM
	vr_startup.employees;

--22
SELECT
	*
FROM
	vr_startup.projects;

--23
SELECT
	first_name,
	last_name
FROM
	vr_startup.employees
WHERE
	current_project IS NULL;


--24
SELECT
	p.project_name
FROM
	vr_startup.projects AS p
WHERE
	p.project_id
		NOT IN
			(SELECT
				e.current_project
			FROM
				vr_startup.employees AS e
			WHERE
				e.current_project IS NOT NULL);

--25
SELECT
	p.project_name
FROM
	vr_startup.projects AS p
JOIN
	vr_startup.employees AS e
		ON p.project_id = e.current_project
GROUP BY
	p.project_name
ORDER BY
	COUNT(e.employee_id) DESC
LIMIT
	1;

--26
SELECT
	p.project_name
FROM
	vr_startup.projects AS p
JOIN
	vr_startup.employees AS e
		ON p.project_id = e.current_project
GROUP BY
	p.project_name
HAVING
	COUNT(e.employee_id) > 1
ORDER BY
	COUNT(e.employee_id) DESC;

--27
SELECT
	(COUNT(*) * 2)
	-
	(SELECT
		COUNT(*)
	FROM
		vr_startup.employees AS e
	WHERE
		e.current_project IS NOT NULL
		AND
		e.position = 'Developer') AS "Count"
FROM
	vr_startup.projects AS p;

-- Personality type		…not compatible with
-- 	INFP			ISFP, ESFP, ISTP, ESTP, ISFJ, ESFJ, ISTJ, ESTJ
-- 	ENFP			ISFP, ESFP, ISTP, ESTP, ISFJ, ESFJ, ISTJ, ESTJ
-- 	INFJ			ISFP, ESFP, ISTP, ESTP, ISFJ, ESFJ, ISTJ, ESTJ
-- 	ENFJ			ESFP, ISTP, ESTP, ISFJ, ESFJ, ISTJ, ESTJ
-- 	ISFP			INFP, ENFP, INFJ
-- 	ESFP			INFP, ENFP, INFJ, ENFJ
-- 	ISTP			INFP, ENFP, INFJ, ENFJ
-- 	ESTP			INFP, ENFP, INFJ, ENFJ
-- 	ISFJ			INFP, ENFP, INFJ, ENFJ
-- 	ESFJ			INFP, ENFP, INFJ, ENFJ
-- 	ISTJ			INFP, ENFP, INFJ, ENFJ
-- 	ESTJ			INFP, ENFP, INFJ, ENFJ

--28
SELECT
	e.personality
FROM
	vr_startup.employees AS e
GROUP BY
	e.personality
ORDER BY
	COUNT(e.personality) DESC
LIMIT
	1;

--29
SELECT
	p.project_name
FROM
	vr_startup.projects AS p
JOIN
	vr_startup.employees AS e
		ON p.project_id = e.current_project
WHERE
	e.personality = (SELECT
				e.personality
			FROM
				vr_startup.employees AS e
			GROUP BY
				e.personality
			ORDER BY
				COUNT(e.personality) DESC
			LIMIT
				1);

--30
SELECT
	e.first_name,
	e.last_name,
	e.personality,
	p.project_name
FROM
	vr_startup.projects AS p
JOIN
	vr_startup.employees AS e
		ON p.project_id = e.current_project
WHERE
	e.personality = (SELECT
						e.personality
					FROM
						vr_startup.employees AS e
					WHERE
					 	e.current_project IS NOT NULL
					GROUP BY
						e.personality
					ORDER BY
						COUNT(e.personality) DESC
					LIMIT
						1);

--31
SELECT
	e.first_name,
	e.last_name,
	e.personality,
	p.project_name,	
	CASE
		WHEN e.personality IN ('INFP', 'ENFP', 'INFJ') THEN (SELECT COUNT(*) FROM vr_startup.employees AS e WHERE e.personality IN ('ISFP', 'ESFP', 'ISTP', 'ESTP', 'ISFJ', 'ESFJ', 'ISTJ', 'ESTJ'))
		WHEN  e.personality = 'ENFJ' THEN (SELECT COUNT(*) FROM vr_startup.employees AS e WHERE e.personality IN ('ESFP', 'ISTP', 'ESTP', 'ISFJ', 'ESFJ', 'ISTJ', 'ESTJ'))
		WHEN  e.personality = 'ISFP' THEN (SELECT COUNT(*) FROM vr_startup.employees AS e WHERE e.personality IN ('INFP', 'ENFP', 'INFJ'))  
		WHEN  e.personality IN ('ESFP', 'IESTP', 'ESTP', 'ISFJ', 'ESFJ', 'ISTJ', 'ESTJ') THEN (SELECT COUNT(*) FROM vr_startup.employees AS e WHERE e.personality IN ('INFP', 'ENFP', 'INFJ', 'ENFJ'))
		ELSE 0
	END AS imcompats
FROM
	vr_startup.employees AS e
LEFT JOIN
	vr_startup.projects AS p
		ON p.project_id = e.current_project;







