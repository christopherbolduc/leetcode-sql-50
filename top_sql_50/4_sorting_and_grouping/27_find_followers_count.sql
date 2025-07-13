-- Problem: https://leetcode.com/problems/find-followers-count/description/?envType=study-plan-v2&envId=top-sql-50
-- LeetCode ID: 1729
-- Title: Find Followers Count
-- Difficulty: Easy 

SELECT
    user_id
    , COUNT(DISTINCT follower_id) as followers_count
FROM Followers
GROUP BY user_id
ORDER BY user_id;

-- Counts how many unique users follow each user_id.
-- Uses GROUP BY with COUNT DISTINCT, then orders by user_id.