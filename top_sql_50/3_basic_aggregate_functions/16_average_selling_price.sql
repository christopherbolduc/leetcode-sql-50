-- Problem: https://leetcode.com/problems/average-selling-price/description/?envType=study-plan-v2&envId=top-sql-50
-- LeetCode ID: 1251
-- Title: Average Selling Price
-- Difficulty: Easy

SELECT
    pr.product_id
    , COALESCE(
        ROUND(SUM(pr.price * us.units) / SUM(us.units)::decimal, 2)
      , 0) as average_price
FROM Prices pr
LEFT JOIN UnitsSold us
    ON pr.product_id = us.product_id
    AND us.purchase_date BETWEEN pr.start_date AND pr.end_date
GROUP BY pr.product_id;

-- Calculates weighted average price per product over matching sales periods.
-- LEFT JOIN ensures products with no sales still appear in the result.
-- COALESCE returns 0 for products with no units sold.