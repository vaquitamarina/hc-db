------------------------------------------------------------------
-- FUNCTION: s_pacientes_count
-- DESCRIPCION: Contar total de pacientes con filtros opcionales
-- PROYECTO: SN-001-2025 - Sistema de Historias Clínicas
-- AUTOR: Equipo BD II - ESIS UNJBG
-- FECHA: 13/10/2025
------------------------------------------------------------------

CREATE OR REPLACE FUNCTION s_pacientes_count(
    p_activo BOOLEAN DEFAULT NULL,
    p_busqueda VARCHAR(200) DEFAULT NULL
)
RETURNS INT
LANGUAGE plpgsql
AS $$
DECLARE
    v_count INT;
BEGIN
    SELECT COUNT(*)::INT INTO v_count
    FROM paciente p
    WHERE 
        -- Filtro por estado activo
        (p_activo IS NULL OR p.activo = p_activo)
        AND
        -- Filtro por búsqueda en nombre o DNI
        (
            p_busqueda IS NULL 
            OR p.nombre_completo ILIKE '%' || p_busqueda || '%'
            OR p.dni LIKE '%' || p_busqueda || '%'
        );
    
    RETURN v_count;
END;
$$;

-- Comentarios
COMMENT ON FUNCTION s_pacientes_count IS 'Cuenta el total de pacientes aplicando los mismos filtros que s_all_pacientes. Útil para paginación.';
