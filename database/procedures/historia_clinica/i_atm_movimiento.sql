------------------------------------------------------------------
-- DESCRIPCION: Procedimiento que registra un movimiento mandibular en el examen ATM
------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE i_atm_movimiento(
    IN p_id_examen_atm UUID,
    IN p_movimiento_desc VARCHAR(50),
    IN p_dolor BOOLEAN,
    IN p_ruido BOOLEAN,
    IN p_salto BOOLEAN
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_id_movimiento UUID;
BEGIN
    -- Buscar UUID del movimiento mandibular
    SELECT id_movimiento INTO v_id_movimiento 
    FROM catalogo_movimiento_mandibular 
    WHERE descripcion = p_movimiento_desc;
    
    IF v_id_movimiento IS NULL THEN
        RAISE EXCEPTION 'Movimiento mandibular "%" no encontrado en catálogo', p_movimiento_desc;
    END IF;

    INSERT INTO atm_movimiento_condicion (
        id_examen_atm,
        id_movimiento,
        dolor,
        ruido,
        salto
    )
    VALUES (
        p_id_examen_atm,
        v_id_movimiento,
        p_dolor,
        p_ruido,
        p_salto
    );

    RAISE NOTICE 'Movimiento ATM registrado para examen %.', p_id_examen_atm;

EXCEPTION
    WHEN foreign_key_violation THEN
        RAISE EXCEPTION 'El examen ATM % no existe o el movimiento no es válido.', p_id_examen_atm;
    WHEN unique_violation THEN
        RAISE EXCEPTION 'El movimiento "%" ya fue registrado para este examen ATM.', p_movimiento_desc;
    WHEN others THEN
        RAISE EXCEPTION 'Ocurrio un error al registrar el movimiento ATM: %', SQLERRM;
END;
$$;
