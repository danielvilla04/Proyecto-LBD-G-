--Archivo para realizar SP dentro de la DB


--Manipulación de los métodos de pago

--Inserción de los metodos de pago
SET SERVEROUTPUT ON;
create or replace  PROCEDURE INSERTAR_METODOPAGO(
    nombre METODO_PAGO_TB.NOMBRE_METODO_PAGO%TYPE,
    detalles METODO_PAGO_TB.DETALLES%TYPE
)     
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

EXECUTE INSERTAR_METODOPAGO('Efectivo','Pago con dólares')--Prueba de inserción

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


--Procedimiento para desactivar el metodo de pago
CREATE OR REPLACE PROCEDURE ACTIVAR_DESACTIVAR_MP(id_metodo METODO_PAGO_TB.ID_METODO_PAGO%TYPE)
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
        
--PRUEBA DE CAMBIO DE ESTADO
EXEC ACTIVAR_DESACTIVAR_MP(2);

--Procedimiento para actualizar el metodo de pago

CREATE OR REPLACE PROCEDURE ACTUALIZAR_METODO_PAGO(id_metodo METODO_PAGO_TB.ID_METODO_PAGO%TYPE, tipo METODO_PAGO_TB.TIPO_METODO_PAGO%TYPE, detalles METODO_PAGO_TB.DETALLES%TYPE)
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
        SET ID_METODO_PAGO = id_metodo, TIPO_METODO_PAGO = tipo, DETALLES = detalles
        WHERE ID_METODO_PAGO = id_metodo;
        COMMIT;
    ELSE
        DBMS_OUTPUT.PUT_LINE('No existe un registro en la base de datos');
    end if;
EXCEPTION
        WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No se encontraron datos');
END;
--Prueba actualizar metodo pago
exec ACTUALIZAR_METODO_PAGO(2,'Tarjeta de Credito',  'Banco Nacional');



----Manipulacion de facturas

--Creación de una factura


