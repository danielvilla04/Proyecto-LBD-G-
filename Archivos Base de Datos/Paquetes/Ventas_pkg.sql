CREATE OR REPLACE PACKAGE VENTAS AS
    --Metodo crear venta
    PROCEDURE CREAR_VENTA(
    id_factura IN historial_ventas.id_factura%TYPE,
    fecha_venta IN historial_ventas.fecha_venta%TYPE,
    total_venta IN historial_ventas.total_venta%TYPE);

    PROCEDURE ELIMINAR_VENTA(
        id_venta IN historial_ventas.id_venta%TYPE);
        
        
end VENTAS;


CREATE OR REPLACE PACKAGE BODY VENTAS AS
    --Metodo crear venta
    PROCEDURE CREAR_VENTA(
        id_factura IN historial_ventas.id_factura%TYPE,
        fecha_venta IN historial_ventas.fecha_venta%TYPE,
        total_venta IN historial_ventas.total_venta%TYPE
        ) AS
    BEGIN
        INSERT INTO historial_ventas (id_factura, fecha_venta, total_venta)
        VALUES (id_factura, fecha_venta, total_venta);
        COMMIT;
    END;
    
    --ELIMINAR VENTA
    PROCEDURE ELIMINAR_VENTA(
        id_venta IN historial_ventas.id_venta%TYPE) AS
    BEGIN
            DELETE FROM historial_ventas
            WHERE id_venta = id_venta;
            COMMIT;
    END;
end VENTAS;
