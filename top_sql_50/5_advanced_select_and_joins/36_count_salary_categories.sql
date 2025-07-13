-- Problem: https://leetcode.com/problems/count-salary-categories/description/?envType=study-plan-v2&envId=top-sql-50
-- LeetCode ID: 1907
-- Title: Count Salary Categories
-- Difficulty: Medium

WITH bracket AS (
SELECT
    CASE
      WHEN income > 50000 THEN 'High Salary'
      WHEN income BETWEEN 20000 AND 50000 THEN 'Average Salary'
      ELSE 'Low Salary'
    END AS category
FROM Accounts
)
SELECT
  c.category
  , COUNT(b.category) AS accounts_count
FROM (
    SELECT 'High Salary' AS category
    UNION ALL
    SELECT 'Average Salary'
    UNION ALL
    SELECT 'Low Salary'
) AS c
LEFT JOIN bracket b
    ON c.category = b.category
GROUP BY c.category
ORDER BY 
    CASE c.category
        WHEN 'High Salary' THEN 1
        WHEN 'Average Salary' THEN 2
        WHEN 'Low Salary' THEN 3
    END;

-- First CTE assigns each account to a salary category using CASE.
-- Derived table (c) lists all categories to guarantee all are represented in the final output.
-- LEFT JOIN ensures we still see categories with zero accounts.
-- Final output includes an ORDER BY to show a logical order from High to Low.