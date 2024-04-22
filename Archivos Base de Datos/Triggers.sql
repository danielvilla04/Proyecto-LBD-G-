--Triggers del proyecto

------------------------------------------------------------------------------
--Triggers para auditoria de pedidos clientes
CREATE OR REPLACE TRIGGER REGISTRO_PEDIDOS_CLIENTES
AFTER INSERT ON AUDITORIA_PEDIDO_CLIENTES
FOR EACH ROW
BEGIN
    INSERT INTO AUDIT_REGISTRO_PEDIDOS_CLIENTES (ID_AUDITORIA_PEDIDO, MENSAJE, FECHA_REGISTRO)
    VALUES (:NEW.ID_AUDITORIA_PEDIDO, 'Se registr? una nueva auditor?a de pedido. Cliente ID: ' || :NEW.ID_CLIENTE || ', Pedido ID: ' || :NEW.ID_PEDIDO_CLIENTE || ', Cumplimiento: ' || :NEW.CUMPLIMIENTO_PEDIDO, SYSDATE);
END;

SELECT * FROM REGISTRO_AUDITORIA;
DROP TRIGGER REGISTRO

-- Segundo trigger

CREATE OR REPLACE TRIGGER registro_actualizacion
AFTER UPDATE ON AUDITORIA_PEDIDO_CLIENTES
FOR EACH ROW
BEGIN
    INSERT INTO audit_actualizacion_pedidos_clientes (id_registro, fecha_hora, usuario, comentario)
    VALUES (:OLD.ID_AUDITORIA_PEDIDO, SYSTIMESTAMP, USER, 'Se actualiz? la auditor?a de pedido. Nuevo cumplimiento: ' || :NEW.CUMPLIMIENTO_PEDIDO);
END;



--------------------------------------------------------------------------

--Triggers para la auditoria de inventario

-----Trigger para actualizar la fecha de ?ltima modificaci?n de un producto----

CREATE OR REPLACE TRIGGER actualizar_fecha_modificacion_producto
BEFORE UPDATE ON PRODUCTO_TB
FOR EACH ROW
BEGIN
    UPDATE INVENTARIO_TB
    SET fecha_actualizacion = SYSDATE;
END actualizar_fecha_modificacion_producto;

-----Trigger para auditar cambios en el inventario---


CREATE OR REPLACE TRIGGER auditar_cambios_inventario
AFTER UPDATE OF CANTIDAD_PRODUCTO ON INVENTARIO_TB
FOR EACH ROW
BEGIN
    INSERT INTO AUDITORIA_INVENTARIO_TB (ACCION, ID_PRODUCTO, CANTIDAD_ANTERIOR, CANTIDAD_ACTUAL, FECHA_ACCION)
    VALUES ('Modificaci?n', :OLD.ID_PRODUCTO, :OLD.CANTIDAD_PRODUCTO, :NEW.CANTIDAD_PRODUCTO, SYSDATE);
END auditar_cambios_inventario;



---------------------------------------------------------------------------
-----Triggers para el apartado de ventas
--Trigger para auditar la creacion de facturas

CREATE OR REPLACE TRIGGER TRG_AUDITORIA_FACTURAS
AFTER INSERT ON FACTURA_TB
FOR EACH ROW
BEGIN
    INSERT INTO AUDITORIA_FACTURAS (ACCION, ID_FACTURA, USUARIO)
    VALUES ('INSERCION', :NEW.ID_FACTURA, USER);
END;

CREATE OR REPLACE TRIGGER TRG_AUDIT_ORDEN_PROVEEDOR
AFTER INSERT OR UPDATE ON ORDEN_PROVEEDOR_TB
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        INSERT INTO AUDITORIA_ORDENES_PROVEEDOR (ACCION, ID_ORDEN_PROVEEDOR, USUARIO)
        VALUES ('INSERCION', :NEW.ID_ORDEN_PROVEEDOR, USER);
    END IF;
    
    IF UPDATING THEN
        INSERT INTO AUDITORIA_ORDENES_PROVEEDOR (ACCION, ID_ORDEN_PROVEEDOR, USUARIO)
        VALUES ('ACTUALIZACION', :NEW.ID_ORDEN_PROVEEDOR, USER);
    END IF;
END;

-------------------------------------------------------------------------------
--Trigger para actualizar historial de ventas
CREATE OR REPLACE TRIGGER eliminar_historial_ventas
BEFORE UPDATE OF estado ON factura_tb
FOR EACH ROW
BEGIN
    -- Verificar si el nuevo estado es "Pendiente"
    IF :NEW.estado = 'Pendiente' THEN
        -- Eliminar el registro correspondiente en la tabla historial_ventas
        DELETE FROM historial_ventas
        WHERE id_factura = :NEW.id_factura;
    END IF;
END;

----------------------------------------------------------------------------------------
--trigger para e manejo de inventario
CREATE OR REPLACE TRIGGER verificar_inventario_antes_insert
BEFORE INSERT ON DETALLE_FACTURA_TB
FOR EACH ROW
DECLARE
    v_cantidad_actual NUMBER;
BEGIN
    -- Obtener la cantidad actual en el inventario para el producto correspondiente
    SELECT CANTIDAD_PRODUCTO
    INTO v_cantidad_actual
    FROM INVENTARIO_TB
    WHERE ID_PRODUCTO = :NEW.ID_PRODUCTO;

    -- Verificar si la cantidad en el inventario es suficiente para la venta
    IF v_cantidad_actual - :NEW.CANTIDAD_PRODUCTOS < 0 THEN
        -- Si es menor a cero, cancelar la inserción del detalle de factura
        RAISE_APPLICATION_ERROR(-20001, 'No hay suficientes productos en inventario para realizar la venta.');
    ELSE
        UPDATE INVENTARIO_TB
        SET CANTIDAD_PRODUCTO = CANTIDAD_PRODUCTO - :NEW.CANTIDAD_PRODUCTOS
        WHERE ID_PRODUCTO = :NEW.ID_PRODUCTO;
    END IF;
END;













