------------------------------------------------------------------
-- DESCRIPCION: Funcion que obtiene los pacientes adultos asignados a un estudiante
-- Usado por: Sistema de Historias Clinicas - Módulo de Estudiantes
-- SN-001-2025 Proyecto Historias Clinicas - Módulo de Estudiantes, Autor: Equipo BD II - 12/10/2025
------------------------------------------------------------------
CREATE OR REPLACE FUNCTION s_paciente_adulto (p_id_estudiante uuid)
    RETURNS TABLE (
        id_paciente uuid,
        id_historia uuid,
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
        p.nombre_completo,
        p.edad,
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
        AND p.edad >= 18;
END;
$$
LANGUAGE plpgsql;

