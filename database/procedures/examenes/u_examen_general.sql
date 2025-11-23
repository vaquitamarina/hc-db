CREATE OR REPLACE PROCEDURE u_examen_general(
    IN p_id_historia UUID,
    IN p_posicion VARCHAR,
    IN p_actitud VARCHAR,
    IN p_deambulacion VARCHAR,
    IN p_facies VARCHAR,
    IN p_facies_obs TEXT,
    IN p_conciencia TEXT,
    IN p_constitucion VARCHAR,
    IN p_estado_nutritivo VARCHAR,
    IN p_temperatura VARCHAR,
    IN p_presion_arterial VARCHAR,
    IN p_frecuencia_respiratoria VARCHAR,
    IN p_pulso VARCHAR,
    IN p_peso DECIMAL,
    IN p_talla DECIMAL,
    IN p_piel_color VARCHAR,
    IN p_piel_humedad VARCHAR,
    IN p_piel_lesiones VARCHAR,
    IN p_piel_lesiones_obs TEXT,
    IN p_piel_anexos VARCHAR,
    IN p_piel_anexos_obs TEXT,
    IN p_tcs_distribucion VARCHAR,
    IN p_tcs_distribucion_obs TEXT,
    IN p_tcs_cantidad VARCHAR,
    IN p_ganglios VARCHAR,
    IN p_ganglios_obs TEXT
)
LANGUAGE plpgsql
AS $$
BEGIN
    -- Intentar actualizar (UPDATE)
    UPDATE examen_general
    SET
        posicion = p_posicion, actitud = p_actitud, deambulacion = p_deambulacion,
        facies = p_facies, facies_obs = p_facies_obs, conciencia = p_conciencia,
        constitucion = p_constitucion, estado_nutritivo = p_estado_nutritivo,
        temperatura = p_temperatura, presion_arterial = p_presion_arterial,
        frecuencia_respiratoria = p_frecuencia_respiratoria, pulso = p_pulso,
        peso = p_peso, talla = p_talla,
        piel_color = p_piel_color, piel_humedad = p_piel_humedad,
        piel_lesiones = p_piel_lesiones, piel_lesiones_obs = p_piel_lesiones_obs,
        piel_anexos = p_piel_anexos, piel_anexos_obs = p_piel_anexos_obs,
        tcs_distribucion = p_tcs_distribucion, tcs_distribucion_obs = p_tcs_distribucion_obs,
        tcs_cantidad = p_tcs_cantidad,
        ganglios = p_ganglios, ganglios_obs = p_ganglios_obs
    WHERE id_historia = p_id_historia;

    -- Si no existe, insertar (INSERT)
    IF NOT FOUND THEN
        INSERT INTO examen_general (
            id_historia, posicion, actitud, deambulacion, facies, facies_obs,
            conciencia, constitucion, estado_nutritivo, temperatura, presion_arterial,
            frecuencia_respiratoria, pulso, peso, talla,
            piel_color, piel_humedad, piel_lesiones, piel_lesiones_obs,
            piel_anexos, piel_anexos_obs, tcs_distribucion, tcs_distribucion_obs,
            tcs_cantidad, ganglios, ganglios_obs
        ) VALUES (
            p_id_historia, p_posicion, p_actitud, p_deambulacion, p_facies, p_facies_obs,
            p_conciencia, p_constitucion, p_estado_nutritivo, p_temperatura, p_presion_arterial,
            p_frecuencia_respiratoria, p_pulso, p_peso, p_talla,
            p_piel_color, p_piel_humedad, p_piel_lesiones, p_piel_lesiones_obs,
            p_piel_anexos, p_piel_anexos_obs, p_tcs_distribucion, p_tcs_distribucion_obs,
            p_tcs_cantidad, p_ganglios, p_ganglios_obs
        );
    END IF;
END;
$$;