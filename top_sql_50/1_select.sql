-- SELECT
--------------------------------------------------------------
-- Problem: https://leetcode.com/problems/recyclable-and-low-fat-products/?envType=study-plan-v2&envId=top-sql-50
-- LeetCode ID: 1757 | Title: Recyclable And Low Fat Products | Difficulty: Easy

SELECT product_id
FROM Products
WHERE low_fats = 'Y' AND recyclable = 'Y';

-- Straightforward filter with two boolean-style columns.
-- Reinforces basics of WHERE clause logic and string comparison.

--------------------------------------------------------------
-- Problem: https://leetcode.com/problems/find-customer-referee/description/?envType=study-plan-v2&envId=top-sql-50
-- LeetCode ID: 584 | Title: Find Customer Referee | Difficulty: Easy

SELECT name
FROM Customer
WHERE COALESCE(referee_id, 0) != 2

-- Used COALESCE to treat NULL referee_ids as 0, so I can safely compare them to 2.
-- Without it, NULL != 2 doesn’t return true — it returns 'unknown' so those rows get filtered out.
-- I could’ve also done 'WHERE referee_id IS NULL OR referee_id != 2', but this is cleaner.

--------------------------------------------------------------
-- Problem: https://leetcode.com/problems/big-countries/description/?envType=study-plan-v2&envId=top-sql-50
-- LeetCode ID: 595 | Title: Big Countries | Difficulty: Easy

SELECT
    name
    , population
    , area
FROM World
WHERE area >= 3000000 OR population >= 25000000;

-- Straightforward OR filter — just grabbing countries that are either really large in area or heavily populated.

--------------------------------------------------------------
-- Problem: https://leetcode.com/problems/article-views-i/description/?envType=study-plan-v2&envId=top-sql-50
-- LeetCode ID: 1148 | Title: Article Views I | Difficulty: Easy

SELECT DISTINCT author_id as id
FROM Views
WHERE author_id = viewer_id
ORDER BY author_id;

-- Looking for authors who viewed their own articles — just a row-wise comparison between author and viewer.
-- Used DISTINCT to avoid duplicates in case someone viewed their own article multiple times.

--------------------------------------------------------------
-- Problem: https://leetcode.com/problems/invalid-tweets/description/?envType=study-plan-v2&envId=top-sql-50
-- LeetCode ID: 1683 | Title: Invalid Tweets | Difficulty: Easy

SELECT tweet_id
FROM Tweets
WHERE CHAR_LENGTH(content) > 15;

-- Simple filter to catch tweets that are too long.
-- Used CHAR_LENGTH to count actual characters — LENGTH would count bytes, which could be misleading with multibyte characters.