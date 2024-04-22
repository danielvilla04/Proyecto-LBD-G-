/* ================================== Inicio paquetes Pedidos clientes ================================== */
CREATE OR REPLACE PACKAGE PEDIDO_CLIENTE_PKG AS
    -- Procedimiento para insertar un nuevo pedido de cliente
    PROCEDURE INSERTAR_PEDIDO_CLIENTE(
        id_factura PEDIDO_CLIENTE_TB.ID_FACTURA%TYPE,
        direccion PEDIDO_CLIENTE_TB.DIRECCION%TYPE,
        id_cliente PEDIDO_CLIENTE_TB.ID_CLIENTE%TYPE,
        estado_pedido PEDIDO_CLIENTE_TB.ESTADO_PEDIDO%TYPE
    );

    -- Procedimiento para actualizar el estado de un pedido de cliente
    PROCEDURE ACTUALIZAR_PEDIDO_CLIENTE(
        p_id_pedido_cliente IN PEDIDO_CLIENTE_TB.ID_PEDIDO_CLIENTE%TYPE,
        p_direccion IN PEDIDO_CLIENTE_TB.DIRECCION%TYPE,
        p_estado_pedido IN PEDIDO_CLIENTE_TB.ESTADO_PEDIDO%TYPE
    );

    -- Procedimiento para eliminar un pedido de cliente
    PROCEDURE ELIMINAR_PEDIDO_CLIENTE(
        idPedidoCliente PEDIDO_CLIENTE_TB.ID_PEDIDO_CLIENTE%TYPE
    );

    -- Funci?n para obtener detalles de un pedido espec?fico
    FUNCTION OBTENER_DETALLES_PEDIDO(id_pedido_in NUMBER) RETURN SYS_REFCURSOR;

    -- Funci?n para obtener el estado actual de un pedido cliente por su ID
    FUNCTION OBTENER_ESTADO_PEDIDO(id_pedido_in NUMBER) RETURN VARCHAR2;

    -- Vista de pedidos de clientes en proceso
    FUNCTION VISTA_PEDIDOS_EN_PROCESO RETURN SYS_REFCURSOR;

    -- Vista de pedidos de clientes entregados
    FUNCTION VISTA_PEDIDOS_ENTREGADOS RETURN SYS_REFCURSOR;

    -- Vista de pedidos de clientes en espera
    FUNCTION VISTA_PEDIDOS_EN_ESPERA RETURN SYS_REFCURSOR;
END PEDIDO_CLIENTE_PKG;

CREATE OR REPLACE PACKAGE BODY PEDIDO_CLIENTE_PKG AS
    -- Procedimiento para insertar un nuevo pedido de cliente
    PROCEDURE INSERTAR_PEDIDO_CLIENTE(
        id_factura PEDIDO_CLIENTE_TB.ID_FACTURA%TYPE,
        direccion PEDIDO_CLIENTE_TB.DIRECCION%TYPE,
        id_cliente PEDIDO_CLIENTE_TB.ID_CLIENTE%TYPE,
        estado_pedido PEDIDO_CLIENTE_TB.ESTADO_PEDIDO%TYPE
    )
    AS
        cantidad NUMBER;
    BEGIN
    

      
            INSERT INTO PEDIDO_CLIENTE_TB(ID_FACTURA, DIRECCION, ID_CLIENTE, ESTADO_PEDIDO)
            VALUES( id_factura, direccion, id_cliente, estado_pedido);
            COMMIT;
     
       
        
    END INSERTAR_PEDIDO_CLIENTE;

    PROCEDURE ACTUALIZAR_PEDIDO_CLIENTE (
        p_id_pedido_cliente IN PEDIDO_CLIENTE_TB.ID_PEDIDO_CLIENTE%TYPE,
        p_direccion IN PEDIDO_CLIENTE_TB.DIRECCION%TYPE,
        p_estado_pedido IN PEDIDO_CLIENTE_TB.ESTADO_PEDIDO%TYPE
    )
    IS
    BEGIN
        -- Actualizar la dirección y el estado del pedido
        UPDATE PEDIDO_CLIENTE_TB
        SET DIRECCION = p_direccion,
            ESTADO_PEDIDO = p_estado_pedido
        WHERE ID_PEDIDO_CLIENTE = p_id_pedido_cliente;
    
        -- Confirmar los cambios
        COMMIT;
    
        DBMS_OUTPUT.PUT_LINE('El pedido del cliente se actualizó correctamente.');
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('No se encontró el pedido del cliente con ID: ' || p_id_pedido_cliente);
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error al actualizar el pedido del cliente: ' || SQLERRM);
    END;



    -- Procedimiento para eliminar un pedido de cliente
    PROCEDURE ELIMINAR_PEDIDO_CLIENTE(
        idPedidoCliente PEDIDO_CLIENTE_TB.ID_PEDIDO_CLIENTE%TYPE
    )
    AS
        validar BOOLEAN;
        cantidad NUMBER;
    BEGIN
        -- Verificar la existencia del registro con el ID proporcionado
        SELECT COUNT(*) INTO cantidad
        FROM PEDIDO_CLIENTE_TB
        WHERE ID_PEDIDO_CLIENTE = idPedidoCliente;
        
        -- Validar la existencia del registro
        IF cantidad > 0 THEN
            validar := TRUE;
        ELSE
            validar := FALSE;
        END IF;
        
        -- Si existe un registro, realizar el borrado
        IF validar = TRUE THEN
            DELETE FROM PEDIDO_CLIENTE_TB
            WHERE ID_PEDIDO_CLIENTE = idPedidoCliente;
            COMMIT;
            DBMS_OUTPUT.PUT_LINE('El pedido del cliente se elimin? correctamente.');
        ELSE
            DBMS_OUTPUT.PUT_LINE('No se encontraron datos.');
        END IF;
    EXCEPTION
        -- Capturar cualquier excepci?n y mostrar un mensaje de error
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Hubo un error al eliminar el pedido: ' || SQLERRM);
    END;

    -- Funci?n para obtener detalles de un pedido espec?fico
    FUNCTION OBTENER_DETALLES_PEDIDO(id_pedido_in NUMBER) RETURN SYS_REFCURSOR IS
        detalles_cur SYS_REFCURSOR;
    BEGIN
        OPEN detalles_cur FOR
        SELECT *
        FROM PEDIDO_CLIENTE_TB
        WHERE ID_PEDIDO_CLIENTE = id_pedido_in;
        
        RETURN detalles_cur;
    END OBTENER_DETALLES_PEDIDO;

    -- Funci?n para obtener el estado actual de un pedido cliente por su ID
    FUNCTION OBTENER_ESTADO_PEDIDO(id_pedido_in NUMBER) RETURN VARCHAR2 IS
        estado_pedido VARCHAR2(100);
    BEGIN
        SELECT ESTADO_PEDIDO INTO estado_pedido
        FROM PEDIDO_CLIENTE_TB
        WHERE ID_PEDIDO_CLIENTE = id_pedido_in;
        
        RETURN estado_pedido;
    END OBTENER_ESTADO_PEDIDO;

    -- Vista de pedidos de clientes en proceso
    FUNCTION VISTA_PEDIDOS_EN_PROCESO RETURN SYS_REFCURSOR IS
        pedidos_cur SYS_REFCURSOR;
    BEGIN
        OPEN pedidos_cur FOR
        SELECT *
        FROM PEDIDO_CLIENTE_TB
        WHERE ESTADO_PEDIDO = 'En proceso';
        
        RETURN pedidos_cur;
    END VISTA_PEDIDOS_EN_PROCESO;

    -- Vista de pedidos de clientes entregados
    FUNCTION VISTA_PEDIDOS_ENTREGADOS RETURN SYS_REFCURSOR IS
        pedidos_cur SYS_REFCURSOR;
    BEGIN
        OPEN pedidos_cur FOR
        SELECT *
        FROM PEDIDO_CLIENTE_TB
        WHERE ESTADO_PEDIDO = 'Entregado';
        
        RETURN pedidos_cur;
    END VISTA_PEDIDOS_ENTREGADOS;

    -- Vista de pedidos de clientes en espera
    FUNCTION VISTA_PEDIDOS_EN_ESPERA RETURN SYS_REFCURSOR IS
        pedidos_cur SYS_REFCURSOR;
    BEGIN
        OPEN pedidos_cur FOR
        SELECT *
        FROM PEDIDO_CLIENTE_TB
        WHERE ESTADO_PEDIDO = 'En espera';
        
        RETURN pedidos_cur;
    END VISTA_PEDIDOS_EN_ESPERA;
