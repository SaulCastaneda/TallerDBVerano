USE AgroquimicosVersion2

--1 Mostrar Los nombres de los cedis y a que id de municipio pertenece

SELECT  c.Nombre_CEDIS, c.ID_Municipio
FROM CEDIS c
WHERE EXISTS
	(SELECT * FROM Producto_CEDIS p
	 WHERE p.ID_CEDIS = c.ID_CEDIS)
GO

--2  Que metodo de entrega solicito cada cliente 

SELECT c.Nombre, o.Metodo_De_Entrega
FROM Orden o 
INNER JOIN Cliente c on c.ID_Cliente = o.ID_Cliente
ORDER BY c.Nombre
GO

--3 Contar las sucursales de cada estado

SELECT COUNT(*) AS CANTIDAD, E.Nombre as Estado FROM Sucursal S
INNER JOIN Municipio M ON M.ID_Municipio = S.ID_Municipio
INNER JOIN Estado E ON E.ID_Estado = M.ID_Estado
GROUP BY E.NOMBRE
GO

--4 Mostrar los nombres ordenados de los productos con Costo_Proveedor menor o igual a 100    

SELECT p.familia, r.Costo_Proveedor
FROM Producto p
INNER JOIN Producto_Proveedor r on r.UPC = p.UPC
WHERE Costo_Proveedor <= 100
ORDER BY p.familia
GO

--5 Mostrar el porcentaje de peligrosidad dependiendo el color amarillo(50%),blanco(30%), rojo(85%) azul(15%) y mostar la familia del producto

SELECT  p.Familia,
       CASE c.Peligrosidad
           WHEN 'AMARILLO'
           THEN '50%'
           WHEN 'BLANCO'
           THEN '30%'
		   WHEN 'ROJO'
		   THEN '85%'
           WHEN 'AZUL'
		   THEN '15%'
       END 
      AS Porcentaje_de_peligrosidad
FROM Producto_CEDIS c
JOIN Producto  p ON p.UPC = c.UPC
GO

--6 A que proveedores se les compra un producto de 2 kg con peligrosidad Amarilla y a que precio
    
SELECT p.Nombre, r.Costo_Proveedor, o.Presentacion, c.Peligrosidad
FROM Proveedor p
INNER JOIN Producto_Proveedor r on r.ID_Proveedor = p.ID_Proveedor
INNER JOIN Producto o on o.UPC = r.UPC
INNER JOIN Producto_CEDIS c on c.UPC = r.UPC
WHERE o.Presentacion = '2kg' and c.Peligrosidad = 'AMARILLO'
GO

--7 Mostrar el ID de la Orden que esten pendientes y que su entrega sea a domicilio y agregar que esos pedidos estan en camino

SELECT ID_Orden, Status, Metodo_de_Entrega,
Upper('En camino') as Actual
FROM Orden
WHERE Status = 'Pendiente' and Metodo_De_Entrega = 'Domicilio'
GO


--8  Cual es la ocupacion de cada cliente que hizo una compra a partir del 2018
 
	 SELECT CONCAT(CONCAT(c.Nombre, + SPACE(1) + 'Se Dedica a'), + SPACE(1) + c.Ocupacion) "Oficio de cliente", o.Fecha
	 FROM Cliente c
	 INNER JOIN Orden o on o.ID_Cliente = c.ID_Cliente
	 WHERE  O.Fecha >= '2018'
	 GO

--9 Muestre la cantidad presentaciones que cuenta cada producto

SELECT  Familia, count(distinct Presentacion) as Total 
from Producto 
Group by Familia
GO

--10 Mostrar las Orden que se hicieron entre la fecha 2015-05-01 y 2020-07-15

SELECT * FROM Orden
WHERE Fecha BETWEEN '2015-05-01 00:00:00.000' AND '2020-07-15 00:00:00.000'
GO

--11 Mostrar la suma total de los costos de los productos de proveedor

SELECT SUM (Costo_Proveedor) as Total
FROM Producto_Proveedor
GO

--12 Mostrar de orden los pedidos pendientes y que el producto tenga un costo mayor de $100

SELECT o.Status, p.familia, p.Costo_publico
FROM Orden o 
INNER JOIN Producto p on p.UPC = o.UPC
WHERE o.Status = 'Pendiente' and p.Costo_publico >100
GO

--13. Mostrar los clientes que hicieron una orden a partir del (2015-05-01)
SELECT Nombre
FROM Cliente
WHERE ID_Cliente IN
	(SELECT ID_Cliente	 FROM Orden
	 WHERE Fecha >'2015-05-01')
GO

--14 Mostrar el nombre del proveedor, el upc del producto y el costo de proveedor del producto de manera desentdente 

