-- Problem: https://leetcode.com/problems/biggest-single-number/description/?envType=study-plan-v2&envId=top-sql-50
-- LeetCode ID: 619
-- Title: Biggest Single Number
-- Difficulty: Easy 

SELECT MAX(num) as num
FROM (
  SELECT num
  FROM MyNumbers
  GROUP BY num
  HAVING COUNT(*) = 1
) as t;

-- Subquery filters for numbers that appear exactly once.
-- Main query finds the maximum of those “single” numbers.