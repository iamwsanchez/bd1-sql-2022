CREATE ROLE db_HumanResources_Role AUTHORIZATION [dbo]
GO
GRANT SELECT ON SCHEMA::HumanResources TO db_HumanResources_Role
GO
GRANT SELECT ON SCHEMA::Person TO db_HumanResources_Role
GO

CREATE ROLE db_HumanResources_Writer AUTHORIZATION [dbo]
GO
GRANT INSERT ON SCHEMA::HumanResources TO db_HumanResources_Writer
GO
GRANT INSERT ON SCHEMA::Person TO db_HumanResources_Writer
GO
GRANT UPDATE ON SCHEMA::HumanResources TO db_HumanResources_Writer
GO
GRANT UPDATE ON SCHEMA::Person TO db_HumanResources_Writer
GO
GRANT DELETE ON SCHEMA::HumanResources TO db_HumanResources_Writer
GO
GRANT DELETE ON SCHEMA::Person TO db_HumanResources_Writer
GO