SELECT r.Nombre, p.Costo_Proveedor, p.UPC
FROM Producto_Proveedor p
INNER JOIN Proveedor r on r.ID_Proveedor = p.ID_Proveedor
ORDER BY  Costo_Proveedor
GO

--15 ORDENES CON STATUS PENDIENTE Y SU RESPECTIVO CLIENTE

SELECT C.NOMBRE, O.* FROM ORDEN O
INNER JOIN CLIENTE C ON C.ID_Cliente=O.ID_Cliente
WHERE O.Status = 'Pendiente'
GO

--15 ORDENES CON STATUS PENDIENTE Y SU RESPECTIVO CLIENTE

SELECT C.NOMBRE, O.* FROM ORDEN O
INNER JOIN CLIENTE C ON C.ID_Cliente=O.ID_Cliente
WHERE O.Status = 'Pendiente'
GO
-- 16 Seleccionar Todos los clientes Que Su giro sea Domestico o Agricultor

select *from Cliente where Ocupacion like'%Agricultor%' or Ocupacion like '%Domestico%'
GO
-- 17 todos los provedores que su producto sea pestisidas

select *
FROM Producto_Proveedor inner join Producto on Producto.UPC= Producto_Proveedor.UPC
where Familia = 'Semillas'
GO
-- 18 Selecciona todos las Sucursales que el origen sea de Culiacan o Oaxaca

select *
From Sucursal inner JOIN Municipio on Sucursal.ID_Municipio  = Municipio.ID_Municipio
where Municipio.Nombre = 'Culiacan' or  Municipio.Nombre= 'Oaxaca' 
GO

-- 19 Imprimir el total precio al publico
		select SUM(Costo_Publico )as'TOTAL DE COSTOS AL PUBLICO 'From Producto 
GO
		
 --20 Selecionar El Nombre de los clientes que hicieron pedidos el 18 de dicembre 2018 

 Select Cliente.ID_Cliente as 'Cliente', Nombre,Fecha as'FECHA'  From Cliente 
 inner join Orden on  Orden.ID_Cliente = Cliente.ID_Cliente
 where Fecha= '2018-12-18 01:34:09.000'

 go
 --21 Seleccionar EL Numero de ventas Por Dia
 
	Select Fecha, COUNT (Fecha) as 'NumeroVtas' From Orden
 Group By Fecha
 
Go

-- 22 Mostrar el ID , Nombre de Cedis Y El municipio que pertenece

select *from Sucursal
Select ID_Sucursal,Sucursal.Nombre,Municipio.ID_Municipio, Municipio.Nombre

from Sucursal left JOIN Municipio ON Sucursal.ID_Municipio  = Municipio.ID_Municipio

GO

-- 23  Seleccionar el numero de entregas por FECHA

select*from ti
	Select Fecha, COUNT (Fecha) as 'Numero DE Entregas' From TI
 Group By Fecha
GO

 --24 Mostrar el nombre de los clinetes con orden pendinete 

 select *from Orden
 select Cliente.ID_Cliente, Nombre,Status,Fecha,Metodo_De_Entrega From Orden
 left JOIN Cliente on Orden.ID_Cliente = Cliente.ID_Cliente
 where Status= 'Pendiente'
 Go

 --25 Mostrar las Familia de prodcutos por proveedor

 Select *from Producto_Proveedor
  
  select  Producto.UPC, Familia,ID_Proveedor,Costo_Proveedor
  from Producto inner JOIN Producto_Proveedor ON Producto.UPC =Producto_Proveedor.UPC

select *from Producto_Proveedor where UPC=1520507

-- 26 Imprimir el nombre del proveedor junto  con el producto

select *from Proveedor

select *from producto_PROVEEDOR
SELECT Producto_Proveedor.ID_Proveedor ,Proveedor.Nombre,UPC
from  Producto_Proveedor
Left JOin Proveedor on Proveedor.ID_Proveedor=Producto_Proveedor.ID_Proveedor
GO

-- 27  Seleccionar Todos Los cedis que surten  a A Tepic O Guadalajara

select *
From CEDIS inner JOIN Municipio on CEDIS.ID_Municipio  = Municipio.ID_Municipio
where Municipio.Nombre = 'Tepic' or  Municipio.Nombre= 'Guadalajara' 
GO

-- 28  Imprimir El total de todos los costo al public

select SUM(Costo_Publico) as'TOTAL DE COSTOS AL PUBLICO' from Producto
GO

--29 La Suma de  el costo al publico de todos los productos

SELECT SUM (Costo_Publico) as Total
FROM Producto
GO

--30 Seleccionar todas las ordenes  que sean de Fungicida O Fertizantes Ordendo del el precio mayor A Menor

Select *from Producto
select *
From Orden inner JOIN Producto on Producto.UPC  = Orden.UPC
where Producto.Familia = 'Fungicida' or  Producto.Familia= 'Fertilizante'
Order By Costo_Publico ASC
GO






