-- Problem: https://leetcode.com/problems/classes-with-at-least-5-students/description/?envType=study-plan-v2&envId=top-sql-50
-- LeetCode ID: 596
-- Title: Classes With at Least 5 Students
-- Difficulty: Easy 

SELECT class
FROM Courses
GROUP BY class
HAVING COUNT(DISTINCT student) >= 5;

-- Groups by class and filters for those with at least 5 unique students.
-- HAVING filters grouped results, whereas WHERE filters rows before grouping happens.

