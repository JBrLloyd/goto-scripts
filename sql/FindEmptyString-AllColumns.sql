SET NOCOUNT ON;

DECLARE @sql NVARCHAR(MAX)
	, @columnName NVARCHAR(100)
	, @schemaName NVARCHAR(100) = 'dbo'
	, @tableName NVARCHAR(100) = 'User'

DECLARE columns CURSOR FOR
SELECT TOP (1000)
	C.[name] AS 'ColumnName'
FROM sys.columns C
INNER JOIN sys.tables T ON C.object_id = T.object_id
INNER JOIN sys.schemas S ON T.schema_id = S.schema_id
INNER JOIN sys.types CType ON C.system_type_id = CType.system_type_id
WHERE S.[name] = @schemaName
AND T.[name] = @tableName
AND CType.[name] NOT IN ('uniqueidentifier', 'timestamp') -- These column types cannot be null

OPEN columns
FETCH NEXT FROM columns
INTO @columnName

WHILE @@FETCH_STATUS = 0

BEGIN
    SET @sql = 'SELECT TOP (1000) ' + @columnName + ', *' 
			+ ' FROM [' + @schemaName + '].[' + @tableName + ']' 
			+ ' WHERE ltrim(rtrim([' + @columnName + '])) = ''''' -- WHERE ltrim(rtrim([columnName])) = ''
    
	print(@sql)

	EXEC(@sql)

	FETCH NEXT FROM columns
    INTO @columnName
END

CLOSE columns;    
DEALLOCATE columns;
