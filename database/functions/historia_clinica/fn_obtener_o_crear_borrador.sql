------------------------------------------------------------------
-- FUNCTION: fn_obtener_o_crear_borrador
-- DESCRIPCION: Obtiene el borrador existente de un estudiante o crea uno nuevo
--              Si el estudiante ya tiene un borrador, devuelve su ID
--              Si no, crea un nuevo borrador y devuelve su ID
-- PROYECTO: SN-001-2025 - Sistema de Historias Clínicas
-- AUTOR: Equipo BD II - ESIS UNJBG
-- FECHA: 26/10/2025
------------------------------------------------------------------

CREATE OR REPLACE FUNCTION fn_obtener_o_crear_borrador(
    p_id_estudiante UUID
)
RETURNS UUID
LANGUAGE plpgsql
AS $$
DECLARE
    v_id_historia UUID;
BEGIN
    -- Buscar si ya existe un borrador para este estudiante
    SELECT id_historia INTO v_id_historia
    FROM historia_clinica
    WHERE id_estudiante = p_id_estudiante
      AND estado = 'borrador'
    LIMIT 1;
    
    -- Si existe, devolverlo
    IF v_id_historia IS NOT NULL THEN
        RAISE NOTICE 'Borrador existente encontrado para estudiante %: %', p_id_estudiante, v_id_historia;
        RETURN v_id_historia;
    END IF;
    
    -- Si no existe, crear uno nuevo
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
    RETURNING id_historia INTO v_id_historia;
    
    RAISE NOTICE 'Nuevo borrador creado para estudiante %: %', p_id_estudiante, v_id_historia;
    RETURN v_id_historia;
END;
$$;

COMMENT ON FUNCTION fn_obtener_o_crear_borrador IS 'Retorna el ID del borrador existente del estudiante o crea uno nuevo si no existe. Garantiza que cada estudiante tenga máximo un borrador a la vez.';
