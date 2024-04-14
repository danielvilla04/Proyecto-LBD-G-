/* ================================== Inicio paquetes Pedidos clientes ================================== */
CREATE OR REPLACE PACKAGE PEDIDO_CLIENTE_PKG AS
    -- Procedimiento para insertar un nuevo pedido de cliente
    PROCEDURE INSERTAR_PEDIDO_CLIENTE(
        idPedidoCliente PEDIDO_CLIENTE_TB.ID_PEDIDO_CLIENTE%TYPE,
        id_factura PEDIDO_CLIENTE_TB.ID_FACTURA%TYPE,
        id_direccion PEDIDO_CLIENTE_TB.ID_DIRECCION%TYPE,
        id_cliente PEDIDO_CLIENTE_TB.ID_CLIENTE%TYPE,
        estado_pedido PEDIDO_CLIENTE_TB.ESTADO_PEDIDO%TYPE
    );

    -- Procedimiento para actualizar el estado de un pedido de cliente
    PROCEDURE ACTUALIZAR_ESTADO_PEDIDO(
        id_pedido_cliente_in PEDIDO_CLIENTE_TB.ID_PEDIDO_CLIENTE%TYPE,
        nuevo_estado_pedido_in PEDIDO_CLIENTE_TB.ESTADO_PEDIDO%TYPE
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
        idPedidoCliente PEDIDO_CLIENTE_TB.ID_PEDIDO_CLIENTE%TYPE,
        id_factura PEDIDO_CLIENTE_TB.ID_FACTURA%TYPE,
        id_direccion PEDIDO_CLIENTE_TB.ID_DIRECCION%TYPE,
        id_cliente PEDIDO_CLIENTE_TB.ID_CLIENTE%TYPE,
        estado_pedido PEDIDO_CLIENTE_TB.ESTADO_PEDIDO%TYPE
    )
    AS
        cantidad NUMBER;
    BEGIN
        SELECT COUNT(*) INTO cantidad FROM PEDIDO_CLIENTE_TB WHERE ID_PEDIDO_CLIENTE = idPedidoCliente;

        IF cantidad = 0 THEN
            INSERT INTO PEDIDO_CLIENTE_TB(ID_PEDIDO_CLIENTE, ID_FACTURA, ID_DIRECCION, ID_CLIENTE, ESTADO_PEDIDO)
            VALUES(idPedidoCliente, id_factura, id_direccion, id_cliente, estado_pedido);
            COMMIT;
            DBMS_OUTPUT.PUT_LINE('Se ha insertado correctamente un registro con el ID de pedido cliente: ' || idPedidoCliente);
        ELSE
            -- Si el registro ya existe, mostrar un mensaje
            DBMS_OUTPUT.PUT_LINE('Ya existe un registro con el ID de pedido cliente: ' || idPedidoCliente);
        END IF;
    END INSERTAR_PEDIDO_CLIENTE;

    -- Procedimiento para actualizar el estado de un pedido de cliente
    PROCEDURE ACTUALIZAR_ESTADO_PEDIDO(
        id_pedido_cliente_in PEDIDO_CLIENTE_TB.ID_PEDIDO_CLIENTE%TYPE,
        nuevo_estado_pedido_in PEDIDO_CLIENTE_TB.ESTADO_PEDIDO%TYPE
    )
    AS
        contador NUMBER;
        verificar BOOLEAN;
    BEGIN
        -- En esta parte validamos si el id existe
        SELECT COUNT(*) INTO contador
        FROM PEDIDO_CLIENTE_TB
        WHERE ID_PEDIDO_CLIENTE = id_pedido_cliente_in;
        
        IF contador = 0 THEN
            verificar := FALSE;
        ELSIF contador = 1 THEN
            verificar := TRUE;
        END IF;
        
        IF verificar = TRUE THEN
            UPDATE PEDIDO_CLIENTE_TB
            SET ESTADO_PEDIDO = nuevo_estado_pedido_in
            WHERE ID_PEDIDO_CLIENTE = id_pedido_cliente_in;
            
            COMMIT;
            DBMS_OUTPUT.PUT_LINE('El estado del pedido se actualiza correctamente.');
        ELSE
            DBMS_OUTPUT.PUT_LINE('No existe ningun pedido con este id.');
        END IF;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('No se encontraron datos.');
    END ACTUALIZAR_ESTADO_PEDIDO;

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
    END ELIMINAR_PEDIDO_CLIENTE;

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
