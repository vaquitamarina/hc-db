CREATE OR REPLACE PROCEDURE i_revision_historia(
    IN p_id_historia UUID,
    IN p_id_docente UUID,
    IN p_id_estado_revision UUID,
    IN p_observacion TEXT
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO revisiones_historia (id_historia, id_docente,id_estado_revision, observaciones)
    VALUES (p_id_historia, p_id_docente,p_id_estado_revision, p_observacion);

    RAISE NOTICE 'Revision de historia registrada exitosamente para historia % por docente %.', p_id_historia, p_id_docente;

EXCEPTION
    WHEN foreign_key_violation THEN
        RAISE EXCEPTION 'El id_historia % o el id_docente % no existen.', p_id_historia, p_id_docente;
    WHEN others THEN
        RAISE EXCEPTION 'Ocurrio un error al registrar la revision: %', SQLERRM;
END;
$$;

