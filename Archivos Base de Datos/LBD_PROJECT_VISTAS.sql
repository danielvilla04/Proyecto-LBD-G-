-- Archivo para crear las VISTAS que trajarán dentro de la DB

--Vistas para el apartado de facturacion
--vista de tabla facturas
CREATE OR REPLACE VIEW v_facturas AS
SELECT id_factura, id_cliente, id_empleado, id_metodo_pago, fecha_facturacion, fecha_impresion, total
FROM factura_tb;

--vista de tabla detalle factura
CREATE OR REPLACE VIEW v_detalles_factura AS
SELECT df.id_factura, df.id_producto, df.cantidad_productos, p.precio, df.PRECIO_FILA
FROM detalle_factura_tb df
INNER JOIN PRODUCTO_TB p ON df.id_producto = p.id_producto ;


--vista de tabla de historial de ventas
CREATE OR REPLACE VIEW vista_historial_ventas AS
SELECT hv.id_venta, f.id_cliente, hv.fecha_venta, hv.total_venta
FROM historial_ventas hv
INNER JOIN FACTURA_TB f ON hv.id_factura = f.id_factura;


--vista de metodo de pago
CREATE OR REPLACE VIEW vista_metodos_pago AS
SELECT id_metodo_pago as id_metodo, nombre_metodo_pago as nombre,  detalles
FROM metodo_pago_tb;

SELECT * FROM vista_metodos_pago
--VISTAS PARA PEDIDOS DE PRODUCTOS
-- Vista sobre el detalle de pedidos
CREATE OR REPLACE VIEW DETALLES_PEDIDOS_CLIENTES AS
SELECT  
    ID_PEDIDO_CLIENTE,
    ID_FACTURA,
    ID_DIRECCION,
    ID_CLIENTE,
    ESTADO_PEDIDO
FROM 
    PEDIDO_CLIENTE_TB;


-- Vistas resumen de los pedidos
CREATE OR REPLACE VIEW RESUMEN_PEDIDOS_CLIENTES AS
SELECT ID_CLIENTE, COUNT(ID_PEDIDO_CLIENTE) AS TOTAL_PEDIDOS, MAX(ESTADO_PEDIDO) AS ESTADO_ACTUAL
FROM PEDIDO_CLIENTE_TB
GROUP BY ID_CLIENTE;

-- Vistas pedidos pendientes
CREATE OR REPLACE VIEW PEDIDOS_PENDIENTES_VIEW AS
SELECT 
    ID_PEDIDO_CLIENTE,
    ID_FACTURA,
    ID_DIRECCION,
    ID_CLIENTE,
    ESTADO_PEDIDO,
    'Total de Pedidos Pendientes' AS DESCRIPCION,
    (SELECT COUNT(*) FROM PEDIDO_CLIENTE_TB WHERE ESTADO_PEDIDO = 'En espera') AS TOTAL_PEDIDOS_PENDIENTES
FROM 
    PEDIDO_CLIENTE_TB
WHERE 
    ESTADO_PEDIDO = 'En espera';

-- Pedido por cliente
CREATE OR REPLACE VIEW PEDIDOS_POR_CLIENTE AS
SELECT ID_CLIENTE, COUNT(ID_PEDIDO_CLIENTE) AS TOTAL_PEDIDOS
FROM PEDIDO_CLIENTE_TB
GROUP BY ID_CLIENTE;



--vistas para productos
CREATE OR REPLACE VIEW VISTA_INVENTARIO_CON_DESCRIPCION AS
SELECT I.ID_INVENTARIO,
       I.ID_PRODUCTO,
       P.NOMBRE_PRODUCTO,
       I.CANTIDAD_PRODUCTO,
       I.FECHA_ACTUALIZACION,
       I.DISPONIBLE
FROM INVENTARIO_TB I
JOIN PRODUCTO_TB P ON I.ID_PRODUCTO = P.ID_PRODUCTO;

------Vista para mostrar los productos disponibles

CREATE OR REPLACE VIEW VISTA_INVENTARIO_DISPONIBLE AS
SELECT *
FROM INVENTARIO_TB
WHERE DISPONIBLE = 1;

-----Vistas para mostrar las categorias activas
CREATE OR REPLACE VIEW VISTA_CATEGORIAS_ACTIVAS AS
SELECT *
FROM CATEGORIA_PRODUCTOS_TB
WHERE ACTIVO = 1;



