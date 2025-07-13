-- Problem: https://leetcode.com/problems/fix-names-in-a-table/description/?envType=study-plan-v2&envId=top-sql-50
-- LeetCode ID: 1667
-- Title: Fix Names in a Table
-- Difficulty: Easy

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

-- Output:
| user_id | name      |
| ------- | --------- |
| 222     | Marry Ann |  -- Here is the fail!
| 593     | Dalia     |
| 944     | Freida    |

-- Expected:
| user_id | name      |
| ------- | --------- |
| 222     | Marry ann |
| 593     | Dalia     |
| 944     | Freida    |

-- I don't think there would ever be a situation when you'd want 'Marry ann'
-- or something similar 'Dawn marie', 'Billy ray', 'Ann marie' etc.

-- In order to pass all 22 here you have to do this mess:
SELECT
    user_id
    , UPPER(LEFT(name, 1)) || LOWER(SUBSTRING(name FROM 2)) AS name     -- || joins strings; builds Title Case manually
FROM Users
ORDER BY user_id;