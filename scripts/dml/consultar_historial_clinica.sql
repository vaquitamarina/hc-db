CREATE OR REPLACE FUNCTION consultar_historia_clinica(p_id_historia UUID)
RETURNS TABLE (
    id_historia UUID,
    fecha_creacion TIMESTAMP,
    nombre_paciente VARCHAR,
    apellido_paciente VARCHAR,
    dni_paciente VARCHAR,
    nombre_alumno VARCHAR,
    apellido_alumno VARCHAR
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        h.id_historia,
        h.fecha_creacion,
        p.nombre AS nombre_paciente,
        p.apellido AS apellido_paciente,
        p.dni AS dni_paciente,
        u.nombre AS nombre_alumno,
        u.apellido AS apellido_alumno
    FROM historias_clinicas h
    INNER JOIN pacientes p ON h.id_paciente = p.id_paciente
    INNER JOIN usuarios u ON h.id_alumno = u.id_usuario
    WHERE h.id_historia = p_id_historia;
END;
$$ LANGUAGE plpgsql;
