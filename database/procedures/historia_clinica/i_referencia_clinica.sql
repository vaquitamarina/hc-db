------------------------------------------------------------------
-- DESCRIPCION: Procedimiento que registra una referencia a clinica especializada
------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE i_referencia_clinica(
    IN p_id_historia UUID,
    IN p_clinica_desc VARCHAR(100),
    IN p_observaciones TEXT
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_id_clinica UUID;
BEGIN
    -- Buscar UUID de la clínica
    SELECT id_clinica INTO v_id_clinica 
    FROM catalogo_clinica 
    WHERE descripcion = p_clinica_desc;
    
    IF v_id_clinica IS NULL THEN
        RAISE EXCEPTION 'Clínica "%" no encontrada en catálogo', p_clinica_desc;
    END IF;

    INSERT INTO referencia_clinica (
        id_historia,
        id_clinica,
        observaciones,
        fecha,
        estado
    )
    VALUES (
        p_id_historia,
        v_id_clinica,
        p_observaciones,
        CURRENT_DATE,
        'pendiente'
    );

    RAISE NOTICE 'Referencia clínica registrada para historia %.', p_id_historia;

EXCEPTION
    WHEN foreign_key_violation THEN
        RAISE EXCEPTION 'La historia % no existe o la clínica no es válida.', p_id_historia;
    WHEN others THEN
        RAISE EXCEPTION 'Ocurrio un error al registrar la referencia clínica: %', SQLERRM;
END;
$$;
