-- Problem: https://leetcode.com/problems/restaurant-growth/description/?envType=study-plan-v2&envId=top-sql-50
-- LeetCode ID: 1321
-- Title: Restaurant Growth
-- Difficulty: Medium

SELECT
    visited_on
    , ROUND(SUM(amount) OVER (
        ORDER BY visited_on
        ROWS BETWEEN 6 PRECEDING AND CURRENT ROW)
      , 2) as amount
    , ROUND(AVG(amount) OVER (
        ORDER BY visited_on
        ROWS BETWEEN 6 PRECEDING AND CURRENT ROW)
      , 2) as average_amount
FROM (
    SELECT visited_on, SUM(amount) as amount
    FROM Customer
    GROUP BY visited_on
) as t
ORDER BY visited_on
OFFSET 6 ROWS;

-- Subquery aggregates total amount per day.
-- Window functions compute a rolling 7-day sum and average by date.
-- OFFSET 6 skips the first 6 rows (no full 7-day window before them).

-- Alternative version using self-join:
SELECT
    c1.visited_on
    , ROUND(SUM(c2.amount), 2) as amount
    , ROUND(AVG(c2.amount), 2) as average_amount
FROM (
    SELECT visited_on, SUM(amount) as amount
    FROM Customer
    GROUP BY visited_on
) c1
JOIN (
    SELECT visited_on, SUM(amount) as amount
    FROM Customer
    GROUP BY visited_on
) c2
  ON c2.visited_on BETWEEN c1.visited_on - INTERVAL '6 days' AND c1.visited_on
GROUP BY c1.visited_on
HAVING COUNT(*) = 7
ORDER BY c1.visited_on;

-- For each date, joins against the 6 previous days (inclusive).
-- HAVING ensures only full 7-day windows are kept.