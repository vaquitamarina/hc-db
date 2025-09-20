CREATE OR REPLACE PROCEDURE registrar_usuario(
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
    INSERT INTO usuarios (nombre, apellido, dni, email, rol, contrasena_hash)
    VALUES (p_nombre, p_apellido, p_dni, p_email, p_rol, p_contrasena_hash);

    RAISE NOTICE 'Usuario con email % registrado exitosamente.', p_email;

EXCEPTION
    WHEN unique_violation THEN
        RAISE EXCEPTION 'El DNI % o el email % ya se encuentran registrados.', p_dni, p_email;
    WHEN others THEN
        RAISE EXCEPTION 'Ocurrió un error al registrar el usuario: %', SQLERRM;
END;
$$;
