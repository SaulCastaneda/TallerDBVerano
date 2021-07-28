use AgroquimicosVersion2
GO

-- Agrega,modificar y eliminar productos
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