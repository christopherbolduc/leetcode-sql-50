-- Problem: https://leetcode.com/problems/immediate-food-delivery-ii/description/?envType=study-plan-v2&envId=top-sql-50
-- LeetCode ID: 1174
-- Title: Immediate Food Delivery II
-- Difficulty: Medium

WITH first_orders as(
    SELECT
        customer_id
        , MIN(order_date) as first_order
    FROM Delivery
    GROUP BY customer_id
    
)
SELECT
    ROUND(
        AVG(CASE WHEN d.order_date = d.customer_pref_delivery_date THEN 1.0 ELSE 0 END) * 100
    , 2) as immediate_percentage
FROM Delivery d
JOIN first_orders f
    ON d.customer_id = f.customer_id
    AND d.order_date = f.first_order;

-- CTE finds each customer’s first delivery.
-- Main query checks if that first delivery was made on their preferred date.
-- Uses CASE + AVG to calculate the percentage, scaled and rounded to 2 decimals.