-- Ejercicio 1
CREATE PROCEDURE InsertarCliente
    @Nombres NVARCHAR(100),
    @Apellidos NVARCHAR(100),
    @DUI CHAR(10),
    @Telefono NVARCHAR(15),
    @Correo NVARCHAR(100),
    @Direccion INT
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;
        INSERT INTO Clientes (NombresCliente, ApellidosCliente, DuiCliente, TelefonoCliente, CorreoCliente, IdDireccion)
        VALUES (@Nombres, @Apellidos, @DUI, @Telefono, @Correo, @Direccion);
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END;
GO

-- Ejercicio 2
CREATE TRIGGER EvitarInventarioNegativo
ON Zapatos
AFTER UPDATE
AS
BEGIN
    BEGIN TRY
        IF EXISTS (SELECT 1 FROM Zapatos WHERE Stock < 0)
        BEGIN
            ROLLBACK TRANSACTION;
            THROW 50000, 'Error: El inventario no puede ser negativo.', 1;
        END
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END;
GO

-- Ejercicio 3
CREATE TRIGGER EvitarEliminarCategoria
ON Categoria
INSTEAD OF DELETE
AS
BEGIN
    BEGIN TRY
        IF EXISTS (SELECT 1 FROM Zapatos WHERE IdCategoria IN (SELECT IdCategoria FROM DELETED))
        BEGIN
            ROLLBACK TRANSACTION;
            THROW 50000, 'Error: No se puede eliminar una categoría asignada a un zapato.', 1;
        END
        ELSE
        BEGIN
            DELETE FROM Categoria WHERE IdCategoria IN (SELECT IdCategoria FROM DELETED);
        END
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END;
GO

-- Ejercicio 4
CREATE PROCEDURE ActualizarVenta
    @VentaID INT,
    @MontoNuevo FLOAT
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;
        UPDATE Ventas SET Monto = @MontoNuevo WHERE IdVenta = @VentaID;
        IF @MontoNuevo < 0
        BEGIN
            ROLLBACK TRANSACTION;
            THROW 50000, 'Error: El monto no puede ser negativo.', 1;
        END
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END;
GO

-- Transacción 1
BEGIN TRY
    BEGIN TRANSACTION;
    INSERT INTO Ventas (Fecha_De_Venta, Total_De_Venta, Monto, IdCliente, IdEmpleado) VALUES (GETDATE(), 5, 100.00, 1, 1);
    INSERT INTO Detalles_De_Ventas (IdVenta, IdZapato, IdSucursal, Cantidad, PrecioUnitario, SubTotal, IdFormaDePago) 
    VALUES (SCOPE_IDENTITY(), 1, 1, 2, 50.00, 100.00, 1);
    COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    ROLLBACK TRANSACTION;
    THROW;
END CATCH;
GO

-- Transacción 2
BEGIN TRY
    BEGIN TRANSACTION;
    INSERT INTO Pedidos (Fecha_De_Pedido, Cantidad_De_Pares, Lotes, Precio, IdProveedor, IdEmpleado) VALUES (GETDATE(), 10, 2, 500.00, 1, 1);
    INSERT INTO Detalles_De_Pedidos (PrecioUnitario, SubTotal, Fecha_De_Compra, TotalPagarCompra, IdSucursal, IdPedido, IdZapato, IdFormaDePago) 
    VALUES (50.00, 500.00, GETDATE(), 500.00, 1, SCOPE_IDENTITY(), 1, 1);
    COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    ROLLBACK TRANSACTION;
    THROW;
END CATCH;
GO

-- Transacción 3
BEGIN TRY
    BEGIN TRANSACTION;
    INSERT INTO Direcciones (Linea1, Linea2, CodigoPostal, IdDistrito) VALUES ('Calle Principal', 'Apartamento 101', '01101', 1);
    INSERT INTO Clientes (NombresCliente, ApellidosCliente, DuiCliente, TelefonoCliente, CorreoCliente, IdDireccion) 
    VALUES ('Juan', 'Perez', '1234567890', '1234-5678', 'juan@gmail.com', SCOPE_IDENTITY());
    COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    ROLLBACK TRANSACTION;
    THROW;
END CATCH;
GO

-- Transacción 4
BEGIN TRY
    BEGIN TRANSACTION;
    UPDATE Zapatos SET Stock = Stock - 2 WHERE IdZapato = 1;
    IF (SELECT Stock FROM Zapatos WHERE IdZapato = 1) < 0
    BEGIN
        ROLLBACK TRANSACTION;
        THROW 50000, 'Error: No hay suficiente stock para esta operación.', 1;
    END
    COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    ROLLBACK TRANSACTION;
    THROW;
END CATCH;
GO

-- Transacción 5
BEGIN TRY
    BEGIN TRANSACTION;
    INSERT INTO Factura_De_Ventas (TotalPagarVenta, Fecha_Factura_Venta, IdDetalleDeVenta, IdFormaDePago) 
    VALUES (100.00, GETDATE(), 1, 1);
    COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    ROLLBACK TRANSACTION;
    THROW;
END CATCH;
GO
