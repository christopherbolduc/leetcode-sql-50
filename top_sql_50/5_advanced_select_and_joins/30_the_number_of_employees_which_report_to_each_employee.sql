-- Problem: https://leetcode.com/problems/the-number-of-employees-which-report-to-each-employee/description/?envType=study-plan-v2&envId=top-sql-50
-- LeetCode ID: 1731
-- Title: The Number of Employees Which Report to Each Employee
-- Difficulty: Easy 

WITH managers as (
SELECT
    reports_to as employee_id
    , COUNT(*) as reports_count
    , ROUND(AVG(age)) as average_age
FROM Employees
WHERE reports_to IS NOT NULL
GROUP BY reports_to
)

SELECT
    e.employee_id
    , e.name
    , m.reports_count
    , m.average_age
FROM Employees e
JOIN managers m
    ON e.employee_id = m.employee_id
ORDER BY e.employee_id;

-- CTE counts how many employees report to each manager (using reports_to),
-- and calculates the average age of their direct reports.
-- Final query joins that data back to the Employees table to display manager info.