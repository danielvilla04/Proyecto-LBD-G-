CREATE OR REPLACE PACKAGE USUARIO_PKG AS
    PROCEDURE crear_usuario(
        p_username IN VARCHAR2,
        p_password IN VARCHAR2,
        p_role IN VARCHAR2,
        p_enabled IN NUMBER
    );
    
    FUNCTION activar_desactivar_usuario(
    p_username IN VARCHAR2,
    p_enabled IN NUMBER)RETURN BOOLEAN;
    
    PROCEDURE actualizar_usuario(
    p_id_usuario IN NUMBER,
    p_username IN VARCHAR2,
    p_password IN VARCHAR2,
    p_role IN VARCHAR2,
    p_enabled IN NUMBER);
    
    PROCEDURE eliminar_usuario(
    p_id_usuario IN NUMBER);
END USUARIO_PKG;




CREATE OR REPLACE PACKAGE BODY USUARIO_PKG AS

    PROCEDURE crear_usuario(
        p_username IN VARCHAR2,
        p_password IN VARCHAR2,
        p_role IN VARCHAR2,
        p_enabled IN NUMBER
    )
    AS
    BEGIN
        INSERT INTO usuarios (username, password, role, enabled)
        VALUES (p_username, p_password, p_role, p_enabled);
        COMMIT;
    END;

    FUNCTION activar_desactivar_usuario(
            p_username IN VARCHAR2,
            p_enabled IN NUMBER
        )
        RETURN BOOLEAN
        IS
            v_success BOOLEAN := FALSE;
        BEGIN
            UPDATE usuarios
            SET enabled = p_enabled
            WHERE username = p_username;
        
            IF SQL%ROWCOUNT = 1 THEN
                v_success := TRUE;
            END IF;
        
            RETURN v_success;
        EXCEPTION
            WHEN OTHERS THEN
                RETURN FALSE;
        END ;
        
        
    PROCEDURE actualizar_usuario(
        p_id_usuario IN NUMBER,
        p_username IN VARCHAR2,
        p_password IN VARCHAR2,
        p_role IN VARCHAR2,
        p_enabled IN NUMBER
    )
    AS
    BEGIN
        UPDATE usuarios
        SET username = p_username,
            password = p_password,
            role = p_role,
            enabled = p_enabled
        WHERE id_usuario = p_id_usuario;
        COMMIT;
    END ;

    PROCEDURE eliminar_usuario(
        p_id_usuario IN NUMBER
    )
    AS
    BEGIN
        DELETE FROM usuarios
        WHERE id_usuario = p_id_usuario;
        COMMIT;
    END eliminar_usuario;
END USUARIO_PKG;




--PRUEBAS
BEGIN
    USUARIO_PKG.crear_usuario('usuario_prueba', 'contraseña', 'ROL_PRUEBA', 1);
END;

BEGIN
    USUARIO_PKG.actualizar_usuario(1, 'nuevo_nombre', 'nueva_contraseña', 'NUEVO_ROL', 0);
END;


DECLARE
    v_success BOOLEAN;
BEGIN
    v_success := USUARIO_PKG.activar_desactivar_usuario('usuario_prueba', 0);
    IF v_success THEN
        DBMS_OUTPUT.PUT_LINE('Usuario activado correctamente');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Error al activar usuario');
    END IF;
END;


BEGIN
    USUARIO_PKG.eliminar_usuario(1);
END;
/





SELECT * FROM Usuarios WHERE ID_USUARIO = 4


