CREATE OR REPLACE PACKAGE categoria_pkg AS
    PROCEDURE agregar_categoria(
        id_categoria IN NUMBER,
        nombre_categoria IN VARCHAR2,
        descripcion_categoria IN VARCHAR2,
        activo IN NUMBER
    );
    
    PROCEDURE actualizar_categoria(
        id_categoria IN NUMBER,
        nombre_categoria IN VARCHAR2,
        descripcion_categoria IN VARCHAR2,
        activo IN NUMBER
    );
    
    PROCEDURE eliminar_categoria(
        id_categoria IN NUMBER
    );
    
    
    FUNCTION obtener_productos_con_categoria RETURN SYS_REFCURSOR;
    
    FUNCTION obtener_productos_por_categoria RETURN SYS_REFCURSOR;
    
    FUNCTION VERIFICAR_CATEGORIA_ACTIVA(
        p_id_categoria IN NUMBER
    ) RETURN NUMBER;
    
    
    
    
END categoria_pkg;


CREATE OR REPLACE PACKAGE BODY categoria_pkg AS
    PROCEDURE agregar_categoria(
        id_categoria IN NUMBER,
        nombre_categoria IN VARCHAR2,
        descripcion_categoria IN VARCHAR2,
        activo IN NUMBER
    ) AS
    BEGIN
        INSERT INTO CATEGORIA_PRODUCTOS_TB(ID_CATEGORIA_PRODUCTOS, NOMBRE_CATEGORIA, DESCRIPCION_CATEGORIA, ACTIVO)
        VALUES(id_categoria, nombre_categoria, descripcion_categoria, activo);
        COMMIT;
    END agregar_categoria;
    
    PROCEDURE actualizar_categoria(
        id_categoria IN NUMBER,
        nombre_categoria IN VARCHAR2,
        descripcion_categoria IN VARCHAR2,
        activo IN NUMBER
    ) AS
    BEGIN
        UPDATE CATEGORIA_PRODUCTOS_TB
        SET NOMBRE_CATEGORIA = nombre_categoria,
            DESCRIPCION_CATEGORIA = descripcion_categoria,
            ACTIVO = activo
        WHERE ID_CATEGORIA_PRODUCTOS = id_categoria;
        COMMIT;
    END actualizar_categoria;
    
    PROCEDURE eliminar_categoria(
        id_categoria IN NUMBER
    ) AS
    BEGIN
        DELETE FROM CATEGORIA_PRODUCTOS_TB
        WHERE ID_CATEGORIA_PRODUCTOS = id_categoria;
        COMMIT;
    END eliminar_categoria;
    
    FUNCTION obtener_productos_con_categoria RETURN SYS_REFCURSOR AS
        cur SYS_REFCURSOR;
    BEGIN
        OPEN cur FOR
        SELECT p.ID_PRODUCTO, p.NOMBRE_PRODUCTO, p.DESCRIPCION_PRODUCTO, p.PRECIO, c.NOMBRE_CATEGORIA
        FROM PRODUCTO_TB p
        INNER JOIN CATEGORIA_PRODUCTOS_TB c ON p.ID_CATEGORIA = c.ID_CATEGORIA_PRODUCTOS;
        RETURN cur;
    END obtener_productos_con_categoria;
    
    
    FUNCTION obtener_productos_por_categoria RETURN SYS_REFCURSOR AS
        cur SYS_REFCURSOR;
    BEGIN
        OPEN cur FOR
        SELECT c.NOMBRE_CATEGORIA, p.NOMBRE_PRODUCTO, i.CANTIDAD_PRODUCTO
        FROM PRODUCTO_TB p
        INNER JOIN INVENTARIO_TB i ON p.ID_PRODUCTO = i.ID_PRODUCTO
        INNER JOIN CATEGORIA_PRODUCTOS_TB c ON p.ID_CATEGORIA = c.ID_CATEGORIA_PRODUCTOS;
        RETURN cur;
    END obtener_productos_por_categoria;
    
    FUNCTION VERIFICAR_CATEGORIA_ACTIVA(
        p_id_categoria IN NUMBER
    ) RETURN NUMBER
    IS
        v_activo NUMBER(1,0);
    BEGIN
        SELECT ACTIVO
        INTO v_activo
        FROM CATEGORIA_PRODUCTOS_TB
        WHERE ID_CATEGORIA_PRODUCTOS = p_id_categoria;
    
        RETURN v_activo;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN 0; -- Retorna 0 si no se encuentra ning?n registro
    END VERIFICAR_CATEGORIA_ACTIVA;
END categoria_pkg;
