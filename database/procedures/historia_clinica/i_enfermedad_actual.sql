------------------------------------------------------------------
-- DESCRIPCION: Procedimiento que registra la enfermedad actual del paciente
------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE i_enfermedad_actual(
    IN p_id_historia UUID,
    IN p_sintoma_principal VARCHAR(300),
    IN p_tiempo_enfermedad VARCHAR(100),
    IN p_forma_inicio VARCHAR(200),
    IN p_curso VARCHAR(200),
    IN p_relato TEXT,
    IN p_tratamiento_prev TEXT
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO enfermedad_actual (
        id_historia,
        sintoma_principal,
        tiempo_enfermedad,
        forma_inicio,
        curso,
        relato,
        tratamiento_prev
    )
    VALUES (
        p_id_historia,
        p_sintoma_principal,
        p_tiempo_enfermedad,
        p_forma_inicio,
        p_curso,
        p_relato,
        p_tratamiento_prev
    );

    RAISE NOTICE 'Enfermedad actual registrada para historia %.', p_id_historia;

EXCEPTION
    WHEN foreign_key_violation THEN
        RAISE EXCEPTION 'La historia % no existe.', p_id_historia;
    WHEN unique_violation THEN
        RAISE EXCEPTION 'La historia % ya tiene una enfermedad actual registrada.', p_id_historia;
    WHEN others THEN
        RAISE EXCEPTION 'Ocurrio un error al registrar la enfermedad actual: %', SQLERRM;
END;
$$;
