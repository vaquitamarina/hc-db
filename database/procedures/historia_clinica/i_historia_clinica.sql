------------------------------------------------------------------
-- DESCRIPCION: Funcion que registra una nueva historia clinica y retorna su ID
-- Usado por: Sistema de Historias Clinicas - Módulo de Historia Clinica
-- SN-001-2025 Proyecto Historias Clinicas - Módulo de Historia Clinica, Autor: Equipo BD II - 12/10/2025
------------------------------------------------------------------
CREATE OR REPLACE FUNCTION i_historia_clinica (p_id_estudiante uuid)
    RETURNS uuid
    AS $$
DECLARE
    v_id_historia_clinica uuid;
BEGIN
    INSERT INTO historia_clinica (id_estudiante)
        VALUES (p_id_estudiante)
    RETURNING
        id_historia INTO v_id_historia_clinica;
    RETURN v_id_historia_clinica;
END;
$$
LANGUAGE plpgsql;

