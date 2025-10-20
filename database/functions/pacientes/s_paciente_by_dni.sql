------------------------------------------------------------------
-- FUNCTION: s_paciente_by_dni
-- DESCRIPCION: Buscar un paciente por su DNI
------------------------------------------------------------------

CREATE OR REPLACE FUNCTION s_paciente_by_dni(
    p_dni CHAR(8)
)
RETURNS TABLE (
    id_paciente UUID,
    nombre VARCHAR(200),
    apellido VARCHAR(200),
    nombre_completo VARCHAR(400),
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
    -- Validar formato de DNI
    IF NOT (p_dni ~ '^\d{8}$') THEN
        RAISE EXCEPTION 'El DNI debe tener exactamente 8 dígitos numéricos';
    END IF;

    RETURN QUERY
    SELECT 
        p.id_paciente,
        p.nombre,
        p.apellido,
        (p.nombre || ' ' || p.apellido)::VARCHAR(400) AS nombre_completo,
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
    WHERE p.dni = p_dni;
END;
$$;

-- Comentarios
COMMENT ON FUNCTION s_paciente_by_dni IS 'Busca un paciente por su DNI con validación de formato';
