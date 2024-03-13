--Archivo para realizar SP dentro de la DB


--Manipulación de los métodos de pago

--Inserción de los metodos de pago
SET SERVEROUTPUT ON;
CREATE OR REPLACE PROCEDURE INSERTAR_METODOPAGO(
    id_metodo METODO_PAGO_TB.ID_METODO_PAGO%TYPE,
    tipo METODO_PAGO_TB.TIPO_METODO_PAGO%TYPE,
    detalles METODO_PAGO_TB.DETALLES%TYPE
)     
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
    
    --Si el registro no existe se inserta uno nuevo
    IF validar = FALSE THEN
        INSERT INTO METODO_PAGO_TB(ID_METODO_PAGO,TIPO_METODO_PAGO,DETALLES)
        VALUES(id_metodo,tipo,detalles);
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Se ha insertado correctamente un registro con el id : ' || id_metodo);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Ya existe un registro con el id : ' || id_metodo);
    END IF;

EXCEPTION
        WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No se encontraron datos');
END;

EXECUTE INSERTAR_METODOPAGO(2,'Efectivo','Pago con dólares')--Prueba de inserción

--Procedimeinto para el Borrado de los métodos de pago

CREATE OR REPLACE PROCEDURE ELIMINAR_METODOPAGO(id_metodo METODO_PAGO_TB.ID_METODO_PAGO%TYPE)
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
--PRUEBA DE BORRADO
EXECUTE ELIMINAR_METODOPAGO(1);





