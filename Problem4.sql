--Project Euler problem 4

/*A palindromic number reads the same both ways. The largest palindrome made from the product of two 2-digit numbers is 9009 = 91 × 99.

Find the largest palindrome made from the product of two 3-digit numbers.*/


CREATE TABLE #Numbers ( Number BIGINT );

WITH 
P0(N) AS (SELECT 1 UNION ALL SELECT 1), /* 2^2^0 */
P1(N) AS (SELECT 1 FROM P0 A, P0 B), /* 2^2^1 */
P2(N) AS (SELECT 1 FROM P1 A, P1 B), /* 2^2^2 */
P3(N) AS (SELECT 1 FROM P2 A, P2 B), /* 2^2^3 */
P4(N) AS (SELECT 1 FROM P3 A, P3 B), /* 2^2^4 */
P5(N) AS (SELECT 1 FROM P4 A, P4 B), /* 2^2^5 */
Numbers(N) AS (SELECT ROW_NUMBER() OVER(ORDER BY (SELECT NULL)) FROM P5)
INSERT INTO #Numbers (Number)
SELECT nb.N FROM Numbers nb
WHERE nb.N <= 999
AND nb.N >= 100;

SELECT TOP 1 Prod AS [Answer] FROM
	(SELECT a.Number as a, b.Number as b, (a.Number * b.Number) AS [Prod] FROM #Numbers a, #Numbers b ) AS [Tab]
WHERE LEFT([Prod],1) = RIGHT([Prod],1) AND
SUBSTRING(CAST([Prod] AS VARCHAR(128)),2,1) = SUBSTRING(CAST([Prod] AS VARCHAR(128)),LEN(CAST([Prod] AS VARCHAR(128)))-1,1) AND
SUBSTRING(CAST([Prod] AS VARCHAR(128)),3,1) = SUBSTRING(CAST([Prod] AS VARCHAR(128)),LEN(CAST([Prod] AS VARCHAR(128)))-2,1) 
ORDER BY Prod DESC

DROP Table #Numbers