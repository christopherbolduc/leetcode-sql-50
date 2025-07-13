-- Problem: https://leetcode.com/problems/big-countries/description/?envType=study-plan-v2&envId=top-sql-50
-- LeetCode ID: 595
-- Title: Big Countries
-- Difficulty: Easy

SELECT
    name
    , population
    , area
FROM World
WHERE area >= 3000000 OR population >= 25000000;

-- Straightforward OR filter — just grabbing countries that are either really large in area or heavily populated.