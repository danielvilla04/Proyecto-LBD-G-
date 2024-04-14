CREATE OR REPLACE PACKAGE inventario_pkg AS
    PROCEDURE agregar_inventario(
        id_inventario IN NUMBER,
        id_producto IN NUMBER,
        cantidad_producto IN NUMBER,
        fecha_actualizacion IN DATE,
        disponible IN NUMBER
    );
    
    PROCEDURE actualizar_inventario(
        id_inventario IN NUMBER,
        cantidad_producto IN NUMBER,
        fecha_actualizacion IN DATE,
        disponible IN NUMBER
    );
    
    PROCEDURE eliminar_inventario(
        id_inventario IN NUMBER
    );
    
    
     FUNCTION obtener_inventario_por_producto RETURN SYS_REFCURSOR;
     
     
      FUNCTION obtener_productos_sin_inventario RETURN SYS_REFCURSOR;
      
      
      FUNCTION obtener_resumen_inventario RETURN SYS_REFCURSOR;
      
      FUNCTION OBTENER_CANTIDAD_TOTAL_PRODUCTO(p_id_producto IN NUMBER) RETURN NUMBER;
      
       FUNCTION ACTUALIZAR_DISPONIBILIDAD_PRODUCTO(p_id_producto IN NUMBER) RETURN NUMBER;
       
       FUNCTION calcular_valor_total_inventario RETURN NUMBER;
       
       FUNCTION obtener_cantidad_total_producto(id_producto IN NUMBER) RETURN NUMBER;
     
     
     
END inventario_pkg;


CREATE OR REPLACE PACKAGE BODY inventario_pkg AS
    PROCEDURE agregar_inventario(
        id_inventario IN NUMBER,
        id_producto IN NUMBER,
        cantidad_producto IN NUMBER,
        fecha_actualizacion IN DATE,
        disponible IN NUMBER
    ) AS
    BEGIN
        INSERT INTO INVENTARIO_TB(ID_INVENTARIO, ID_PRODUCTO, CANTIDAD_PRODUCTO, FECHA_ACTUALIZACION, DISPONIBLE)
        VALUES(id_inventario, id_producto, cantidad_producto, fecha_actualizacion, disponible);
        COMMIT;
    END agregar_inventario;
    
    PROCEDURE actualizar_inventario(
        id_inventario IN NUMBER,
        cantidad_producto IN NUMBER,
        fecha_actualizacion IN DATE,
        disponible IN NUMBER
    ) AS
    BEGIN
        UPDATE INVENTARIO_TB
        SET CANTIDAD_PRODUCTO = cantidad_producto,
            FECHA_ACTUALIZACION = fecha_actualizacion,
            DISPONIBLE = disponible
        WHERE ID_INVENTARIO = id_inventario;
        COMMIT;
    END actualizar_inventario;
    
    PROCEDURE eliminar_inventario(
        id_inventario IN NUMBER
    ) AS
    BEGIN
        DELETE FROM INVENTARIO_TB
        WHERE ID_INVENTARIO = id_inventario;
        COMMIT;
    END eliminar_inventario;
    
    
    FUNCTION obtener_inventario_por_producto RETURN SYS_REFCURSOR AS
        cur SYS_REFCURSOR;
    BEGIN
        OPEN cur FOR
        SELECT p.ID_PRODUCTO, p.NOMBRE_PRODUCTO, p.DESCRIPCION_PRODUCTO, i.CANTIDAD_PRODUCTO
        FROM PRODUCTO_TB p
        INNER JOIN INVENTARIO_TB i ON p.ID_PRODUCTO = i.ID_PRODUCTO;
        RETURN cur;
    END obtener_inventario_por_producto;
    
    
    
    FUNCTION obtener_productos_sin_inventario RETURN SYS_REFCURSOR AS
        cur SYS_REFCURSOR;
    BEGIN
        OPEN cur FOR
        SELECT p.ID_PRODUCTO, p.NOMBRE_PRODUCTO, p.DESCRIPCION_PRODUCTO
        FROM PRODUCTO_TB p
        LEFT JOIN INVENTARIO_TB i ON p.ID_PRODUCTO = i.ID_PRODUCTO
        WHERE i.ID_PRODUCTO IS NULL;
        RETURN cur;
    END obtener_productos_sin_inventario;
    
    
     FUNCTION obtener_resumen_inventario RETURN SYS_REFCURSOR AS
        cur SYS_REFCURSOR;
    BEGIN
        OPEN cur FOR
        SELECT p.ID_PRODUCTO, p.NOMBRE_PRODUCTO, SUM(i.CANTIDAD_PRODUCTO) AS CANTIDAD_TOTAL
        FROM PRODUCTO_TB p
        INNER JOIN INVENTARIO_TB i ON p.ID_PRODUCTO = i.ID_PRODUCTO
        GROUP BY p.ID_PRODUCTO, p.NOMBRE_PRODUCTO;
        RETURN cur;
    END obtener_resumen_inventario;
    
     FUNCTION OBTENER_CANTIDAD_TOTAL_PRODUCTO(
        p_id_producto IN NUMBER
    ) RETURN NUMBER
    IS
        v_cantidad_total NUMBER;
    BEGIN
        SELECT SUM(CANTIDAD_PRODUCTO)
        INTO v_cantidad_total
        FROM INVENTARIO_TB
        WHERE ID_PRODUCTO = p_id_producto;
    
        RETURN v_cantidad_total;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN 0; -- Retornar 0 si no se encuentra ning?n registro
    END OBTENER_CANTIDAD_TOTAL_PRODUCTO;
    
    
    FUNCTION ACTUALIZAR_DISPONIBILIDAD_PRODUCTO(
        p_id_producto IN NUMBER
    ) RETURN NUMBER
    IS
        v_disponible NUMBER(1,0);
    BEGIN
        SELECT CASE WHEN SUM(CANTIDAD_PRODUCTO) > 0 THEN 1 ELSE 0 END
        INTO v_disponible
        FROM INVENTARIO_TB
        WHERE ID_PRODUCTO = p_id_producto;
    
        UPDATE INVENTARIO_TB
        SET DISPONIBLE = v_disponible
        WHERE ID_PRODUCTO = p_id_producto;
    
        RETURN v_disponible;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN 0; -- Retornar 0 si no se encuentra ning?n registro
    END ACTUALIZAR_DISPONIBILIDAD_PRODUCTO;
    
    
    FUNCTION calcular_valor_total_inventario RETURN NUMBER IS
       total_valor NUMBER;
    BEGIN
       SELECT SUM(p.PRECIO * i.CANTIDAD_PRODUCTO)
       INTO total_valor
       FROM PRODUCTO_TB p
       INNER JOIN INVENTARIO_TB i ON p.ID_PRODUCTO = i.ID_PRODUCTO;
       
       RETURN total_valor;
    END calcular_valor_total_inventario;
    
    
    FUNCTION obtener_cantidad_total_producto(id_producto IN NUMBER) RETURN NUMBER IS
    total_cantidad NUMBER;
    BEGIN
        SELECT SUM(CANTIDAD_PRODUCTO)
        INTO total_cantidad
        FROM INVENTARIO_TB
        WHERE ID_PRODUCTO = id_producto;
        RETURN total_cantidad;
        
END obtener_cantidad_total_producto;
    
END inventario_pkg;