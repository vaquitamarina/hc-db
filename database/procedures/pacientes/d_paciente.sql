------------------------------------------------------------------
-- PROCEDURE: d_paciente
-- DESCRIPCION: Desactivar (borrado lógico) de un paciente
------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE d_paciente(
    p_id_paciente UUID
)
LANGUAGE plpgsql
AS $$
BEGIN
    -- Verificar que el paciente existe
    IF NOT EXISTS (SELECT 1 FROM paciente WHERE id_paciente = p_id_paciente) THEN
        RAISE EXCEPTION 'No existe un paciente con el ID proporcionado';
    END IF;

    -- Verificar si el paciente tiene historias clínicas asociadas
    IF EXISTS (SELECT 1 FROM historia_clinica WHERE id_paciente = p_id_paciente) THEN
        RAISE NOTICE 'El paciente tiene historias clínicas asociadas. Se realizará borrado lógico.';
    END IF;

    -- Realizar borrado lógico (desactivar)
    UPDATE paciente
    SET activo = FALSE
    WHERE id_paciente = p_id_paciente;

    RAISE NOTICE 'Paciente desactivado exitosamente: %', p_id_paciente;

EXCEPTION
    WHEN OTHERS THEN
        RAISE EXCEPTION 'Error al desactivar paciente: %', SQLERRM;
END;
$$;

