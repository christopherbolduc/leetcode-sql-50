-- Problem: https://leetcode.com/problems/delete-duplicate-emails/description/?envType=study-plan-v2&envId=top-sql-50
-- LeetCode ID: 196
-- Title: Delete Duplicate Emails
-- Difficulty: Easy

WITH ranked_emails AS (
    SELECT
        id
        , ROW_NUMBER() OVER (PARTITION BY email ORDER BY id) as rn
    FROM Person
)

DELETE FROM Person
WHERE id IN (
    SELECT id
    FROM ranked_emails
    WHERE rn > 1
);

-- CTE assigns row numbers partitioned by email, ordered by id.
-- Keeps the first occurrence (rn = 1), deletes the rest (rn > 1).