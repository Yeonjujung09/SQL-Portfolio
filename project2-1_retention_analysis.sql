-- Create 4 CTEs
-- t1: extract month from sign_up date and last_login date
-- t2: count the number of lost users each month
-- t3: count the number of users signed up each month
-- t4: count the number of accumulated lost users each month

WITH t1 AS -- extract month from sign_up date and last_login date
(
SELECT *, EXTRACT(MONTH FROM sign_up) AS sign_month, EXTRACT(MONTH FROM last_login) AS last_month
FROM retention
)
, t2 AS -- count the number of lost users each month
(
SELECT sign_month, last_month, COUNT(*) AS lost
FROM t1
GROUP BY sign_month, last_month
)
, t3 AS -- count the number of users signed up each month
(
SELECT sign_month, COUNT(*) AS cohort_size
FROM t1	
GROUP BY sign_month
)
, t4 AS -- count the number of accumulated lost users each month
(
SELECT t2.sign_month AS start
	, t2.last_month AS last
	, lost
	, SUM(lost) OVER (PARTITION BY t2.sign_month ORDER BY t2.last_month ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cumlost
	, cohort_size
FROM t2
JOIN t3 ON t3.sign_month = t2.sign_month
)

SELECT start
	, last
	, lost
	, cumlost
	, ROUND((cohort_size - COALESCE(LAG(cumlost) over (PARTITION BY start),0))/cohort_size*100,0) AS retention_rate
FROM t4;
