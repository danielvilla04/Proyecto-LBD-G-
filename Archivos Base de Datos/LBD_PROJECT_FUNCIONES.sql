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
