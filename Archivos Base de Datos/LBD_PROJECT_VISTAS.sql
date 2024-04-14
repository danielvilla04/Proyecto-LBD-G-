-- Archivo para crear las VISTAS que trajarán dentro de la DB

----------------------Vistas para el apartado de facturacion
--vista de tabla facturas
CREATE OR REPLACE VIEW v_facturas AS
SELECT id_factura, id_cliente, id_empleado, id_metodo_pago, fecha_facturacion, total
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

SELECT * FROM vista_metodos_pago;
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


------------------------ Vistas  de los pedidos de clientes
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




----------------------------------Vistas para Categorias-----

---Vista de productos con su categor?a---
CREATE OR REPLACE VIEW v_productos_con_categoria AS
SELECT p.ID_PRODUCTO, p.NOMBRE_PRODUCTO, p.DESCRIPCION_PRODUCTO, p.PRECIO, c.NOMBRE_CATEGORIA
FROM PRODUCTO_TB p
INNER JOIN CATEGORIA_PRODUCTOS_TB c ON p.ID_CATEGORIA = c.ID_CATEGORIA_PRODUCTOS;

------Vista de productos por categor?a----
CREATE OR REPLACE VIEW v_productos_por_categoria AS
SELECT c.NOMBRE_CATEGORIA, p.NOMBRE_PRODUCTO, i.CANTIDAD_PRODUCTO
FROM PRODUCTO_TB p
INNER JOIN INVENTARIO_TB i ON p.ID_PRODUCTO = i.ID_PRODUCTO
INNER JOIN CATEGORIA_PRODUCTOS_TB c ON p.ID_CATEGORIA = c.ID_CATEGORIA_PRODUCTOS;

---------------------------------Vistas para Productos-----

----Vista de productos ordenados por precio descendente---
CREATE OR REPLACE VIEW v_productos_por_precio_desc AS
SELECT ID_PRODUCTO, NOMBRE_PRODUCTO, DESCRIPCION_PRODUCTO, PRECIO
FROM PRODUCTO_TB
ORDER BY PRECIO DESC;

-----Vista de productos con precios superiores a cierto valor----
CREATE OR REPLACE VIEW v_productos_precio_superior AS
SELECT ID_PRODUCTO, NOMBRE_PRODUCTO, DESCRIPCION_PRODUCTO, PRECIO
FROM PRODUCTO_TB
WHERE PRECIO > 20000; ---- Reemplazar por el valor por el que queremos realizar la consulta




--------------------------------Vistas para Inventario-----

----Productos disponibles en el inventario---
CREATE OR REPLACE VIEW v_productos_disponibles AS
SELECT p.ID_PRODUCTO, p.NOMBRE_PRODUCTO, p.DESCRIPCION_PRODUCTO, p.PRECIO, i.CANTIDAD_PRODUCTO
FROM PRODUCTO_TB p
INNER JOIN INVENTARIO_TB i ON p.ID_PRODUCTO = i.ID_PRODUCTO
WHERE i.DISPONIBLE = 1;

------Productos agotados en el inventario----
CREATE OR REPLACE VIEW v_productos_agotados AS
SELECT p.ID_PRODUCTO, p.NOMBRE_PRODUCTO, p.DESCRIPCION_PRODUCTO, p.PRECIO
FROM PRODUCTO_TB p
INNER JOIN INVENTARIO_TB i ON p.ID_PRODUCTO = i.ID_PRODUCTO
WHERE i.CANTIDAD_PRODUCTO = 0;

----Inventario por producto----
CREATE OR REPLACE VIEW v_inventario_por_producto AS
SELECT p.ID_PRODUCTO, p.NOMBRE_PRODUCTO, p.DESCRIPCION_PRODUCTO, i.CANTIDAD_PRODUCTO
FROM PRODUCTO_TB p
INNER JOIN INVENTARIO_TB i ON p.ID_PRODUCTO = i.ID_PRODUCTO;

---Productos sin inventario disponible----
CREATE OR REPLACE VIEW v_productos_sin_inventario AS
SELECT p.ID_PRODUCTO, p.NOMBRE_PRODUCTO, p.DESCRIPCION_PRODUCTO
FROM PRODUCTO_TB p
LEFT JOIN INVENTARIO_TB i ON p.ID_PRODUCTO = i.ID_PRODUCTO
WHERE i.ID_PRODUCTO IS NULL;

