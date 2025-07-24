-- ADVANCED SELECT AND JOINS
--------------------------------------------------------------
-- Problem: https://leetcode.com/problems/the-number-of-employees-which-report-to-each-employee/description/?envType=study-plan-v2&envId=top-sql-50
-- LeetCode ID: 1731 | Title: The Number of Employees Which Report to Each Employee | Difficulty: Easy

WITH managers as (
SELECT
    reports_to as employee_id
    , COUNT(*) as reports_count
    , ROUND(AVG(age)) as average_age
FROM Employees
WHERE reports_to IS NOT NULL
GROUP BY reports_to
)

SELECT
    e.employee_id
    , e.name
    , m.reports_count
    , m.average_age
FROM Employees e
JOIN managers m
    ON e.employee_id = m.employee_id
ORDER BY e.employee_id;

-- CTE counts how many employees report to each manager (using reports_to),
-- and calculates the average age of their direct reports.
-- Final query joins that data back to the Employees table to display manager info.

--------------------------------------------------------------
-- Problem: https://leetcode.com/problems/primary-department-for-each-employee/description/?envType=study-plan-v2&envId=top-sql-50
-- LeetCode ID: 1789 | Title: Primary Department for Each Employee | Difficulty: Easy

SELECT
    employee_id
    , department_id
FROM Employee
WHERE primary_flag = 'Y' OR
    employee_id IN (
     SELECT employee_id
     FROM Employee
     GROUP BY employee_id
     HAVING COUNT(department_id) = 1
    )
ORDER BY employee_id;

-- Returns each employee’s primary department.
-- If an employee has multiple departments, we use the row marked 'Y' as primary.
-- If they belong to only one department, that department is considered primary by default.

--------------------------------------------------------------
-- Problem: https://leetcode.com/problems/triangle-judgement/description/?envType=study-plan-v2&envId=top-sql-50
-- LeetCode ID: 610 | Title: Triangle Judgement | Difficulty: Easy

SELECT
   *
    , CASE 
        WHEN x + y > z AND y + z > x AND z + x > y
        THEN 'Yes'
        ELSE 'No' 
      END as triangle
FROM Triangle;

-- Applies the triangle inequality rule:
-- For three lengths to form a triangle, the sum of any two must be greater than the third.
-- If the condition holds for all three combinations, return 'Yes'; otherwise, 'No'.

--------------------------------------------------------------
-- Problem: https://leetcode.com/problems/consecutive-numbers/description/?envType=study-plan-v2&envId=top-sql-50
-- LeetCode ID: 180 | Title: Consecutive Numbers | Difficulty: Medium

SELECT DISTINCT num as ConsecutiveNums
FROM (
  SELECT
    num
    , LAG(num, 1) OVER (ORDER BY id) as prev
    , LAG(num, 2) OVER (ORDER BY id) as prev2
  FROM Logs
) as t
WHERE num = prev AND num = prev2;

-- Uses LAG to access values from previous two rows in the window ordered by id.
-- Filters for rows where num matches both the previous two — meaning three in a row.
-- DISTINCT ensures we only list each qualifying number once.

--------------------------------------------------------------
-- Problem: https://leetcode.com/problems/product-price-at-a-given-date/description/?envType=study-plan-v2&envId=top-sql-50
-- LeetCode ID: 1164 | Title: Product Price at a Given Date | Difficulty: Medium

SELECT
  product_id,
  COALESCE(
    ( SELECT new_price
      FROM Products as p2
      WHERE p2.product_id = p1.product_id
        AND p2.change_date <= '2019-08-16'
      ORDER BY change_date DESC
      LIMIT 1 )
  , 10) as price
FROM Products as p1
GROUP BY product_id
ORDER BY product_id;

-- For each product, looks up the most recent price before or on '2019-08-16'.
-- Uses a correlated subquery with ORDER BY + LIMIT 1 to get the latest applicable price.
-- COALESCE returns 10 if no price was set before that date (default price).

--------------------------------------------------------------
-- Problem: https://leetcode.com/problems/last-person-to-fit-in-the-bus/description/?envType=study-plan-v2&envId=top-sql-50
-- LeetCode ID: 1204 | Title: Last Person to Fit in the Bus | Difficulty: Medium

WITH rolling_sum as (
    SELECT
        person_name
        , turn
        , SUM(weight) OVER (ORDER BY turn) as rolling_weight
    FROM Queue
)

SELECT
    person_name
FROM rolling_sum
WHERE rolling_weight <= 1000
ORDER BY turn DESC
LIMIT 1;

-- Calculates a running total of weights in queue order using SUM() OVER (ORDER BY turn).
-- Filters only the people whose entry kept the total at or below 1000.
-- Takes the last one of those (highest turn) as the final person allowed on the bus.

--------------------------------------------------------------
-- Problem: https://leetcode.com/problems/count-salary-categories/description/?envType=study-plan-v2&envId=top-sql-50
-- LeetCode ID: 1907 | Title: Count Salary Categories | Difficulty: Medium

WITH bracket as (
SELECT
    CASE
      WHEN income > 50000 THEN 'High Salary'
      WHEN income BETWEEN 20000 AND 50000 THEN 'Average Salary'
      ELSE 'Low Salary'
    END as category
FROM Accounts
)

SELECT
  c.category
  , COUNT(b.category) as accounts_count
FROM (
    SELECT 'High Salary' as category
    UNION ALL
    SELECT 'Average Salary'
    UNION ALL
    SELECT 'Low Salary'
) as c
LEFT JOIN bracket b
    ON c.category = b.category
GROUP BY c.category
ORDER BY 
    CASE c.category
        WHEN 'High Salary' THEN 1
        WHEN 'Average Salary' THEN 2
        WHEN 'Low Salary' THEN 3
    END;

-- CTE assigns each account to a salary category using CASE.
-- Derived table (c) lists all categories to guarantee all are represented in the final output.
-- LEFT JOIN ensures we still see categories with zero accounts.
-- Final output includes an ORDER BY to show a logical order from High to Low.