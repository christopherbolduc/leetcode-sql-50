-- Problem: https://leetcode.com/problems/find-customer-referee/description/?envType=study-plan-v2&envId=top-sql-50
-- LeetCode ID: 584
-- Title: Find Customer Referee
-- Difficulty: Easy 

SELECT name
FROM Customer
WHERE COALESCE(referee_id, 0) != 2

-- Used COALESCE to treat NULL referee_ids as 0, so I can safely compare them to 2.
-- Without it, NULL != 2 doesn’t return true — it returns 'unknown' so those rows get filtered out.
-- I could’ve also done 'referee_id IS NULL OR referee_id != 2', but this is cleaner.