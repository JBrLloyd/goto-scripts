DECLARE @Id INT
SELECT @Id = Id FROM dbo.Document WHERE RandomNumber = 'S012'

;WITH CTE AS 
(
	SELECT D.Id AS CurrId, D.Number, D.PrevId
	FROM dbo.Document D
	WHERE Id = @Id

	UNION ALL

	SELECT D2.Id AS CurrId, D2.Number, D2.PrevId
	FROM dbo.Document D2
	JOIN CTE C ON D2.Id = C.PrevId
)

SELECT TOP 1000 I.*
FROM dbo.DocumentItems I
JOIN CTE C ON I.Id = C.CurrId
