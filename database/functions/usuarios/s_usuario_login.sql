------------------------------------------------------------------
-- DESCRIPCION: Funcion que obtiene los datos de un usuario por su codigo
-- Usado por: Sistema de Historias Clinicas - Módulo de Autenticación
-- SN-001-2025 Proyecto Historias Clinicas - Módulo de Usuarios, Autor: Equipo BD II - 12/10/2025
------------------------------------------------------------------
CREATE OR REPLACE FUNCTION s_usuario_login(p_codigo_usuario VARCHAR)
RETURNS TABLE (
    id_usuario UUID,
    codigo_usuario VARCHAR,
    nombre VARCHAR,
    apellido VARCHAR,
    dni VARCHAR,
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
      AND u.activo = TRUE;  -- Solo usuarios activos
END;
$$ LANGUAGE plpgsql;

