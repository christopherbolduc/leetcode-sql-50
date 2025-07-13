-- Problem: https://leetcode.com/problems/article-views-i/description/?envType=study-plan-v2&envId=top-sql-50
-- LeetCode ID: 1148
-- Title: Article Views I
-- Difficulty: Easy

SELECT DISTINCT author_id as id
FROM Views
WHERE author_id = viewer_id
ORDER BY author_id;

-- Looking for authors who viewed their own articles — just a row-wise comparison between author and viewer.
-- Used DISTINCT to avoid duplicates in case someone viewed their own article multiple times.