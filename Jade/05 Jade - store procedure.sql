USE Jade
go

IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'HumanResources'
     AND SPECIFIC_NAME = N'usp_InsertJob' 
)
   DROP PROCEDURE HumanResources.usp_InsertJob
GO

CREATE PROCEDURE HumanResources.usp_InsertJob
@Name VARCHAR(100),
@Description VARCHAR(500) = NULL
AS
IF EXISTS(SELECT 1 FROM [HumanResources].[Job] WHERE [Name] = @Name)
BEGIN
	PRINT 'Ya existe el puesto de trabajo indicado.'
END
ELSE
BEGIN
	INSERT INTO [HumanResources].[Job]([Name],[Description])
	VALUES(@Name, @Description)
END
GO

-- SI USAN ALTER PARA MODIFICAR EL SP
EXEC sp_recompile 'HumanResources.usp_InsertJob'
GO

EXEC HumanResources.usp_InsertJob 'Técnico de redes';
GO
EXEC HumanResources.usp_InsertJob 'Técnico de soporte técnico', 'Coloborador encargado de mantenimiento preventivo y correctivo de equipo de computos'
GO
EXEC HumanResources.usp_InsertJob 'Agente de seguridad';
GO

IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'HumanResources'
     AND SPECIFIC_NAME = N'usp_UpdateJob' 
)
   DROP PROCEDURE HumanResources.usp_UpdateJob
GO

CREATE PROCEDURE HumanResources.usp_UpdateJob
@Id INT,
@Name VARCHAR(100),
@Description VARCHAR(500) = NULL,
@Activo BIT NULL
AS
IF EXISTS(SELECT 1 FROM [HumanResources].[Job] 
			WHERE Id != @Id AND [Name] = @Name)
BEGIN
	PRINT 'Ya existe el puesto de trabajo indicado.'
END
ELSE
BEGIN
	UPDATE HumanResources.Job
	SET [Name] = @Name,
		[Description] = @Description,
		Activo = @Activo
	WHERE Id = @Id
END
GO
---
exec HumanResources.usp_UpdateJob 5, 'Tecnico de contabilidad', NULL, 1
exec HumanResources.usp_UpdateJob 6, 'Tecnico de contabilidad', NULL, 1
---
SELECT * FROM HumanResources.Job
--
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'HumanResources'
     AND SPECIFIC_NAME = N'usp_DeleteJob' 
)
   DROP PROCEDURE HumanResources.usp_DeleteJob
GO
CREATE PROCEDURE HumanResources.usp_DeleteJob
@Id INT,
@Message VARCHAR(500) OUTPUT
AS
IF EXISTS(SELECT 1 FROM HumanResources.Employee WHERE JobId = @Id)
BEGIN
	--RAISERROR ('No puede ser eliminado. El puesto tiene empleados relacionados.', -- Message text.
 --              16, -- Severity.
 --              1 -- State.
 --              );
	SET @Message = 'No puede ser eliminado. El puesto tiene empleados relacionados.';
END
ELSE
BEGIN
	DELETE FROM HumanResources.Job WHERE Id = @Id;
	SET @Message = 'Empleado eliminado exitosamente';
END
GO
---
DECLARE @msg varchar(500);
EXEC HumanResources.usp_DeleteJob 13, @msg output
select @msg

---
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'HumanResources'
     AND SPECIFIC_NAME = N'usp_GetFullEmployeeInfo' 
)
   DROP PROCEDURE HumanResources.usp_GetFullEmployeeInfo
GO
CREATE PROCEDURE HumanResources.usp_GetFullEmployeeInfo
AS
SELECT  e.FirstName, e.LastName, j.[Name]
FROM HumanResources.Job j
INNER JOIN HumanResources.Employee e ON j.Id = e.JobId
GO

EXEC HumanResources.usp_GetFullEmployeeInfo