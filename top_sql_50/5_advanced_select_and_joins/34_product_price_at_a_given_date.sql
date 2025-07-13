-- Problem: https://leetcode.com/problems/product-price-at-a-given-date/description/?envType=study-plan-v2&envId=top-sql-50
-- LeetCode ID: 1164
-- Title: Product Price at a Given Date
-- Difficulty: Medium

SELECT
  product_id,
  COALESCE(
    ( SELECT new_price
      FROM Products AS p2
      WHERE p2.product_id = p1.product_id
        AND p2.change_date <= '2019-08-16'
      ORDER BY change_date DESC
      LIMIT 1 )
  , 10) AS price
FROM Products AS p1
GROUP BY product_id
ORDER BY product_id;

-- For each product, looks up the most recent price before or on '2019-08-16'.
-- Uses a correlated subquery with ORDER BY + LIMIT 1 to get the latest applicable price.
-- COALESCE returns 10 if no price was set before that date (default price).