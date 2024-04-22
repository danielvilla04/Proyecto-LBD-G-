CREATE OR REPLACE PACKAGE PEDIDOS_PROVEEDORES_PKG AS

   FUNCTION INSERTAR_ORDEN_PROVEEDOR (
    p_id_proveedor IN NUMBER,
    p_detalles IN VARCHAR2,
    p_fecha_pedido IN DATE,
    p_fecha_estimada_fin IN DATE
) RETURN NUMBER;
    
    PROCEDURE ACTUALIZAR_ORDEN_PROVEEDOR (
        p_id_orden IN NUMBER,
        p_id_proveedor IN NUMBER,
        p_detalles IN VARCHAR2,
        p_fecha_pedido IN DATE,
        p_fecha_estimada_fin IN DATE
    );
    
    PROCEDURE ELIMINAR_ORDEN_PROVEEDOR (
        p_id_orden IN NUMBER
    );
    
    --SP para detalles de orden
     PROCEDURE INSERTAR_DETALLE_ORDEN_PROVEEDOR (
        p_id_orden_proveedor IN NUMBER,
        p_id_producto IN NUMBER,
        p_cantidad IN NUMBER
    );
    
    PROCEDURE ACTUALIZAR_DETALLE_ORDEN_PROVEEDOR (
        p_id_detalle_orden IN NUMBER,
        p_id_orden_proveedor IN NUMBER,
        p_id_producto IN NUMBER,
        p_cantidad IN NUMBER
    );
    
    PROCEDURE ELIMINAR_DETALLE_ORDEN_PROVEEDOR (
        p_id_detalle_orden IN NUMBER
    );
    
    PROCEDURE obtener_ordenes_por_rango(
        fecha_inicio IN DATE,
        fecha_fin IN DATE,
        ordenes OUT SYS_REFCURSOR
    );
    
END PEDIDOS_PROVEEDORES_PKG;
    
CREATE OR REPLACE PACKAGE BODY PEDIDOS_PROVEEDORES_PKG AS

---------  Procedimeintos para las ordenes de proveedores
    FUNCTION INSERTAR_ORDEN_PROVEEDOR (
    p_id_proveedor IN NUMBER,
    p_detalles IN VARCHAR2,
    p_fecha_pedido IN DATE,
    p_fecha_estimada_fin IN DATE
) RETURN NUMBER IS
    v_id_orden NUMBER;
BEGIN
    INSERT INTO ORDEN_PROVEEDOR_TB (
        ID_PROVEEDOR,
        DETALLES,
        FECHA_PEDIDO,
        FECHA_ESTIMADA_FIN
    ) VALUES (
        p_id_proveedor,
        p_detalles,
        p_fecha_pedido,
        p_fecha_estimada_fin
    ) RETURNING ID_ORDEN_PROVEEDOR INTO v_id_orden;
    DBMS_OUTPUT.PUT_LINE(v_id_orden);

    COMMIT;
    
    RETURN v_id_orden;
END INSERTAR_ORDEN_PROVEEDOR;
    
    PROCEDURE ACTUALIZAR_ORDEN_PROVEEDOR (
        p_id_orden IN NUMBER,
        p_id_proveedor IN NUMBER,
        p_detalles IN VARCHAR2,
        p_fecha_pedido IN DATE,
        p_fecha_estimada_fin IN DATE
    ) AS
    BEGIN
        UPDATE ORDEN_PROVEEDOR_TB
        SET
            ID_PROVEEDOR = p_id_proveedor,
            DETALLES = p_detalles,
            FECHA_PEDIDO = p_fecha_pedido,
            FECHA_ESTIMADA_FIN = p_fecha_estimada_fin
        WHERE
            ID_ORDEN_PROVEEDOR = p_id_orden;
        COMMIT;
    END ACTUALIZAR_ORDEN_PROVEEDOR;
    
    PROCEDURE ELIMINAR_ORDEN_PROVEEDOR (
        p_id_orden IN NUMBER
    ) AS
    BEGIN
        DELETE FROM ORDEN_PROVEEDOR_TB
        WHERE ID_ORDEN_PROVEEDOR = p_id_orden;
        COMMIT;
    END ELIMINAR_ORDEN_PROVEEDOR;
    
    
    --------Procedimientos para los detalles orden
    PROCEDURE INSERTAR_DETALLE_ORDEN_PROVEEDOR (
        p_id_orden_proveedor IN NUMBER,
        p_id_producto IN NUMBER,
        p_cantidad IN NUMBER
    ) AS
    BEGIN
        INSERT INTO DETALLE_ORDEN_PROVEEDOR_TB (
            ID_ORDEN_PROVEEDOR,
            ID_PRODUCTO,
            CANTIDAD
        ) VALUES (
            p_id_orden_proveedor,
            p_id_producto,
            p_cantidad
        );
        COMMIT;
    END INSERTAR_DETALLE_ORDEN_PROVEEDOR;
    
    PROCEDURE ACTUALIZAR_DETALLE_ORDEN_PROVEEDOR (
            p_id_detalle_orden IN NUMBER,
            p_id_orden_proveedor IN NUMBER,
            p_id_producto IN NUMBER,
            p_cantidad IN NUMBER
        ) AS
        BEGIN
            UPDATE DETALLE_ORDEN_PROVEEDOR_TB
            SET
                ID_ORDEN_PROVEEDOR = p_id_orden_proveedor,
                ID_PRODUCTO = p_id_producto,
                CANTIDAD = p_cantidad
            WHERE
                ID_DETALLE_ORDEN = p_id_detalle_orden;
            COMMIT;
        END ACTUALIZAR_DETALLE_ORDEN_PROVEEDOR;
        
    PROCEDURE ELIMINAR_DETALLE_ORDEN_PROVEEDOR (
        p_id_detalle_orden IN NUMBER
    ) AS
    BEGIN
        DELETE FROM DETALLE_ORDEN_PROVEEDOR_TB
        WHERE ID_DETALLE_ORDEN = p_id_detalle_orden;
        COMMIT;
    END ;
    
    PROCEDURE obtener_ordenes_por_rango(
        fecha_inicio IN DATE,
        fecha_fin IN DATE,
        ordenes OUT SYS_REFCURSOR
    )
    AS
    BEGIN
        OPEN ordenes FOR
        SELECT * FROM ORDEN_PROVEEDOR_TB
        WHERE fecha_pedido BETWEEN fecha_inicio AND fecha_fin;
    END;
    
END PEDIDOS_PROVEEDORES_PKG;

DECLARE
    v_id_orden NUMBER;
BEGIN
    -- Llama a la función INSERTAR_ORDEN_PROVEEDOR con valores de ejemplo
    v_id_orden := PEDIDOS_PROVEEDORES_PKG.INSERTAR_ORDEN_PROVEEDOR(
        p_id_proveedor => 12000,
        p_detalles => 'Detalles de la orden',
        p_fecha_pedido => TO_DATE('2024-04-19', 'YYYY-MM-DD'),
        p_fecha_estimada_fin => TO_DATE('2024-04-30', 'YYYY-MM-DD')
    );
    
    -- Muestra el ID de la orden insertada
    DBMS_OUTPUT.PUT_LINE('ID de la orden insertada: ' || v_id_orden);
END;


