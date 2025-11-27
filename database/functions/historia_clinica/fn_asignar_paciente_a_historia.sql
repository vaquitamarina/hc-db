------------------------------------------------------------------
-- FUNCTION: fn_asignar_paciente_a_historia
-- DESCRIPCION: Asigna un paciente a una historia clínica en borrador
--              y cambia el estado a 'en_proceso'
------------------------------------------------------------------

CREATE OR REPLACE FUNCTION fn_asignar_paciente_a_historia(
    p_id_historia UUID,
    p_id_paciente UUID
)
RETURNS BOOLEAN
LANGUAGE plpgsql
AS $$
DECLARE
    v_estado_actual VARCHAR(50);
    v_paciente_existe BOOLEAN;
    v_paciente_tiene_historia BOOLEAN;
BEGIN
    -- Verificar que la historia clínica existe y obtener su estado
    SELECT estado INTO v_estado_actual
    FROM historia_clinica
    WHERE id_historia = p_id_historia;
    
    IF v_estado_actual IS NULL THEN
        RAISE EXCEPTION 'Historia clínica no encontrada con ID: %', p_id_historia;
    END IF;
    
    -- Verificar que la historia está en estado borrador
    IF v_estado_actual != 'borrador' THEN
        RAISE EXCEPTION 'La historia clínica no está en estado borrador. Estado actual: %', v_estado_actual;
    END IF;
    
    -- Verificar que el paciente existe
    SELECT EXISTS(
        SELECT 1 FROM paciente WHERE id_paciente = p_id_paciente
    ) INTO v_paciente_existe;
    
    IF NOT v_paciente_existe THEN
        RAISE EXCEPTION 'Paciente no encontrado con ID: %', p_id_paciente;
    END IF;
    
    -- Verificar que el paciente no tiene otra historia asignada
    SELECT EXISTS(
        SELECT 1 
        FROM historia_clinica 
        WHERE id_paciente = p_id_paciente 
          AND id_historia != p_id_historia
    ) INTO v_paciente_tiene_historia;
    
    IF v_paciente_tiene_historia THEN
        RAISE EXCEPTION 'El paciente ya tiene una historia clínica asignada';
    END IF;
    
    -- Asignar el paciente y cambiar el estado
    UPDATE historia_clinica
    SET 
        id_paciente = p_id_paciente,
        estado = 'en_proceso',
        ultima_modificacion = CURRENT_TIMESTAMP
    WHERE id_historia = p_id_historia;
    
    RAISE NOTICE 'Paciente % asignado a historia % exitosamente', p_id_paciente, p_id_historia;
    
    RETURN TRUE;
    
EXCEPTION
    WHEN OTHERS THEN
        RAISE EXCEPTION 'Error al asignar paciente: %', SQLERRM;
END;
$$;

COMMENT ON FUNCTION fn_asignar_paciente_a_historia IS 'Asigna un paciente a una historia clínica en estado borrador y la cambia a estado en_proceso. Valida que la historia esté en borrador y que el paciente no tenga otra historia asignada.';
