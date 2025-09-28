CREATE OR REPLACE FUNCTION fn_obtener_paciente_adulto(p_id_estudiante UUID)
RETURNS TABLE (
    id_paciente UUID,
    nombre_completo VARCHAR,
    ultima_modificacion TIMESTAMP
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        p.id_paciente,
        p.nombre_completo,
        h.ultima_modificacion
    FROM historia_clinica h
    INNER JOIN paciente p ON h.id_paciente = p.id_paciente
    WHERE h.id_estudiante = p_id_estudiante
      AND p.edad >= 18;
END;
$$ LANGUAGE plpgsql;

