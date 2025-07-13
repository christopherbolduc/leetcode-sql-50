-- Problem: https://leetcode.com/problems/employee-bonus/description/?envType=study-plan-v2&envId=top-sql-50
-- LeetCode ID: 577
-- Title: Employee Bonus
-- Difficulty: Easy 

SELECT
    name
    , bonus
FROM Employee
LEFT JOIN Bonus
USING(empID)
WHERE bonus < 1000 OR bonus IS NULL;

-- LEFT JOIN to include employees who don’t have a bonus at all.
-- Filter keeps only bonuses below 1000, or NULL (no bonus given).
-- USING(empID) removes the need to qualify it and avoids duplicate columns in the result.
