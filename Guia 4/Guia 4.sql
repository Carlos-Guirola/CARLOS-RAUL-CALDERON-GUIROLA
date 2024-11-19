
-- Ejercicio 1
CREATE VIEW Ejercicio1 AS
SELECT c.IdCliente, c.NombresCliente, c.ApellidosCliente, d.Linea1, d.Linea2
FROM Clientes c
INNER JOIN Direcciones d ON c.IdDireccion = d.IdDireccion;

-- Ejercicio 2
CREATE VIEW Ejercicio2 AS
SELECT e.IdEmpleado, e.NombresEmpleado, e.ApellidosEmpleado, ca.Cargo
FROM Empleados e
INNER JOIN Cargos ca ON e.IdCargo = ca.IdCargo;

-- Ejercicio 3
CREATE VIEW Ejercicio3 AS
SELECT s.IdSucursaL, s.TelefonoSucursal, d.Linea1, d.CodigoPostal
FROM Sucursales s
LEFT JOIN Direcciones d ON s.IdDireccion = d.IdDireccion;

-- Ejercicio 4
CREATE VIEW Ejercicio4 AS
SELECT p.IdProveedor, p.NombresProveedor, p.TelefonoProveedor, d.Linea1
FROM Proveedores p
RIGHT JOIN Direcciones d ON p.IdDireccion = d.IdDireccion;

-- Ejercicio 5
CREATE VIEW Ejercicio5 AS
SELECT v.IdVenta, v.Fecha_De_Venta, c.NombresCliente, e.NombresEmpleado
FROM Ventas v
INNER JOIN Clientes c ON v.IdCliente = c.IdCliente
INNER JOIN Empleados e ON v.IdEmpleado = e.IdEmpleado;

-- Ejercicio 6
CREATE VIEW Ejercicio6 AS
SELECT pe.IdPedido, pe.Fecha_De_Pedido, pe.Cantidad_De_Pares, pr.NombresProveedor
FROM Pedidos pe
INNER JOIN Proveedores pr ON pe.IdProveedor = pr.IdProveedor;

-- Ejercicio 7
CREATE VIEW Ejercicio7 AS
SELECT z.IdZapato, z.Nombre, z.Descripcion, z.Precio, c.Categoria
FROM Zapatos z
INNER JOIN Categoria c ON z.IdCategoria = c.IdCategoria;

-- Ejercicio 8
CREATE VIEW Ejercicio8 AS
SELECT z.IdZapato, z.Nombre, z.Color, t.Material
FROM Zapatos z
INNER JOIN Tipo_De_Material t ON z.IdTipoDeMaterial = t.IdTipoDeMaterial;

-- Ejercicio 9
CREATE VIEW Ejercicio9 AS
SELECT dv.IdDetalleDeVenta, dv.Cantidad, dv.PrecioUnitario, z.Nombre AS Zapato
FROM Detalles_De_Ventas dv
INNER JOIN Zapatos z ON dv.IdZapato = z.IdZapato;

-- Ejercicio 10
CREATE VIEW Ejercicio10 AS
SELECT dp.IdDetalleDePedido, dp.Cantidad, dp.SubTotal, p.NombresProveedor
FROM Detalles_De_Pedidos dp
INNER JOIN Proveedores p ON dp.IdPedido = p.IdProveedor;

-- Ejercicio 11
CREATE VIEW Ejercicio11 AS
SELECT f.IdFacturaVenta, f.TotalPagarVenta, f.Fecha_Factura_Venta, c.NombresCliente
FROM Factura_De_Ventas f
INNER JOIN Ventas v ON f.IdDetalleDeVenta = v.IdVenta
INNER JOIN Clientes c ON v.IdCliente = c.IdCliente;

-- Ejercicio 12
CREATE VIEW Ejercicio12 AS
SELECT f.IdFacturaCompra, f.TotalPagarCompra, f.Fecha_Factura_Compra, p.NombresProveedor
FROM Factura_De_Compras f
INNER JOIN Detalles_De_Pedidos dp ON f.IdDetalleDePedido = dp.IdDetalleDePedido
INNER JOIN Proveedores p ON dp.IdPedido = p.IdProveedor;

-- Ejercicio 13
CREATE VIEW Ejercicio13 AS
SELECT u.Idusuario, u.Usuario, r.Rol
FROM usuarios u
INNER JOIN roles r ON u.IdRol = r.IdRol;

-- Ejercicio 14
CREATE VIEW Ejercicio14 AS
SELECT z.IdZapato, z.Nombre, i.Inventario, i.Estante
FROM Zapatos z
INNER JOIN Inventario i ON z.IdInventario = i.IdInventario;

-- Ejercicio 15
CREATE VIEW Ejercicio15 AS
SELECT s.IdSucursaL, s.TelefonoSucursal, d.Distrito, m.Municipio, dep.Departamento
FROM Sucursales s
INNER JOIN Direcciones dir ON s.IdDireccion = dir.IdDireccion
INNER JOIN Distritos d ON dir.IdDistrito = d.IdDistrito
INNER JOIN Municipios m ON d.IdMunicipio = m.IdMunicipio
INNER JOIN Departamentos dep ON m.IdDepartamento = dep.IdDepartamento;
