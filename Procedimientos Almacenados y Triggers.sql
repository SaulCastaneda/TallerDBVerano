use AgroquimicosVersion2
GO

--Procedimientos almacenados

-- 1. Sumar el surtido 
CREATE PROCEDURE SP_SumarSurtido
@IdCEDIS AS NVARCHAR(6),
@Cantidad AS INT 
AS
UPDATE InfoCEDIS.CEDIS SET CEDIS_Surte = CEDIS_Surte + @Cantidad
WHERE ID_CEDIS = @IdCEDIS
GO

-- 2. Restar el surtido
CREATE PROCEDURE SP_RestarSurtido
@IdCEDIS AS NVARCHAR(6),
@Cantidad AS INT 
AS
UPDATE InfoCEDIS.CEDIS SET CEDIS_Surte = CEDIS_Surte - @Cantidad
WHERE ID_CEDIS = @IdCEDIS
GO

-- 3. Agrega,modificar y eliminar productos
CREATE PROC SP_AgrModElimProd
	@p_UPC            int,
	@p_Familia        nvarchar(30)=NULL,
	@p_Presentacion   nvarchar(60) = NULL,
	@p_Costo_Publico  money = NULL,
	@p_MODO          char (1)
	AS
	IF @p_MODO ='A'
	BEGIN
		INSERT Producto VALUES (@p_UPC, @p_Familia,@p_Presentacion, @p_Costo_Publico )
		END 
	IF @p_MODO ='M'
	BEGIN
		UPDATE Producto SET Familia=@p_Familia, Presentacion=@p_Presentacion, Costo_Publico=@p_Costo_Publico
		WHERE UPC=@p_UPC
		END
	IF @p_MODO ='E'
	BEGIN 
		DELETE FROM Producto WHERE UPC=@p_UPC
END
GO

-- 4. Validar Translado de inventario
CREATE PROC SP_ValidarYAgregarTInew
@P_ID_TI   INT,
@P_UPC     INT,
@P_Origen  INT,
@P_Destino INT,
@P_Cantidad INT,
@P_Fecha DATETIME
AS
IF EXISTS(SELECT ID_TI FROM TI WHERE ID_TI=@P_ID_TI)
BEGIN
PRINT('Este Traslado de inventario ya fue realizado')
RETURN
END
BEGIN
INSERT INTO TI VALUES (@P_ID_TI, @P_UPC, @P_Origen, @P_Destino, @P_Cantidad, @P_Fecha)
END
BEGIN 
SELECT * FROM TI WHERE ID_TI=@P_ID_TI
END

GO
SELECT * FROM TI
-- 5. Ordenes por fecha
if object_id('ordenesxfecha') is not null
begin
	drop procedure ordenesxfecha
end
GO

CREATE PROC ordenesxfecha
@fecha DATE,
@cantidad INT OUTPUT
AS
	SELECT @cantidad = sum(UPC) from TI
	WHERE Fecha = @fecha
GO
-- ejecutar
declare @c int
EXEC ordenesxfecha '2018-12-18',@cantidad = @c output
print 'Cantidad: ' + cast(@c as char(10))
GO

--Trigger
-- Validar translado de inventario de tienda a tienda (que no se pueda)
CREATE TRIGGER ValidaEntradaTiendaInventario 
		ON TI
		FOR INSERT, UPDATE
		AS BEGIN
			IF EXISTS (SELECT * FROM inserted WHERE Origen = Destino)
			BEGIN
				ROLLBACK TRANSACTION
			END
		END
		INSERT INTO TI	(ID_TI, UPC, Origen, Destino, Cantidad, Fecha)
		VALUES(2012411,63089014,582555,582556,-10,GETDATE())
GO
 

