------------------------------------------------------------------
-- DESCRIPCION: Funcion que obtiene los datos de un usuario por su ID
------------------------------------------------------------------
CREATE OR REPLACE FUNCTION fn_obtener_usuario(
    p_id_usuario UUID
)
RETURNS TABLE (
    id_usuario     UUID,
    codigo_usuario VARCHAR,
    nombre         VARCHAR,
    apellido       VARCHAR,
    dni            VARCHAR,
    email          VARCHAR
) AS $$
BEGIN
    RETURN QUERY
    SELECT u.id_usuario,
           u.codigo_usuario,
           u.nombre,
           u.apellido,
           u.dni,
           u.email
    FROM usuario u
    WHERE u.id_usuario = p_id_usuario;
END;
$$ LANGUAGE plpgsql;

