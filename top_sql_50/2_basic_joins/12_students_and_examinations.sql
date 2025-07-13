-- Problem: https://leetcode.com/problems/students-and-examinations/description/?envType=study-plan-v2&envId=top-sql-50
-- LeetCode ID: 1208
-- Title: Students and Examinations
-- Difficulty: Easy 

SELECT
    s.student_id
    , s.student_name
    , sub.subject_name
    , COUNT(ex.student_id) as attended_exams
FROM Students s
CROSS JOIN Subjects sub
LEFT JOIN Examinations ex
    ON s.student_id = ex.student_id
    AND sub.subject_name = ex.subject_name
GROUP BY s.student_id, s.student_name, sub.subject_name
ORDER BY s.student_id, s.student_name, sub.subject_name;

-- CROSS JOIN builds all student–subject combinations.
-- LEFT JOIN attaches matching exam records where they exist.
-- COUNT handles cases with 0 matches, so we still get rows even if a student didn’t attend.