-- Problem: https://leetcode.com/problems/monthly-transactions-i/description/?envType=study-plan-v2&envId=top-sql-50
-- LeetCode ID: 1193
-- Title: Monthly Transactions I
-- Difficulty: Medium

SELECT
    TO_CHAR(trans_date, 'YYYY-MM') as month
    , country
    , COUNT(id) as trans_count
    , COUNT(state) FILTER (WHERE state = 'approved') as approved_count
    , SUM(amount) as trans_total_amount
    , COALESCE(
        SUM(amount) FILTER (WHERE state = 'approved')
      , 0) as approved_total_amount
FROM Transactions
GROUP BY month, country;

-- Uses FILTER clause to count and sum only approved transactions.
-- TO_CHAR formats dates into 'YYYY-MM' monthly buckets.
-- COALESCE ensures total is 0 when no approved transactions exist.