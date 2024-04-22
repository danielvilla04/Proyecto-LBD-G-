Create or replace package ventas_pkg as
    PROCEDURE ELIMINAR_VENTA(
        v_id_venta IN historial_ventas.id_venta%TYPE);
    
     PROCEDURE obtener_ventas_por_rango(
        fecha_inicio IN DATE,
        fecha_fin IN DATE,
        ventas OUT SYS_REFCURSOR
    );
    PROCEDURE CREAR_historial_ventas;
    
end VENTAS_PKG;


create or replace package body ventas_pkg as

    
    --ELIMINAR VENTA
    PROCEDURE ELIMINAR_VENTA(
        v_id_venta IN historial_ventas.id_venta%TYPE) AS
    BEGIN
             DELETE FROM historial_ventas
    WHERE ID_VENTA = v_id_venta;
            COMMIT;
    END;
    
    PROCEDURE obtener_ventas_por_rango(
        fecha_inicio IN DATE,
        fecha_fin IN DATE,
        ventas OUT SYS_REFCURSOR
    )
    AS
    BEGIN
        OPEN ventas FOR
        SELECT * FROM HISTORIAL_VENTAS
        WHERE fecha_venta BETWEEN fecha_inicio AND fecha_fin;
    END;
    
    PROCEDURE CREAR_historial_ventas AS
        v_id_factura FACTURA_TB.ID_FACTURA%TYPE;
        fecha_venta DATE;
        v_total_venta FACTURA_TB.TOTAL%TYPE;
        v_count NUMBER;
        
        CURSOR c_facturas IS
            SELECT ID_FACTURA, FECHA_FACTURACION, TOTAL
            FROM FACTURA_TB
            WHERE ESTADO = 'Cancelada';
    BEGIN
        OPEN c_facturas;
        LOOP
            FETCH c_facturas INTO v_id_factura, fecha_venta, v_total_venta;
            EXIT WHEN c_facturas%NOTFOUND;
    
            -- Verificar si el ID de la factura ya está en historial_ventas
            SELECT COUNT(*) INTO v_count
            FROM historial_ventas
            WHERE id_factura = v_id_factura;
    
            -- Si el ID de la factura no está en historial_ventas, insertarlo
            IF v_count = 0 THEN
                INSERT INTO historial_ventas (id_factura, fecha_venta, total_venta)
                VALUES (v_id_factura, fecha_venta, v_total_venta);
            END IF;
        END LOOP;
        
        CLOSE c_facturas;
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Historial de ventas generado correctamente.');
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('Error al generar el historial de ventas: ' || SQLERRM);
    END CREAR_historial_ventas;
    
    
end ventas_pkg;



CREATE OR REPLACE PROCEDURE CREAR_historial_ventas AS
    v_id_factura FACTURA_TB.ID_FACTURA%TYPE;
    fecha_venta DATE;
    v_total_venta FACTURA_TB.TOTAL%TYPE;
    v_count NUMBER;
    
    CURSOR c_facturas IS
        SELECT ID_FACTURA, FECHA_FACTURACION, TOTAL
        FROM FACTURA_TB
        WHERE ESTADO = 'Cancelada';
BEGIN
    OPEN c_facturas;
    LOOP
        FETCH c_facturas INTO v_id_factura, fecha_venta, v_total_venta;
        EXIT WHEN c_facturas%NOTFOUND;

        -- Verificar si el ID de la factura ya está en historial_ventas
        SELECT COUNT(*) INTO v_count
        FROM historial_ventas
        WHERE id_factura = v_id_factura;

        -- Si el ID de la factura no está en historial_ventas, insertarlo
        IF v_count = 0 THEN
            INSERT INTO historial_ventas (id_factura, fecha_venta, total_venta)
            VALUES (v_id_factura, fecha_venta, v_total_venta);
        END IF;
    END LOOP;
    
    CLOSE c_facturas;
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Historial de ventas generado correctamente.');
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error al generar el historial de ventas: ' || SQLERRM);
END ;




exec CREAR_historial_ventas ventas_pkg.ELIMINAR_VENTA(43);


CREATE OR REPLACE PROCEDURE imprimir_ventas_por_rango(v_fecha_venta_inicio HISTORIAL_VENTAS.FECHA_VENTA%TYPE, v_fecha_venta_fin HISTORIAL_VENTAS.FECHA_VENTA%TYPE;) AS
    v_cursor SYS_REFCURSOR;
    v_id_venta HISTORIAL_VENTAS.ID_VENTA%TYPE;
    v_id_factura HISTORIAL_VENTAS.ID_FACTURA%TYPE;
    v_fecha_venta HISTORIAL_VENTAS.FECHA_VENTA%TYPE;
    v_total_venta HISTORIAL_VENTAS.TOTAL_VENTA%TYPE;
BEGIN
    -- Llamar al procedimiento almacenado obtener_ventas_por_rango
    ventas_pkg.obtener_ventas_por_rango(v_fecha_venta_inicio, v_fecha_venta_fin, v_cursor);

    -- Recorrer el cursor y mostrar los resultados
    LOOP
        FETCH v_cursor INTO v_id_venta, v_id_factura, v_fecha_venta, v_total_venta;
        EXIT WHEN v_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('ID_VENTA: ' || v_id_venta || ', ID_FACTURA: ' || v_id_factura || ', FECHA_VENTA: ' || v_fecha_venta || ', TOTAL_VENTA: ' || v_total_venta);
    END LOOP;

    -- Cerrar el cursor después de usarlo
    CLOSE v_cursor;
END;
EXEC imprimir_ventas_por_rango
SET SERVEROUTPUT ON