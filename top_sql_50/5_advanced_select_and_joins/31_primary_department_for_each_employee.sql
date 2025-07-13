-- Problem: https://leetcode.com/problems/primary-department-for-each-employee/description/?envType=study-plan-v2&envId=top-sql-50
-- LeetCode ID: 1789
-- Title: Primary Department for Each Employee
-- Difficulty: Easy 

SELECT
    employee_id
    , department_id
FROM Employee
WHERE primary_flag = 'Y' OR
    employee_id IN (
     SELECT employee_id
     FROM Employee
     GROUP BY employee_id
     HAVING COUNT(department_id) = 1
    )
ORDER BY employee_id;

-- Returns each employee’s primary department.
-- If an employee has multiple departments, we use the row marked 'Y' as primary.
-- If they belong to only one department, that department is considered primary by default.