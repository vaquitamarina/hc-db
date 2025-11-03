------------------------------------------------------------------
-- FUNCTION: fn_obtener_paciente_por_historia
-- DESCRIPCION: Obtiene los datos del paciente asociado a una historia clínica
-- PROYECTO: SN-001-2025 - Sistema de Historias Clínicas
-- AUTOR: Equipo BD II - ESIS UNJBG
-- FECHA: 26/10/2025
------------------------------------------------------------------
DROP FUNCTION IF EXISTS fn_obtener_paciente_por_historia;

CREATE OR REPLACE FUNCTION fn_obtener_paciente_por_historia(
    p_id_historia UUID
)
RETURNS TABLE (
    id_paciente UUID,
    dni CHAR(8),
    nombre VARCHAR(200),
    apellido VARCHAR(200),
    fecha_nacimiento DATE,
    edad INTEGER,
    sexo VARCHAR(20),
    telefono VARCHAR(20),
    email VARCHAR(200),
    fecha_registro TIMESTAMP,
    activo BOOLEAN
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT 
        p.id_paciente,
        p.dni,
        p.nombre,
        p.apellido,
        p.fecha_nacimiento,
        EXTRACT(YEAR FROM AGE(CURRENT_DATE, p.fecha_nacimiento))::INTEGER AS edad,
        cs.descripcion AS sexo,
        p.telefono,
        p.email,
        p.fecha_registro,
        p.activo
    FROM historia_clinica hc
    INNER JOIN paciente p ON hc.id_paciente = p.id_paciente
    LEFT JOIN catalogo_sexo cs ON p.id_sexo = cs.id_sexo
    WHERE hc.id_historia = p_id_historia;
    
    -- Si no se encuentra, devolver vacío (no error)
    IF NOT FOUND THEN
        RAISE NOTICE 'No se encontró paciente para la historia %', p_id_historia;
    END IF;
END;
$$;

COMMENT ON FUNCTION fn_obtener_paciente_por_historia IS 'Retorna los datos completos del paciente asociado a una historia clínica. Devuelve NULL si la historia no tiene paciente asignado.';
