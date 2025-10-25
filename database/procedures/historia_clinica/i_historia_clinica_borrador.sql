------------------------------------------------------------------
-- PROCEDURE: i_historia_clinica_borrador
-- DESCRIPCION: Crea una historia clínica en estado borrador para un estudiante
-- PROYECTO: SN-001-2025 - Sistema de Historias Clínicas
-- AUTOR: Equipo BD II - ESIS UNJBG
-- FECHA: 25/10/2025
------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE i_historia_clinica_borrador(
    p_id_estudiante UUID,
    OUT p_id_historia UUID
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO historia_clinica (
        id_estudiante,
        fecha_elaboracion,
        ultima_modificacion,
        estado
    ) VALUES (
        p_id_estudiante,
        CURRENT_DATE,
        CURRENT_TIMESTAMP,
        'borrador'
    )
    RETURNING id_historia INTO p_id_historia;
    
    RAISE NOTICE 'Historia clínica borrador creada: %', p_id_historia;
END;
$$;

COMMENT ON PROCEDURE i_historia_clinica_borrador IS 'Crea una historia clínica en estado borrador sin paciente asociado. El paciente se asocia después con u_historia_clinica_asignar_paciente';
