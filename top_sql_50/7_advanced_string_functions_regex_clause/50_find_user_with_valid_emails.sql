-- Problem: https://leetcode.com/problems/find-users-with-valid-e-mails/description/?envType=study-plan-v2&envId=top-sql-50
-- LeetCode ID: 1517
-- Title: Find Users With Valid E-Mails
-- Difficulty: Easy

-- This is the more realistic and technically correct solution:
SELECT *
FROM Users
WHERE mail ~* '^[a-z][a-z0-9_.-]*@leetcode\.com$'
-- It passes in 26/27 testcases but "fails" here:

-- Input:
| user_id | name    | mail                 |
| ------- | ------- | -------------------- |
| 1       | Winston | winston@leetcode.COM |

-- Output:
| user_id | name    | mail                 |
| ------- | ------- | -------------------- |
| 1       | Winston | winston@leetcode.COM |    -- Here is the fail!

-- Expected:
| user_id | name | mail |
| ------- | ---- | ---- |

-- But winston@leetcode.COM is a valid email address so if this were real-life,
-- leetcode's 'correct' solution would trash valid email addresses:

SELECT *
FROM Users
WHERE mail ~* '^[a-z][a-z0-9_.-]*@leetcode\.com$'
AND mail LIKE '%@leetcode.com'

-- REGEX notes:
-- ~*               - case-insensitive(*) match(~)
-- ^[a-z]           — first character must be a letter
-- [a-z0-9_.-]*     — allows letters, digits, underscore, dot, and hyphen after the first character
-- *                — means "zero or more" of the previous group
-- @leetcode\.com$  — matches the exact domain "leetcode.com" at the end of the string
-- \.               — escapes the dot (otherwise dot means "any character")
-- $                — asserts the end of the string