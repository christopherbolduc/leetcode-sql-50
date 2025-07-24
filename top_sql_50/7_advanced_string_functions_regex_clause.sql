-- ADVANCED STRING FUNCTIONS / REGEX / CLAUSE
--------------------------------------------------------------
-- Problem: https://leetcode.com/problems/fix-names-in-a-table/description/?envType=study-plan-v2&envId=top-sql-50
-- LeetCode ID: 1667 | Title: Fix Names in a Table | Difficulty: Easy

-- For this problem, I think this is really the right solution:
SELECT
    user_id
    , INITCAP(name) as name     -- Capitalizes first letter of each word in a string (Title Case)
FROM Users
ORDER BY user_id;
-- It passes in 21/22 testcases but "fails" here:

-- Input:
| user_id | name      |
| ------- | --------- |
| 593     | DAlia     |
| 944     | FREIda    |
| 222     | MaRRy aNN |

-- My Output:
| user_id | name      |
| ------- | --------- |
| 222     | Marry Ann |  -- Here is the "fail"!
| 593     | Dalia     |
| 944     | Freida    |

-- Expected Output:
| user_id | name      |
| ------- | --------- |
| 222     | Marry ann |
| 593     | Dalia     |
| 944     | Freida    |

-- I don't think there would ever be a situation when you'd want 'Marry ann'
-- or something similar 'Dawn marie', 'Billy ray', 'Ann marie' etc.

-- In order to pass all 22 here I had to do this:
SELECT
    user_id
    , UPPER(LEFT(name, 1)) || LOWER(SUBSTRING(name FROM 2)) as name     -- || joins strings; builds Title Case manually
FROM Users
ORDER BY user_id;

--------------------------------------------------------------
-- Problem: https://leetcode.com/problems/patients-with-a-condition/description/?envType=study-plan-v2&envId=top-sql-50
-- LeetCode ID: 1527 | Title: Patients With a Condition | Difficulty: Easy

-- This is the more medically appropriate solution:
SELECT
    patient_id
    , patient_name
    , conditions
FROM Patients
WHERE conditions ~* '\mDIAB1';

-- WHERE conditions ~* '\mDIAB1' uses regex:
-- ~ means regex match; * makes it case-insensitive.
-- \m matches the start of a word: any word that begins with 'DIAB1'

-- This passes 8/9 test cases but "fails" here:

-- Input:
| patient_id | patient_name | conditions    |
| ---------- | ------------ | ------------- |
| 1          | George       | ACNE +DIAB100 |
| 2          | Alain        | DIAB201       |

-- My Output:
| patient_id | patient_name | conditions    |
| ---------- | ------------ | ------------- |
| 1          | George       | ACNE +DIAB100 |   -- Here is the "fail"!

-- Expected Output:
| patient_id | patient_name | conditions |
| ---------- | ------------ | ---------- |

-- Patient 1 clearly has a diabetes-related condition,
-- but leetcode rejects it because 'DIAB1' isn’t space-separated.

-- To pass all 9 cases on leetcode, I had to use this:
SELECT
    patient_id
    , patient_name
    , conditions
FROM Patients
WHERE conditions ILIKE 'DIAB1%'
    OR conditions ILIKE '% DIAB1%';

-- ILIKE is case-insensitive LIKE, but LIKE works here too.
-- First condition: string starts with 'DIAB1'.
-- Second condition: 'DIAB1' appears at the start of any word after a space.
-- This works because LIKE does not treat '+' as a special character.

--------------------------------------------------------------
-- Problem: https://leetcode.com/problems/delete-duplicate-emails/description/?envType=study-plan-v2&envId=top-sql-50
-- LeetCode ID: 196 | Title: Delete Duplicate Emails | Difficulty: Easy

WITH ranked_emails as (
    SELECT
        id
        , ROW_NUMBER() OVER (PARTITION BY email ORDER BY id) as rn
    FROM Person
)

DELETE FROM Person
WHERE id IN (
    SELECT id
    FROM ranked_emails
    WHERE rn > 1
);

-- CTE assigns row numbers partitioned by email, ordered by id.
-- Keeps the first occurrence (rn = 1), deletes the rest (rn > 1).

--------------------------------------------------------------
-- Problem: https://leetcode.com/problems/second-highest-salary/description/?envType=study-plan-v2&envId=top-sql-50
-- LeetCode ID: 176 | Title: Second Highest Salary | Difficulty: Medium

