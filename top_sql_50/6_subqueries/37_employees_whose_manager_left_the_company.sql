-- Problem: https://leetcode.com/problems/employees-whose-manager-left-the-company/description/?envType=study-plan-v2&envId=top-sql-50
-- LeetCode ID: 1978
-- Title: Employees Whose Manager Left the Company
-- Difficulty: Easy

SELECT e.employee_id
FROM Employees e
WHERE e.salary < 30000
  AND e.manager_id IS NOT NULL
  AND NOT EXISTS (
    SELECT 1    -- placeholder
    FROM Employees m
    WHERE m.employee_id = e.manager_id
  )
ORDER BY e.employee_id;

-- Filters for employees earning less than 30K
-- Only considers those with a non-null manager_id
-- NOT EXISTS checks if that manager_id no longer appears in the Employees table
-- If no match is found, we include the employee — their manager has left