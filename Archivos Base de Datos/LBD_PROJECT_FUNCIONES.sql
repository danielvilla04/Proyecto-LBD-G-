-- Archivo para crear las funciones que trajarán dentro de la DB



--FUNCIONES PARA EL APARTADO DE fACTURACION

--obtener desde factura
CREATE OR REPLACE FUNCTION obtener_factura(
    id_factura IN factura_tb.id_factura%TYPE
) RETURN factura_tb%ROWTYPE IS
    factura factura_tb%ROWTYPE;
BEGIN
    SELECT * INTO factura
    FROM factura_tb
    WHERE id_factura = id_factura;
    RETURN factura;
END obtener_factura; 

--obtener factura y detalles factura
CREATE OR REPLACE FUNCTION obtener_factura_detalles(v_id_factura IN FACTURA_TB.id_factura%TYPE)
RETURN SYS_REFCURSOR
IS
    f_cursor SYS_REFCURSOR;
BEGIN
    OPEN f_cursor FOR
    SELECT f.id_factura as factura_id, f.id_cliente as cliente_id, f.id_empleado as empleado_id, f.id_metodo_pago as metodo_pago, f.detalles as detalles, f.fecha_facturacion as fecha_facturacion, f.fecha_impresion as fecha_impresion, f.total as total,
           df.id_detalle_factura as detalle_factura_id,  df.id_producto as producto_id, df.cantidad_productos as cantidad_fila, df.precio_fila as precio_fila
    FROM FACTURA_TB f
    JOIN DETALLE_FACTURA_TB df ON f.id_factura = df.id_factura
    WHERE f.id_factura = v_id_factura;

    RETURN f_cursor;
END obtener_factura_detalles;


--obtener desde historial_ventas
CREATE OR REPLACE FUNCTION obtener_venta(
    id_venta IN historial_ventas.id_venta%TYPE
) RETURN historial_ventas%ROWTYPE IS
    v_venta historial_ventas%ROWTYPE;
BEGIN
    SELECT * INTO v_venta
    FROM historial_ventas
    WHERE id_venta = id_venta;
    RETURN v_venta;
END obtener_venta; 


--FUNCIONES PARA EL APARTADO DE METODO DE PAGO

--obtener desde METODO DE PAGO
CREATE OR REPLACE FUNCTION obtener_metodo_pago(
    id_metodo_pago IN metodo_pago_tb.id_metodo_pago%TYPE
) RETURN metodo_pago_tb%ROWTYPE IS
    metodo_pago metodo_pago_tb%ROWTYPE;
BEGIN
    SELECT * INTO metodo_pago
    FROM metodo_pago_tb
    WHERE id_metodo_pago = id_metodo_pago;
    RETURN  metodo_pago;
END obtener_metodo_pago; 

--Funciones para pedidos de cliente
-- 1- Calcular los pedidos por cliente
CREATE OR REPLACE FUNCTION calcular_pedidos(id_cliente IN NUMBER) 
RETURN NUMBER 
AS
    total_pedidos NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO total_pedidos
    FROM PEDIDO_CLIENTE_TB
    WHERE ID_CLIENTE = id_cliente;
    
    RETURN total_pedidos;
END;
/

SELECT calcular_pedidos(1001) AS Total_pedidos
FROM DUAL;


--2- Obtener detalles de un pedido
-- Funci?n para obtener los detalles de un pedido
CREATE OR REPLACE FUNCTION obtener_detalles_pedido(id_pedido IN NUMBER) RETURN PEDIDO_CLIENTE_TB%ROWTYPE AS
    pedido_detalle PEDIDO_CLIENTE_TB%ROWTYPE;
BEGIN
    SELECT *
    INTO pedido_detalle
    FROM PEDIDO_CLIENTE_TB
    WHERE ID_PEDIDO_CLIENTE = id_pedido;
    
    RETURN pedido_detalle;
END;
/

