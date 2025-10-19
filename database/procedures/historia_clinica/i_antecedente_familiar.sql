------------------------------------------------------------------
-- DESCRIPCION: Procedimiento que registra los antecedentes familiares del paciente
------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE i_antecedente_familiar(
    IN p_id_historia UUID,
    IN p_descripcion TEXT
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO antecedente_familiar (
        id_historia,
        descripcion
    )
    VALUES (
        p_id_historia,
        p_descripcion
    );

    RAISE NOTICE 'Antecedentes familiares registrados para historia %.', p_id_historia;

EXCEPTION
    WHEN foreign_key_violation THEN
        RAISE EXCEPTION 'La historia % no existe.', p_id_historia;
    WHEN unique_violation THEN
        RAISE EXCEPTION 'La historia % ya tiene antecedentes familiares registrados.', p_id_historia;
    WHEN others THEN
        RAISE EXCEPTION 'Ocurrio un error al registrar los antecedentes familiares: %', SQLERRM;
END;
$$;