END PEDIDO_CLIENTE_PKG;



DECLARE
    v_id_factura PEDIDO_CLIENTE_TB.ID_FACTURA%TYPE := 52; -- Coloca aquí el valor deseado
    v_direccion PEDIDO_CLIENTE_TB.DIRECCION%TYPE := 'Calle 123'; -- Coloca aquí el valor deseado
    v_id_cliente PEDIDO_CLIENTE_TB.ID_CLIENTE%TYPE := 3; -- Coloca aquí el valor deseado
    v_estado_pedido PEDIDO_CLIENTE_TB.ESTADO_PEDIDO%TYPE := 'Pendiente'; -- Coloca aquí el valor deseado
BEGIN
    PEDIDO_CLIENTE_PKG.INSERTAR_PEDIDO_CLIENTE(v_id_factura, v_direccion, v_id_cliente, v_estado_pedido);
    DBMS_OUTPUT.PUT_LINE('El pedido del cliente se insertó correctamente.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Hubo un error al insertar el pedido: ' || SQLERRM);
END;
/

-- Procedimiento ACTUALIZAR_ESTADO_PEDIDO
DECLARE
    v_id_pedido_cliente PEDIDO_CLIENTE_TB.ID_PEDIDO_CLIENTE%TYPE := 1; -- Coloca aquí el valor deseado
    v_direccion PEDIDO_CLIENTE_TB.DIRECCION%TYPE := 'Nueva dirección'; -- Coloca aquí el valor deseado
    v_estado_pedido PEDIDO_CLIENTE_TB.ESTADO_PEDIDO%TYPE := 'Entregado'; -- Coloca aquí el valor deseado
BEGIN
    PEDIDO_CLIENTE_PKG.ACTUALIZAR_PEDIDO_CLIENTE(v_id_pedido_cliente, v_direccion, v_estado_pedido);
    DBMS_OUTPUT.PUT_LINE('El estado del pedido del cliente se actualizó correctamente.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Hubo un error al actualizar el estado del pedido: ' || SQLERRM);
END; 
SET SERVEROUTPUT ON

/

-- Procedimiento ELIMINAR_PEDIDO_CLIENTE
DECLARE
    v_id_pedido_cliente PEDIDO_CLIENTE_TB.ID_PEDIDO_CLIENTE%TYPE := 1; -- Coloca aquí el valor deseado
BEGIN
    PEDIDO_CLIENTE_PKG.ELIMINAR_PEDIDO_CLIENTE(v_id_pedido_cliente);
END;

