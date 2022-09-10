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