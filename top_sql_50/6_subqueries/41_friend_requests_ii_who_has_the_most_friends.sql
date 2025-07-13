-- Problem: https://leetcode.com/problems/friend-requests-ii-who-has-the-most-friends/description/?envType=study-plan-v2&envId=top-sql-50
-- LeetCode ID: 602
-- Title: Friend Requests II: Who Has the Most Friends
-- Difficulty: Medium

SELECT 
    id
    , COUNT(*) as num
FROM (
    SELECT requester_id as id FROM RequestAccepted
    UNION ALL
    SELECT accepter_id as id FROM RequestAccepted
) t
GROUP BY id
ORDER BY num DESC
LIMIT 1;

-- Combines both requester and accepter IDs into one stream.
-- Counts total accepted requests per user.
-- Returns the user with the most friends.