-- Problem: https://leetcode.com/problems/customer-who-visited-but-did-not-make-any-transactions/description/?envType=study-plan-v2&envId=top-sql-50
-- LeetCode ID: 1581
-- Title: Customer Who Visited but Did Not Make Any Transactions
-- Difficulty: Easy 

SELECT
    customer_id
    , COUNT(visit_id) as count_no_trans
FROM Visits
LEFT JOIN Transactions
USING(visit_id)     -- Could use ON but USING felt cleaner here
WHERE transaction_id IS NULL
GROUP BY customer_id;

-- Standard anti-join pattern: LEFT JOIN then filter where the right-side key is NULL.
-- Counting how many times each customer visited without making a transaction.

SELECT
    v.customer_id
    , COUNT(*) AS count_no_trans
FROM Visits v
WHERE NOT EXISTS (
    SELECT 1    -- Checks if a match exists; so the '1' is just a placeholder
    FROM Transactions t
    WHERE t.visit_id = v.visit_id
)
GROUP BY v.customer_id;

-- Same logic, different approach.
-- WHERE NOT EXISTS lets the database check for a match without needing to join rows — often faster if visit_id is indexed.