SELECT (
    SELECT DISTINCT salary
    FROM Employee
    ORDER BY salary DESC
    LIMIT 1 OFFSET 1
) as SecondHighestSalary;

-- Selects the second-highest distinct salary.
-- DISTINCT removes duplicates; ORDER BY DESC ranks salaries from high -> low.
-- LIMIT 1 OFFSET 1 skips the highest and returns the second-highest (or NULL if none).
-- The outer SELECT just names the column and ensures a single-value result.

--------------------------------------------------------------
-- Problem: https://leetcode.com/problems/group-sold-products-by-the-date/description/?envType=study-plan-v2&envId=top-sql-50
-- LeetCode ID: 1484 | Title: Group Sold Products By The Date | Difficulty: Easy

SELECT
    sell_date
    , COUNT(DISTINCT product) as num_sold
    , STRING_AGG(DISTINCT product, ',' ORDER BY product) as products
FROM Activities
GROUP BY sell_date
ORDER BY sell_date;

-- Groups sales by date and counts how many distinct products were sold each day.
-- STRING_AGG concatenates product names into a comma-separated string, ordered alphabetically.
-- DISTINCT ensures duplicates are removed from both count and list.

--------------------------------------------------------------
-- Problem: https://leetcode.com/problems/list-the-products-ordered-in-a-period/description/?envType=study-plan-v2&envId=top-sql-50
-- LeetCode ID: 1327 | Title: List the Products Ordered in a Period | Difficulty: Easy

SELECT
    pro.product_name
    , SUM(ord.unit) as unit
FROM Products pro
JOIN Orders ord
    ON pro.product_id = ord.product_id
WHERE ord.order_date >= '2020-02-01'::date
    AND ord.order_date < '2020-03-01'::date
GROUP BY pro.product_name
HAVING SUM(ord.unit) >= 100;

-- Joins product and order data by product_id
-- Filters orders placed in February 2020 using a date range (inclusive start, exclusive end)
-- Aggregates total units sold per product using SUM()
-- Filters to only include products with 100 or more total units ordered

-- Could have used:
WHERE TO_CHAR(ord.order_date, 'YYYY-MM') = '2020-02'
-- But applying a function to the column disables index use.
-- Using a date range keeps the query fast and index-friendly.
-- It’s also easier to tweak the start or end date later if needed.

--------------------------------------------------------------
-- Problem: https://leetcode.com/problems/find-users-with-valid-e-mails/description/?envType=study-plan-v2&envId=top-sql-50
-- LeetCode ID: 1517 | Title: Find Users With Valid E-Mails | Difficulty: Easy

-- This is the more realistic and technically correct solution:
SELECT *
FROM Users
WHERE LOWER(mail) ~ '^[a-z][a-z0-9_.-]*@leetcode\.com$'
-- It passes in 26/27 testcases but "fails" here:

-- Input:
| user_id | name    | mail                 |
| ------- | ------- | -------------------- |
| 1       | Winston | winston@leetcode.COM |

-- My Output:
| user_id | name    | mail                 |
| ------- | ------- | -------------------- |
| 1       | Winston | winston@leetcode.COM |    -- Here is the "fail"!

-- Expected Output:
| user_id | name | mail |
| ------- | ---- | ---- |

-- But 'winston@leetcode.COM' IS a valid email address (domains are always case insensitive)
-- If this were real-life, leetcode's accepted solution would drop valid email addresses:

SELECT *
FROM Users
WHERE mail ~ '^[a-zA-Z][a-zA-Z0-9_.-]*@leetcode\.com$'


-- REGEX notes:
-- ~                - case-sensitive match operator
-- ^[a-z]           — first character must be a letter (lower-case)
-- [a-z0-9_.-]*     — allows lower-case letters, digits, underscores, dots, and hyphens after the first character
-- [a-zA-Z]         — allow both uppercase and lowercase letters
-- [a-zA-Z0-9_.-]*  — allows uppercase/lowercase letters, digits, underscores, dots, and hyphens
-- *                — means "zero or more" of the previous group
-- @leetcode\.com$  — matches exactly "leetcode.com" at the end (case-sensitive)
-- \.               — escapes the dot (otherwise dot means "any character")
-- $                — asserts the end of the string