SELECT *
FROM survey
LIMIT 10;

SELECT question, COUNT(DISTINCT user_id) AS 'Distinct Responses'
FROM survey
GROUP BY question;

SELECT *
FROM quiz
LIMIT 5;

SELECT *
FROM home_try_on
LIMIT 5;

SELECT *
FROM purchase
LIMIT 5;

SELECT
DISTINCT quiz.user_id,
CASE
	WHEN home_try_on.user_id IS NOT NULL
 	THEN 'True'
		ELSE 'False'
	END AS 'is_home_try_on', home_try_on.number_of_pairs,
CASE
	WHEN purchase.user_id is NOT NULL THEN 'True'
	ELSE 'False'
END AS 'is_purchase'
FROM quiz
LEFT JOIN home_try_on
ON quiz.user_id = home_try_on.user_id
LEFT JOIN purchase
ON purchase.user_id = quiz.user_id
LIMIT 10;

with funnel AS
(SELECT DISTINCT q.user_id,
   h.user_id IS NOT NULL AS 'is_home_try_on',
   h.number_of_pairs,
   p.user_id IS NOT NULL AS 'is_purchase'
FROM quiz q
LEFT JOIN home_try_on h
   ON q.user_id = h.user_id
LEFT JOIN purchase p
   ON p.user_id = q.user_id)
SELECT
100.0 * sum(is_purchase = 1) / count(*) AS 'Overall Conversion Rate',
100.0 * sum(is_home_try_on = 1) / count(*) AS 'Quiz Taker Conversion',
100.0 * sum(is_home_try_on = 1 AND is_purchase = 1) / sum(is_home_try_on = 1) AS 'Purchase % Home Try On',
100.0 * sum(is_purchase = 1 AND number_of_pairs = '3 pairs') / sum(number_of_pairs = '3 pairs') AS '3 Pair Conversion',
100.0 * sum(is_purchase = 1 AND number_of_pairs = '5 pairs') / sum(number_of_pairs = '5 pairs') AS '5 Pair Conversion'
FROM funnel;

SELECT style, COUNT(*) AS ‘Count’
FROM quiz
GROUP BY style
ORDER BY 2 DESC;

SELECT color, COUNT(*) AS ‘Count’
FROM quiz
GROUP BY color
ORDER BY 2 DESC;

SELECT fit, COUNT(*) AS ‘Count’
FROM quiz
GROUP BY fit
ORDER BY 2 DESC;

SELECT shape, COUNT(*) AS ‘Count’
FROM quiz
GROUP BY shape
ORDER BY 2 DESC;

SELECT style, fit, shape,
COUNT (*) AS 'Count'
FROM quiz
WHERE style = "Women's Styles"
GROUP BY style, fit, shape
ORDER BY Count DESC;
SELECT style, fit, shape,
COUNT (*) AS 'Count'
FROM quiz
WHERE style = "Men's Styles"
GROUP BY style, fit, shape
ORDER BY Count DESC;


SELECT price, COUNT(*) AS “Count”
from purchase
GROUP BY price
ORDER BY 2 DESC;

SELECT model_name AS “Model Name”, COUNT(*) AS “Count”
from purchase
GROUP BY model_name
ORDER BY 2 DESC;

SELECT style, COUNT(*) AS “Count”
from purchase
GROUP BY style
ORDER BY 2 DESC;

SELECT color, COUNT(*) AS “Count”
from purchase
GROUP BY color
ORDER BY 2 DESC;

SELECT model_name AS “Model Name”, style, color, price, COUNT(*) AS “Count”
FROM purchase
GROUP BY style, model_name, color, price
ORDER BY 5 DESC
LIMIT 5;
