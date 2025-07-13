-- Problem: https://leetcode.com/problems/second-highest-salary/description/?envType=study-plan-v2&envId=top-sql-50
-- LeetCode ID: 176
-- Title: Second Highest Salary
-- Difficulty: Medium

WITH rankings AS (
    SELECT
        salary
        , DENSE_RANK() OVER (ORDER BY salary DESC) as rank
    FROM Employee
)

(SELECT salary AS SecondHighestSalary
 FROM rankings
 WHERE rank = 2
 LIMIT 1
)

UNION ALL

(SELECT NULL AS SecondHighestSalary
 WHERE NOT EXISTS (
     SELECT 1 FROM rankings WHERE rank = 2
 )
);

-- CTE ranks salaries in descending order using DENSE_RANK (which does not skip numbers for ties).
-- First SELECT returns the 2nd highest salary if it exists.
-- Second SELECT returns NULL if no 2nd highest exists.
-- UNION ALL ensures one result row is always returned — either a salary or NULL.