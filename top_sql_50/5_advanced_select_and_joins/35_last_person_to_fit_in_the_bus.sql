-- Problem: https://leetcode.com/problems/last-person-to-fit-in-the-bus/description/?envType=study-plan-v2&envId=top-sql-50
-- LeetCode ID: 1204
-- Title: Last Person to Fit in the Bus
-- Difficulty: Medium

WITH rolling_sum AS (
    SELECT
        person_name
        , turn
        , SUM(weight) OVER (ORDER BY turn) as rolling_weight
    FROM Queue
)

SELECT
    person_name
FROM rolling_sum
WHERE rolling_weight <= 1000
ORDER BY turn DESC
LIMIT 1;

-- Calculates a running total of weights in queue order using SUM() OVER (ORDER BY turn).
-- Filters only the people whose entry kept the total at or below 1000.
-- Takes the last one of those (highest turn) as the final person allowed on the bus.