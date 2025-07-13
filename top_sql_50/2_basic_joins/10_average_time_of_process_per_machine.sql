-- Problem: https://leetcode.com/problems/average-time-of-process-per-machine/description/?envType=study-plan-v2&envId=top-sql-50
-- LeetCode ID: 1661
-- Title: Average Time of Process per Machine
-- Difficulty: Easy 

WITH start_end_pairs AS (
    SELECT
        machine_id
        , process_id,
        , MAX(CASE WHEN activity_type = 'start' THEN timestamp END) AS start_time,
        , MAX(CASE WHEN activity_type = 'end' THEN timestamp END) AS end_time
    FROM activity
    GROUP BY machine_id, process_id
)
SELECT
    machine_id
    , ROUND(AVG(end_time - start_time)::numeric, 3) AS processing_time
FROM start_end_pairs
-- Optional: filter out incomplete records
-- WHERE start_time IS NOT NULL AND end_time IS NOT NULLGROUP BY machine_id;
GROUP BY machine_id;

-- CTE pairs up start and end timestamps for each machine/process combo.
-- Final query calculates the average processing time per machine, rounded to 3 decimals.
