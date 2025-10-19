------------------------------------------------------------------
-- DESCRIPCION: Procedimiento que registra el examen fisico general
------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE i_examen_general(
    IN p_id_historia UUID,
    IN p_posicion_desc VARCHAR(50),
    IN p_actitud BOOLEAN,
    IN p_deambulacion UUID,
    IN p_facies VARCHAR(100),
    IN p_conciencia TEXT,
    IN p_constitucion VARCHAR(50),
    IN p_estado_nutritivo VARCHAR(50),
    IN p_temperatura VARCHAR(50),
    IN p_presion_arterial VARCHAR(50),
    IN p_frecuencia_respiratoria VARCHAR(50),
    IN p_pulso VARCHAR(50),
    IN p_peso DECIMAL(5, 2),
    IN p_talla DECIMAL(5, 2),
    IN p_observaciones TEXT
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_id_posicion UUID;
BEGIN
    -- Buscar UUID de posición si se proporciona
    IF p_posicion_desc IS NOT NULL THEN
        SELECT id_posicion INTO v_id_posicion 
        FROM catalogo_posicion 
        WHERE posicion = p_posicion_desc;
        
        IF v_id_posicion IS NULL THEN
            RAISE EXCEPTION 'Posición "%" no encontrada en catálogo', p_posicion_desc;
        END IF;
    END IF;

    INSERT INTO examen_general (
        id_historia,
        id_posicion,
        actitud,
        deambulacion,
        facies,
        conciencia,
        constitucion,
        estado_nutritivo,
        temperatura,
        presion_arterial,
        frecuencia_respiratoria,
        pulso,
        peso,
        talla,
        observaciones
    )
    VALUES (
        p_id_historia,
        v_id_posicion,
        p_actitud,
        p_deambulacion,
        p_facies,
        p_conciencia,
        p_constitucion,
        p_estado_nutritivo,
        p_temperatura,
        p_presion_arterial,
        p_frecuencia_respiratoria,
        p_pulso,
        p_peso,
        p_talla,
        p_observaciones
    );

    RAISE NOTICE 'Examen general registrado para historia %.', p_id_historia;

EXCEPTION
    WHEN foreign_key_violation THEN
        RAISE EXCEPTION 'La historia % no existe o algún catálogo referenciado no es válido.', p_id_historia;
    WHEN unique_violation THEN
        RAISE EXCEPTION 'La historia % ya tiene un examen general registrado.', p_id_historia;
    WHEN others THEN
        RAISE EXCEPTION 'Ocurrio un error al registrar el examen general: %', SQLERRM;
END;
$$;
