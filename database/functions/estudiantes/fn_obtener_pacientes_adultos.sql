------------------------------------------------------------------
-- DESCRIPCION: Funcion que obtiene los pacientes adultos asignados a un estudiante
------------------------------------------------------------------
CREATE OR REPLACE FUNCTION fn_obtener_pacientes_adultos (p_id_estudiante uuid)
    RETURNS TABLE (
        id_paciente uuid,
        id_historia uuid,
        nombre varchar,
        apellido varchar,
        nombre_completo varchar,
        edad int,
        telefono varchar,
        email varchar,
        sexo varchar,
        ultima_modificacion timestamp
    )
    AS $$
BEGIN
    RETURN QUERY
    SELECT
        p.id_paciente,
        h.id_historia,
        p.nombre,
        p.apellido,
        (p.nombre || ' ' || p.apellido)::VARCHAR AS nombre_completo,
        EXTRACT(YEAR FROM AGE(CURRENT_DATE, p.fecha_nacimiento))::INT AS edad,
        p.telefono,
        p.email,
        s.descripcion AS sexo,
        h.ultima_modificacion
    FROM
        historia_clinica h
        INNER JOIN paciente p ON h.id_paciente = p.id_paciente
        LEFT JOIN catalogo_sexo s ON p.id_sexo = s.id_sexo
    WHERE
        h.id_estudiante = p_id_estudiante
        AND EXTRACT(YEAR FROM AGE(CURRENT_DATE, p.fecha_nacimiento))::INT >= 18;
END;
$$
LANGUAGE plpgsql;

