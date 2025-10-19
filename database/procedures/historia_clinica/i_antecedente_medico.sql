------------------------------------------------------------------
-- DESCRIPCION: Procedimiento que registra los antecedentes medicos del paciente
------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE i_antecedente_medico(
    IN p_id_historia UUID,
    IN p_salud_general VARCHAR(50),
    IN p_bajo_tratamiento BOOLEAN,
    IN p_tipo_tratamiento VARCHAR(200),
    IN p_hospitalizaciones TEXT,
    IN p_traumatismos TEXT,
    IN p_alergias TEXT,
    IN p_medicamentos_contraindicados TEXT,
    IN p_odontologicos TEXT
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO antecedente_medico (
        id_historia,
        salud_general,
        bajo_tratamiento,
        tipo_tratamiento,
        hospitalizaciones,
        traumatismos,
        alergias,
        medicamentos_contraindicados,
        odontologicos
    )
    VALUES (
        p_id_historia,
        p_salud_general,
        p_bajo_tratamiento,
        p_tipo_tratamiento,
        p_hospitalizaciones,
        p_traumatismos,
        p_alergias,
        p_medicamentos_contraindicados,
        p_odontologicos
    );

    RAISE NOTICE 'Antecedentes médicos registrados para historia %.', p_id_historia;

EXCEPTION
    WHEN foreign_key_violation THEN
        RAISE EXCEPTION 'La historia % no existe.', p_id_historia;
    WHEN unique_violation THEN
        RAISE EXCEPTION 'La historia % ya tiene antecedentes médicos registrados.', p_id_historia;
    WHEN others THEN
        RAISE EXCEPTION 'Ocurrio un error al registrar los antecedentes médicos: %', SQLERRM;
END;
$$;
