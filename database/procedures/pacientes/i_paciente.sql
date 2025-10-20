------------------------------------------------------------------
-- PROCEDURE: i_paciente
-- DESCRIPCION: Registrar un nuevo paciente en el sistema
------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE i_paciente(
    p_nombre VARCHAR(200),
    p_apellido VARCHAR(200),
    p_dni CHAR(8),
    p_fecha_nacimiento DATE,
    p_sexo VARCHAR(20),  -- Recibe: 'Masculino' o 'Femenino'
    p_telefono VARCHAR(20) DEFAULT NULL,
    p_email VARCHAR(200) DEFAULT NULL
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_id_sexo UUID;
BEGIN
    SELECT id_sexo INTO v_id_sexo
    FROM catalogo_sexo
    WHERE UPPER(descripcion) = UPPER(p_sexo);
    
    IF v_id_sexo IS NULL THEN
        RAISE EXCEPTION 'El sexo proporcionado no existe en el catálogo. Use: Masculino o Femenino';
    END IF;

    INSERT INTO paciente (
        nombre,
        apellido,
        dni,
        fecha_nacimiento,
        id_sexo,
        telefono,
        email,
        fecha_registro,
        activo
    ) VALUES (
        p_nombre,
        p_apellido,
        p_dni,
        p_fecha_nacimiento,
        v_id_sexo,  -- Cambiado: usa el UUID convertido
        p_telefono,
        p_email,
        CURRENT_TIMESTAMP,
        TRUE
    );

    RAISE NOTICE 'Paciente registrado exitosamente: % % (DNI: %)', p_nombre, p_apellido, p_dni;

EXCEPTION
    WHEN unique_violation THEN
        RAISE EXCEPTION 'Ya existe un paciente registrado con el DNI: %', p_dni;
    WHEN foreign_key_violation THEN
        RAISE EXCEPTION 'Error de integridad referencial: %', SQLERRM;
    WHEN check_violation THEN
        RAISE EXCEPTION 'Error de validación de datos: %', SQLERRM;
    WHEN OTHERS THEN
        RAISE EXCEPTION 'Error al registrar paciente: %', SQLERRM;
END;
$$;

-- Comentarios
COMMENT ON PROCEDURE i_paciente IS 'Registra un nuevo paciente en el sistema con validaciones de datos';
