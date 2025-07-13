-- Problem: https://leetcode.com/problems/rising-temperature/description/?envType=study-plan-v2&envId=top-sql-50
-- LeetCode ID: 197
-- Title: Rising Temperature
-- Difficulty: Easy 

SELECT
    tod.id
FROM Weather tod
JOIN Weather yes
    ON tod.recordDate = yes.recordDate + INTERVAL '1 day'
    AND tod.temperature > yes.temperature; 

-- Self-join on the Weather table to compare each day to the previous one.
-- Using INTERVAL '1 day' makes the date logic clear and avoids any ambiguity.
-- Grabbing rows where today’s temperature is higher than yesterday’s.