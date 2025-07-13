-- Problem: https://leetcode.com/problems/product-sales-analysis-iii/description/?envType=study-plan-v2&envId=top-sql-50
-- LeetCode ID: 1070
-- Title: Product Sales Analysis III
-- Difficulty: Medium

WITH first_sales as (
    SELECT
        product_id
        , MIN(year) as first_year
    FROM Sales
    GROUP BY product_id
)

SELECT
  s.product_id
  , fs.first_year
  , s.quantity
  , s.price
FROM Sales s
JOIN first_sales fs
  ON s.product_id = fs.product_id
 AND s.year = fs.first_year;

-- CTE gets each product’s first sales year.
-- Final query joins to pull quantity and price from that first year.