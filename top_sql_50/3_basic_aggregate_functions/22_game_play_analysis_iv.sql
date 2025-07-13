-- Problem: https://leetcode.com/problems/game-play-analysis-iv/description/?envType=study-plan-v2&envId=top-sql-50
-- LeetCode ID: 550
-- Title: Game Play Analysis IV
-- Difficulty: Medium

WITH first_login as (
    SELECT 
    player_id
    , MIN(event_date) as first_date
  FROM Activity
  GROUP BY player_id
)

SELECT 
    ROUND(
        COUNT(DISTINCT a.player_id) * 1.0 / 
        (SELECT COUNT(DISTINCT player_id) FROM Activity)
    , 2) as fraction
FROM Activity a
JOIN first_login f
  ON a.player_id = f.player_id
 AND a.event_date = f.first_date + INTERVAL '1 day';

-- CTE finds each player’s first login date.
-- Final query checks if they logged in again the very next day.
-- Fraction is total players who did / total unique players, rounded to 2 decimals.