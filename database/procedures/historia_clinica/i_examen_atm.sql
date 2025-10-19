------------------------------------------------------------------
-- DESCRIPCION: Procedimiento que registra el examen de ATM
------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE i_examen_atm(
    IN p_id_historia UUID,
    IN p_trayectoria_desc VARCHAR(50),
    IN p_coordinacion_condilar BOOLEAN,
    IN p_apertura_maxima_mm NUMERIC(5, 2),
    IN p_observaciones TEXT,
    IN p_musculos_dolor_presente BOOLEAN,
    IN p_dolor_grado_desc VARCHAR(50),
    IN p_musculos_dolor_zona TEXT
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_id_trayectoria UUID;
    v_id_dolor_grado UUID;
BEGIN
    -- Buscar UUID de trayectoria
    IF p_trayectoria_desc IS NOT NULL THEN
        SELECT id_trayectoria INTO v_id_trayectoria 
        FROM catalogo_atm_trayectoria 
        WHERE descripcion = p_trayectoria_desc;
        
        IF v_id_trayectoria IS NULL THEN
            RAISE EXCEPTION 'Trayectoria ATM "%" no encontrada en catálogo', p_trayectoria_desc;
        END IF;
    END IF;

    -- Buscar UUID de grado de dolor
    IF p_dolor_grado_desc IS NOT NULL THEN
        SELECT id_grado INTO v_id_dolor_grado 
        FROM catalogo_dolor_grado 
        WHERE descripcion = p_dolor_grado_desc;
        
        IF v_id_dolor_grado IS NULL THEN
            RAISE EXCEPTION 'Grado de dolor "%" no encontrado en catálogo', p_dolor_grado_desc;
        END IF;
    END IF;

    INSERT INTO examen_atm (
        id_historia,
        id_trayectoria,
        coordinacion_condilar,
        apertura_maxima_mm,
        observaciones,
        musculos_dolor_presente,
        id_musculos_dolor_grado,
        musculos_dolor_zona
    )
    VALUES (
        p_id_historia,
        v_id_trayectoria,
        p_coordinacion_condilar,
        p_apertura_maxima_mm,
        p_observaciones,
        p_musculos_dolor_presente,
        v_id_dolor_grado,
        p_musculos_dolor_zona
    );

    RAISE NOTICE 'Examen ATM registrado para historia %.', p_id_historia;

EXCEPTION
    WHEN foreign_key_violation THEN
        RAISE EXCEPTION 'La historia % no existe o algún catálogo referenciado no es válido.', p_id_historia;
    WHEN unique_violation THEN
        RAISE EXCEPTION 'La historia % ya tiene un examen ATM registrado.', p_id_historia;
    WHEN others THEN
        RAISE EXCEPTION 'Ocurrio un error al registrar el examen ATM: %', SQLERRM;
END;
$$;
