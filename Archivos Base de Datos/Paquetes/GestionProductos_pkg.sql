CREATE OR REPLACE PACKAGE producto_pkg AS
    PROCEDURE agregar_producto(
        id_producto IN NUMBER,
        nombre_producto IN VARCHAR2,
        descripcion_producto IN VARCHAR2,
        precio IN NUMBER,
        id_categoria IN NUMBER
    );
    
    PROCEDURE actualizar_producto(
        id_producto IN NUMBER,
        nombre_producto IN VARCHAR2,
        descripcion_producto IN VARCHAR2,
        precio IN NUMBER,
        id_categoria IN NUMBER
    );
    
    PROCEDURE eliminar_producto(
        id_producto IN NUMBER
    );
    
    --Funcion para obtener productos disponibles
    FUNCTION obtener_productos_disponibles RETURN SYS_REFCURSOR;
    
    --Funcion para obtener productos agotados
    FUNCTION obtener_productos_agotados RETURN SYS_REFCURSOR;
    
    FUNCTION OBTENER_CANTIDAD_PRODUCTOS_POR_CATEGORIA(
        p_id_categoria IN NUMBER) RETURN NUMBER;
    
    
    
    
END producto_pkg;


CREATE OR REPLACE PACKAGE BODY producto_pkg AS
    PROCEDURE agregar_producto(
        id_producto IN NUMBER,
        nombre_producto IN VARCHAR2,
        descripcion_producto IN VARCHAR2,
        precio IN NUMBER,
        id_categoria IN NUMBER
    ) AS
    BEGIN
        INSERT INTO PRODUCTO_TB(ID_PRODUCTO, NOMBRE_PRODUCTO, DESCRIPCION_PRODUCTO, PRECIO, ID_CATEGORIA)
        VALUES(id_producto, nombre_producto, descripcion_producto, precio, id_categoria);
        COMMIT;
    END agregar_producto;
    
    PROCEDURE actualizar_producto(
        id_producto IN NUMBER,
        nombre_producto IN VARCHAR2,
        descripcion_producto IN VARCHAR2,
        precio IN NUMBER,
        id_categoria IN NUMBER
    ) AS
    BEGIN
        UPDATE PRODUCTO_TB
        SET NOMBRE_PRODUCTO = nombre_producto,
            DESCRIPCION_PRODUCTO = descripcion_producto,
            PRECIO = precio,
            ID_CATEGORIA = id_categoria
        WHERE ID_PRODUCTO = id_producto;
        COMMIT;
    END actualizar_producto;
    
    PROCEDURE eliminar_producto(
        id_producto IN NUMBER
    ) AS
    BEGIN
        DELETE FROM PRODUCTO_TB
        WHERE ID_PRODUCTO = id_producto;
        COMMIT;
    END eliminar_producto;
    
    
    FUNCTION obtener_productos_disponibles RETURN SYS_REFCURSOR AS
        cur SYS_REFCURSOR;
    BEGIN
        OPEN cur FOR
        SELECT p.ID_PRODUCTO, p.NOMBRE_PRODUCTO, p.DESCRIPCION_PRODUCTO, p.PRECIO, i.CANTIDAD_PRODUCTO
        FROM PRODUCTO_TB p
        INNER JOIN INVENTARIO_TB i ON p.ID_PRODUCTO = i.ID_PRODUCTO
        WHERE i.DISPONIBLE = 1;
        RETURN cur;
    END obtener_productos_disponibles;
    
    
    FUNCTION obtener_productos_agotados RETURN SYS_REFCURSOR AS
        cur SYS_REFCURSOR;
    BEGIN
        OPEN cur FOR
        SELECT p.ID_PRODUCTO, p.NOMBRE_PRODUCTO, p.DESCRIPCION_PRODUCTO, p.PRECIO
        FROM PRODUCTO_TB p
        INNER JOIN INVENTARIO_TB i ON p.ID_PRODUCTO = i.ID_PRODUCTO
        WHERE i.CANTIDAD_PRODUCTO = 0;
        RETURN cur;
    END obtener_productos_agotados;
    
    FUNCTION OBTENER_CANTIDAD_PRODUCTOS_POR_CATEGORIA(
        p_id_categoria IN NUMBER
    ) RETURN NUMBER
    IS
        v_cantidad_productos NUMBER;
    BEGIN
        SELECT COUNT(*)
        INTO v_cantidad_productos
        FROM PRODUCTO_TB
        WHERE ID_CATEGORIA = p_id_categoria;
    
        RETURN v_cantidad_productos;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN 0; -- Retorna 0 si no se encuentra ning?n registro
    END OBTENER_CANTIDAD_PRODUCTOS_POR_CATEGORIA;
    
    
END producto_pkg;