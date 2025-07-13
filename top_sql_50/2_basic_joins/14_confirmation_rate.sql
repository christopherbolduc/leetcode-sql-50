-- Problem: https://leetcode.com/problems/confirmation-rate/description/?envType=study-plan-v2&envId=top-sql-50
-- LeetCode ID: 1934
-- Title: Confirmation Rate
-- Difficulty: Medium

SELECT
    s.user_id
    , ROUND(
        AVG(
            CASE WHEN c.action = 'confirmed' THEN 1.00 ELSE 0 END 
        )
      , 2) as confirmation_rate
FROM Signups s
LEFT JOIN Confirmations c
    ON s.user_id = c.user_id
GROUP BY s.user_id;

-- LEFT JOIN includes users who signed up but never confirmed.
-- CASE + AVG gives the confirmation rate per user (1 for confirmed, 0 otherwise).
-- Used 1.00 to force decimal division; ROUNDed to 2 decimals.