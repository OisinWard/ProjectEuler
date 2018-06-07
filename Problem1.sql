-- Project Euler problem 1

/* 
If we list all the natural numbers below 10 that are multiples of 3 or 5, we get 3, 5, 6 and 9. The sum of these multiples is 23.

Find the sum of all the multiples of 3 or 5 below 1000.
*/

DECLARE @Sum TABLE
(
  SUM_Multiples INT
)

DECLARE @Mult AS INT = 0
DECLARE @Upper AS INT = 1000

WHILE @Mult < @Upper
	BEGIN
		SET @Mult = @Mult + 1
		IF @Mult = @Upper
			BREAK
		
		IF @Mult%5 = 0
			INSERT INTO @Sum VALUES (@Mult)
		IF @Mult%3 = 0
			INSERT INTO @Sum VALUES (@Mult)
	END

SELECT SUM(DISTINCT (SUM_Multiples)) AS [Answer] FROM @Sum