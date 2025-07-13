-- Problem: https://leetcode.com/problems/patients-with-a-condition/description/?envType=study-plan-v2&envId=top-sql-50
-- LeetCode ID: 1527
-- Title: Patients With a Condition
-- Difficulty: Easy

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

-- Output:
| patient_id | patient_name | conditions    |
| ---------- | ------------ | ------------- |
| 1          | George       | ACNE +DIAB100 |

-- Expected:
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