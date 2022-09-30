CREATE LOGIN HumanResourcesUser WITH PASSWORD = 'pa$$w0rD'
GO
CREATE LOGIN WilliamSanchez WITH PASSWORD = 'pa$$w0rD'
GO

USE AdventureWorks2019
GO

CREATE USER HumanResourcesUser FOR LOGIN HumanResourcesUser WITH DEFAULT_SCHEMA = dbo;
GO

CREATE USER WilliamSanchez FOR LOGIN WilliamSanchez WITH DEFAULT_SCHEMA = dbo;
GO

ALTER ROLE db_HumanResources_Role ADD MEMBER HumanResourcesUser
GO

ALTER ROLE db_HumanResources_Writer ADD MEMBER HumanResourcesUser
GO

ALTER ROLE db_HumanResources_Role ADD MEMBER WilliamSanchez
GO