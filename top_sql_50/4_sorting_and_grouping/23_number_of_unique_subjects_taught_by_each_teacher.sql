-- Problem: https://leetcode.com/problems/number-of-unique-subjects-taught-by-each-teacher/description/?envType=study-plan-v2&envId=top-sql-50
-- LeetCode ID: 2356
-- Title: Number of Unique Subjects Taught by Each Teacher
-- Difficulty: Easy 

SELECT
    teacher_id
    , COUNT(DISTINCT subject_id) as cnt
FROM Teacher
GROUP BY teacher_id;

-- Counts how many unique subjects each teacher is associated with.
-- Straightforward GROUP BY with COUNT DISTINCT.