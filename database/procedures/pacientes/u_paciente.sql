------------------------------------------------------------------
-- PROCEDURE: u_paciente
-- DESCRIPCION: Actualizar datos de un paciente existente
------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE u_paciente(
    p_id_paciente UUID,
    p_nombre_completo VARCHAR(200) DEFAULT NULL,
    p_telefono VARCHAR(20) DEFAULT NULL,
    p_email VARCHAR(200) DEFAULT NULL,
    p_activo BOOLEAN DEFAULT NULL
)
LANGUAGE plpgsql
AS $$
BEGIN
    -- Verificar que el paciente existe
    IF NOT EXISTS (SELECT 1 FROM paciente WHERE id_paciente = p_id_paciente) THEN
        RAISE EXCEPTION 'No existe un paciente con el ID proporcionado';
    END IF;

    -- Actualizar solo los campos que no sean NULL
    UPDATE paciente
    SET
        nombre_completo = COALESCE(p_nombre_completo, nombre_completo),
        telefono = COALESCE(p_telefono, telefono),
        email = COALESCE(p_email, email),
        activo = COALESCE(p_activo, activo)
    WHERE id_paciente = p_id_paciente;

    RAISE NOTICE 'Paciente actualizado exitosamente: %', p_id_paciente;

EXCEPTION
    WHEN OTHERS THEN
        RAISE EXCEPTION 'Error al actualizar paciente: %', SQLERRM;
END;
$$;

-- Comentarios
COMMENT ON PROCEDURE u_paciente IS 'Actualiza los datos de un paciente existente (nombre, teléfono, email, estado activo)';
