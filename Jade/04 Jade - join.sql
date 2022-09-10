USE Jade
GO
SELECT * FROM HumanResources.Job
SELECT * FROM HumanResources.Employee
----
SELECT *
FROM HumanResources.Job, HumanResources.Employee
---
SELECT *
FROM HumanResources.Job j, HumanResources.Employee e
WHERE j.Id = e.JobId
--
SELECT e.FirstName, e.LastName, j.[Name]
FROM HumanResources.Job j, HumanResources.Employee e
WHERE j.Id = e.JobId
---CORRECTO
SELECT  j.[Name], e.FirstName, e.LastName
FROM HumanResources.Job j
INNER JOIN HumanResources.Employee e ON j.Id = e.JobId

---CORRECTO
SELECT  j.[Name], e.FirstName, e.LastName
FROM HumanResources.Job j
LEFT JOIN HumanResources.Employee e ON j.Id = e.JobId


SELECT Id FROM HumanResources.Job 
WHERE Id NOT IN(
SELECT DISTINCT JobId FROM HumanResources.Employee)