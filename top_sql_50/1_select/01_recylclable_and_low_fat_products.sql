-- Problem: https://leetcode.com/problems/recyclable-and-low-fat-products/?envType=study-plan-v2&envId=top-sql-50
-- LeetCode ID: 1757
-- Title: Recyclable And Low Fat Products
-- Difficulty: Easy

SELECT product_id
FROM Products
WHERE low_fats = 'Y' AND recyclable = 'Y';

-- Straightforward filter with two boolean-style columns.
-- Reinforces basics of WHERE clause logic and string comparison.