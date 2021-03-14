SELECT TOP 100 
	'SELECT TOP 100 ' + c.[name] + ', * FROM [' + s.[name] + '].[' + t.[name] + ']' AS 'SelectSatement',
	s.[name] AS 'SchemaName',
	t.[name] AS 'TableName',
	c.[name] AS 'ColumnName'
FROM sys.columns c
INNER JOIN sys.tables t ON c.object_id = t.object_id
INNER JOIN sys.schemas s ON t.schema_id = s.schema_id
WHERE c.[name] LIKE '%colName%'
ORDER BY SchemaName, TableName, ColumnName
