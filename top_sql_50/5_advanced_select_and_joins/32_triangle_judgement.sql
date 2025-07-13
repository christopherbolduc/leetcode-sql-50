-- Problem: https://leetcode.com/problems/triangle-judgement/description/?envType=study-plan-v2&envId=top-sql-50
-- LeetCode ID: 610
-- Title: Triangle Judgement
-- Difficulty: Easy 

SELECT
   *
    , CASE 
        WHEN x + y > z AND y + z > x AND z + x > y
        THEN 'Yes'
        ELSE 'No' 
      END as triangle
FROM Triangle;

-- Applies the triangle inequality rule:
-- For three lengths to form a triangle, the sum of any two must be greater than the third.
-- If the condition holds for all three combinations, return 'Yes'; otherwise, 'No'.