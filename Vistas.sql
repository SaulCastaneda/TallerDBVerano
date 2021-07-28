use AgroquimicosVersion2

-- 1.- Visualiza los clientes frecuentes y su ocupacion
		CREATE VIEW ClientesFrecuentes
		AS SELECT ID_Cliente, Nombre, Ocupacion FROM Cliente

-- 2.- Muestra los precios de los productos tanto publico como para proveedores
		CREATE VIEW CostosDeProductos (Producto, CostoAlPublico,[CostoAProveedores])
		AS SELECT Producto.Familia,Producto.Costo_Publico,Producto_Proveedor.Costo_Proveedor
		FROM Producto JOIN Producto_Proveedor ON Producto.UPC = Producto_Proveedor.UPC

-- 3.- Sucursales en el municipio de Culiacan
		CREATE VIEW SucursalEnCuliacan (Sucursal,DireccionDeSucursal,Municipio)
		AS SELECT Sucursal.Nombre,Sucursal.Direccion,Municipio.Nombre
		FROM Sucursal JOIN Municipio ON Sucursal.ID_Municipio = Municipio.ID_Municipio WHERE Municipio.Nombre = 'Culiacan'

-- 4.- Visualiza el status de la entrega del producto y el nombre de la persona que lo ordeno
		CREATE VIEW Envio (Producto,Status,FechaDeEnvio,EntregaEn,PedidoDe)
		AS SELECT Producto.Familia,Orden.Status,Orden.Fecha,Orden.Metodo_De_Entrega,Cliente.Nombre
		FROM Producto JOIN Orden ON Producto.UPC = Orden.UPC JOIN Cliente ON Orden.ID_Cliente = Cliente.ID_Cliente

-- 5.- Visualiza en CEDIS la peligrosidad de los productos almacenados
		CREATE VIEW PeligrosidadDeProductos(CEDIS,Direccion,Peligrosidad,Producto)
		AS SELECT CEDIS.Nombre_CEDIS,CEDIS.Direccion,Producto_CEDIS.Peligrosidad,Producto.Familia
		FROM CEDIS JOIN Producto_CEDIS ON CEDIS.ID_CEDIS = Producto_CEDIS.ID_CEDIS JOIN Producto ON Producto_CEDIS.UPC = Producto.UPC
