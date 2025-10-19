------------------------------------------------------------------
-- DESCRIPCION: Procedimiento que registra la evolucion del tratamiento
------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE i_evolucion(
    IN p_id_historia UUID,
    IN p_actividad TEXT,
    IN p_alumno VARCHAR(200),
    IN p_observaciones TEXT
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO evolucion (
        id_historia,
        fecha,
        actividad,
        alumno,
        observaciones
    )
    VALUES (
        p_id_historia,
        CURRENT_DATE,
        p_actividad,
        p_alumno,
        p_observaciones
    );

    RAISE NOTICE 'Evolución registrada para historia %.', p_id_historia;

EXCEPTION
    WHEN foreign_key_violation THEN
        RAISE EXCEPTION 'La historia % no existe.', p_id_historia;
    WHEN others THEN
        RAISE EXCEPTION 'Ocurrio un error al registrar la evolución: %', SQLERRM;
END;
$$;
