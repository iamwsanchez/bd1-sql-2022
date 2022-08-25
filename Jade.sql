use master
go
--Just another database example
CREATE DATABASE Jade
GO
USE Jade
GO
CREATE SCHEMA HumanResources
GO


CREATE TABLE HumanResources.Job
(
	Id tinyint NOT NULL,
	[Name] VARCHAR(100) NOT NULL,
	[Description] VARCHAR(500),
	CONSTRAINT PK_Job_Id PRIMARY KEY(Id)
)
GO

INSERT INTO HumanResources.Job
VALUES(1,'Gerente general', 'Este es el gerente de la empresa')

SELECT * 
FROM HumanResources.Job

DROP TABLE HumanResources.Job
GO


CREATE TABLE HumanResources.Job
(
	Id tinyint NOT NULL IDENTITY(1,1),
	[Name] VARCHAR(100) NOT NULL,
	[Description] VARCHAR(500),
	Activo BIT NOT NULL CONSTRAINT DF_Job_Activo DEFAULT 1,
	CONSTRAINT PK_Job_Id PRIMARY KEY(Id)
)
GO

INSERT INTO HumanResources.Job([Name])
VALUES('Gerente general')
GO
INSERT INTO HumanResources.Job([Name], [Description])
VALUES('Gerente de recursos humanos', 'Esta es la oficina que nunca sabe como hacer una selección.')
GO
INSERT INTO HumanResources.Job([Name], [Description], Activo)
VALUES('Gerente de finanzas', NULL, 0)
GO

INSERT INTO HumanResources.Job([Name])
VALUES('Lorem ipsum dolor sit amet, consectetur adipiscing elit.')
GO
SELECT * 
FROM HumanResources.Job
GO

--DELETE FROM HumanResources.Job WHERE Id = 7

ALTER TABLE HumanResources.Job ADD CONSTRAINT UK_Job_Name UNIQUE([Name])
GO

CREATE TABLE HumanResources.Employee
(
	Id smallint NOT NULL IDENTITY(1,1),
	FirstName VARCHAR(20) NOT NULL,
	MiddleName VARCHAR(20),
	LastName VARCHAR(20) NOT NULL,
	JobId TINYINT NOT NULL,
	CONSTRAINT PK_Employee_Id PRIMARY KEY(Id),
	CONSTRAINT FK_Employee_Job_JobId FOREIGN KEY(JobId) REFERENCES HumanResources.Job(Id)
)
GO

INSERT INTO HumanResources.Employee(FirstName,LastName, JobId)
VALUES('Juan', 'Perez', 1)
GO

INSERT INTO HumanResources.Employee(FirstName,LastName, JobId)
VALUES('María', 'García', 2)


SELECT * FROM HumanResources.Employee
GO