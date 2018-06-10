-- Project Euler problem 3

/*
The prime factors of 13195 are 5, 7, 13 and 29.

What is the largest prime factor of the number 600851475143 ?
*/

DECLARE @Number AS BIGINT = 600851475143;
DECLARE @Divisor AS BIGINT = FLOOR(SQRT(@Number));

WITH FindingFactorsOfNumber AS
(
		SELECT   @Number%@Divisor AS Div
				,@Divisor AS Factor
				,@Number AS Num
		UNION ALL
		SELECT	 CAST(Num%(Factor - 1) AS BIGINT) AS Div
				,CAST(Factor - 1 AS BIGINT) AS Factor
				,Num AS Num
		FROM PrimeFact
		WHERE Factor > 2 
)
SELECT * INTO #Temp
FROM PrimeFact
WHERE Div = 0
OPTION (MAXRECURSION 0);

DECLARE @MAX AS INT =  (SELECT COUNT(Factor) FROM #Temp);

WITH FindingFactorsOfFactors AS 
(
	SELECT 
		 T1.Factor AS Factor1 
		,T2.Factor AS Factor2 
		,(CASE WHEN (T2.Factor <= T1.Factor)  THEN  NULL  ELSE  (T2.Factor%T1.Factor) END) AS [Div]
	FROM #Temp T1
	CROSS JOIN #Temp T2
)
SELECT TOP 1 Factor2 AS [Largest_Prime_Factor]
FROM FactOfFact
WHERE Div <> 0
OR Div IS NULL
GROUP BY Factor2
HAVING COUNT(Factor2) = @MAX
ORDER BY Factor2 DESC

DROP TABLE #Temp