-- Create 7 CTEs
-- t1: extract month from sign_up date and last_login date
-- t2: count the number of lost users each month
-- t3: count the number of users signed up each month
-- t4: count the number of accumulated lost users each month
-- t5: calculate the total number of payments and the sum of payment amounts per user_id using the payment table
-- t6: add sign_month column to t5 by performing a join with t1
-- t7: calculate the number of paid users and total revenue for December, grouped by signup month

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
	, SUM(lost) OVER(PARTITION BY t2.sign_month ORDER BY t2.last_month ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) as cumlost
	, cohort_size
FROM t2
JOIN t3 ON t3.sign_month = t2.sign_month
)
, t5 AS -- calculate the total number of payments and the sum of payment amounts (revenue) per user_id for December
(
SELECT user_id, COUNT(*) AS payment_cnt, SUM(amount) AS revenue
FROM payment
GROUP BY user_id
)
, t6 AS -- add sign_month column to t5 by performing a join with t1
(
SELECT t5.user_id, revenue, sign_month
FROM t5
JOIN t1 ON t5.user_id = t1.user_id
)
, t7 AS -- calculate the number of paid users and total revenue for December, grouped by signup month
(
SELECT sign_month, COUNT(*) AS paid_users, SUM(revenue) AS total_revenue
FROM t6
GROUP BY sign_month
)
SELECT t7.sign_month
	, cohort_size
	, ROUND(lost*100.0/cohort_size,0) AS retention_rate
	, lost AS active_users -- the number of active users in December 2019
	, paid_users
	, ROUND(paid_users*100.0/lost,0) AS paid_user_ratio
	, ROUND(total_revenue/paid_users,0) AS ARPPU
	, total_revenue
FROM t7
JOIN t3 ON t3.sign_month = t7.sign_month
JOIN (SELECT sign_month, lost FROM t2 WHERE last_month = 12) t2 ON t2.sign_month = t7.sign_month
ORDER BY t7.sign_month;
