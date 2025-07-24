-- BASIC AGGREGATE FUNCTIONS
--------------------------------------------------------------
-- Problem: https://leetcode.com/problems/not-boring-movies/description/?envType=study-plan-v2&envId=top-sql-50
-- LeetCode ID: 620 | Title: Not Boring Movies | Difficulty: Easy

SELECT *
FROM Cinema
WHERE id % 2 = 1 AND description != 'boring'
ORDER BY rating DESC;

-- Filters out even IDs and rows with 'boring' in the description.
-- Orders the remaining movies by rating, highest first.
-- Even numbers: n % 2 = 0 (no remainder)
-- Odd numbers:  n % 2 = 1 (has remainder)

--------------------------------------------------------------
-- Problem: https://leetcode.com/problems/average-selling-price/description/?envType=study-plan-v2&envId=top-sql-50
-- LeetCode ID: 1251 | Title: Average Selling Price | Difficulty: Easy

SELECT
    pr.product_id
    , COALESCE(
        ROUND(SUM(pr.price * us.units) / SUM(us.units)::decimal, 2)
      , 0) as average_price
FROM Prices pr
LEFT JOIN UnitsSold us
    ON pr.product_id = us.product_id
    AND us.purchase_date BETWEEN pr.start_date AND pr.end_date
GROUP BY pr.product_id;

-- Calculates weighted average price per product over matching sales periods.
-- LEFT JOIN ensures products with no sales still appear in the result.
-- COALESCE returns 0 for products with no units sold.

--------------------------------------------------------------
-- Problem: https://leetcode.com/problems/project-employees-i/description/?envType=study-plan-v2&envId=top-sql-50
-- LeetCode ID: 1075 | Title: Project Employees I | Difficulty: Easy

SELECT
    p.project_id
    , ROUND(AVG(e.experience_years), 2) as average_years
FROM Project p
JOIN Employee e
    ON p.employee_id = e.employee_id
GROUP BY p.project_id;

-- Joins projects to their assigned employees by employee_id.
-- Averages experience years per project, rounded to 2 decimals.

--------------------------------------------------------------
-- Problem: https://leetcode.com/problems/percentage-of-users-attended-a-contest/description/?envType=study-plan-v2&envId=top-sql-50
-- LeetCode ID: 1633 | Title: Percentage of Users Attended a Contest | Difficulty: Easy

WITH total_users as (
    SELECT COUNT(*) as total
    FROM Users
)

SELECT
    r.contest_id
    , ROUND(COUNT(DISTINCT r.user_id) * 100.0 / MAX(tu.total), 2) as percentage
FROM Register r
CROSS JOIN total_users tu
GROUP BY r.contest_id
ORDER BY percentage DESC, r.contest_id;

-- CROSS JOIN brings total user count into each row for the percentage calc.
-- MAX(tu.total) is safe because total_users only has one row.
-- Multiplies by 100.0 to force float division, then rounds to 2 decimals.

--------------------------------------------------------------
-- Problem: https://leetcode.com/problems/queries-quality-and-percentage/description/?envType=study-plan-v2&envId=top-sql-50
-- LeetCode ID: 1211 | Title: Queries Quality and Percentage | Difficulty: Easy

SELECT
    query_name
    , ROUND(AVG(rating * 1.0 / position), 2) as quality
    , ROUND(
        AVG(CASE WHEN rating < 3 THEN 1 ELSE 0 END) * 100
            , 2) as poor_query_percentage
FROM Queries
GROUP BY query_name;

-- AVG(rating / position) gives the query quality score.
-- Second AVG calculates the percentage of times a query was rated below 3.
-- Multiplies by 100 to convert to a percentage, then rounds to 2 decimals.

--------------------------------------------------------------
-- Problem: https://leetcode.com/problems/monthly-transactions-i/description/?envType=study-plan-v2&envId=top-sql-50
-- LeetCode ID: 1193 | Title: Monthly Transactions I | Difficulty: Medium

SELECT
    TO_CHAR(trans_date, 'YYYY-MM') as month
    , country
    , COUNT(id) as trans_count
    , COUNT(state) FILTER (WHERE state = 'approved') as approved_count
    , SUM(amount) as trans_total_amount
    , COALESCE(
        SUM(amount) FILTER (WHERE state = 'approved')
      , 0) as approved_total_amount
FROM Transactions
GROUP BY month, country;

-- Uses FILTER clause to count and sum only approved transactions.
-- TO_CHAR formats dates into 'YYYY-MM' monthly buckets.
-- COALESCE ensures total is 0 when no approved transactions exist.

--------------------------------------------------------------
-- Problem: https://leetcode.com/problems/immediate-food-delivery-ii/description/?envType=study-plan-v2&envId=top-sql-50
-- LeetCode ID: 1174 | Title: Immediate Food Delivery II | Difficulty: Medium

WITH first_orders as (
    SELECT
        customer_id
        , MIN(order_date) as first_order
    FROM Delivery
    GROUP BY customer_id
    
)
SELECT
    ROUND(
        AVG(CASE WHEN d.order_date = d.customer_pref_delivery_date THEN 1.0 ELSE 0 END) * 100
    , 2) as immediate_percentage
FROM Delivery d
JOIN first_orders f
    ON d.customer_id = f.customer_id
    AND d.order_date = f.first_order;

-- CTE finds each customer’s first delivery.
-- Main query checks if that first delivery was made on their preferred date.
-- Uses CASE + AVG to calculate the percentage, scaled and rounded to 2 decimals.

--------------------------------------------------------------
-- Problem: https://leetcode.com/problems/game-play-analysis-iv/description/?envType=study-plan-v2&envId=top-sql-50
-- LeetCode ID: 550 | Title: Game Play Analysis IV | Difficulty: Medium

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