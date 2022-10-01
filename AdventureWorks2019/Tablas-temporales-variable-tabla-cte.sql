--TABLAS TEMPORALES
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'Sales'
     AND SPECIFIC_NAME = N'usp_SalesByTerritoryTemp' 
)
   DROP PROCEDURE Sales.usp_SalesByTerritoryTemp
GO

CREATE PROCEDURE Sales.usp_SalesByTerritoryTemp
@TerritoryID INT = NULL,
@Year INT = NULL
AS
	CREATE TABLE #TempSalesyByTerritory
	( 
		TerritoryID INT,
		TerritoryName NVARCHAR(50),
		SalesTotal DECIMAL(18,2)
	)

	INSERT INTO #TempSalesyByTerritory
	SELECT t.TerritoryID, t.[Name] AS TerritoryName, SUM(s.TotalDue) as SalesTotal
	FROM Sales.SalesTerritory t
	INNER JOIN Sales.Customer c ON t.TerritoryID = c.TerritoryID
	INNER JOIN Sales.SalesOrderHeader s ON c.CustomerID = s.CustomerID
	WHERE (@Year IS NULL OR YEAR(s.OrderDate) = @Year)
	AND
	(@TerritoryID IS NULL OR t.TerritoryID = @TerritoryID)
	GROUP BY t.TerritoryID, t.[Name];
	--
	SELECT TerritoryID, TerritoryName, SalesTotal, Utility = SalesTotal*0.85
	FROM #TempSalesyByTerritory tr

GO

EXEC Sales.usp_SalesByTerritoryTemp
GO


IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'Sales'
     AND SPECIFIC_NAME = N'usp_SalesByTerritoryTempGlobal' 
)
   DROP PROCEDURE Sales.usp_SalesByTerritoryTempGlobal
GO

CREATE PROCEDURE Sales.usp_SalesByTerritoryTempGlobal
@TerritoryID INT = NULL,
@Year INT = NULL
AS
	IF OBJECT_ID('tempdb..##TempSalesyByTerritory', 'U') IS NOT NULL
	  DROP TABLE ##TempSalesyByTerritory

	CREATE TABLE ##TempSalesyByTerritory
	( 
		TerritoryID INT,
		TerritoryName NVARCHAR(50),
		SalesTotal DECIMAL(18,2)
	)

	INSERT INTO ##TempSalesyByTerritory
	SELECT t.TerritoryID, t.[Name] AS TerritoryName, SUM(s.TotalDue) as SalesTotal
	FROM Sales.SalesTerritory t
	INNER JOIN Sales.Customer c ON t.TerritoryID = c.TerritoryID
	INNER JOIN Sales.SalesOrderHeader s ON c.CustomerID = s.CustomerID
	WHERE (@Year IS NULL OR YEAR(s.OrderDate) = @Year)
	AND
	(@TerritoryID IS NULL OR t.TerritoryID = @TerritoryID)
	GROUP BY t.TerritoryID, t.[Name];
	--
	SELECT TerritoryID, TerritoryName, SalesTotal, Utility = SalesTotal*0.85
	FROM ##TempSalesyByTerritory tr

GO
EXEC Sales.usp_SalesByTerritoryTempGlobal
GO
SELECT TerritoryID, TerritoryName, SalesTotal, Utility = SalesTotal*0.85
FROM ##TempSalesyByTerritory tr
GO

IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'Sales'
     AND SPECIFIC_NAME = N'usp_SalesByTerritoryCTE' 
)
   DROP PROCEDURE Sales.usp_SalesByTerritoryCTE
GO
--CTE = COMMON TABLE EXPRESION
CREATE PROCEDURE Sales.usp_SalesByTerritoryCTE
@TerritoryID INT = NULL,
@Year INT = NULL
AS

;WITH CTE_TempSalesyByTerritory AS ( 
	SELECT t.TerritoryID, t.[Name] AS TerritoryName, SUM(s.TotalDue) as SalesTotal
	FROM Sales.SalesTerritory t
	INNER JOIN Sales.Customer c ON t.TerritoryID = c.TerritoryID
	INNER JOIN Sales.SalesOrderHeader s ON c.CustomerID = s.CustomerID
	WHERE (@Year IS NULL OR YEAR(s.OrderDate) = @Year)
	AND
	(@TerritoryID IS NULL OR t.TerritoryID = @TerritoryID)
	GROUP BY t.TerritoryID, t.[Name]
)

--
SELECT TerritoryID, TerritoryName, SalesTotal, Utility = SalesTotal*0.85
FROM CTE_TempSalesyByTerritory 
GO

EXEC Sales.usp_SalesByTerritoryTempGlobal
GO

--VARIABLES DE TABLA
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'Sales'
     AND SPECIFIC_NAME = N'usp_SalesByTerritoryVarTable' 
)
   DROP PROCEDURE Sales.usp_SalesByTerritoryVarTable
GO

CREATE PROCEDURE Sales.usp_SalesByTerritoryVarTable
@TerritoryID INT = NULL,
@Year INT = NULL
AS
	DECLARE @TempSalesyByTerritory AS TABLE 
	( 
		TerritoryID INT,
		TerritoryName NVARCHAR(50),
		SalesTotal DECIMAL(18,2)
	);

	INSERT INTO @TempSalesyByTerritory
	SELECT t.TerritoryID, t.[Name] AS TerritoryName, SUM(s.TotalDue) as SalesTotal
	FROM Sales.SalesTerritory t
	INNER JOIN Sales.Customer c ON t.TerritoryID = c.TerritoryID
	INNER JOIN Sales.SalesOrderHeader s ON c.CustomerID = s.CustomerID
	WHERE (@Year IS NULL OR YEAR(s.OrderDate) = @Year)
	AND
	(@TerritoryID IS NULL OR t.TerritoryID = @TerritoryID)
	GROUP BY t.TerritoryID, t.[Name]
	---
	INSERT INTO @TempSalesyByTerritory (TerritoryID, TerritoryName, SalesTotal)
	VALUES(9999, 'TERRITORIO TEMPORAL', 100000)
	---
	UPDATE @TempSalesyByTerritory
	SET TerritoryName = 'Francia'
	WHERE TerritoryName = 'France'
	---
	SELECT TerritoryID, TerritoryName, SalesTotal, Utility = SalesTotal*0.85
	FROM @TempSalesyByTerritory
	--
GO

EXEC Sales.usp_SalesByTerritoryVarTable
GO