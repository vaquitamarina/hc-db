------------------------------------------------------------------
-- DESCRIPCION: Funcion que obtiene los datos de un usuario por su ID
-- Usado por: Sistema de Historias Clinicas - Módulo de Usuarios
-- SN-001-2025 Proyecto Historias Clinicas - Módulo de Usuarios, Autor: Equipo BD II - 12/10/2025
------------------------------------------------------------------
CREATE OR REPLACE FUNCTION s_usuario(
    p_id_usuario UUID
)
RETURNS TABLE (
    id_usuario    UUID,
    usuario_login VARCHAR,
    nombre        VARCHAR,
    apellido      VARCHAR,
    dni           VARCHAR,
    email         VARCHAR
) AS $$
BEGIN
    RETURN QUERY
    SELECT u.id_usuario,
           u.usuario_login,
           u.nombre,
           u.apellido,
           u.dni,
           u.email
    FROM usuario u
    WHERE u.id_usuario = p_id_usuario;
END;
$$ LANGUAGE plpgsql;

