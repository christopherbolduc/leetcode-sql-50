-- Problem: https://leetcode.com/problems/exchange-seats/description/?envType=study-plan-v2&envId=top-sql-50
-- LeetCode ID: 626
-- Title: Exchange Seats
-- Difficulty: Medium

SELECT
    CASE WHEN id % 2 = 1 AND id != (SELECT MAX(id) FROM Seat) THEN id + 1
         WHEN id % 2 = 0 THEN id - 1
         ELSE id
         END as id
    , student
FROM Seat
ORDER BY id;

-- First CASE checks if the id is odd and not the highest -> add 1 to swap forward
-- Second CASE checks if the id is even -> subtract 1 to swap backward
-- ELSE handles if the highest id is odd (no one to swap with)