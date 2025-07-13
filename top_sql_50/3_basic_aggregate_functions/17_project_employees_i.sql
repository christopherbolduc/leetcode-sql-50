-- Problem: https://leetcode.com/problems/project-employees-i/description/?envType=study-plan-v2&envId=top-sql-50
-- LeetCode ID: 1075
-- Title: Project Employees I
-- Difficulty: Easy

SELECT
    p.project_id
    , ROUND(AVG(e.experience_years), 2) as average_years
FROM Project p
JOIN Employee e
    ON p.employee_id = e.employee_id
GROUP BY p.project_id;

-- Joins projects to their assigned employees by employee_id.
-- Averages experience years per project, rounded to 2 decimals.