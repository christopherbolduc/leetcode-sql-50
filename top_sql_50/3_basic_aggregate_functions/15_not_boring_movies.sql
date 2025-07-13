-- Problem: https://leetcode.com/problems/not-boring-movies/description/?envType=study-plan-v2&envId=top-sql-50
-- LeetCode ID: 620
-- Title: Not Boring Movies
-- Difficulty: Easy

SELECT *
FROM Cinema
WHERE id % 2 = 1 AND description != 'boring'
ORDER BY rating DESC;

-- Filters out even IDs and rows with 'boring' in the description.
-- Orders the remaining movies by rating, highest first.
-- Even numbers: n % 2 = 0 (no remainder)
-- Odd numbers:  n % 2 = 1 (has remainder)