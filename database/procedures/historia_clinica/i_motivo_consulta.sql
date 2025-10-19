------------------------------------------------------------------
-- DESCRIPCION: Procedimiento que registra el motivo de consulta
------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE i_motivo_consulta(
    IN p_id_historia UUID,
    IN p_motivo TEXT
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO motivo_consulta (
        id_historia,
        motivo,
        fecha_registro
    )
    VALUES (
        p_id_historia,
        p_motivo,
        CURRENT_TIMESTAMP
    );

    RAISE NOTICE 'Motivo de consulta registrado para historia %.', p_id_historia;

EXCEPTION
    WHEN foreign_key_violation THEN
        RAISE EXCEPTION 'La historia % no existe.', p_id_historia;
    WHEN others THEN
        RAISE EXCEPTION 'Ocurrio un error al registrar el motivo de consulta: %', SQLERRM;
END;
$$;
