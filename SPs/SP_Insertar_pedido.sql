CREATE PROCEDURE InsertarPedido
    @UsuarioID INT,
    @ProductoID INT,
    @FechaPedido DATETIME = NULL,
    @Estado NVARCHAR(20) = 'Pendiente'
AS
BEGIN
    SET NOCOUNT ON;

    -- ✅ Validación: Verificar que el usuario existe
    IF NOT EXISTS (SELECT 1 FROM Usuario WHERE UsuarioID = @UsuarioID)
    BEGIN
        RAISERROR('El UsuarioID proporcionado no existe.', 16, 1);
        RETURN;
    END;

    -- ✅ Validación: Verificar que el producto existe y hay stock disponible
    DECLARE @StockDisponible INT;
    SELECT @StockDisponible = Stock FROM Producto WHERE ProductoID = @ProductoID;

    IF @StockDisponible IS NULL
    BEGIN
        RAISERROR('El ProductoID proporcionado no existe.', 16, 1);
        RETURN;
    END;

    IF @StockDisponible <= 0
    BEGIN
        RAISERROR('No hay stock disponible para este producto.', 16, 1);
        RETURN;
    END;

    -- ✅ Insertar el pedido
    INSERT INTO Pedido (UsuarioID, ProductoID, FechaPedido, Estado)
    VALUES (@UsuarioID, @ProductoID, ISNULL(@FechaPedido, GETDATE()), @Estado);

    -- ✅ Reducir el stock del producto
    UPDATE Producto
    SET Stock = Stock - 1
    WHERE ProductoID = @ProductoID;

    -- ✅ Confirmación
    SELECT 'Pedido insertado correctamente' AS Mensaje, SCOPE_IDENTITY() AS PedidoID;
END;
GO
