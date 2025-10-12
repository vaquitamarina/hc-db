------------------------------------------------------------------
-- DESCRIPCION: Procedimiento que registra un nuevo usuario en el sistema
-- Usado por: Sistema de Historias Clinicas - Módulo de Usuarios
-- SN-001-2025 Proyecto Historias Clinicas - Módulo de Usuarios, Autor: Equipo BD II - 12/10/2025
------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE i_usuario(
    IN p_usuario_login VARCHAR(50),
    IN p_nombre VARCHAR(255),
    IN p_apellido VARCHAR(255),
    IN p_dni VARCHAR(20),
    IN p_email VARCHAR(255),
    IN p_rol VARCHAR(50),
    IN p_contrasena_hash VARCHAR(255)
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO usuario (usuario_login, nombre, apellido, dni, email, rol, contrasena_hash)
    VALUES (p_usuario_login, p_nombre, p_apellido, p_dni, p_email, p_rol, p_contrasena_hash);

    RAISE NOTICE 'Usuario con codigo % registrado exitosamente.', p_usuario_login;

EXCEPTION
    WHEN unique_violation THEN
        RAISE EXCEPTION 'El DNI %, email %, usuario % ya se encuentran registrados.', p_dni, p_email, p_usuario_login;
    WHEN others THEN
        RAISE EXCEPTION 'Ocurrió un error al registrar el usuario: %', SQLERRM;
END;
$$;
