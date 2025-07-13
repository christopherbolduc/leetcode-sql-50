-- Problem: https://leetcode.com/problems/movie-rating/description/?envType=study-plan-v2&envId=top-sql-50
-- LeetCode ID: 1341
-- Title: Movie Rating
-- Difficulty: Medium

-- Top user by number of ratings
(SELECT us.name as results
FROM MovieRating mr
JOIN Users us
    ON mr.user_id = us.user_id
GROUP BY us.name
ORDER BY COUNT(rating) DESC, us.name
LIMIT 1) 

UNION ALL

-- Top-rated movie in Feb 2020
(SELECT m.title as results
FROM Movies m
JOIN MovieRating mr
    ON mr.movie_id = m.movie_id
    AND mr.created_at >= '2020-02-01'
    AND mr.created_at < '2020-03-01'
GROUP BY m.title
ORDER BY AVG(rating) DESC, m.title
LIMIT 1);

-- GROUP BY is needed to use COUNT/AVG with name and title in SELECT.
-- ORDER BY breaks ties alphabetically by name (for users) and title (for movies).
-- UNION ALL simply stacks the two results — no need for UNION since these rows are guaranteed to be different.


