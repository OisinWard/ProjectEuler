-- Project Euler problem 2

/* 
Each new term in the Fibonacci sequence is generated by adding the previous two terms. By starting with 1 and 2, the first 10 terms will be:

				1, 2, 3, 5, 8, 13, 21, 34, 55, 89, ...

By considering the terms in the Fibonacci sequence whose values do not exceed four million, find the sum of the even-valued terms.
*/



WITH Fibonacci AS 
(
	SELECT	 0 AS f0
			,1 AS f1

	UNION ALL

	SELECT	 f1 AS f0
			,f0 + f1 AS f1

	FROM Fibonacci
	WHERE f1 < 4000000
)
SELECT SUM(f0) AS Fibonacci
FROM Fibonacci
WHERE f0%2 = 0