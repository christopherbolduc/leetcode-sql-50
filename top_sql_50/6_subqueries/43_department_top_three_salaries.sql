-- Problem: https://leetcode.com/problems/department-top-three-salaries/?envType=study-plan-v2&envId=top-sql-50
-- LeetCode ID: 185
-- Title: Department Top Three Salaries
-- Difficulty: Hard

WITH emp_dep_rank AS(
    SELECT
        dep.name as Department
        , emp.name as Employee
        , emp.salary as Salary
        , DENSE_RANK() OVER (PARTITION BY dep.id ORDER BY emp.salary DESC) as DR
    FROM Employee emp
    JOIN Department dep
        ON emp.departmentId = dep.id
)

SELECT Department, Employee, Salary
FROM emp_dep_rank
WHERE DR <= 3;

-- CTE ranks employees within each department by salary using DENSE_RANK.
-- Final SELECT filters to only the top 3 salaries per department.
-- DENSE_RANK includes ties — so more than 3 employees appear if there are duplicate salaries.