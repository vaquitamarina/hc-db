CREATE OR REPLACE FUNCTION fn_registrar_historia_clinica (p_id_estudiante uuid)
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

