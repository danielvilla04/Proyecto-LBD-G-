CREATE OR REPLACE PACKAGE GESTION_CLIENTES_PKG AS

    -- Procedimiento para insertar un nuevo cliente
    PROCEDURE INSERTAR_CLIENTE(
        idCliente IN CLIENTE_TB.ID_CLIENTE%TYPE,
        nombre_cliente IN CLIENTE_TB.NOMBRE_CLIENTE%TYPE,
        primer_apellido IN CLIENTE_TB.PRIMER_APELLIDO%TYPE,
        segundo_apellido IN CLIENTE_TB.SEGUNDO_APELLIDO%TYPE,
        numero_cedula IN CLIENTE_TB.NUMERO_CEDULA%TYPE,
        edad IN CLIENTE_TB.EDAD%TYPE,
        genero IN CLIENTE_TB.GENERO%TYPE,
        id_direccion IN CLIENTE_TB.ID_DIRECCION%TYPE
    );

    -- Procedimiento para actualizar los datos de un cliente
    PROCEDURE ACTUALIZAR_CLIENTE(
        idCliente IN CLIENTE_TB.ID_CLIENTE%TYPE,
        nombre_cliente IN CLIENTE_TB.NOMBRE_CLIENTE%TYPE,
        primer_apellido IN CLIENTE_TB.PRIMER_APELLIDO%TYPE,
        segundo_apellido IN CLIENTE_TB.SEGUNDO_APELLIDO%TYPE,
        numero_cedula IN CLIENTE_TB.NUMERO_CEDULA%TYPE,
        edad IN CLIENTE_TB.EDAD%TYPE,
        genero IN CLIENTE_TB.GENERO%TYPE,
        id_direccion IN CLIENTE_TB.ID_DIRECCION%TYPE
    );

    -- Procedimiento para eliminar un cliente por su ID
    PROCEDURE ELIMINAR_CLIENTE(
        idCliente IN CLIENTE_TB.ID_CLIENTE%TYPE
    );

    -- Funci?n para verificar si un cliente existe por su ID
    FUNCTION VERIFICAR_ID_CLIENTE(id_cliente_in NUMBER) RETURN NUMBER;

    -- Funci?n para obtener el g?nero de un cliente por su ID
    FUNCTION OBTENER_GENERO_CLIENTE(id_cliente_in NUMBER) RETURN VARCHAR2;

    -- Procedimiento para obtener la vista de clientes masculinos
    PROCEDURE OBTENER_VISTA_CLIENTES_MASCULINOS(
        clientes OUT SYS_REFCURSOR
    );

    -- Procedimiento para obtener la vista de clientes femeninos
    PROCEDURE OBTENER_VISTA_CLIENTES_FEMENINOS(
        clientes OUT SYS_REFCURSOR
    );

    -- Procedimiento para obtener la vista de clientes mayores de 30 a?os
    PROCEDURE OBTENER_VISTA_CLIENTES_MAYORES_30(
        clientes OUT SYS_REFCURSOR
    );

END GESTION_CLIENTES_PKG;


