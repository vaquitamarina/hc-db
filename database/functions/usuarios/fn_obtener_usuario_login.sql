------------------------------------------------------------------
-- DESCRIPCION: Funcion que obtiene los datos de un usuario por su codigo para login
------------------------------------------------------------------
CREATE OR REPLACE FUNCTION fn_obtener_usuario_login(p_codigo_usuario VARCHAR)
RETURNS TABLE (
    id_usuario UUID,
    codigo_usuario VARCHAR,
    nombre VARCHAR,
    apellido VARCHAR,
    dni CHAR(8),
    email VARCHAR,
    rol VARCHAR,
    contrasena_hash VARCHAR
) AS $$
BEGIN
    RETURN QUERY
    SELECT u.id_usuario, u.codigo_usuario, u.nombre, u.apellido, 
           u.dni, u.email, u.rol, u.contrasena_hash
    FROM usuario u
    WHERE u.codigo_usuario = p_codigo_usuario 
      AND u.activo = TRUE;
END;
$$ LANGUAGE plpgsql;

