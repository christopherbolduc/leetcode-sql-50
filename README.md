# LeetCode SQL 50 – My Solutions & Commentary

This repository contains my complete solutions to the [LeetCode Top 50 SQL Questions](https://leetcode.com/studyplan/top-sql-50). Every query is fully commented — not just to pass test cases, but to be readable, explainable, and realistic for real-world use.


<div align="center">
  <img src="/images/sql_badge.png" alt="SQL Badge" width="300" style="margin-bottom: 12px;">
</div>

I approached this set with three goals:

1. Write clean, readable SQL.
2. Add meaningful comments that show understanding — not just what the query *does*, but *why* it’s written that way.
3. Refactor when LeetCode’s “accepted” answer seemed incomplete, unrealistic, or semantically off.

---
## Folder Structure

Problems are grouped into categories following the official LeetCode study plan. Each category has a single `.sql` file containing all problems in that group.

```
leetcode_sql_practice/
├── images/
│   └── sql_badge.png
├── top_sql_50/
│   ├── 1_select.sql
│   ├── 2_basic_joins.sql
│   ├── 3_basic_aggregate_functions.sql
│   ├── 4_sorting_and_grouping.sql
│   ├── 5_advanced_select_and_joins.sql
│   ├── 6_subqueries.sql
│   ├── 7_advanced_string_functions_regex_clause.sql
├── .gitignore
├── LICENSE
└── README.md      
```

Each solution:
- Provides the link to the original LeetCode problem
- Displays the LeetCode ID, title, and difficulty level
- Includes detailed commentary and (when relevant) alternate solutions or notes on edge cases

---

## Why I Wrote It This Way

Some problems have more than one reasonable solution. When that was the case, I included:

- **Alternative versions** using different techniques (e.g., `NOT EXISTS`, `JOIN`, window functions).
- **Real-world adjustments** for situations where LeetCode’s “accepted” answer technically passes test cases, but misses common-sense expectations — like mishandling names or dropping valid email formats.

For example, in this case, LeetCode's version misses this patient with type 1 diabetes:

```sql
-- This passes 8/9 test cases but "fails" here:

-- Input:
| patient_id | patient_name | conditions    |
| ---------- | ------------ | ------------- |
| 1          | George       | ACNE +DIAB100 |
| 2          | Alain        | DIAB201       |

-- Output:
| patient_id | patient_name | conditions    |
| ---------- | ------------ | ------------- |
| 1          | George       | ACNE +DIAB100 |   -- I include poor George

-- Expected:
| patient_id | patient_name | conditions |
| ---------- | ------------ | ---------- |      -- LeetCode misses him

-- Patient 1 clearly has a diabetes-related condition,
-- but leetcode rejects it because 'DIAB1' isn’t space-separated.
```
## Notes on Style

PostgreSQL syntax is used throughout.

I followed a few deliberate conventions to keep the code readable, maintainable, and explainable:

### Leading commas

I place commas at the beginning of each line in the `SELECT` list. This makes version control diffs cleaner and makes it easier to scan, comment out, or reorder columns.

Example:
```sql
SELECT
    name
    , population
    , area
FROM World
```
### Consistent aliasing

I use `as` (lowercase) for all column aliases — even when optional — to improve clarity and avoid ambiguity.

The lowercase `as` is a personal style choice: it keeps the query quieter and more readable.

### Window functions
Used when appropriate for ranking, partitioned aggregations, or rolling calculations. Each usage includes a comment explaining its role.

### Regex
Regular expressions are used carefully and only when needed. I explain each pattern in plain language to clarify intent and avoid misinterpretation.

Example:
```sql
-- ~*               - case-insensitive(*) match(~)
-- ^[a-z]           — first character must be a letter
-- [a-z0-9_.-]*     — allows letters, digits, underscore, dot, and hyphen after the first character
-- @leetcode\.com$  — matches the exact domain "leetcode.com" at the end of the string

```
## License

This project is licensed under the [MIT License](LICENSE).

If you find these solutions or commentary helpful and reuse them in public projects, I’d appreciate a shout-out or link back!
> ⚠️ Disclaimer: Problem descriptions and titles are property of LeetCode.  
> This repository only contains my personal solutions and commentary, with links to the original problems.

## Author

**Christopher Bolduc**  
[LinkedIn](https://www.linkedin.com/in/christopher-david-bolduc/) • [GitHub](https://github.com/christopherbolduc)