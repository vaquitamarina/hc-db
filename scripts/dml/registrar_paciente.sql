CREATE OR REPLACE PROCEDURE registrar_paciente(
    IN p_nombre VARCHAR(255),
    IN p_apellido VARCHAR(255),
    IN p_dni VARCHAR(20),
    IN p_fecha_nacimiento DATE,
    IN p_sexo VARCHAR(20),
    IN p_direccion VARCHAR(255),
    IN p_telefono VARCHAR(20)
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO pacientes (nombre, apellido, dni, fecha_nacimiento, sexo, direccion, telefono)
    VALUES (p_nombre, p_apellido, p_dni, p_fecha_nacimiento, p_sexo, p_direccion, p_telefono);
    
    -- Opcional: Puedes devolver un mensaje de éxito
    RAISE NOTICE 'Paciente con DNI % registrado exitosamente.', p_dni;

EXCEPTION
    WHEN unique_violation THEN
        RAISE EXCEPTION 'El DNI % ya se encuentra registrado.', p_dni;
    WHEN others THEN
        RAISE EXCEPTION 'Ocurrió un error al intentar registrar el paciente: %', SQLERRM;
END;
$$;
