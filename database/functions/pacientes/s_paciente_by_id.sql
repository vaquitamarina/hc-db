------------------------------------------------------------------
-- FUNCTION: s_paciente_by_id
-- DESCRIPCION: Obtener datos completos de un paciente por su ID
-- PROYECTO: SN-001-2025 - Sistema de Historias Clínicas
-- AUTOR: Equipo BD II - ESIS UNJBG
-- FECHA: 13/10/2025
------------------------------------------------------------------

CREATE OR REPLACE FUNCTION s_paciente_by_id(
    p_id_paciente UUID
)
RETURNS TABLE (
    id_paciente UUID,
    nombre_completo VARCHAR(200),
    dni CHAR(8),
    fecha_nacimiento DATE,
    edad INT,
    id_sexo UUID,
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
        p.id_sexo,
        cs.descripcion AS sexo_descripcion,
        p.telefono,
        p.email,
        p.fecha_registro,
        p.activo,
        EXISTS(SELECT 1 FROM historia_clinica hc WHERE hc.id_paciente = p.id_paciente) AS tiene_historia_clinica
    FROM paciente p
    INNER JOIN catalogo_sexo cs ON p.id_sexo = cs.id_sexo
    WHERE p.id_paciente = p_id_paciente;
    
    IF NOT FOUND THEN
        RAISE EXCEPTION 'No se encontró un paciente con el ID proporcionado';
    END IF;
END;
$$;

-- Comentarios
COMMENT ON FUNCTION s_paciente_by_id IS 'Obtiene los datos completos de un paciente por su ID, incluyendo edad calculada y descripción del sexo';
