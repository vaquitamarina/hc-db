------------------------------------------------------------------
-- DESCRIPCION: Procedimiento que registra un diagnostico
------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE i_diagnostico(
    IN p_id_historia UUID,
    IN p_descripcion TEXT,
    IN p_definitivo BOOLEAN DEFAULT FALSE
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO diagnostico (
        id_historia,
        descripcion,
        definitivo,
        fecha
    )
    VALUES (
        p_id_historia,
        p_descripcion,
        p_definitivo,
        CURRENT_DATE
    );

    RAISE NOTICE 'Diagnóstico registrado para historia %.', p_id_historia;

EXCEPTION
    WHEN foreign_key_violation THEN
        RAISE EXCEPTION 'La historia % no existe.', p_id_historia;
    WHEN others THEN
        RAISE EXCEPTION 'Ocurrio un error al registrar el diagnóstico: %', SQLERRM;
END;
$$;