-- 3- Buscar un pedido pendiente
CREATE OR REPLACE FUNCTION buscar_pedidos_pendientes RETURN SYS_REFCURSOR AS
    pedidos_pendientes SYS_REFCURSOR;
BEGIN
    OPEN pedidos_pendientes FOR
        SELECT *
        FROM PEDIDO_CLIENTE_TB
        WHERE ESTADO_PEDIDO = 'En espera';
    
    RETURN pedidos_pendientes;
END;
/

-- 4 Estado pendiente especifico
CREATE OR REPLACE FUNCTION obtener_estado_pedido(id_pedido IN NUMBER) RETURN VARCHAR2 AS
    estado_pedido VARCHAR2(100);
BEGIN
    SELECT ESTADO_PEDIDO
    INTO estado_pedido
    FROM PEDIDO_CLIENTE_TB
    WHERE ID_PEDIDO_CLIENTE = id_pedido;
    
    RETURN estado_pedido;
END;
/
SELECT obtener_estado_pedido(30000) AS Estado_pedido
FROM DUAL;

/* *******************************Funciones para producto ******************************** */

--Funcion para calcular la cantidad especifica de los productos
CREATE OR REPLACE FUNCTION OBTENER_CANTIDAD_TOTAL_PRODUCTO(
    p_id_producto IN NUMBER
) RETURN NUMBER
IS
    v_cantidad_total NUMBER;
BEGIN
    SELECT SUM(CANTIDAD_PRODUCTO)
    INTO v_cantidad_total
    FROM INVENTARIO_TB
    WHERE ID_PRODUCTO = p_id_producto;

    RETURN v_cantidad_total;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 0; -- Retornar 0 si no se encuentra ning?n registro
END OBTENER_CANTIDAD_TOTAL_PRODUCTO;


--Funcion para actualizar la disponibilidad de los productos en el inventario
CREATE OR REPLACE FUNCTION ACTUALIZAR_DISPONIBILIDAD_PRODUCTO(
    p_id_producto IN NUMBER
) RETURN NUMBER
IS
    v_disponible NUMBER(1,0);
BEGIN
    SELECT CASE WHEN SUM(CANTIDAD_PRODUCTO) > 0 THEN 1 ELSE 0 END
    INTO v_disponible
    FROM INVENTARIO_TB
    WHERE ID_PRODUCTO = p_id_producto;

    UPDATE INVENTARIO_TB
    SET DISPONIBLE = v_disponible
    WHERE ID_PRODUCTO = p_id_producto;

    RETURN v_disponible;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 0; -- Retornar 0 si no se encuentra ning?n registro
END ACTUALIZAR_DISPONIBILIDAD_PRODUCTO;

--Funci?n para obtener la Cantidad de Productos por Categor?a
CREATE OR REPLACE FUNCTION OBTENER_CANTIDAD_PRODUCTOS_POR_CATEGORIA(
    p_id_categoria IN NUMBER
) RETURN NUMBER
IS
    v_cantidad_productos NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO v_cantidad_productos
    FROM PRODUCTO_TB
    WHERE ID_CATEGORIA = p_id_categoria;

    RETURN v_cantidad_productos;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 0; -- Retorna 0 si no se encuentra ning?n registro
END OBTENER_CANTIDAD_PRODUCTOS_POR_CATEGORIA;

--Funci?n para verificar si una categor?a est? activa
CREATE OR REPLACE FUNCTION VERIFICAR_CATEGORIA_ACTIVA(
    p_id_categoria IN NUMBER
) RETURN NUMBER
IS
    v_activo NUMBER(1,0);
BEGIN
    SELECT ACTIVO
    INTO v_activo
    FROM CATEGORIA_PRODUCTOS_TB
    WHERE ID_CATEGORIA_PRODUCTOS = p_id_categoria;

    RETURN v_activo;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 0; -- Retorna 0 si no se encuentra ning?n registro
END VERIFICAR_CATEGORIA_ACTIVA;
 