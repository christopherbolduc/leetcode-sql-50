-- Problem: https://leetcode.com/problems/list-the-products-ordered-in-a-period/description/?envType=study-plan-v2&envId=top-sql-50
-- LeetCode ID: 1327
-- Title: List the Products Ordered in a Period
-- Difficulty: Easy

SELECT
    pro.product_name
    , SUM(ord.unit) as unit
FROM Products pro
JOIN Orders ord
    ON pro.product_id = ord.product_id
WHERE ord.order_date >= '2020-02-01'::date
    AND ord.order_date < '2020-03-01'::date
GROUP BY pro.product_name
HAVING SUM(ord.unit) >= 100;

-- Joins product and order data by product_id
-- Filters orders placed in February 2020 using a date range (inclusive start, exclusive end)
-- Aggregates total units sold per product using SUM()
-- Filters to only include products with 100 or more total units ordered

-- Could have used:
WHERE TO_CHAR(ord.order_date, 'YYYY-MM') = '2020-02'
-- But applying a function to the column disables index use.
-- Using a date range keeps the query fast and index-friendly.
-- It’s also easier to tweak the start or end date later if needed.