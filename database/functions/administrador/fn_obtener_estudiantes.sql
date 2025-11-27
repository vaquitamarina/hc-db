------------------------------------------------------------------
-- DESCRIPCION: Obtiene todos los estudiantes del sistema con información resumida
------------------------------------------------------------------

CREATE OR REPLACE FUNCTION fn_obtener_estudiantes(
    p_activo BOOLEAN DEFAULT NULL,
    p_busqueda VARCHAR(200) DEFAULT NULL
)
RETURNS TABLE (
    id_usuario UUID,
    codigo_usuario VARCHAR(100),
    nombre VARCHAR(200),
    apellido VARCHAR(200),
    nombre_completo VARCHAR(400),
    dni CHAR(8),
    email VARCHAR(200),
    activo BOOLEAN,
    total_historias_asignadas BIGINT
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT 
        u.id_usuario,
        u.codigo_usuario,
        u.nombre,
        u.apellido,
        (u.nombre || ' ' || u.apellido)::VARCHAR(400) AS nombre_completo,
        u.dni,
        u.email,
        u.activo,
        COUNT(hc.id_historia) AS total_historias_asignadas
    FROM usuario u
    LEFT JOIN historia_clinica hc ON u.id_usuario = hc.id_estudiante
    WHERE 
        u.rol = 'estudiante'
        AND (p_activo IS NULL OR u.activo = p_activo)
        AND (
            p_busqueda IS NULL 
            OR u.nombre ILIKE '%' || p_busqueda || '%'
            OR u.apellido ILIKE '%' || p_busqueda || '%'
            OR (u.nombre || ' ' || u.apellido) ILIKE '%' || p_busqueda || '%'
            OR u.codigo_usuario ILIKE '%' || p_busqueda || '%'
            OR u.dni LIKE '%' || p_busqueda || '%'
        )
    GROUP BY 
        u.id_usuario,
        u.codigo_usuario,
        u.nombre,
        u.apellido,
        u.dni,
        u.email,
        u.activo
    ORDER BY u.apellido, u.nombre;
END;
$$;

COMMENT ON FUNCTION fn_obtener_estudiantes IS 'Obtiene todos los estudiantes con filtros opcionales por estado activo y búsqueda por nombre, apellido, código o DNI. Incluye conteo de historias clínicas asignadas.';
