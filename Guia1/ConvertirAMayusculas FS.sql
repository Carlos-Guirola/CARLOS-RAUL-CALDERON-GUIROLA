USE [Zapateria]
GO
/****** Object:  UserDefinedFunction [dbo].[ConvertirAMinusculas]    Script Date: 14/10/2024 10:22:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[ConvertirAMinusculas]
(
    @pPalabra NVARCHAR(MAX)
)
RETURNS NVARCHAR(MAX)
AS
BEGIN
    RETURN LOWER(@pPalabra);
END
