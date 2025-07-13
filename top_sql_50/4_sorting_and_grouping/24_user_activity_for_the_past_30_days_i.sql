-- Problem: https://leetcode.com/problems/user-activity-for-the-past-30-days-i/description/?envType=study-plan-v2&envId=top-sql-50
-- LeetCode ID: 1141
-- Title: User Activity for the Past 30 Days I
-- Difficulty: Easy 

SELECT
    activity_date as day
    , COUNT(DISTINCT user_id) as active_users
FROM Activity 
WHERE activity_date BETWEEN '2019-07-27'::date - INTERVAL '29 days'
    AND '2019-07-27'::date
GROUP BY activity_date;

-- Counts unique users per day within the 30-day period ending on 2019-07-27.
-- Uses BETWEEN with INTERVAL to define the date window.
-- Casting with ::date ensures the string is treated as a date, not text.