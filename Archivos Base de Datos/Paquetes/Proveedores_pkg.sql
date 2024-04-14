CREATE OR REPLACE PACKAGE PROVEEDOR_PKG AS

    
    PROCEDURE insertar_proveedor(
        idProveedor IN PROVEEDOR_TB.ID_PROVEEDOR%TYPE,
        nombre_empresa IN PROVEEDOR_TB.NOMBRE_EMPRESA%TYPE,
        persona_contacto IN PROVEEDOR_TB.PERSONA_CONTACTO%TYPE,
        tipo_proveedor IN PROVEEDOR_TB.TIPO_PROVEEDOR%TYPE,
        id_direccion IN PROVEEDOR_TB.ID_DIRECCION%TYPE
    );
    
    PROCEDURE actualizar_proveedor(
        id_proveedor_in IN PROVEEDOR_TB.ID_PROVEEDOR%TYPE,
        nombre_empresa_in IN PROVEEDOR_TB.NOMBRE_EMPRESA%TYPE,
        persona_contacto_in IN PROVEEDOR_TB.PERSONA_CONTACTO%TYPE,
        tipo_proveedor_in IN PROVEEDOR_TB.TIPO_PROVEEDOR%TYPE,
        id_direccion_in IN PROVEEDOR_TB.ID_DIRECCION%TYPE
    );
    
    PROCEDURE eliminar_proveedor(
        idProveedor IN PROVEEDOR_TB.ID_PROVEEDOR%TYPE
    );

    -- Funciones
    FUNCTION verificar_proveedor(id_proveedor_in NUMBER) RETURN NUMBER;
    FUNCTION obtener_nombre_empresa_proveedor(id_proveedor_in NUMBER) RETURN VARCHAR2;
END PROVEEDOR_PKG;



