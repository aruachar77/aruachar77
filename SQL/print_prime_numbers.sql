-- SQL Program to Print Prime Numbers
-- This script generates and displays prime numbers up to a specified limit

-- Using a recursive CTE approach to generate numbers and filter primes
-- This example finds prime numbers up to 100

WITH RECURSIVE
-- Generate a sequence of numbers from 2 to 100
numbers(n) AS (
    SELECT 2
    UNION ALL
    SELECT n + 1
    FROM numbers
    WHERE n < 100
),
-- Find prime numbers by checking divisibility
primes(n) AS (
    SELECT n
    FROM numbers n1
    WHERE NOT EXISTS (
        SELECT 1
        FROM numbers n2
        WHERE n2.n < n1.n
        AND n2.n > 1
        AND n1.n % n2.n = 0
    )
)
-- Display the prime numbers
SELECT n AS prime_number
FROM primes
ORDER BY n;

-- Alternative approach using a cross join for divisibility check
-- Uncomment the following section to use this approach instead:

/*
WITH RECURSIVE
numbers(n) AS (
    SELECT 2
    UNION ALL
    SELECT n + 1
    FROM numbers
    WHERE n < 100
)
SELECT n1.n AS prime_number
FROM numbers n1
WHERE n1.n = 2
   OR NOT EXISTS (
       SELECT 1
       FROM numbers n2
       WHERE n2.n >= 2
       AND n2.n < n1.n
       AND n1.n % n2.n = 0
   )
ORDER BY n1.n;
*/

-- Notes:
-- 1. This script uses Common Table Expressions (CTEs) supported by most modern SQL databases
--    (PostgreSQL, MySQL 8.0+, SQL Server, SQLite 3.8.3+, Oracle 11g+)
-- 2. The limit is set to 100 but can be changed by modifying the WHERE clause
-- 3. The script starts from 2 as it's the first prime number
-- 4. Time complexity increases with the limit, so very large numbers may take longer to compute
