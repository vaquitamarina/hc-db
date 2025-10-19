------------------------------------------------------------------
-- DESCRIPCION: Procedimiento que registra el examen regional (cabeza y cuello)
------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE i_examen_regional(
    IN p_id_historia UUID,
    IN p_craneo_forma_desc VARCHAR(50),
    IN p_cara_forma_desc VARCHAR(50),
    IN p_perfil_ap_desc VARCHAR(50),
    IN p_ojos_cejas_adecuada BOOLEAN,
    IN p_ojos_implantacion_obs TEXT,
    IN p_escleroticas VARCHAR(100),
    IN p_agudeza_visual_conservada BOOLEAN,
    IN p_iris_color VARCHAR(50),
    IN p_arco_senil VARCHAR(50),
    IN p_nariz_forma VARCHAR(100),
    IN p_nariz_permeables BOOLEAN,
    IN p_nariz_secreciones BOOLEAN,
    IN p_senos_paranasales_dolorosos BOOLEAN,
    IN p_oidos_anomalias_morfologicas BOOLEAN,
    IN p_oidos_anomalias_obs TEXT,
    IN p_oidos_secreciones BOOLEAN,
    IN p_audicion_conservada BOOLEAN,
    IN p_cuello_simetrico BOOLEAN,
    IN p_cuello_simetrico_obs TEXT,
    IN p_cuello_movilidad_conservada BOOLEAN,
    IN p_cuello_movilidad_obs TEXT,
    IN p_laringe_alineada BOOLEAN,
    IN p_laringe_alineada_obs TEXT,
    IN p_cuello_otros TEXT
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_id_craneo_forma UUID;
    v_id_cara_forma UUID;
    v_id_perfil_ap UUID;
BEGIN
    -- Buscar UUIDs de catálogos de medidas regionales
    IF p_craneo_forma_desc IS NOT NULL THEN
        SELECT id_medida INTO v_id_craneo_forma 
        FROM catalogo_medida_regional 
        WHERE tipo_medida = 'craneo_forma' AND descripcion = p_craneo_forma_desc;
    END IF;

    IF p_cara_forma_desc IS NOT NULL THEN
        SELECT id_medida INTO v_id_cara_forma 
        FROM catalogo_medida_regional 
        WHERE tipo_medida = 'cara_forma' AND descripcion = p_cara_forma_desc;
    END IF;

    IF p_perfil_ap_desc IS NOT NULL THEN
        SELECT id_medida INTO v_id_perfil_ap 
        FROM catalogo_medida_regional 
        WHERE tipo_medida = 'perfil_ap' AND descripcion = p_perfil_ap_desc;
    END IF;

    INSERT INTO examen_regional (
        id_historia,
        id_craneo_forma,
        id_cara_forma,
        id_perfil_ap,
        ojos_cejas_adecuada,
        ojos_implantacion_obs,
        escleroticas,
        agudeza_visual_conservada,
        iris_color,
        arco_senil,
        nariz_forma,
        nariz_permeables,
        nariz_secreciones,
        senos_paranasales_dolorosos,
        oidos_anomalias_morfologicas,
        oidos_anomalias_obs,
        oidos_secreciones,
        audicion_conservada,
        cuello_simetrico,
        cuello_simetrico_obs,
        cuello_movilidad_conservada,
        cuello_movilidad_obs,
        laringe_alineada,
        laringe_alineada_obs,
        cuello_otros
    )
    VALUES (
        p_id_historia,
        v_id_craneo_forma,
        v_id_cara_forma,
        v_id_perfil_ap,
        p_ojos_cejas_adecuada,
        p_ojos_implantacion_obs,
        p_escleroticas,
        p_agudeza_visual_conservada,
        p_iris_color,
        p_arco_senil,
        p_nariz_forma,
        p_nariz_permeables,
        p_nariz_secreciones,
        p_senos_paranasales_dolorosos,
        p_oidos_anomalias_morfologicas,
        p_oidos_anomalias_obs,
        p_oidos_secreciones,
        p_audicion_conservada,
        p_cuello_simetrico,
        p_cuello_simetrico_obs,
        p_cuello_movilidad_conservada,
        p_cuello_movilidad_obs,
        p_laringe_alineada,
        p_laringe_alineada_obs,
        p_cuello_otros
    );

    RAISE NOTICE 'Examen regional registrado para historia %.', p_id_historia;

EXCEPTION
    WHEN foreign_key_violation THEN
        RAISE EXCEPTION 'La historia % no existe o algún catálogo referenciado no es válido.', p_id_historia;
    WHEN unique_violation THEN
        RAISE EXCEPTION 'La historia % ya tiene un examen regional registrado.', p_id_historia;
    WHEN others THEN
        RAISE EXCEPTION 'Ocurrio un error al registrar el examen regional: %', SQLERRM;
END;
$$;