CREATE OR REPLACE PACKAGE BODY PROVEEDOR_PKG AS


    PROCEDURE insertar_proveedor(
        idProveedor IN PROVEEDOR_TB.ID_PROVEEDOR%TYPE,
        nombre_empresa IN PROVEEDOR_TB.NOMBRE_EMPRESA%TYPE,
        persona_contacto IN PROVEEDOR_TB.PERSONA_CONTACTO%TYPE,
        tipo_proveedor IN PROVEEDOR_TB.TIPO_PROVEEDOR%TYPE,
        id_direccion IN PROVEEDOR_TB.ID_DIRECCION%TYPE
    ) AS
        validar BOOLEAN;
        cantidad NUMBER;
    BEGIN
        SELECT COUNT(*) INTO cantidad
        FROM PROVEEDOR_TB
        WHERE ID_PROVEEDOR = idProveedor;

        IF cantidad = 0 THEN
            validar := FALSE;
        ELSE
            validar := TRUE;
        END IF;

        IF validar = FALSE THEN
            INSERT INTO PROVEEDOR_TB(ID_PROVEEDOR, NOMBRE_EMPRESA, PERSONA_CONTACTO, TIPO_PROVEEDOR, ID_DIRECCION)
            VALUES(idProveedor, nombre_empresa, persona_contacto, tipo_proveedor, id_direccion);
            COMMIT;
            DBMS_OUTPUT.PUT_LINE('Se ha insertado correctamente un proveedor con ID: ' || idProveedor);
        ELSE
            DBMS_OUTPUT.PUT_LINE('Ya existe un proveedor con ID: ' || idProveedor);
        END IF;
    END insertar_proveedor;

    PROCEDURE actualizar_proveedor(
        id_proveedor_in IN PROVEEDOR_TB.ID_PROVEEDOR%TYPE,
        nombre_empresa_in IN PROVEEDOR_TB.NOMBRE_EMPRESA%TYPE,
        persona_contacto_in IN PROVEEDOR_TB.PERSONA_CONTACTO%TYPE,
        tipo_proveedor_in IN PROVEEDOR_TB.TIPO_PROVEEDOR%TYPE,
        id_direccion_in IN PROVEEDOR_TB.ID_DIRECCION%TYPE
    ) AS
        contador NUMBER;
        verificar BOOLEAN;
    BEGIN
        SELECT COUNT(*) INTO contador
        FROM PROVEEDOR_TB
        WHERE ID_PROVEEDOR = id_proveedor_in;

        IF contador = 0 THEN
            verificar := FALSE;
        ELSIF contador = 1 THEN
            verificar := TRUE;
        END IF;

        IF verificar = TRUE THEN
            UPDATE PROVEEDOR_TB
            SET NOMBRE_EMPRESA = nombre_empresa_in,
                PERSONA_CONTACTO = persona_contacto_in,
                TIPO_PROVEEDOR = tipo_proveedor_in,
                ID_DIRECCION = id_direccion_in
            WHERE ID_PROVEEDOR = id_proveedor_in;

            COMMIT;
            DBMS_OUTPUT.PUT_LINE('Los datos del proveedor se actualizaron correctamente.');
        ELSE
            DBMS_OUTPUT.PUT_LINE('No existe ning?n proveedor con el ID ingresado.');
        END IF;
    END actualizar_proveedor;

    PROCEDURE eliminar_proveedor(
        idProveedor IN PROVEEDOR_TB.ID_PROVEEDOR%TYPE
    ) AS
        validar BOOLEAN;
        cantidad NUMBER;
    BEGIN
        SELECT COUNT(*) INTO cantidad
        FROM PROVEEDOR_TB
        WHERE ID_PROVEEDOR = idProveedor;

        IF cantidad > 0 THEN
            validar := TRUE;
        ELSE
            validar := FALSE;
        END IF;

        IF validar = TRUE THEN
            DELETE FROM PROVEEDOR_TB
            WHERE ID_PROVEEDOR = idProveedor;
            COMMIT;
            DBMS_OUTPUT.PUT_LINE('El proveedor se elimin? correctamente.');
        ELSE
            DBMS_OUTPUT.PUT_LINE('No se encontraron datos para eliminar.');
        END IF;
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Hubo un error al eliminar el proveedor: ' || SQLERRM);
    END eliminar_proveedor;

    FUNCTION verificar_proveedor(id_proveedor_in NUMBER) RETURN NUMBER IS
        cantidad NUMBER;
    BEGIN
        SELECT COUNT(*)
        INTO cantidad
        FROM PROVEEDOR_TB
        WHERE ID_PROVEEDOR = id_proveedor_in;
        
        RETURN cantidad; -- Devolver? 1 si el proveedor existe, 0 si no existe
    END verificar_proveedor;

    FUNCTION obtener_nombre_empresa_proveedor(id_proveedor_in NUMBER) RETURN VARCHAR2 IS
        nombre_empresa VARCHAR2(40);
    BEGIN
        SELECT NOMBRE_EMPRESA
        INTO nombre_empresa
        FROM PROVEEDOR_TB
        WHERE ID_PROVEEDOR = id_proveedor_in;
        
        RETURN nombre_empresa;
    END obtener_nombre_empresa_proveedor;

END PROVEEDOR_PKG;

-- Creaci?n de las vistas
-- Vista de todos los proveedores
CREATE OR REPLACE VIEW VISTA_PROVEEDORES AS
SELECT *
FROM PROVEEDOR_TB;

-- Ver vista
SELECT * FROM VISTA_PROVEEDORES;

-- Vista de proveedores por tipo
CREATE OR REPLACE VIEW VISTA_PROVEEDORES_POR_TIPO AS
SELECT TIPO_PROVEEDOR, COUNT(*) AS NUMERO_PROVEEDORES
FROM PROVEEDOR_TB
GROUP BY TIPO_PROVEEDOR;

-- Ver vista
SELECT * FROM VISTA_PROVEEDORES_POR_TIPO;

-- Vista de proveedores con detalles de direcci?n
CREATE OR REPLACE VIEW VISTA_PROVEEDORES_COMIENZAN_CON_P AS
SELECT *
FROM PROVEEDOR_TB
WHERE NOMBRE_EMPRESA LIKE 'P%';

-- Ver vista
SELECT * FROM VISTA_PROVEEDORES_COMIENZAN_CON_P;

/* ================================== Fin paquetes Gestion proveedores ================================== */


