SELECT T.TerritoryID, t.[Name] AS TerritoryName, SUM(s.TotalDue) as SalesTotal
FROM Sales.SalesTerritory t
INNER JOIN Sales.Customer c ON t.TerritoryID = c.TerritoryID
INNER JOIN Sales.SalesOrderHeader s ON c.CustomerID = s.CustomerID
GROUP BY t.TerritoryID, t.[Name]
GO

CREATE VIEW Sales.uvw_SalesByTerritory
AS
	SELECT T.TerritoryID, t.[Name] AS TerritoryName, SUM(s.TotalDue) as SalesTotal
	FROM Sales.SalesTerritory t
	INNER JOIN Sales.Customer c ON t.TerritoryID = c.TerritoryID
	INNER JOIN Sales.SalesOrderHeader s ON c.CustomerID = s.CustomerID
	GROUP BY t.TerritoryID, t.[Name]
GO

SELECT * FROM Sales.uvw_SalesByTerritory
GO

IF OBJECT_ID (N'Sales.ufn_SalesByTerritory') IS NOT NULL
   DROP FUNCTION Sales.ufn_SalesByTerritory
GO
CREATE FUNCTION Sales.ufn_SalesByTerritory(@TerritoryID INT = NULL)
RETURNS TABLE
AS
RETURN(
		SELECT t.TerritoryID, t.[Name] AS TerritoryName, SUM(s.TotalDue) as SalesTotal
		FROM Sales.SalesTerritory t
		INNER JOIN Sales.Customer c ON t.TerritoryID = c.TerritoryID
		INNER JOIN Sales.SalesOrderHeader s ON c.CustomerID = s.CustomerID
		WHERE @TerritoryID IS NULL OR t.TerritoryID = @TerritoryID
		GROUP BY t.TerritoryID, t.[Name]
	)
GO

SELECT * FROM Sales.ufn_SalesByTerritory(9)
GO

SELECT * FROM Sales.ufn_SalesByTerritory(NULL)
GO

IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'Sales'
     AND SPECIFIC_NAME = N'usp_SalesByTerritory' 
)
   DROP PROCEDURE Sales.usp_SalesByTerritory
GO

CREATE PROCEDURE Sales.usp_SalesByTerritory
@TerritoryID INT = NULL,
@Year INT = NULL,
@Message VARCHAR(500) = NULL OUTPUT
AS
	IF(@Year IS NOT NULL AND @Year> YEAR(GETDATE()))
		SET @Message = 'El año indicado no es válido';
	ELSE
		SELECT t.TerritoryID, t.[Name] AS TerritoryName, SUM(s.TotalDue) as SalesTotal
		FROM Sales.SalesTerritory t
		INNER JOIN Sales.Customer c ON t.TerritoryID = c.TerritoryID
		INNER JOIN Sales.SalesOrderHeader s ON c.CustomerID = s.CustomerID
		WHERE (@Year IS NULL OR YEAR(s.OrderDate) = @Year)
		AND
		(@TerritoryID IS NULL OR t.TerritoryID = @TerritoryID)
		GROUP BY t.TerritoryID, t.[Name]
GO


EXEC Sales.usp_SalesByTerritory
GO

EXEC Sales.usp_SalesByTerritory 2, 2011
GO
EXEC Sales.usp_SalesByTerritory 2, 2012
GO

--
DECLARE @msg VARCHAR(500)

EXEC Sales.usp_SalesByTerritory 2, 2011, @msg output
select @msg
GO