USE [Zapateria]
GO
/****** Object:  UserDefinedFunction [dbo].[ListarVentasPorCliente]    Script Date: 14/10/2024 10:20:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[ListarVentasPorCliente]
(
    @IdCliente INT
)
RETURNS @Ventas TABLE
(
    IdVenta INT,
    Fecha_De_Venta DATE,
    Total_De_Venta DECIMAL(18, 2)
)
AS
BEGIN
    INSERT INTO @Ventas
    SELECT 
        IdVenta,
        Fecha_De_Venta,
        Total_De_Venta
    FROM 
        [Zapateria].[dbo].[Ventas]
    WHERE 
        IdCliente = @IdCliente;

    RETURN;
END;
