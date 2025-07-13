-- Problem: https://leetcode.com/problems/investments-in-2016/description/?envType=study-plan-v2&envId=top-sql-50
-- LeetCode ID: 585
-- Title: Investments in 2016
-- Difficulty: Medium

SELECT
    ROUND(SUM(tiv_2016)::numeric, 2) as tiv_2016
FROM Insurance
WHERE tiv_2015 IN (
        -- Selects tiv_2015 values that appear more than once
        SELECT tiv_2015
        FROM Insurance
        GROUP BY tiv_2015
        HAVING COUNT(*) > 1
) 
AND (lat, lon) IN (
        -- Filters for records with unique (lat, lon) combinations
        SELECT lat, lon
        FROM Insurance
        GROUP BY lat, lon
        HAVING COUNT(*) =1
);

-- Adds up tiv_2016 for properties with:
-- a tiv_2015 value shared with others & a unique location