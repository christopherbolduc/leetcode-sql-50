-- SORTING AND GROUPING
--------------------------------------------------------------
-- Problem: https://leetcode.com/problems/number-of-unique-subjects-taught-by-each-teacher/description/?envType=study-plan-v2&envId=top-sql-50
-- LeetCode ID: 2356 | Title: Number of Unique Subjects Taught by Each Teacher | Difficulty: Easy

SELECT
    teacher_id
    , COUNT(DISTINCT subject_id) as cnt
FROM Teacher
GROUP BY teacher_id;

-- Counts how many unique subjects each teacher is associated with.
-- Straightforward GROUP BY with COUNT DISTINCT.

--------------------------------------------------------------
-- Problem: https://leetcode.com/problems/user-activity-for-the-past-30-days-i/description/?envType=study-plan-v2&envId=top-sql-50
-- LeetCode ID: 1141 | Title: User Activity for the Past 30 Days I | Difficulty: Easy

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

--------------------------------------------------------------
-- Problem: https://leetcode.com/problems/product-sales-analysis-iii/description/?envType=study-plan-v2&envId=top-sql-50
-- LeetCode ID: 1070 | Title: Product Sales Analysis III | Difficulty: Medium

WITH first_sales as (
    SELECT
        product_id
        , MIN(year) as first_year
    FROM Sales
    GROUP BY product_id
)

SELECT
  s.product_id
  , fs.first_year
  , s.quantity
  , s.price
FROM Sales s
JOIN first_sales fs
  ON s.product_id = fs.product_id
 AND s.year = fs.first_year;

-- CTE gets each product’s first sales year.
-- Final query joins to pull quantity and price from that first year.

--------------------------------------------------------------
-- Problem: https://leetcode.com/problems/classes-with-at-least-5-students/description/?envType=study-plan-v2&envId=top-sql-50
-- LeetCode ID: 596 | Title: Classes With at Least 5 Students | Difficulty: Easy

SELECT class
FROM Courses
GROUP BY class
HAVING COUNT(DISTINCT student) >= 5;

-- Groups by class and filters for those with at least 5 unique students.
-- HAVING filters grouped results, whereas WHERE filters rows before grouping happens.

--------------------------------------------------------------
-- Problem: https://leetcode.com/problems/find-followers-count/description/?envType=study-plan-v2&envId=top-sql-50
-- LeetCode ID: 1729 | Title: Find Followers Count | Difficulty: Easy

SELECT
    user_id
    , COUNT(DISTINCT follower_id) as followers_count
FROM Followers
GROUP BY user_id
ORDER BY user_id;

-- Counts how many unique users follow each user_id.
-- Uses GROUP BY with COUNT DISTINCT, then orders by user_id.

--------------------------------------------------------------
-- Problem: https://leetcode.com/problems/biggest-single-number/description/?envType=study-plan-v2&envId=top-sql-50
-- LeetCode ID: 619 | Title: Biggest Single Number | Difficulty: Easy

SELECT MAX(num) as num
FROM (
  SELECT num
  FROM MyNumbers
  GROUP BY num
  HAVING COUNT(*) = 1
) as t;

-- Subquery filters for numbers that appear exactly once.
-- Main query finds the maximum of those “single” numbers.

--------------------------------------------------------------
-- Problem: https://leetcode.com/problems/customers-who-bought-all-products/description/?envType=study-plan-v2&envId=top-sql-50
-- LeetCode ID: 1045 | Title: Customers Who Bought All Products | Difficulty: Medium

SELECT customer_id
FROM Customer
GROUP BY customer_id
HAVING COUNT(DISTINCT(product_key)) = (
    SELECT COUNT(*) FROM Product
);

-- Counts how many unique products each customer bought.
-- Subquery returns the total number of distinct products from the Product table.
-- HAVING compares each customer's distinct purchase count to that total.
-- If they match, it means the customer bought all products.

-- Alternative version using NOT EXISTS:
SELECT DISTINCT customer_id
FROM Customer c1
WHERE NOT EXISTS (
    SELECT 1
    FROM Product p
    WHERE NOT EXISTS (
        SELECT 1
        FROM Customer c2
        WHERE c2.customer_id = c1.customer_id
          AND c2.product_key = p.product_key
    )
);

-- Inner NOT EXISTS: looks for a product the customer did not purchase.
-- Outer NOT EXISTS: confirms that no such product exists — meaning the customer bought all products.
-- The double-NOT structure expresses: “there does not exist a product they didn’t buy.”
-- (SELECT 1s are placeholders — existence is all that matters, not the value returned.)