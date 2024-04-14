CREATE OR REPLACE PACKAGE facturacion AS

    --Metodo para insertar un metodo de pago
    PROCEDURE INSERTAR_METODOPAGO(
    nombre METODO_PAGO_TB.NOMBRE_METODO_PAGO%TYPE,
    detalles METODO_PAGO_TB.DETALLES%TYPE);
    
    --Metodo para eliminar un metodo de pago
    PROCEDURE ELIMINAR_METODOPAGO(
    id_metodo METODO_PAGO_TB.ID_METODO_PAGO%TYPE);
    
    --Metodo para activar o desactivar metodo pago
    PROCEDURE ACTIVAR_DESACTIVAR_MP(
    id_metodo METODO_PAGO_TB.ID_METODO_PAGO%TYPE);
    
    --Metodos para actualizar metodo pago
    PROCEDURE ACTUALIZAR_METODO_PAGO(
    id_metodo METODO_PAGO_TB.ID_METODO_PAGO%TYPE,
    nombre_metodo_pago METODO_PAGO_TB.NOMBRE_METODO_PAGO%TYPE,
    detalles METODO_PAGO_TB.DETALLES%TYPE);
    
    --Metodo para insertar factura
    PROCEDURE INSERTAR_FACTURA(
        id_factura FACTURA_TB.ID_FACTURA%TYPE,
        id_cliente FACTURA_TB.ID_CLIENTE%TYPE,
        id_empleado FACTURA_TB.ID_EMPLEADO%TYPE,
        id_metodo FACTURA_TB.ID_METODO_PAGO%TYPE,
        detalles FACTURA_TB.DETALLES%TYPE,
        estado FACTURA_TB.ESTADO%TYPE,
        fecha_factuacion FACTURA_TB.FECHA_FACTURACION%TYPE,
        total FACTURA_TB.TOTAL%TYPE);     
        
    --Metodo para eliminar factura
    PROCEDURE ELIMINAR_FACTURA(
    id_factura FACTURA_TB.ID_FACTURA%TYPE);
    
    --Metodo para insertar detalle factura
    PROCEDURE INSERTAR_DETALLE_FACTURA(
        id_detalle_factura DETALLE_FACTURA_TB.ID_DETALLE_FACTURA%TYPE,
        id_factura DETALLE_FACTURA_TB.ID_FACTURA%TYPE,
        id_producto DETALLE_FACTURA_TB.ID_PRODUCTO%TYPE,
        cantidad_producto DETALLE_FACTURA_TB.CANTIDAD_PRODUCTOS%TYPE,
        precio_fila DETALLE_FACTURA_TB.PRECIO_FILA%TYPE);  
        
   

END facturacion;


