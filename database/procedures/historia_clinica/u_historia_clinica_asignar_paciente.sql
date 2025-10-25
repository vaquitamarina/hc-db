------------------------------------------------------------------
-- PROCEDURE: u_historia_clinica_asignar_paciente
-- DESCRIPCION: Asigna un paciente a una historia clínica en borrador
-- PROYECTO: SN-001-2025 - Sistema de Historias Clínicas
-- AUTOR: Equipo BD II - ESIS UNJBG
-- FECHA: 25/10/2025
------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE u_historia_clinica_asignar_paciente(
    p_id_historia UUID,
    p_id_paciente UUID
)
LANGUAGE plpgsql
AS $$
BEGIN
    -- Verificar que la historia existe y está en borrador
    IF NOT EXISTS (
        SELECT 1 FROM historia_clinica 
        WHERE id_historia = p_id_historia 
        AND estado = 'borrador'
    ) THEN
        RAISE EXCEPTION 'La historia clínica no existe o no está en estado borrador';
    END IF;
    
    -- Verificar que el paciente existe
    IF NOT EXISTS (SELECT 1 FROM paciente WHERE id_paciente = p_id_paciente) THEN
        RAISE EXCEPTION 'El paciente no existe';
    END IF;
    
    -- Verificar que el paciente no tenga ya una historia clínica
    IF EXISTS (
        SELECT 1 FROM historia_clinica 
        WHERE id_paciente = p_id_paciente 
        AND id_historia != p_id_historia
    ) THEN
        RAISE EXCEPTION 'El paciente ya tiene una historia clínica asignada';
    END IF;
    
    -- Asignar paciente y cambiar estado a 'en_proceso'
    UPDATE historia_clinica
    SET 
        id_paciente = p_id_paciente,
        estado = 'en_proceso',
        ultima_modificacion = CURRENT_TIMESTAMP
    WHERE id_historia = p_id_historia;
    
    RAISE NOTICE 'Paciente % asignado a historia %', p_id_paciente, p_id_historia;
END;
$$;

COMMENT ON PROCEDURE u_historia_clinica_asignar_paciente IS 'Asigna un paciente a una historia clínica en borrador y cambia el estado a en_proceso';
