CREATE OR REPLACE PROCEDURE u_examen_regional(
    IN p_id_historia UUID,
    -- Cabeza
    IN p_cabeza_posicion VARCHAR, IN p_cabeza_movimientos VARCHAR, IN p_cabeza_movimientos_obs TEXT,
    IN p_craneo_tamano VARCHAR, IN p_craneo_forma VARCHAR,
    IN p_cara_forma_frente VARCHAR, IN p_cara_forma_perfil VARCHAR,
    -- Ojos
    IN p_ojos_cejas_adecuada BOOLEAN, IN p_ojos_implantacion_obs TEXT, IN p_ojos_escleroticas VARCHAR,
    IN p_ojos_agudeza_visual BOOLEAN, IN p_ojos_iris_color VARCHAR, IN p_ojos_arco_senil BOOLEAN,
    -- Nariz
    IN p_nariz_forma VARCHAR, IN p_nariz_permeables BOOLEAN, IN p_nariz_secreciones BOOLEAN, IN p_nariz_senos_dolorosos BOOLEAN,
    -- Oídos
    IN p_oidos_anomalias_morfologicas BOOLEAN, IN p_oidos_anomalias_obs TEXT, IN p_oidos_secreciones BOOLEAN, IN p_oidos_audicion_conservada BOOLEAN,
    -- ATM (Nuevos campos)
    IN p_atm_trayectoria VARCHAR,
    IN p_atm_lat_izq_dolor BOOLEAN, IN p_atm_lat_izq_ruido BOOLEAN, IN p_atm_lat_izq_salto BOOLEAN,
    IN p_atm_lat_der_dolor BOOLEAN, IN p_atm_lat_der_ruido BOOLEAN, IN p_atm_lat_der_salto BOOLEAN,
    IN p_atm_prot_dolor BOOLEAN, IN p_atm_prot_ruido BOOLEAN, IN p_atm_prot_salto BOOLEAN,
    IN p_atm_aper_dolor BOOLEAN, IN p_atm_aper_ruido BOOLEAN, IN p_atm_aper_salto BOOLEAN,
    IN p_atm_cierre_dolor BOOLEAN, IN p_atm_cierre_ruido BOOLEAN, IN p_atm_cierre_salto BOOLEAN,
    IN p_atm_coordinacion_condilar BOOLEAN, IN p_atm_apertura_maxima_mm NUMERIC, IN p_atm_observaciones TEXT,
    IN p_atm_musculos_dolor BOOLEAN, IN p_atm_musculos_dolor_grado VARCHAR, IN p_atm_musculos_dolor_zona TEXT,
    -- Cuello
    IN p_cuello_simetrico BOOLEAN, IN p_cuello_simetrico_obs TEXT,
    IN p_cuello_movilidad_conservada BOOLEAN, IN p_cuello_movilidad_obs TEXT,
    IN p_laringe_alineada BOOLEAN, IN p_laringe_alineada_obs TEXT, IN p_cuello_otros TEXT
)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE examen_regional
    SET
        cabeza_posicion = p_cabeza_posicion, cabeza_movimientos = p_cabeza_movimientos, cabeza_movimientos_obs = p_cabeza_movimientos_obs,
        craneo_tamano = p_craneo_tamano, craneo_forma = p_craneo_forma, cara_forma_frente = p_cara_forma_frente, cara_forma_perfil = p_cara_forma_perfil,
        ojos_cejas_adecuada = p_ojos_cejas_adecuada, ojos_implantacion_obs = p_ojos_implantacion_obs, ojos_escleroticas = p_ojos_escleroticas,
        ojos_agudeza_visual = p_ojos_agudeza_visual, ojos_iris_color = p_ojos_iris_color, ojos_arco_senil = p_ojos_arco_senil,
        nariz_forma = p_nariz_forma, nariz_permeables = p_nariz_permeables, nariz_secreciones = p_nariz_secreciones, nariz_senos_dolorosos = p_nariz_senos_dolorosos,
        oidos_anomalias_morfologicas = p_oidos_anomalias_morfologicas, oidos_anomalias_obs = p_oidos_anomalias_obs, oidos_secreciones = p_oidos_secreciones, oidos_audicion_conservada = p_oidos_audicion_conservada,
        -- ATM
        atm_trayectoria = p_atm_trayectoria,
        atm_lat_izq_dolor = p_atm_lat_izq_dolor, atm_lat_izq_ruido = p_atm_lat_izq_ruido, atm_lat_izq_salto = p_atm_lat_izq_salto,
        atm_lat_der_dolor = p_atm_lat_der_dolor, atm_lat_der_ruido = p_atm_lat_der_ruido, atm_lat_der_salto = p_atm_lat_der_salto,
        atm_prot_dolor = p_atm_prot_dolor, atm_prot_ruido = p_atm_prot_ruido, atm_prot_salto = p_atm_prot_salto,
        atm_aper_dolor = p_atm_aper_dolor, atm_aper_ruido = p_atm_aper_ruido, atm_aper_salto = p_atm_aper_salto,
        atm_cierre_dolor = p_atm_cierre_dolor, atm_cierre_ruido = p_atm_cierre_ruido, atm_cierre_salto = p_atm_cierre_salto,
        atm_coordinacion_condilar = p_atm_coordinacion_condilar, atm_apertura_maxima_mm = p_atm_apertura_maxima_mm, atm_observaciones = p_atm_observaciones,
        atm_musculos_dolor = p_atm_musculos_dolor, atm_musculos_dolor_grado = p_atm_musculos_dolor_grado, atm_musculos_dolor_zona = p_atm_musculos_dolor_zona,
        -- Cuello
        cuello_simetrico = p_cuello_simetrico, cuello_simetrico_obs = p_cuello_simetrico_obs,
        cuello_movilidad_conservada = p_cuello_movilidad_conservada, cuello_movilidad_obs = p_cuello_movilidad_obs,
        laringe_alineada = p_laringe_alineada, laringe_alineada_obs = p_laringe_alineada_obs, cuello_otros = p_cuello_otros
    WHERE id_historia = p_id_historia;

    IF NOT FOUND THEN
        INSERT INTO examen_regional (
            id_historia, cabeza_posicion, cabeza_movimientos, cabeza_movimientos_obs, craneo_tamano, craneo_forma, cara_forma_frente, cara_forma_perfil,
            ojos_cejas_adecuada, ojos_implantacion_obs, ojos_escleroticas, ojos_agudeza_visual, ojos_iris_color, ojos_arco_senil,
            nariz_forma, nariz_permeables, nariz_secreciones, nariz_senos_dolorosos,
            oidos_anomalias_morfologicas, oidos_anomalias_obs, oidos_secreciones, oidos_audicion_conservada,
            atm_trayectoria,
            atm_lat_izq_dolor, atm_lat_izq_ruido, atm_lat_izq_salto,
            atm_lat_der_dolor, atm_lat_der_ruido, atm_lat_der_salto,
            atm_prot_dolor, atm_prot_ruido, atm_prot_salto,
            atm_aper_dolor, atm_aper_ruido, atm_aper_salto,
            atm_cierre_dolor, atm_cierre_ruido, atm_cierre_salto,
            atm_coordinacion_condilar, atm_apertura_maxima_mm, atm_observaciones,
            atm_musculos_dolor, atm_musculos_dolor_grado, atm_musculos_dolor_zona,
            cuello_simetrico, cuello_simetrico_obs, cuello_movilidad_conservada, cuello_movilidad_obs,
            laringe_alineada, laringe_alineada_obs, cuello_otros
        ) VALUES (
            p_id_historia, p_cabeza_posicion, p_cabeza_movimientos, p_cabeza_movimientos_obs, p_craneo_tamano, p_craneo_forma, p_cara_forma_frente, p_cara_forma_perfil,
            p_ojos_cejas_adecuada, p_ojos_implantacion_obs, p_ojos_escleroticas, p_ojos_agudeza_visual, p_ojos_iris_color, p_ojos_arco_senil,
            p_nariz_forma, p_nariz_permeables, p_nariz_secreciones, p_nariz_senos_dolorosos,
            p_oidos_anomalias_morfologicas, p_oidos_anomalias_obs, p_oidos_secreciones, p_oidos_audicion_conservada,
            p_atm_trayectoria,
            p_atm_lat_izq_dolor, p_atm_lat_izq_ruido, p_atm_lat_izq_salto,
            p_atm_lat_der_dolor, p_atm_lat_der_ruido, p_atm_lat_der_salto,
            p_atm_prot_dolor, p_atm_prot_ruido, p_atm_prot_salto,
            p_atm_aper_dolor, p_atm_aper_ruido, p_atm_aper_salto,
            p_atm_cierre_dolor, p_atm_cierre_ruido, p_atm_cierre_salto,
            p_atm_coordinacion_condilar, p_atm_apertura_maxima_mm, p_atm_observaciones,
            p_atm_musculos_dolor, p_atm_musculos_dolor_grado, p_atm_musculos_dolor_zona,
            p_cuello_simetrico, p_cuello_simetrico_obs, p_cuello_movilidad_conservada, p_cuello_movilidad_obs,
            p_laringe_alineada, p_laringe_alineada_obs, p_cuello_otros
        );
    END IF;
END;
$$;