CREATE OR REPLACE PROCEDURE INSERTAR_FACTURA(
    id_factura FACTURA_TB.ID_FACTURA%TYPE,
    id_cliente FACTURA_TB.ID_CLIENTE%TYPE,
    id_empleado FACTURA_TB.ID_EMPLEADO%TYPE,
    id_metodo FACTURA_TB.ID_METODO_PAGO%TYPE,
    detalles FACTURA_TB.DETALLES%TYPE,
    fecha_factuacion FACTURA_TB.FECHA_FACTURACION%TYPE,
    fecha_impresion FACTURA_TB.FECHA_IMPRESION%TYPE,
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
        INSERT INTO FACTURA_TB(ID_FACTURA, ID_CLIENTE, ID_EMPLEADO, ID_METODO_PAGO, DETALLES, FECHA_FACTURACION, FECHA_IMPRESION, TOTAL)
        VALUES(id_factura,id_cliente,id_empleado,id_metodo,detalles,fecha_factuacion,fecha_impresion,total);
        COMMIT;

    END IF;

EXCEPTION
        WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No se encontraron datos');
END;

EXECUTE INSERTAR_FACTURA(1,1,1,1,'direccion','25-MAR-2024','25-MAR-2024',8000);


--Funcion para eliminar una factura
CREATE OR REPLACE PROCEDURE ELIMINAR_FACTURA(id_factura FACTURA_TB.ID_FACTURA%TYPE)
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
--PRUEBA DE BORRADO
EXECUTE ELIMINAR_FACTURA(1);


--Procedimiento para insertar un detalle de factura

CREATE OR REPLACE PROCEDURE INSERTAR_DETALLE_FACTURA(
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


EXECUTE INSERTAR_DETALLE_FACTURA(1,1,1,5,25000);


--PROCEDIMIENTOS PARA EL APARTADO DE HISTORIAL DE VENTAS

--PROCEDIMEINTO PARA INSERTAR LOS HISTORICOS DE VENTAS
CREATE OR REPLACE PROCEDURE CREAR_VENTA(
    id_factura IN historial_ventas.id_factura%TYPE,
    fecha_venta IN historial_ventas.fecha_venta%TYPE,
    total_venta IN historial_ventas.total_venta%TYPE
) AS
BEGIN
    INSERT INTO historial_ventas (id_factura, fecha_venta, total_venta)
    VALUES (id_factura, fecha_venta, total_venta);
    COMMIT;
END;

--PROCEDIMIENTO PARA BORRAR UN HISTORIAL DE VENTA
CREATE OR REPLACE PROCEDURE ELIMINAR_VENTA(
    id_venta IN historial_ventas.id_venta%TYPE
) AS
BEGIN
    DELETE FROM historial_ventas
    WHERE id_venta = id_venta;
    COMMIT;
END;


--Procedimientos para pedidos 

CREATE OR REPLACE PROCEDURE INSERTAR_PEDIDO_CLIENTE(
    id_pedido_cliente PEDIDO_CLIENTE_TB.ID_PEDIDO_CLIENTE%TYPE,
    id_factura PEDIDO_CLIENTE_TB.ID_FACTURA%TYPE,
    id_direccion PEDIDO_CLIENTE_TB.ID_DIRECCION%TYPE,
    id_cliente PEDIDO_CLIENTE_TB.ID_CLIENTE%TYPE,
    estado_pedido PEDIDO_CLIENTE_TB.ESTADO_PEDIDO%TYPE
)     
AS
    validar BOOLEAN;
    cantidad NUMBER;
BEGIN
    SELECT COUNT(*) INTO cantidad
    FROM PEDIDO_CLIENTE_TB
    WHERE ID_PEDIDO_CLIENTE = id_pedido_cliente;
    
    IF cantidad > 0 THEN
        validar := TRUE;
    ELSE
        validar := FALSE;
    END IF;
    
    -- Validar el id
    IF validar = FALSE THEN
        -- Si el registro no existe, se inserta uno nuevo
        INSERT INTO PEDIDO_CLIENTE_TB(ID_PEDIDO_CLIENTE, ID_FACTURA, ID_DIRECCION, ID_CLIENTE, ESTADO_PEDIDO)
        VALUES(id_pedido_cliente, id_factura, id_direccion, id_cliente, estado_pedido);
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Se ha insertado correctamente un registro con el ID de pedido cliente: ' || id_pedido_cliente);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Ya existe un registro con el ID de pedido cliente: ' || id_pedido_cliente);
    END IF;
END;
/

-- Prueba de Ingresar,  se cambia solo el ID ya que los dem?s datos son de otras tablas
BEGIN
    INSERTAR_PEDIDO_CLIENTE(30000, 100000, 100000, 10000, 'En espera');
END;
/

-- Ver la tabla de (PEDIDO_CLIENTE_TB)
SELECT * FROM PEDIDO_CLIENTE_TB;
/* ================================= Fin Create ================================= */  


/* ================================= Inicio Update ================================= */

-- En esta parte solo se actualzia el estado del pedido

CREATE OR REPLACE PROCEDURE ACTUALIZAR_ESTADO_PEDIDO(
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
END;
/

-- Prueba de actualizar el pedido ingresando el id de la tabla (ID_CLIENTE_PEDIDO) y cambiendo el estado en este caso "En proceso" 
BEGIN
    ACTUALIZAR_ESTADO_PEDIDO(30000, 'En proceso');
END;
/

-- Ver la tabla de (PEDIDO_CLIENTE_TB)
SELECT * FROM PEDIDO_CLIENTE_TB;
/
/* ================================= Fin Update ================================= */



/* ================================= Inicio Delete ================================= */
CREATE OR REPLACE PROCEDURE ELIMINAR_PEDIDO_CLIENTE(
    id_pedido_cliente PEDIDO_CLIENTE_TB.ID_PEDIDO_CLIENTE%TYPE
)
AS
    validar BOOLEAN;
    cantidad NUMBER;
BEGIN
    -- Verificar la existencia del registro con el ID proporcionado
    SELECT COUNT(*) INTO cantidad
    FROM PEDIDO_CLIENTE_TB
    WHERE ID_PEDIDO_CLIENTE = id_pedido_cliente;
    
    -- Validar la existencia del registro
    IF cantidad > 0 THEN
        validar := TRUE;
    ELSE
        validar := FALSE;
    END IF;
    
    -- Si existe un registro, realizar el borrado
    IF validar = TRUE THEN
        DELETE FROM PEDIDO_CLIENTE_TB
        WHERE ID_PEDIDO_CLIENTE = id_pedido_cliente;
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



--Procedimientos para prductos

---Insercion de productos en la tabla PRODUCTO_TB
SET SERVEROUTPUT ON;
CREATE OR REPLACE PROCEDURE INSERTAR_PRODUCTO(
    p_id_producto PRODUCTO_TB.ID_PRODUCTO%TYPE,
    p_nombre_producto PRODUCTO_TB.NOMBRE_PRODUCTO%TYPE,
    p_descripcion_producto PRODUCTO_TB.DESCRIPCION_PRODUCTO%TYPE,
    p_precio PRODUCTO_TB.PRECIO%TYPE,
    p_id_categoria PRODUCTO_TB.ID_CATEGORIA%TYPE
)
AS
    validar BOOLEAN;
    cantidad NUMBER;

BEGIN
    SELECT COUNT(*) INTO cantidad
    FROM PRODUCTO_TB
    WHERE ID_PRODUCTO = p_id_producto;
    
    -- Validar la existencia de un registro con el ID
    IF cantidad > 0 THEN
        validar := TRUE;
    ELSE
        validar := FALSE;
    END IF;
    
    -- Si el registro no existe, se inserta uno nuevo
    IF validar = FALSE THEN
        INSERT INTO PRODUCTO_TB(ID_PRODUCTO, NOMBRE_PRODUCTO, DESCRIPCION_PRODUCTO, PRECIO, ID_CATEGORIA)
        VALUES(p_id_producto, p_nombre_producto, p_descripcion_producto, p_precio, p_id_categoria);
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Se ha insertado correctamente un producto con el ID: ' || p_id_producto);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Ya existe un producto con el ID: ' || p_id_producto);
    END IF;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No se encontraron datos');
END;

EXECUTE INSERTAR_PRODUCTO(1, 'Martillo', 'Martillo de acero con mango de madera', 15.99, 1); --Prueba de inserci?n


-- Actualizaci?n del precio de un producto
SET SERVEROUTPUT ON;
CREATE OR REPLACE PROCEDURE ACTUALIZAR_PRECIO_PRODUCTO(
    p_id_producto PRODUCTO_TB.ID_PRODUCTO%TYPE,
    p_nuevo_precio PRODUCTO_TB.PRECIO%TYPE
)
AS
    cantidad NUMBER;

BEGIN
    SELECT COUNT(*) INTO cantidad
    FROM PRODUCTO_TB
    WHERE ID_PRODUCTO = p_id_producto;

    -- Verificar si existe un producto con el ID especificado
    IF cantidad > 0 THEN
        UPDATE PRODUCTO_TB
        SET PRECIO = p_nuevo_precio
        WHERE ID_PRODUCTO = p_id_producto;

        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Precio del producto actualizado correctamente.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('No se encontr? ning?n producto con el ID especificado.');
    END IF;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No se encontraron datos.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error al actualizar el precio del producto: ' || SQLERRM);
END ACTUALIZAR_PRECIO_PRODUCTO;

EXECUTE ACTUALIZAR_PRECIO_PRODUCTO(1, 19.99); --Prueba de actualizaci?n







