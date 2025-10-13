------------------------------------------------------------------
-- FUNCTION: s_pacientes_sin_historia_clinica
-- DESCRIPCION: Listar pacientes que aún no tienen historia clínica asignada
-- PROYECTO: SN-001-2025 - Sistema de Historias Clínicas
-- AUTOR: Equipo BD II - ESIS UNJBG
-- FECHA: 13/10/2025
------------------------------------------------------------------

CREATE OR REPLACE FUNCTION s_pacientes_sin_historia_clinica(
    p_limite INT DEFAULT 50,
    p_offset INT DEFAULT 0
)
RETURNS TABLE (
    id_paciente UUID,
    nombre_completo VARCHAR(200),
    dni CHAR(8),
    fecha_nacimiento DATE,
    edad INT,
    sexo_descripcion VARCHAR(20),
    telefono VARCHAR(20),
    email VARCHAR(200),
    fecha_registro TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT 
        p.id_paciente,
        p.nombre_completo,
        p.dni,
        p.fecha_nacimiento,
        EXTRACT(YEAR FROM AGE(CURRENT_DATE, p.fecha_nacimiento))::INT AS edad,
        cs.descripcion AS sexo_descripcion,
        p.telefono,
        p.email,
        p.fecha_registro
    FROM paciente p
    INNER JOIN catalogo_sexo cs ON p.id_sexo = cs.id_sexo
    LEFT JOIN historia_clinica hc ON p.id_paciente = hc.id_paciente
    WHERE 
        p.activo = TRUE
        AND hc.id_historia IS NULL
    ORDER BY p.fecha_registro DESC
    LIMIT p_limite
    OFFSET p_offset;
END;
$$;

-- Comentarios
COMMENT ON FUNCTION s_pacientes_sin_historia_clinica IS 'Lista pacientes activos que aún no tienen historia clínica asignada. Útil para asignar nuevos pacientes a estudiantes.';
