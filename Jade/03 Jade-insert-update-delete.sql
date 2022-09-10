USE Jade
GO
INSERT INTO HumanResources.Employee(FirstName,LastName, JobId)
VALUES('Anielka', 'Areas', 6)
---
INSERT INTO HumanResources.Employee(FirstName,[MiddleName],LastName, JobId)
VALUES('Camilo','Antonio', 'Castro', 5)
---
INSERT INTO HumanResources.Employee(FirstName,[MiddleName],LastName, JobId)
VALUES('Diana','María', 'Mejía', 5),
('Danielka','Paola', 'Briggit', 5),
('Johny','Eduardo', 'Lagos', 5);
---INSERTAR UN VALOR IDENTITY
SET IDENTITY_INSERT HumanResources.Employee ON
INSERT INTO HumanResources.Employee([Id],FirstName,[MiddleName],LastName, JobId)
VALUES(2, 'Alvaro','Antonio', 'Solano', 5)
SET IDENTITY_INSERT HumanResources.Employee OFF
----------------------------------
---              UPDATE        ---
----------------------------------
UPDATE HumanResources.Employee
SET MiddleName = 'Raquel'
WHERE Id = 12
--
UPDATE HumanResources.Employee
SET JobId = 2
WHERE MiddleName = 'Antonio'
--
UPDATE HumanResources.Employee
SET JobId = 3
WHERE Id = 13
--
UPDATE HumanResources.Employee
SET JobId = 1
WHERE FirstName = 'Camilo' AND MiddleName = 'Antonio' AND LastName = 'Castro'
--
UPDATE HumanResources.Employee
SET MiddleName = 'NINGUNO'
WHERE MiddleName IS NULL
--
UPDATE HumanResources.Employee
SET MiddleName = NULL
WHERE MiddleName = 'NINGUNO'
--
UPDATE HumanResources.Employee
SET JobId = 6
WHERE LastName = 'Areas' OR LastName = 'Sánchez'
--
UPDATE HumanResources.Employee
SET JobId = 3
WHERE LastName = 'Areas' AND LastName = 'Sánchez'
--
UPDATE HumanResources.Employee
SET JobId = 3
WHERE LastName IN('Areas','Sánchez','Solano')
------------------
--     DELETE   --
------------------
DELETE FROM HumanResources.Employee WHERE Id = 17
---
DELETE FROM HumanResources.Employee 
WHERE Id >= 17 AND LastName IN('Areas','Sánchez','Solano')
---
DELETE FROM HumanResources.Employee 
WHERE Id >= 17
---
SELECT * FROM HumanResources.Employee
---
