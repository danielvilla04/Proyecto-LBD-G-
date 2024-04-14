CREATE OR REPLACE PACKAGE PEDIDOS_PROVEEDORES_PKG AS

    -- Definir un tipo de tabla para los arrays de ID de productos y cantidades
    TYPE ID_PRODUCTOS_ARRAY IS TABLE OF DETALLE_ORDEN_PROVEEDOR_TB.ID_PRODUCTO%TYPE;
    TYPE CANTIDADES_ARRAY IS TABLE OF DETALLE_ORDEN_PROVEEDOR_TB.CANTIDAD%TYPE;

    PROCEDURE INSERTAR_ORDEN_PROVEEDOR (
        p_id_proveedor IN ORDEN_PROVEEDOR_TB.ID_PROVEEDOR%TYPE,
        p_detalles IN ORDEN_PROVEEDOR_TB.DETALLES%TYPE,
        p_fecha_pedido IN ORDEN_PROVEEDOR_TB.FECHA_PEDIDO%TYPE,
        p_fecha_estimada_fin IN ORDEN_PROVEEDOR_TB.FECHA_ESTIMADA_FIN%TYPE,
        p_id_productos IN ID_PRODUCTOS_ARRAY,
        p_cantidades IN CANTIDADES_ARRAY
    );
END PEDIDOS_PROVEEDORES_PKG;
    
CREATE OR REPLACE PACKAGE BODY PEDIDOS_PROVEEDORES_PKG AS

   PROCEDURE INSERTAR_ORDEN_PROVEEDOR (
        p_id_proveedor IN ORDEN_PROVEEDOR_TB.ID_PROVEEDOR%TYPE,
        p_detalles IN ORDEN_PROVEEDOR_TB.DETALLES%TYPE,
        p_fecha_pedido IN ORDEN_PROVEEDOR_TB.FECHA_PEDIDO%TYPE,
        p_fecha_estimada_fin IN ORDEN_PROVEEDOR_TB.FECHA_ESTIMADA_FIN%TYPE,
        p_id_productos IN ID_PRODUCTOS_ARRAY,
        p_cantidades IN CANTIDADES_ARRAY
    ) IS
        v_id_orden_proveedor ORDEN_PROVEEDOR_TB.ID_ORDEN_PROVEEDOR%TYPE;
    BEGIN
        -- Insertar la orden de proveedor
        INSERT INTO ORDEN_PROVEEDOR_TB (ID_PROVEEDOR, DETALLES, FECHA_PEDIDO, FECHA_ESTIMADA_FIN)
        VALUES (p_id_proveedor, p_detalles, p_fecha_pedido, p_fecha_estimada_fin)
        RETURNING ID_ORDEN_PROVEEDOR INTO v_id_orden_proveedor;
    
        -- Insertar los detalles de la orden
        FOR i IN 1 .. p_id_productos.COUNT LOOP
            INSERT INTO DETALLE_ORDEN_PROVEEDOR_TB (ID_ORDEN_PROVEEDOR, ID_PRODUCTO, CANTIDAD)
            VALUES (v_id_orden_proveedor, p_id_productos(i), p_cantidades(i));
        END LOOP;
        
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE;
    END INSERTAR_ORDEN_PROVEEDOR;
    
END PEDIDOS_PROVEEDORES_PKG;





DECLARE
    TYPE ID_PRODUCTOS_ARRAY IS TABLE OF DETALLE_ORDEN_PROVEEDOR_TB.ID_PRODUCTO%TYPE;
    TYPE CANTIDADES_ARRAY IS TABLE OF DETALLE_ORDEN_PROVEEDOR_TB.CANTIDAD%TYPE;
    
    v_id_productos ID_PRODUCTOS_ARRAY := ID_PRODUCTOS_ARRAY(101, 102, 103);
    v_cantidades CANTIDADES_ARRAY := CANTIDADES_ARRAY(10, 20, 15);
BEGIN
    FOR i IN 1 .. v_id_productos.COUNT LOOP
        PEDIDOS_PROVEEDORES_PKG.INSERTAR_ORDEN_PROVEEDOR(
            p_id_proveedor => 1,
            p_detalles => 'Orden de prueba',
            p_fecha_pedido => SYSDATE,
            p_fecha_estimada_fin => SYSDATE + 7,
            p_id_productos => v_id_productos(i),
            p_cantidades => v_cantidades(i)
        );
    END LOOP;
END;