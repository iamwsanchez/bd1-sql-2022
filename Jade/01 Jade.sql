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

INSERT INTO HumanResources.Job([Name])
VALUES('Director de tecnología')
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

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Identificador único del empleado (Autonumérico)' , @level0type=N'SCHEMA',@level0name=N'HumanResources', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Id'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primer nombre del empleado' , @level0type=N'SCHEMA',@level0name=N'HumanResources', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'FirstName'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Segundo nombre del empleado' , @level0type=N'SCHEMA',@level0name=N'HumanResources', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'MiddleName'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Apellido del empleado' , @level0type=N'SCHEMA',@level0name=N'HumanResources', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'LastName'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Identificador del puesto de trabajo que ocupa el empleado' , @level0type=N'SCHEMA',@level0name=N'HumanResources', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'JobId'
GO

INSERT INTO HumanResources.Employee(FirstName,LastName, JobId)
VALUES('Juan', 'Perez', 1)
GO

INSERT INTO HumanResources.Employee(FirstName,LastName, JobId)
VALUES('María', 'García', 2)

INSERT INTO HumanResources.Employee(FirstName,LastName, JobId)
VALUES('Alan', 'Mondragón', 5),
		('Alvaro', 'Tellez', 5),
		('Brenda', 'López', 5),
		('Belinda', 'Andino', 6),
		('Jaime', 'Soza', 6),
		('Karla', 'Martinez', 6)

INSERT INTO HumanResources.Employee(FirstName, MiddleName,LastName, JobId)
VALUES('William', 'José', 'Sánchez', 6),
		('Douglas', 'Antonio', 'Sánchez', 6)
GO

CREATE TABLE HumanResources.Log_Job
(
	Id INT NOT NULL IDENTITY(1,1),
	JobId tinyint NOT NULL,
	[OldName] VARCHAR(100),
	[OldDescription] VARCHAR(500),
	OldActive BIT,
	[NewName] VARCHAR(100),
	[NewDescription] VARCHAR(500),
	NewActive BIT,
	CONSTRAINT PK_Id PRIMARY KEY(Id)
)
GO

CREATE TABLE HumanResources.Dummy
(
	Id tinyint NOT NULL IDENTITY(1,1),
	[Name] VARCHAR(100) NOT NULL,
	[Description] VARCHAR(500),
	CONSTRAINT PK_Dummy_Id PRIMARY KEY(Id)
)
GO

INSERT INTO HumanResources.Dummy([Name])
VALUES('Valor Dummy 1'), ('Valor Dummy 2'), ('Valor Dummy 3')
GO

