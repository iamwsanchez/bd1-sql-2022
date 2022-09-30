IF OBJECT_ID (N'HumanResources.ufnGetFullEmployeeInfo') IS NOT NULL
    DROP FUNCTION HumanResources.ufnGetFullEmployeeInfo
GO

CREATE FUNCTION HumanResources.ufnGetFullEmployeeInfo()
RETURNS TABLE
AS RETURN
(
	SELECT  e.FirstName, e.LastName, j.[Name]
	FROM HumanResources.Job j
	INNER JOIN HumanResources.Employee e ON j.Id = e.JobId
)
GO

IF OBJECT_ID (N'dbo.CalculateSum') IS NOT NULL
    DROP FUNCTION dbo.CalculateSum
GO

CREATE FUNCTION dbo.CalculateSum(@num1 decimal(10,2), @num2 decimal(10,2))
RETURNS decimal(10,2)
AS
BEGIN
	RETURN @num1 + @num2;
END
GO
SELECT dbo.CalculateSum(10,15)

IF OBJECT_ID (N'dbo.CalculateDiv') IS NOT NULL
    DROP FUNCTION dbo.CalculateDiv
GO

CREATE FUNCTION dbo.CalculateDiv(@num1 INT, @num2 INT)
RETURNS decimal(10,4)
AS
BEGIN
	RETURN CAST(@num1 AS decimal) / CAST(@num2 AS decimal);
END
GO

SELECT dbo.CalculateDiv(10,15)

--

IF OBJECT_ID (N'HumanResources.GetLastJobId') IS NOT NULL
    DROP FUNCTION HumanResources.GetLastJobId
GO

CREATE FUNCTION HumanResources.GetLastJobId()
RETURNS tinyint
AS
BEGIN
	RETURN(SELECT MAX(Id) FROM [HumanResources].[Job])
END
GO

--SELECT HumanResources.GetLastJobId()