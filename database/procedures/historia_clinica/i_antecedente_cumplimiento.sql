------------------------------------------------------------------
-- DESCRIPCION: Procedimiento que registra los antecedentes de cumplimiento del paciente
------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE i_antecedente_cumplimiento(
    IN p_id_historia UUID,
    IN p_dentista_dolor BOOLEAN,
    IN p_frecuenca_dentista VARCHAR(100),
    IN p_higiene_oral VARCHAR(100),
    IN p_tranquilo BOOLEAN,
    IN p_nervioso BOOLEAN,
    IN p_panico BOOLEAN,
    IN p_desagrado_atencion TEXT
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO antecedente_cumplimiento (
        id_historia,
        dentista_dolor,
        frecuenca_dentista,
        higiene_oral,
        tranquilo,
        nervioso,
        panico,
        desagrado_atencion
    )
    VALUES (
        p_id_historia,
        p_dentista_dolor,
        p_frecuenca_dentista,
        p_higiene_oral,
        p_tranquilo,
        p_nervioso,
        p_panico,
        p_desagrado_atencion
    );

    RAISE NOTICE 'Antecedentes de cumplimiento registrados para historia %.', p_id_historia;

EXCEPTION
    WHEN foreign_key_violation THEN
        RAISE EXCEPTION 'La historia % no existe.', p_id_historia;
    WHEN unique_violation THEN
        RAISE EXCEPTION 'La historia % ya tiene antecedentes de cumplimiento registrados.', p_id_historia;
    WHEN others THEN
        RAISE EXCEPTION 'Ocurrio un error al registrar los antecedentes de cumplimiento: %', SQLERRM;
END;
$$;
