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


