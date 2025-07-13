-- Problem: https://leetcode.com/problems/consecutive-numbers/description/?envType=study-plan-v2&envId=top-sql-50
-- LeetCode ID: 180
-- Title: Consecutive Numbers
-- Difficulty: Medium

SELECT DISTINCT num as ConsecutiveNums
FROM (
  SELECT
    num
    , LAG(num, 1) OVER (ORDER BY id) AS prev
    , LAG(num, 2) OVER (ORDER BY id) AS prev2
  FROM Logs
) as t
WHERE num = prev AND num = prev2;

-- Uses LAG to access values from previous two rows in the window ordered by id.
-- Filters for rows where num matches both the previous two — meaning three in a row.
-- DISTINCT ensures we only list each qualifying number once.