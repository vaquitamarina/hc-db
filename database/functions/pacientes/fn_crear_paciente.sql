------------------------------------------------------------------
-- FUNCTION: fn_crear_paciente
-- DESCRIPCION: Crea un nuevo paciente y retorna su ID
-- PROYECTO: SN-001-2025 - Sistema de Historias Clínicas
-- AUTOR: Equipo BD II - ESIS UNJBG
-- FECHA: 25/10/2025
------------------------------------------------------------------

CREATE OR REPLACE FUNCTION fn_crear_paciente(
    p_nombre VARCHAR(200),
    p_apellido VARCHAR(200),
    p_dni CHAR(8),
    p_fecha_nacimiento DATE,
    p_sexo VARCHAR(20),  -- Recibe: 'Masculino' o 'Femenino'
    p_telefono VARCHAR(20) DEFAULT NULL,
    p_email VARCHAR(200) DEFAULT NULL
)
RETURNS UUID
LANGUAGE plpgsql
AS $$
DECLARE
    v_id_sexo UUID;
    v_id_paciente UUID;
BEGIN
    -- Obtener el UUID del sexo desde el catálogo
    SELECT id_sexo INTO v_id_sexo
    FROM catalogo_sexo
    WHERE UPPER(descripcion) = UPPER(p_sexo);
    
    IF v_id_sexo IS NULL THEN
        RAISE EXCEPTION 'El sexo proporcionado no existe en el catálogo. Use: Masculino o Femenino';
    END IF;

    -- Insertar el paciente
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
        v_id_sexo,
        p_telefono,
        p_email,
        CURRENT_TIMESTAMP,
        TRUE
    )
    RETURNING id_paciente INTO v_id_paciente;

    RAISE NOTICE 'Paciente creado: % % (DNI: %) con ID: %', p_nombre, p_apellido, p_dni, v_id_paciente;

    RETURN v_id_paciente;

EXCEPTION
    WHEN unique_violation THEN
        RAISE EXCEPTION 'Ya existe un paciente registrado con el DNI: %', p_dni;
    WHEN foreign_key_violation THEN
        RAISE EXCEPTION 'Error de integridad referencial: %', SQLERRM;
    WHEN check_violation THEN
        RAISE EXCEPTION 'Error de validación de datos: %', SQLERRM;
    WHEN OTHERS THEN
        RAISE EXCEPTION 'Error al crear paciente: %', SQLERRM;
END;
$$;

COMMENT ON FUNCTION fn_crear_paciente IS 'Crea un nuevo paciente y retorna su UUID';
