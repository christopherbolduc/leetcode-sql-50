-- Problem: https://leetcode.com/problems/replace-employee-id-with-the-unique-identifier/description/?envType=study-plan-v2&envId=top-sql-50
-- LeetCode ID: 1378
-- Title: Replace Employee ID With The Unique Identifier
-- Difficulty: Easy 

SELECT 
    u.unique_id
    , e.name
FROM Employees e
LEFT JOIN EmployeeUNI u
    ON e.id = u.id;


-- Simple LEFT JOIN to match employee names with their unique IDs, if they have one.
-- USING(id) would’ve worked too, but I went with ON to keep it explicit.