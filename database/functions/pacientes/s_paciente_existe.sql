------------------------------------------------------------------
-- FUNCTION: s_paciente_existe
-- DESCRIPCION: Verificar si un paciente existe por DNI
-- PROYECTO: SN-001-2025 - Sistema de Historias Clínicas
-- AUTOR: Equipo BD II - ESIS UNJBG
-- FECHA: 13/10/2025
------------------------------------------------------------------

CREATE OR REPLACE FUNCTION s_paciente_existe(
    p_dni CHAR(8)
)
RETURNS BOOLEAN
LANGUAGE plpgsql
AS $$
DECLARE
    v_existe BOOLEAN;
BEGIN
    -- Validar formato de DNI
    IF NOT (p_dni ~ '^\d{8}$') THEN
        RAISE EXCEPTION 'El DNI debe tener exactamente 8 dígitos numéricos';
    END IF;

    SELECT EXISTS(
        SELECT 1 
        FROM paciente 
        WHERE dni = p_dni
    ) INTO v_existe;
    
    RETURN v_existe;
END;
$$;

-- Comentarios
COMMENT ON FUNCTION s_paciente_existe IS 'Verifica si existe un paciente con el DNI proporcionado. Útil para validaciones previas al registro.';
