CREATE OR REPLACE PACKAGE VENTAS_pkg AS

    PROCEDURE ELIMINAR_VENTA(
        id_venta IN historial_ventas.id_venta%TYPE);
    CURSOR c_facturas IS
        SELECT ID_FACTURA, FECHA_FACTURACION, TOTAL
        FROM FACTURA_TB
        WHERE ESTADO = 'Cancelada';
    PROCEDURE generar_historial_ventas(
    v_id_factura FACTURA_TB.ID_FACTURA%TYPE,
    v_fecha_venta FACTURA_TB.FECHA_FACTURACION%TYPE,
    v_total_venta FACTURA_TB.TOTAL%TYPE);
        
end VENTAS_PKG;
drop package ventas

CREATE OR REPLACE PACKAGE BODY VENTAS_PKG AS
    PROCEDURE generar_historial_ventas AS    
        v_id_factura FACTURA_TB.ID_FACTURA%TYPE;
        v_fecha_venta FACTURA_TB.FECHA_FACTURACION%TYPE;
        v_total_venta FACTURA_TB.TOTAL%TYPE;
    BEGIN
        OPEN c_facturas;
        LOOP
            FETCH c_facturas INTO v_id_factura, v_fecha_venta, v_total_venta;
            EXIT WHEN c_facturas%NOTFOUND;
            
            INSERT INTO historial_ventas (id_factura, fecha_venta, total_venta)
            VALUES (v_id_factura, v_fecha_venta, v_total_venta);
        END LOOP;
        CLOSE c_facturas;
        
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Historial de ventas generado correctamente.');
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('Error al generar el historial de ventas: ' || SQLERRM);
    END generar_historial_ventas;
    
    --ELIMINAR VENTA
    PROCEDURE ELIMINAR_VENTA(
        id_venta IN historial_ventas.id_venta%TYPE) AS
    BEGIN
            DELETE FROM historial_ventas
            WHERE id_venta = id_venta;
            COMMIT;
    END ELIMINAR_VENTA;
    
END VENTAS_PKG;
EXEC VENTAS_PKG.generar_historial_ventas;