-- Problem: https://leetcode.com/problems/percentage-of-users-attended-a-contest/description/?envType=study-plan-v2&envId=top-sql-50
-- LeetCode ID: 1633
-- Title: Percentage of Users Attended a Contest
-- Difficulty: Easy

WITH total_users as (
    SELECT COUNT(*) as total
    FROM Users
)

SELECT
    r.contest_id
    , ROUND(COUNT(DISTINCT r.user_id) * 100.0 / MAX(tu.total), 2) as percentage
FROM Register r
CROSS JOIN total_users tu
GROUP BY r.contest_id
ORDER BY percentage DESC, r.contest_id;

-- CROSS JOIN brings total user count into each row for the percentage calc.
-- MAX(tu.total) is safe because total_users only has one row.
-- Multiplies by 100.0 to force float division, then rounds to 2 decimals.