-- Problem: https://leetcode.com/problems/managers-with-at-least-5-direct-reports/description/?envType=study-plan-v2&envId=top-sql-50
-- LeetCode ID: 570
-- Title: Managers with at Least 5 Direct Reports
-- Difficulty: Medium

SELECT name
FROM Employee
WHERE id IN (
    SELECT managerId
    FROM Employee
    GROUP BY managerId
    HAVING COUNT(*) >= 5
);

-- Finds employees who are listed as managers with at least 5 direct reports.
-- Uses a subquery with GROUP BY + HAVING to filter for manager IDs.