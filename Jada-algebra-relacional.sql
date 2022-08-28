USE Jade
GO

--Selecci�n
SELECT * FROM HumanResources.Employee
GO

SELECT * FROM HumanResources.Employee
WHERE FirstName like 'A%'
GO

SELECT [Id], [FirstName], [MiddleName], [LastName], [JobId] 
FROM HumanResources.Employee
WHERE FirstName like 'M%'
GO

---Proyecci�n
SELECT FirstName, LastName FROM HumanResources.Employee
WHERE FirstName like 'M%'
GO

SELECT e.Id /*Identificador �nico del empleado.
Bla, bla.
Bla, bla.
*/, 
e.FirstName, 
e.LastName
FROM HumanResources.Employee AS e

SELECT e.Id AS IdEmpleado, 
e.FirstName AS [Primer Nombre], 
e.LastName AS Apellido
FROM HumanResources.Employee AS e

SELECT e.Id AS IdEmpleado, 
[Nombre Completo] = CONCAT(e.FirstName, ' ', e.MiddleName, ' ', e.LastName)
FROM HumanResources.Employee AS e

SELECT e.Id AS IdEmpleado, 
[Nombre Completo] = e.FirstName + ISNULL(' ' +  e.MiddleName,'') +  ' ' + e.LastName
FROM HumanResources.Employee AS e

--Combinaci�n
SELECT [Id], [FirstName], [MiddleName], [LastName], [JobId] 
FROM HumanResources.Employee
WHERE FirstName LIKE 'M%'
GO
SELECT [Id], [FirstName], [MiddleName], [LastName], [JobId] 
FROM HumanResources.Employee
WHERE FirstName LIKE 'A%'
GO
SELECT [Id], [FirstName], [MiddleName], [LastName], [JobId] 
FROM HumanResources.Employee
WHERE FirstName LIKE 'M%' OR FirstName like 'A%'
GO

SELECT * FROM HumanResources.Employee
WHERE FirstName LIKE 'A%'
UNION
SELECT [Id], [FirstName], [MiddleName], [LastName], [JobId] 
FROM HumanResources.Employee
WHERE FirstName LIKE 'M%'
GO

--INTERSECCI�N
SELECT [Id], [FirstName], [MiddleName], [LastName], [JobId] 
FROM HumanResources.Employee
WHERE FirstName like 'B%'
GO

SELECT [Id], [FirstName], [MiddleName], [LastName], [JobId] 
FROM HumanResources.Employee
WHERE FirstName like '%D%'
GO

SELECT [Id], [FirstName], [MiddleName], [LastName], [JobId] 
FROM HumanResources.Employee
WHERE FirstName like 'B%'
INTERSECT
SELECT [Id], [FirstName], [MiddleName], [LastName], [JobId] 
FROM HumanResources.Employee
WHERE FirstName like '%D%'
GO