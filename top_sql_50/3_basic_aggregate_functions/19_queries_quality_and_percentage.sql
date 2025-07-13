-- Problem: https://leetcode.com/problems/queries-quality-and-percentage/description/?envType=study-plan-v2&envId=top-sql-50
-- LeetCode ID: 1211
-- Title: Queries Quality and Percentage
-- Difficulty: Easy

SELECT
    query_name
    , ROUND(AVG(rating * 1.0 / position), 2) as quality
    , ROUND(
        AVG(CASE WHEN rating < 3 THEN 1 ELSE 0 END) * 100
            , 2) as poor_query_percentage
FROM Queries
GROUP BY query_name;

-- AVG(rating / position) gives the query quality score.
-- Second AVG calculates the percentage of times a query was rated below 3.
-- Multiplies by 100 to convert to a percentage, then rounds to 2 decimals.