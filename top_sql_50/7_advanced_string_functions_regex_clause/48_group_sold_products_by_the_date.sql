-- Problem: https://leetcode.com/problems/group-sold-products-by-the-date/description/?envType=study-plan-v2&envId=top-sql-50
-- LeetCode ID: 1484
-- Title: Group Sold Products By The Date
-- Difficulty: Easy

SELECT
    sell_date
    , COUNT(DISTINCT product) as num_sold
    , STRING_AGG(DISTINCT product, ',' ORDER BY product) as products
FROM Activities
GROUP BY sell_date
ORDER BY sell_date;

-- Groups sales by date and counts how many distinct products were sold each day.
-- STRING_AGG concatenates product names into a comma-separated string, ordered alphabetically.
-- DISTINCT ensures duplicates are removed from both count and list.