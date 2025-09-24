CREATE OR REPLACE FUNCTION get_user_login(p_usuario_login VARCHAR)
RETURNS TABLE (
    id_usuario UUID,
    usuario_login VARCHAR,
    nombre VARCHAR,
    apellido VARCHAR,
    dni VARCHAR,
    email VARCHAR,
    rol VARCHAR,
    contrasena_hash VARCHAR
) AS $$
BEGIN
    RETURN QUERY
    SELECT u.id_usuario, u.usuario_login, u.nombre, u.apellido, 
           u.dni, u.email, u.rol, u.contrasena_hash
    FROM usuarios u
    WHERE u.usuario_login = p_usuario_login;
END;
$$ LANGUAGE plpgsql;

