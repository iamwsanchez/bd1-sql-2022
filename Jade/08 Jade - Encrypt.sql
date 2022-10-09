--Demostración de uso de HASHBYTES para cifrado de datos
--SELECT LEN(HASHBYTES('SHA2_512','MIDATO'))
--GO
--SELECT LEN(HASHBYTES('SHA2_512','ESTE ES UN TEXTO MAS LARGO'))
--GO

--Creo un schema nuevo para la seguridad de la bd.
CREATE SCHEMA dbSecurity
GO
--Creo una tabla con una columna tipo VARBINARY que permite almacenar datos con formato binario.
CREATE TABLE dbSecurity.dbUser(
	Id INT IDENTITY(1, 1)  NOT NULl CONSTRAINT PK_dbUser_Id PRIMARY KEY(Id),
	UserName VARCHAR(100) NOT NULL,
	UserPassoword VARBINARY(32) NOT NULL,
	IsEnabled BIT NOT NULL CONSTRAINT DF_dbUser_IsEnabled DEFAULT 1
)
--Se corrige el tamaño de la columna UserPassoword
ALTER TABLE dbSecurity.dbUser ALTER COLUMN UserPassoword VARBINARY(64) NOT NULL
GO

--Inserto usuarios fake en la tabla, con la función HASHBYTES encripto la contraseña.
INSERT INTO dbSecurity.dbUser(UserName, UserPassoword)
VALUES('wsanchez', HASHBYTES('SHA2_512', 'mypass1983#')),
	('jperez', HASHBYTES('SHA2_512', 'mypass1984#'))
GO

SELECT * FROM dbSecurity.dbUser
GO

IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbSecurity'
     AND SPECIFIC_NAME = N'usp_VerifyIdentity' 
)
   DROP PROCEDURE dbSecurity.usp_VerifyIdentity
GO
-- =============================================
-- Author:		William Sánchez
-- Create date: 2022/10/09
-- Description:	Verifica si el usuario y contraseña indicados son válidos.
-- Usa la función HASHBYTES para encriptar el parámetro contraseña y compararlo 
-- con el valor almacenado en base de datos.
-- =============================================
CREATE PROCEDURE dbSecurity.usp_VerifyIdentity
@UserName VARCHAR(100),
@UserPassword VARCHAR(100),
@Outcome BIT OUTPUT,
@Message VARCHAR(500) OUTPUT
AS
		
IF NOT EXISTS(
	SELECT 1 FROM dbSecurity.dbUser u
	WHERE u.UserName = @UserName 
)
BEGIN
	SET @Outcome = 0;
	SET @Message = 'El usuario es incorrecto.'
END
ELSE
BEGIN
	IF NOT EXISTS(SELECT 1 FROM dbSecurity.dbUser u
	WHERE u.UserName = @UserName AND  u.UserPassoword = HASHBYTES('SHA2_512', @UserPassword))
	BEGIN
		SET @Outcome = 0;
		SET @Message = 'La contraseña es incorrecta.'
	END
	ELSE
	BEGIN
		SET @Outcome = 1;
		SET @Message = 'Bievenido(a) ' + @UserName
	END
END
GO


DECLARE @out BIT, @msg VARCHAR(500),
		@pass VARCHAR(100)
SET @pass = 'mypass1983#'
EXEC dbSecurity.usp_VerifyIdentity 'wsanchez', @pass, @out OUTPUT, @msg OUTPUT
--
SELECT @out, @msg
--
SET @pass = 'mypass1983#'
EXEC dbSecurity.usp_VerifyIdentity 'wlopez', @pass, @out OUTPUT, @msg OUTPUT
--
SELECT @out, @msg
--
SET @pass = 'mypass1983#'
EXEC dbSecurity.usp_VerifyIdentity 'jperez', @pass, @out OUTPUT, @msg OUTPUT
--
SELECT @out, @msg