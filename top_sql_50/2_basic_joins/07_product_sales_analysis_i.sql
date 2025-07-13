-- Problem: https://leetcode.com/problems/product-sales-analysis-i/description/?envType=study-plan-v2&envId=top-sql-50
-- LeetCode ID: 1068
-- Title: Product Sales Analysis I
-- Difficulty: Easy 

SELECT
    p.product_name
    , s.year
    , s.price
FROM Sales s
JOIN Product p
    ON s.product_id = p.product_id;

-- Standard inner join to pull product names into the sales table using product_id.
-- Classic "lookup and enrich" pattern — joining facts (Sales) with dimension info (Product).