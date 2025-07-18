-- SUBQUERIES
--------------------------------------------------------------
-- Problem: https://leetcode.com/problems/employees-whose-manager-left-the-company/description/?envType=study-plan-v2&envId=top-sql-50
-- LeetCode ID: 1978 | Title: Employees Whose Manager Left the Company | Difficulty: Easy

SELECT e.employee_id
FROM Employees e
WHERE e.salary < 30000
  AND e.manager_id IS NOT NULL
  AND NOT EXISTS (
    SELECT 1    -- placeholder
    FROM Employees m
    WHERE m.employee_id = e.manager_id
  )
ORDER BY e.employee_id;

-- Filters for employees earning less than 30K
-- Only considers those with a non-null manager_id
-- NOT EXISTS checks if that manager_id no longer appears in the Employees table
-- If no match is found, we include the employee — their manager has left

--------------------------------------------------------------
-- Problem: https://leetcode.com/problems/exchange-seats/description/?envType=study-plan-v2&envId=top-sql-50
-- LeetCode ID: 626 | Title: Exchange Seats | Difficulty: Medium

SELECT
    CASE WHEN id % 2 = 1 AND id != (SELECT MAX(id) FROM Seat) THEN id + 1
         WHEN id % 2 = 0 THEN id - 1
         ELSE id
         END as id
    , student
FROM Seat
ORDER BY id;

-- First CASE checks if the id is odd and not the highest -> add 1 to swap forward
-- Second CASE checks if the id is even -> subtract 1 to swap backward
-- ELSE handles if the highest id is odd (no one to swap with)

--------------------------------------------------------------
-- Problem: https://leetcode.com/problems/movie-rating/description/?envType=study-plan-v2&envId=top-sql-50
-- LeetCode ID: 1341 | Title: Movie Rating | Difficulty: Medium

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

--------------------------------------------------------------
-- Problem: https://leetcode.com/problems/restaurant-growth/description/?envType=study-plan-v2&envId=top-sql-50
-- LeetCode ID: 1321 | Title: Restaurant Growth | Difficulty: Medium

SELECT
    visited_on
    , ROUND(SUM(amount) OVER (
        ORDER BY visited_on
        ROWS BETWEEN 6 PRECEDING AND CURRENT ROW)
      , 2) as amount
    , ROUND(AVG(amount) OVER (
        ORDER BY visited_on
        ROWS BETWEEN 6 PRECEDING AND CURRENT ROW)
      , 2) as average_amount
FROM (
    SELECT visited_on, SUM(amount) as amount
    FROM Customer
    GROUP BY visited_on
) as t
ORDER BY visited_on
OFFSET 6 ROWS;

-- Subquery aggregates total amount per day.
-- Window functions compute a rolling 7-day sum and average by date.
-- OFFSET 6 skips the first 6 rows (no full 7-day window before them).

-- Alternative version using self-join:
SELECT
    c1.visited_on
    , ROUND(SUM(c2.amount), 2) as amount
    , ROUND(AVG(c2.amount), 2) as average_amount
FROM (
    SELECT visited_on, SUM(amount) as amount
    FROM Customer
    GROUP BY visited_on
) c1
JOIN (
    SELECT visited_on, SUM(amount) as amount
    FROM Customer
    GROUP BY visited_on
) c2
  ON c2.visited_on BETWEEN c1.visited_on - INTERVAL '6 days' AND c1.visited_on
GROUP BY c1.visited_on
HAVING COUNT(*) = 7
ORDER BY c1.visited_on;

-- For each date, joins against the 6 previous days (inclusive).
-- HAVING ensures only full 7-day windows are kept.

--------------------------------------------------------------
-- Problem: https://leetcode.com/problems/friend-requests-ii-who-has-the-most-friends/description/?envType=study-plan-v2&envId=top-sql-50
-- LeetCode ID: 602 | Title: Friend Requests II: Who Has the Most Friends | Difficulty: Medium

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

--------------------------------------------------------------
-- Problem: https://leetcode.com/problems/investments-in-2016/description/?envType=study-plan-v2&envId=top-sql-50
-- LeetCode ID: 585 | Title: Investments in 2016 | Difficulty: Medium

SELECT
    ROUND(SUM(tiv_2016)::numeric, 2) as tiv_2016
FROM Insurance
WHERE tiv_2015 IN (
        -- Selects tiv_2015 values that appear more than once
        SELECT tiv_2015
        FROM Insurance
        GROUP BY tiv_2015
        HAVING COUNT(*) > 1
) 
AND (lat, lon) IN (
        -- Filters for records with unique (lat, lon) combinations
        SELECT lat, lon
        FROM Insurance
        GROUP BY lat, lon
        HAVING COUNT(*) =1
);

-- Adds up tiv_2016 for properties with:
-- a tiv_2015 value shared with others & a unique location

--------------------------------------------------------------
-- Problem: https://leetcode.com/problems/department-top-three-salaries/?envType=study-plan-v2&envId=top-sql-50
-- LeetCode ID: 185 | Title: Department Top Three Salaries | Difficulty: Hard

WITH emp_dep_rank as (
    SELECT
        dep.name as Department
        , emp.name as Employee
        , emp.salary as Salary
        , DENSE_RANK() OVER (PARTITION BY dep.id ORDER BY emp.salary DESC) as DR
    FROM Employee emp
    JOIN Department dep
        ON emp.departmentId = dep.id
)

SELECT Department, Employee, Salary
FROM emp_dep_rank
WHERE DR <= 3;

-- CTE ranks employees within each department by salary using DENSE_RANK.
-- Final SELECT filters to only the top 3 salaries per department.
-- DENSE_RANK includes ties but does not skip rank values (unlike RANK)
-- So more than 3 employees appear if there are duplicate salaries.