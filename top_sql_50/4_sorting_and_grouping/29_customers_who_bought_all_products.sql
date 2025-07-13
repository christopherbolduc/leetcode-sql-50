-- Problem: https://leetcode.com/problems/customers-who-bought-all-products/description/?envType=study-plan-v2&envId=top-sql-50
-- LeetCode ID: 1045
-- Title: Customers Who Bought All Products
-- Difficulty: Medium

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