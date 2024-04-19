Create or replace package ventas_pkg as
    PROCEDURE ELIMINAR_VENTA(
        v_id_venta IN historial_ventas.id_venta%TYPE);
    
end VENTAS_PKG;


create or replace package body ventas_pkg as

    
    --ELIMINAR VENTA
    PROCEDURE ELIMINAR_VENTA(
        v_id_venta IN historial_ventas.id_venta%TYPE) AS
    BEGIN
             DELETE FROM historial_ventas
    WHERE ID_VENTA = v_id_venta;
            COMMIT;
    END ELIMINAR_VENTA;
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
END CREAR_historial_ventas;


exec CREAR_historial_ventas ventas_pkg.ELIMINAR_VENTA(43);
