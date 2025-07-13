-- Problem: https://leetcode.com/problems/invalid-tweets/description/?envType=study-plan-v2&envId=top-sql-50
-- LeetCode ID: 1683
-- Title: Invalid Tweets
-- Difficulty: Easy

SELECT tweet_id
FROM Tweets
WHERE CHAR_LENGTH(content) > 15;

-- Simple filter to catch tweets that are too long.
-- Used CHAR_LENGTH to count actual characters — LENGTH would count bytes, which could be misleading with multibyte characters.