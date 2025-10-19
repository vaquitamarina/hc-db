------------------------------------------------------------------
-- DESCRIPCION: Procedimiento que registra un examen auxiliar solicitado
------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE i_examen_auxiliar(
    IN p_id_historia UUID,
    IN p_examen_desc VARCHAR(100),
    IN p_detalle VARCHAR(200)
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_id_examen UUID;
BEGIN
    -- Buscar UUID del examen auxiliar
    SELECT id_examen INTO v_id_examen 
    FROM catalogo_examen_auxiliar 
    WHERE descripcion = p_examen_desc;
    
    IF v_id_examen IS NULL THEN
        RAISE EXCEPTION 'Examen auxiliar "%" no encontrado en catálogo', p_examen_desc;
    END IF;

    INSERT INTO examen_auxiliar (
        id_historia,
        id_examen,
        detalle,
        fecha_solicitud
    )
    VALUES (
        p_id_historia,
        v_id_examen,
        p_detalle,
        CURRENT_TIMESTAMP
    );

    RAISE NOTICE 'Examen auxiliar registrado para historia %.', p_id_historia;

EXCEPTION
    WHEN foreign_key_violation THEN
        RAISE EXCEPTION 'La historia % no existe o el examen no es válido.', p_id_historia;
    WHEN others THEN
        RAISE EXCEPTION 'Ocurrio un error al registrar el examen auxiliar: %', SQLERRM;
END;
$$;
