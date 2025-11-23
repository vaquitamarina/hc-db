------------------------------------------------------------------
-- PROCEDIMIENTO: u_filiacion
-- DESCRIPCION: Actualiza los datos de filiación de una historia clínica
--              Maneja la búsqueda de IDs de catálogos por descripción.
------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE u_filiacion(
    IN p_id_historia UUID,
    IN p_raza VARCHAR(100),
    IN p_fecha_nacimiento DATE,
    IN p_lugar VARCHAR(150),
    IN p_estado_civil_desc VARCHAR(50),
    IN p_nombre_conyuge VARCHAR(200),
    IN p_ocupacion_desc VARCHAR(100),
    IN p_lugar_procedencia VARCHAR(150),
    IN p_tiempo_residencia_tacna VARCHAR(50),
    IN p_direccion VARCHAR(200),
    IN p_grado_instruccion_desc VARCHAR(100),
    IN p_ultima_visita_dentista DATE,
    IN p_motivo_visita_dentista VARCHAR(300),
    IN p_ultima_visita_medico DATE,
    IN p_motivo_visita_medico VARCHAR(300),
    IN p_contacto_emergencia VARCHAR(200),
    IN p_telefono_emergencia VARCHAR(20),
    IN p_acompaniante VARCHAR(200)
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_id_estado_civil UUID;
    v_id_ocupacion UUID;
    v_id_grado_instruccion UUID;
BEGIN
    -- 1. Buscar UUIDs de catálogos por descripción (Mismo patrón que i_filiacion)
    IF p_estado_civil_desc IS NOT NULL THEN
        SELECT id_estado_civil INTO v_id_estado_civil 
        FROM catalogo_estado_civil 
        WHERE descripcion = p_estado_civil_desc;
        IF v_id_estado_civil IS NULL THEN RAISE EXCEPTION 'Estado civil "%" no encontrado', p_estado_civil_desc; END IF;
    END IF;
    
    IF p_ocupacion_desc IS NOT NULL THEN
        SELECT id_ocupacion INTO v_id_ocupacion 
        FROM catalogo_ocupacion 
        WHERE descripcion = p_ocupacion_desc;
        IF v_id_ocupacion IS NULL THEN RAISE EXCEPTION 'Ocupación "%" no encontrada', p_ocupacion_desc; END IF;
    END IF;
    
    IF p_grado_instruccion_desc IS NOT NULL THEN
        SELECT id_grado_instruccion INTO v_id_grado_instruccion 
        FROM catalogo_grado_instruccion 
        WHERE descripcion = p_grado_instruccion_desc;
        IF v_id_grado_instruccion IS NULL THEN RAISE EXCEPTION 'Grado instrucción "%" no encontrado', p_grado_instruccion_desc; END IF;
    END IF;

    -- 2. Intentar actualizar (UPDATE)
    UPDATE filiacion
    SET
        raza = p_raza,
        fecha_nacimiento = p_fecha_nacimiento,
        lugar = p_lugar,
        id_estado_civil = v_id_estado_civil,
        nombre_conyuge = p_nombre_conyuge,
        id_ocupacion = v_id_ocupacion,
        lugar_procedencia = p_lugar_procedencia,
        tiempo_residencia_tacna = p_tiempo_residencia_tacna,
        direccion = p_direccion,
        id_grado_instruccion = v_id_grado_instruccion,
        ultima_visita_dentista = p_ultima_visita_dentista,
        motivo_visita_dentista = p_motivo_visita_dentista,
        ultima_visita_medico = p_ultima_visita_medico,
        motivo_visita_medico = p_motivo_visita_medico,
        contacto_emergencia = p_contacto_emergencia,
        telefono_emergencia = p_telefono_emergencia,
        acompaniante = p_acompaniante
    WHERE id_historia = p_id_historia;

    -- 3. Si no se actualizó nada (no existía), insertar (INSERT)
    IF NOT FOUND THEN
        INSERT INTO filiacion (
            id_historia, raza, fecha_nacimiento, lugar, id_estado_civil, nombre_conyuge, 
            id_ocupacion, lugar_procedencia, tiempo_residencia_tacna, direccion, 
            id_grado_instruccion, ultima_visita_dentista, motivo_visita_dentista, 
            ultima_visita_medico, motivo_visita_medico, contacto_emergencia, 
            telefono_emergencia, acompaniante
        ) VALUES (
            p_id_historia, p_raza, p_fecha_nacimiento, p_lugar, v_id_estado_civil, p_nombre_conyuge, 
            v_id_ocupacion, p_lugar_procedencia, p_tiempo_residencia_tacna, p_direccion, 
            v_id_grado_instruccion, p_ultima_visita_dentista, p_motivo_visita_dentista, 
            p_ultima_visita_medico, p_motivo_visita_medico, p_contacto_emergencia, 
            p_telefono_emergencia, p_acompaniante
        );
    END IF;

    RAISE NOTICE 'Filiación actualizada/registrada para historia %', p_id_historia;
END;
$$;