-- BASIC JOINS
-------------------------------------------------------------
-- Problem: https://leetcode.com/problems/replace-employee-id-with-the-unique-identifier/description/?envType=study-plan-v2&envId=top-sql-50
-- LeetCode ID: 1378 | Title: Replace Employee ID With The Unique Identifier | Difficulty: Easy

SELECT 
    u.unique_id
    , e.name
FROM Employees e
LEFT JOIN EmployeeUNI u
    ON e.id = u.id;

-- Simple LEFT JOIN to match employee names with their unique IDs, if they have one.
-- USING(id) would’ve worked too, but I went with ON to keep it explicit.

--------------------------------------------------------------
-- Problem: https://leetcode.com/problems/product-sales-analysis-i/description/?envType=study-plan-v2&envId=top-sql-50
-- LeetCode ID: 1068 | Title: Product Sales Analysis I | Difficulty: Easy

SELECT
    p.product_name
    , s.year
    , s.price
FROM Sales s
JOIN Product p
    ON s.product_id = p.product_id;

-- Standard inner join to pull product names into the sales table using product_id.
-- Classic "lookup and enrich" pattern — joining facts (Sales) with dimension info (Product).

--------------------------------------------------------------
-- Problem: https://leetcode.com/problems/customer-who-visited-but-did-not-make-any-transactions/description/?envType=study-plan-v2&envId=top-sql-50
-- LeetCode ID: 1581 | Title: Customer Who Visited but Did Not Make Any Transactions | Difficulty: Easy

SELECT
    customer_id
    , COUNT(visit_id) as count_no_trans
FROM Visits
LEFT JOIN Transactions
USING(visit_id)     -- Could use ON but USING felt cleaner here
WHERE transaction_id IS NULL
GROUP BY customer_id;

-- Standard anti-join pattern: LEFT JOIN then filter where the right-side key is NULL.
-- Counting how many times each customer visited without making a transaction.

SELECT
    v.customer_id
    , COUNT(*) as count_no_trans
FROM Visits v
WHERE NOT EXISTS (
    SELECT 1    -- Checks if a match exists; so the '1' is just a placeholder
    FROM Transactions t
    WHERE t.visit_id = v.visit_id
)
GROUP BY v.customer_id;

-- Same logic, different approach.
-- WHERE NOT EXISTS lets the database check for a match without needing to join rows — often faster if visit_id is indexed.

--------------------------------------------------------------
-- Problem: https://leetcode.com/problems/rising-temperature/description/?envType=study-plan-v2&envId=top-sql-50
-- LeetCode ID: 197 | Title: Rising Temperature | Difficulty: Easy

SELECT
    tod.id
FROM Weather tod
JOIN Weather yes
    ON tod.recordDate = yes.recordDate + INTERVAL '1 day'
    AND tod.temperature > yes.temperature; 

-- Self-join on the Weather table to compare each day to the previous one.
-- Using INTERVAL '1 day' makes the date logic clear and avoids any ambiguity.
-- Grabbing rows where today’s temperature is higher than yesterday’s.

--------------------------------------------------------------
-- Problem: https://leetcode.com/problems/average-time-of-process-per-machine/description/?envType=study-plan-v2&envId=top-sql-50
-- LeetCode ID: 1661 | Title: Average Time of Process per Machine | Difficulty: Easy

WITH start_end_pairs as (
    SELECT
        machine_id
        , process_id,
        , MAX(CASE WHEN activity_type = 'start' THEN timestamp END) AS start_time,
        , MAX(CASE WHEN activity_type = 'end' THEN timestamp END) AS end_time
    FROM activity
    GROUP BY machine_id, process_id
)
SELECT
    machine_id
    , ROUND(AVG(end_time - start_time)::numeric, 3) as processing_time
FROM start_end_pairs
-- Optional: filter out incomplete records
-- WHERE start_time IS NOT NULL AND end_time IS NOT NULL GROUP BY machine_id;
GROUP BY machine_id;

-- CTE pairs up start and end timestamps for each machine/process combo.
-- Final query calculates the average processing time per machine, rounded to 3 decimals.

--------------------------------------------------------------
-- Problem: https://leetcode.com/problems/employee-bonus/description/?envType=study-plan-v2&envId=top-sql-50
-- LeetCode ID: 577 | Title: Employee Bonus | Difficulty: Easy

SELECT
    name
    , bonus
FROM Employee
LEFT JOIN Bonus
USING(empID)
WHERE bonus < 1000 OR bonus IS NULL;

-- LEFT JOIN to include employees who don’t have a bonus at all.
-- Filter keeps only bonuses below 1000, or NULL (no bonus given).
-- USING(empID) removes the need to qualify it and avoids duplicate columns in the result.

--------------------------------------------------------------
-- Problem: https://leetcode.com/problems/students-and-examinations/description/?envType=study-plan-v2&envId=top-sql-50
-- LeetCode ID: 1208 | Title: Students and Examinations | Difficulty: Easy

SELECT
    s.student_id
    , s.student_name
    , sub.subject_name
    , COUNT(ex.student_id) as attended_exams
FROM Students s
CROSS JOIN Subjects sub
LEFT JOIN Examinations ex
    ON s.student_id = ex.student_id
    AND sub.subject_name = ex.subject_name
GROUP BY s.student_id, s.student_name, sub.subject_name
ORDER BY s.student_id, s.student_name, sub.subject_name;

-- CROSS JOIN builds all student–subject combinations.
-- LEFT JOIN attaches matching exam records where they exist.
-- COUNT handles cases with 0 matches, so we still get rows even if a student didn’t attend.

--------------------------------------------------------------
-- Problem: https://leetcode.com/problems/managers-with-at-least-5-direct-reports/description/?envType=study-plan-v2&envId=top-sql-50
-- LeetCode ID: 570 | Title: Managers with at Least 5 Direct Reports | Difficulty: Medium

SELECT name
FROM Employee
WHERE id IN (
    SELECT managerId
    FROM Employee
    GROUP BY managerId
    HAVING COUNT(*) >= 5
);

-- Finds employees who are listed as managers with at least 5 direct reports.
-- Uses a subquery with GROUP BY + HAVING to filter for manager IDs.

--------------------------------------------------------------
-- Problem: https://leetcode.com/problems/confirmation-rate/description/?envType=study-plan-v2&envId=top-sql-50
-- LeetCode ID: 1934 | Title: Confirmation Rate | Difficulty: Medium

SELECT
    s.user_id
    , ROUND(
        AVG(
            CASE WHEN c.action = 'confirmed' THEN 1.00 ELSE 0 END 
        )
      , 2) as confirmation_rate
FROM Signups s
LEFT JOIN Confirmations c
    ON s.user_id = c.user_id
GROUP BY s.user_id;

-- LEFT JOIN includes users who signed up but never confirmed.
-- CASE + AVG gives the confirmation rate per user (1 for confirmed, 0 otherwise).
-- Used 1.00 to force decimal division; ROUNDed to 2 decimals.