CREATE OR REPLACE PACKAGE BODY GESTION_CLIENTES_PKG AS

    -- Procedimiento para insertar un nuevo cliente
    PROCEDURE INSERTAR_CLIENTE(
        idCliente IN CLIENTE_TB.ID_CLIENTE%TYPE,
        nombre_cliente IN CLIENTE_TB.NOMBRE_CLIENTE%TYPE,
        primer_apellido IN CLIENTE_TB.PRIMER_APELLIDO%TYPE,
        segundo_apellido IN CLIENTE_TB.SEGUNDO_APELLIDO%TYPE,
        numero_cedula IN CLIENTE_TB.NUMERO_CEDULA%TYPE,
        edad IN CLIENTE_TB.EDAD%TYPE,
        genero IN CLIENTE_TB.GENERO%TYPE,
        id_direccion IN CLIENTE_TB.ID_DIRECCION%TYPE
    )
    AS
    BEGIN
        -- Verificar si el cliente ya existe
        IF VERIFICAR_ID_CLIENTE(idCliente) = 0 THEN
            -- Insertar el nuevo cliente
            INSERT INTO CLIENTE_TB(ID_CLIENTE, NOMBRE_CLIENTE, PRIMER_APELLIDO, SEGUNDO_APELLIDO, NUMERO_CEDULA, EDAD, GENERO, ID_DIRECCION)
            VALUES(idCliente, nombre_cliente, primer_apellido, segundo_apellido, numero_cedula, edad, genero, id_direccion);
            COMMIT;
            DBMS_OUTPUT.PUT_LINE('Cliente insertado correctamente.');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Ya existe un cliente con el ID proporcionado.');
        END IF;
    END INSERTAR_CLIENTE;

    -- Procedimiento para actualizar los datos de un cliente
    PROCEDURE ACTUALIZAR_CLIENTE(
        idCliente IN CLIENTE_TB.ID_CLIENTE%TYPE,
        nombre_cliente IN CLIENTE_TB.NOMBRE_CLIENTE%TYPE,
        primer_apellido IN CLIENTE_TB.PRIMER_APELLIDO%TYPE,
        segundo_apellido IN CLIENTE_TB.SEGUNDO_APELLIDO%TYPE,
        numero_cedula IN CLIENTE_TB.NUMERO_CEDULA%TYPE,
        edad IN CLIENTE_TB.EDAD%TYPE,
        genero IN CLIENTE_TB.GENERO%TYPE,
        id_direccion IN CLIENTE_TB.ID_DIRECCION%TYPE
    )
    AS
    BEGIN
        -- Verificar si el cliente existe
        IF VERIFICAR_ID_CLIENTE(idCliente) = 1 THEN
            -- Actualizar los datos del cliente
            UPDATE CLIENTE_TB
            SET NOMBRE_CLIENTE = nombre_cliente,
                PRIMER_APELLIDO = primer_apellido,
                SEGUNDO_APELLIDO = segundo_apellido,
                NUMERO_CEDULA = numero_cedula,
                EDAD = edad,
                GENERO = genero,
                ID_DIRECCION = id_direccion
            WHERE ID_CLIENTE = idCliente;
            COMMIT;
            DBMS_OUTPUT.PUT_LINE('Datos del cliente actualizados correctamente.');
        ELSE
            DBMS_OUTPUT.PUT_LINE('No se encontr? ning?n cliente con el ID proporcionado.');
        END IF;
    END ACTUALIZAR_CLIENTE;

    -- Procedimiento para eliminar un cliente por su ID
    PROCEDURE ELIMINAR_CLIENTE(
        idCliente IN CLIENTE_TB.ID_CLIENTE%TYPE
    )
    AS
    BEGIN
        -- Verificar si el cliente existe
        IF VERIFICAR_ID_CLIENTE(idCliente) = 1 THEN
            -- Eliminar el cliente
            DELETE FROM CLIENTE_TB WHERE ID_CLIENTE = idCliente;
            COMMIT;
            DBMS_OUTPUT.PUT_LINE('Cliente eliminado correctamente.');
        ELSE
            DBMS_OUTPUT.PUT_LINE('No se encontr? ning?n cliente con el ID proporcionado.');
        END IF;
    END ELIMINAR_CLIENTE;

    -- Funci?n para verificar si un cliente existe por su ID
    FUNCTION VERIFICAR_ID_CLIENTE(id_cliente_in NUMBER) RETURN NUMBER IS
        cantidad NUMBER;
    BEGIN
        SELECT COUNT(*)
        INTO cantidad
        FROM CLIENTE_TB
        WHERE ID_CLIENTE = id_cliente_in;
        
        RETURN cantidad; -- Devolver? 1 si el cliente existe, 0 si no existe
    END VERIFICAR_ID_CLIENTE;

    -- Funci?n para obtener el g?nero de un cliente por su ID
    FUNCTION OBTENER_GENERO_CLIENTE(id_cliente_in NUMBER) RETURN VARCHAR2 IS
        genero_cliente VARCHAR2(20);
    BEGIN
        SELECT GENERO
        INTO genero_cliente
        FROM CLIENTE_TB
        WHERE ID_CLIENTE = id_cliente_in;
        
        RETURN genero_cliente;
    END OBTENER_GENERO_CLIENTE;

    -- Procedimiento para obtener la vista de clientes masculinos
    PROCEDURE OBTENER_VISTA_CLIENTES_MASCULINOS(
        clientes OUT SYS_REFCURSOR
    )
    AS
    BEGIN
        OPEN clientes FOR
        SELECT *
        FROM CLIENTE_TB
        WHERE GENERO = 'Masculino';
    END OBTENER_VISTA_CLIENTES_MASCULINOS;

    -- Procedimiento para obtener la vista de clientes femeninos
    PROCEDURE OBTENER_VISTA_CLIENTES_FEMENINOS(
        clientes OUT SYS_REFCURSOR
    )
    AS
    BEGIN
        OPEN clientes FOR
        SELECT *
        FROM CLIENTE_TB
        WHERE GENERO = 'Femenino';
    END OBTENER_VISTA_CLIENTES_FEMENINOS;

    -- Procedimiento para obtener la vista de clientes mayores de 30 a?os
    PROCEDURE OBTENER_VISTA_CLIENTES_MAYORES_30(
        clientes OUT SYS_REFCURSOR
    )
    AS
    BEGIN
        OPEN clientes FOR
        SELECT *
        FROM CLIENTE_TB
        WHERE EDAD > 30;
    END OBTENER_VISTA_CLIENTES_MAYORES_30;

END GESTION_CLIENTES_PKG;