CREATE OR REPLACE PACKAGE BODY facturacion AS

    

    --Metodo insertar metodo pago
    PROCEDURE INSERTAR_METODOPAGO(
    nombre METODO_PAGO_TB.NOMBRE_METODO_PAGO%TYPE,
    detalles METODO_PAGO_TB.DETALLES%TYPE)     
    AS
        validar BOOLEAN;
        cantidad NUMBER;

    BEGIN

        SELECT COUNT(*) INTO cantidad
        FROM METODO_PAGO_TB
        WHERE NOMBRE_METODO_PAGO = nombre;
        --Validar la existencia de un registro con el id
        IF cantidad > 0 THEN
            validar := TRUE;
        ELSE
            validar := FALSE;
        END IF;
    
        --Si el registro no existe se inserta uno nuevo
        IF validar = FALSE THEN
            INSERT INTO METODO_PAGO_TB(NOMBRE_METODO_PAGO,DETALLES)
            VALUES(nombre,detalles);
            COMMIT;
            DBMS_OUTPUT.PUT_LINE('Se ha insertado correctamente un registro con el id ');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Ya existe un registro  ' );
        END IF;

    EXCEPTION
            WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('No se encontraron datos');
    END;
    
    
    --Eliminar metodo pago
    PROCEDURE ELIMINAR_METODOPAGO(id_metodo METODO_PAGO_TB.ID_METODO_PAGO%TYPE)
    AS
        validar BOOLEAN;
        cantidad NUMBER;
    
    BEGIN
        SELECT COUNT(*) INTO cantidad
        FROM METODO_PAGO_TB
        WHERE ID_METODO_PAGO = id_metodo;
        --Validar la existencia de un registro con el id
        IF cantidad > 0 THEN
            validar := TRUE;
        ELSE
            validar := FALSE;
        END IF;
        
        --SI EXISTE UNN REGISTRO REALIZAR EL BORRADO
        IF validar = TRUE THEN
            DELETE FROM METODO_PAGO_TB
            WHERE ID_METODO_PAGO = id_metodo;
            COMMIT;
            DBMS_OUTPUT.PUT_LINE('Registro eliminado correctamente');
        ELSE
            DBMS_OUTPUT.PUT_LINE('No se encontraron datos');
        END IF;
    END;
    
    
    --Metodo para activar desactivar metodos de pago
    PROCEDURE ACTIVAR_DESACTIVAR_MP(id_metodo METODO_PAGO_TB.ID_METODO_PAGO%TYPE)
    AS
        estado NUMBER;
    BEGIN
        SELECT ACTIVO INTO estado
        FROM METODO_PAGO_TB
        WHERE ID_METODO_PAGO = id_metodo;
        
        IF estado = 0 THEN
            UPDATE METODO_PAGO_TB
            SET ACTIVO = 1
            WHERE ID_METODO_PAGO = id_metodo;
            COMMIT;
            DBMS_OUTPUT.PUT_LINE('Activado correctamente');
        ELSIF estado = 1 THEN
            UPDATE METODO_PAGO_TB
            SET ACTIVO = 0
            WHERE ID_METODO_PAGO = id_metodo;
            COMMIT;
            DBMS_OUTPUT.PUT_LINE('Desactivado correctamente');
        END IF;
        
    EXCEPTION
            WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('No se encontraron datos');
    END;
    
    
    --Actualizar Metodo Pago
    PROCEDURE ACTUALIZAR_METODO_PAGO(id_metodo METODO_PAGO_TB.ID_METODO_PAGO%TYPE, nombre_metodo_pago METODO_PAGO_TB.NOMBRE_METODO_PAGO%TYPE, detalles METODO_PAGO_TB.DETALLES%TYPE)
    AS
        contador NUMBER;
        verificar BOOLEAN;
    BEGIN
        SELECT COUNT(*) INTO contador
        FROM METODO_PAGO_TB
        WHERE ID_METODO_PAGO = id_metodo;
        
        IF contador = 0 THEN
            verificar := FALSE;
        ELSIF contador = 1 THEN
            verificar := TRUE;
        END IF;
        
        IF verificar = TRUE THEN
            UPDATE METODO_PAGO_TB
            SET ID_METODO_PAGO = id_metodo, NOMBRE_METODO_PAGO = nombre_metodo_pago, DETALLES = detalles
            WHERE ID_METODO_PAGO = id_metodo;
            COMMIT;
        ELSE
            DBMS_OUTPUT.PUT_LINE('No existe un registro en la base de datos');
        end if;
    EXCEPTION
            WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('No se encontraron datos');
    END;
    
    
    --Insertar Factura
    PROCEDURE INSERTAR_FACTURA(
        id_factura FACTURA_TB.ID_FACTURA%TYPE,
        id_cliente FACTURA_TB.ID_CLIENTE%TYPE,
        id_empleado FACTURA_TB.ID_EMPLEADO%TYPE,
        id_metodo FACTURA_TB.ID_METODO_PAGO%TYPE,
        detalles FACTURA_TB.DETALLES%TYPE,
        estado FACTURA_TB.ESTADO%TYPE,
        fecha_factuacion FACTURA_TB.FECHA_FACTURACION%TYPE,
        total FACTURA_TB.TOTAL%TYPE
    )     
    AS
        validar BOOLEAN;
        cantidad NUMBER;
    
    BEGIN
        
        SELECT COUNT(*) INTO cantidad
        FROM FACTURA_TB
        WHERE ID_FACTURA = id_factura;
        
        --Validar la existencia de un registro con el id
        IF cantidad > 0 THEN
            validar := TRUE;
        ELSE
            validar := FALSE;
        END IF;
        
        --Si el registro no existe se inserta uno nuevo
        IF validar = FALSE THEN
            INSERT INTO FACTURA_TB(ID_FACTURA, ID_CLIENTE, ID_EMPLEADO, ID_METODO_PAGO, DETALLES, ESTADO, FECHA_FACTURACION, TOTAL)
            VALUES(id_factura,id_cliente,id_empleado,id_metodo,detalles, estado, fecha_factuacion, total);
            COMMIT;
    
        END IF;
    
    EXCEPTION
            WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('No se encontraron datos');
    END;
    
    --Eliminar factura
    PROCEDURE ELIMINAR_FACTURA(id_factura FACTURA_TB.ID_FACTURA%TYPE)
    AS
        cantidad NUMBER;
    BEGIN
        SELECT COUNT(*) INTO cantidad
        FROM FACTURA_TB
        WHERE ID_FACTURA = id_factura;
        --Validar la existencia de un registro con el id
        
        --SI EXISTE UNN REGISTRO REALIZAR EL BORRADO
        IF cantidad>0 THEN
            DELETE FROM DETALLE_FACTURA_TB
            WHERE id_factura = id_factura;
    
            -- Eliminar la factura
            DELETE FROM FACTURA_TB
            WHERE ID_FACTURA = id_factura;
    
            -- Realizar un commit para hacer permanentes los cambios
            COMMIT;
            
            -- Mensaje de éxito
            DBMS_OUTPUT.PUT_LINE('Factura eliminada correctamente');
        ELSE
            DBMS_OUTPUT.PUT_LINE('No se encontraron datos');
        END IF;
    END;
    
    --Insertar detalle dactura
    PROCEDURE INSERTAR_DETALLE_FACTURA(
        id_detalle_factura DETALLE_FACTURA_TB.ID_DETALLE_FACTURA%TYPE,
        id_factura DETALLE_FACTURA_TB.ID_FACTURA%TYPE,
        id_producto DETALLE_FACTURA_TB.ID_PRODUCTO%TYPE,
        cantidad_producto DETALLE_FACTURA_TB.CANTIDAD_PRODUCTOS%TYPE,
        precio_fila DETALLE_FACTURA_TB.PRECIO_FILA%TYPE
    )     
    AS
        validar BOOLEAN;
        cantidad NUMBER;
    
    BEGIN
        
        SELECT COUNT(*) INTO cantidad
        FROM DETALLE_FACTURA_TB
        WHERE ID_DETALLE_FACTURA = id_detalle_factura;
        
        --Validar la existencia de un registro con el id
        IF cantidad > 0 THEN
            validar := TRUE;
        ELSE
            validar := FALSE;
        END IF;
        
        --Si el registro no existe se inserta uno nuevo
        IF validar = FALSE THEN
            INSERT INTO DETALLE_FACTURA_TB(ID_DETALLE_FACTURA, ID_FACTURA, ID_PRODUCTO, CANTIDAD_PRODUCTOS, PRECIO_FILA)
            VALUES(id_detalle_factura, id_factura,id_producto ,cantidad_producto,precio_fila);
            COMMIT;
    
        END IF;
    
    EXCEPTION
            WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('No se encontraron datos');
    END;

   
    
END facturacion;