----Resumen del inventario-----
CREATE OR REPLACE VIEW v_resumen_inventario AS
SELECT p.ID_PRODUCTO, p.NOMBRE_PRODUCTO, SUM(i.CANTIDAD_PRODUCTO) AS CANTIDAD_TOTAL
FROM PRODUCTO_TB p
INNER JOIN INVENTARIO_TB i ON p.ID_PRODUCTO = i.ID_PRODUCTO
GROUP BY p.ID_PRODUCTO, p.NOMBRE_PRODUCTO;

CREATE OR REPLACE VIEW VISTA_INVENTARIO_CON_DESCRIPCION AS
SELECT I.ID_INVENTARIO,
       I.ID_PRODUCTO,
       P.NOMBRE_PRODUCTO,
       I.CANTIDAD_PRODUCTO,
       I.FECHA_ACTUALIZACION,
       I.DISPONIBLE
FROM INVENTARIO_TB I
JOIN PRODUCTO_TB P ON I.ID_PRODUCTO = P.ID_PRODUCTO;




/* ============= Vista de todos los proveedores ============= */
-- Vistas Gestion_Provedores

CREATE VIEW VISTA_PROVEEDORES AS
SELECT *
FROM PROVEEDOR_TB;

-- Ver vista
SELECT * FROM VISTA_PROVEEDORES;


/* ============= Vista de proveedores por tipo ============= */
CREATE VIEW VISTA_PROVEEDORES_POR_TIPO AS
SELECT TIPO_PROVEEDOR, COUNT(*) AS NUMERO_PROVEEDORES
FROM PROVEEDOR_TB
GROUP BY TIPO_PROVEEDOR;

-- Ver vista
SELECT * FROM VISTA_PROVEEDORES_POR_TIPO;


/* ============= Vista de proveedores con detalles de direcci?n ============= */
CREATE VIEW VISTA_PROVEEDORES_COMIENZAN_CON_P AS
SELECT *
FROM PROVEEDOR_TB
WHERE NOMBRE_EMPRESA LIKE 'P%';

-- Ver vista
SELECT * FROM VISTA_PROVEEDORES_COMIENZAN_CON_P;



/* ------------------------------------------------------------------------------------------------------------------ */
/* ============= Vista de pedidos de clientes en proceso ============= */
-- Pedido_Cliente

CREATE VIEW VISTA_PEDIDOS_EN_PROCESO AS
SELECT *
FROM PEDIDO_CLIENTE_TB
WHERE ESTADO_PEDIDO = 'En proceso';

-- Ver vista
SELECT * FROM VISTA_PEDIDOS_EN_PROCESO;


/* ============= Vista de pedidos de clientes entregados ============= */
CREATE VIEW VISTA_PEDIDOS_ENTREGADOS AS
SELECT *
FROM PEDIDO_CLIENTE_TB
WHERE ESTADO_PEDIDO = 'Entregado';

-- Ver vista
SELECT * FROM VISTA_PEDIDOS_EN_PROCESO;


/* ============= Vista de pedidos de clientes en espera ============= */
CREATE VIEW VISTA_PEDIDOS_EN_ESPERA AS
SELECT *
FROM PEDIDO_CLIENTE_TB
WHERE ESTADO_PEDIDO = 'En espera';

-- Ver vista
SELECT * FROM VISTA_PEDIDOS_EN_ESPERA;




/* ------------------------------------------------------------------------------------------------------------------ */
-- Vistas Gestion_Cliente
/* ============= Vista de clientes masculinos ============= */
CREATE VIEW VISTA_CLIENTES_MASCULINOS AS
SELECT *
FROM CLIENTE_TB
WHERE GENERO = 'Masculino';

-- Ver vista
SELECT * FROM VISTA_CLIENTES_MASCULINOS;


/* ============= Vista de clientes femeninos ============= */
CREATE VIEW VISTA_CLIENTES_FEMENINOS AS
SELECT *
FROM CLIENTE_TB
WHERE GENERO = 'Femenino';

-- Ver vista
SELECT * FROM VISTA_CLIENTES_FEMENINOS;


/* ============= Vista de clientes mayores de 30 a?os ============= */
CREATE VIEW VISTA_CLIENTES_MAYORES_30 AS
SELECT *
FROM CLIENTE_TB
WHERE EDAD > 30;

-- Ver vista
SELECT * FROM VISTA_CLIENTES_MAYORES_30;


