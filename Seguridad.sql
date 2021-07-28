use AgroquimicosVersion2

GO 

-- Esquemas --
CREATE SCHEMA InfoProveedor
GO

ALTER SCHEMA InfoProveedor TRANSFER dbo.Proveedor
GO

ALTER SCHEMA InfoProveedor TRANSFER dbo.Producto_Proveedor
GO

CREATE SCHEMA InfoCEDIS
GO

ALTER SCHEMA InfoCEDIS TRANSFER dbo.CEDIS
GO

ALTER SCHEMA InfoCEDIS TRANSFER dbo.Producto_CEDIS
GO

CREATE SCHEMA InfoSucursal
GO

ALTER SCHEMA InfoSucursal TRANSFER dbo.Sucursal
GO

ALTER SCHEMA InfoSucursal TRANSFER dbo.Producto_Sucursal
GO

CREATE SCHEMA Locacion
GO

ALTER SCHEMA Locacion TRANSFER dbo.Estado
GO

ALTER SCHEMA Locacion TRANSFER dbo.Municipio
GO

-- Roles --
	
	-- Logins --
use master
GO

CREATE LOGIN Administrador WITH PASSWORD = '1793' MUST_CHANGE, DEFAULT_DATABASE = [AgroquimicosVersion2], DEFAULT_LANGUAGE=[Español], CHECK_EXPIRATION=ON, CHECK_POLICY=ON
GO

CREATE LOGIN Proveedor WITH PASSWORD = '1793' MUST_CHANGE, DEFAULT_DATABASE = [AgroquimicosVersion2], DEFAULT_LANGUAGE=[Español], CHECK_EXPIRATION=ON, CHECK_POLICY=ON
GO

CREATE LOGIN Transportista WITH PASSWORD = '1793' MUST_CHANGE, DEFAULT_DATABASE = [AgroquimicosVersion2], DEFAULT_LANGUAGE=[Español], CHECK_EXPIRATION=ON, CHECK_POLICY=ON
GO
	-- Crear Users para Logins
use AgroquimicosVersion2
GO

CREATE USER Administrador FOR LOGIN Administrador
GO

CREATE USER Proveedor FOR LOGIN Proveedor
GO

CREATE USER Transportista FOR LOGIN Transportista
GO

	-- Crear roles
CREATE ROLE Administradores AUTHORIZATION Administrador
GO

CREATE ROLE Proveedores AUTHORIZATION Proveedor
GO

CREATE ROLE Transportistas AUTHORIZATION Transportista
GO

ALTER ROLE Administradores ADD MEMBER Administrador
GO

ALTER ROLE Proveedores ADD MEMBER Proveedor
GO

ALTER ROLE Transportistas ADD MEMBER Transportista
GO

	-- Asignar permisos -- 
GRANT INSERT,SELECT ON SCHEMA :: InfoCEDIS TO Administrador WITH GRANT OPTION
GO

GRANT INSERT,SELECT,DELETE ON SCHEMA :: InfoProveedor to Proveedor WITH GRANT OPTION
GO

GRANT UPDATE ON SCHEMA :: Locacion to Transportista WITH GRANT OPTION
GO