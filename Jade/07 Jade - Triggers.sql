--IF OBJECT_ID ('HumanResources.utr_ValidateJob','TR') IS NOT NULL
--   DROP TRIGGER HumanResources.utr_ValidateJob 
--GO

--CREATE TRIGGER HumanResources.utr_ValidateJob 
--   ON  HumanResources.Job 
--   INSTEAD OF DELETE
--AS 
--	IF EXISTS(SELECT 1 FROM HumanResources.Employee e
--				INNER JOIN DELETED d ON e.JobId = d.Id)
--	BEGIN
--		RAISERROR ('No puede ser eliminado. El puesto tiene empleados relacionados.', -- Message text.
--	               16, -- Severity.
--	               1 -- State.
--	               );
--	END
--GO

--delete from HumanResources.Job WHERE id = 18

IF OBJECT_ID ('HumanResources.utr_AuditJob','TR') IS NOT NULL
   DROP TRIGGER HumanResources.utr_AuditJob 
GO

CREATE TRIGGER HumanResources.utr_AuditJob 
   ON  HumanResources.Job 
   FOR INSERT, UPDATE, DELETE
AS 
	DECLARE @ins bit = 0
			,@del bit = 0
	IF EXISTS(SELECT 1 FROM INSERTED)
		SET @ins = 1;
	IF EXISTS(SELECT 1 FROM DELETED)
		SET @del = 1;
	--
	IF @ins = 1 AND @del = 1
	BEGIN 
		INSERT INTO HumanResources.Log_Job( [JobId], [OldName], [OldDescription], [OldActive], 
		[NewName], [NewDescription], [NewActive])
		SELECT d.Id, d.[Name], d.[Description], d.Activo, 
		i.[Name], i.[Description], i.Activo FROM deleted d 
		INNER JOIN inserted i ON d.Id = i.Id
	END
	ELSE
		IF(@ins = 1 AND @del = 0)
		BEGIN
			INSERT INTO HumanResources.Log_Job( [JobId],[NewName], [NewDescription], [NewActive])
			SELECT i.Id, i.[Name], i.[Description], i.Activo FROM inserted i
		END
		ELSE
		BEGIN
			INSERT INTO HumanResources.Log_Job( [JobId],[OldName], [OldDescription], [OldActive])
			SELECT d.Id, d.[Name], d.[Description], d.Activo FROM deleted d
		END
		
GO



UPDATE HumanResources.Job
SET Name = 'Jefe de seguridad interna',
Description = 'Jefe de seguridad interna de la empresa',
Activo = 0
WHERE Id = 19

SELECT * FROM HumanResources.Job

SELECT * FROM HumanResources.Log_Job


IF OBJECT_ID ('HumanResources.utr_LockDummyTable','TR') IS NOT NULL
   DROP TRIGGER HumanResources.utr_LockDummyTable 
GO

CREATE TRIGGER HumanResources.utr_LockDummyTable 
   ON  HumanResources.Dummy 
   FOR INSERT, UPDATE, DELETE
AS 
	ROLLBACK TRANSACTION
GO


INSERT INTO HumanResources.Dummy([Name])
VALUES('Valor Dummy 4'), ('Valor Dummy 5'), ('Valor Dummy 6')
GO


SELECT * FROM HumanResources.Dummy
GO

DELETE FROM HumanResources.Dummy
GO

UPDATE HumanResources.Dummy
SET [Name] = 'nuevo valor'
WHERE id = 1