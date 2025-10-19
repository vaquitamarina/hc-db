------------------------------------------------------------------
-- FUNCTION: s_all_pacientes
-- DESCRIPCION: Listar todos los pacientes con filtros opcionales
------------------------------------------------------------------

CREATE OR REPLACE FUNCTION s_all_pacientes(
    p_activo BOOLEAN DEFAULT NULL,
    p_busqueda VARCHAR(200) DEFAULT NULL,
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
    fecha_registro TIMESTAMP,
    activo BOOLEAN,
    tiene_historia_clinica BOOLEAN
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
        p.fecha_registro,
        p.activo,
        EXISTS(SELECT 1 FROM historia_clinica hc WHERE hc.id_paciente = p.id_paciente) AS tiene_historia_clinica
    FROM paciente p
    INNER JOIN catalogo_sexo cs ON p.id_sexo = cs.id_sexo
    WHERE 
        -- Filtro por estado activo
        (p_activo IS NULL OR p.activo = p_activo)
        AND
        -- Filtro por búsqueda en nombre o DNI
        (
            p_busqueda IS NULL 
            OR p.nombre_completo ILIKE '%' || p_busqueda || '%'
            OR p.dni LIKE '%' || p_busqueda || '%'
        )
    ORDER BY p.fecha_registro DESC
    LIMIT p_limite
    OFFSET p_offset;
END;
$$;

-- Comentarios
COMMENT ON FUNCTION s_all_pacientes IS 'Lista todos los pacientes con filtros opcionales por estado activo y búsqueda por nombre o DNI. Incluye paginación.';
