SELECT * FROM HumanResources.Employee

UPDATE HumanResources.Employee
SET JobTitle = 'Representante de ventas' --'Sales Representative'
WHERE BusinessEntityID = 285
GO

DELETE FROM HumanResources.Employee
WHERE BusinessEntityID = 285


SELECT pp.BusinessEntityID, COUNT(pp.PhoneNumber)
  FROM [Person].[PersonPhone] pp
  group by BusinessEntityID
  HAVING COUNT(pp.PhoneNumber) > 1

  SELECT pp.*
  FROM [Person].[PersonPhone] pp
  WHERE BusinessEntityID = 40
  