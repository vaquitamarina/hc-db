------------------------------------------------------------------
-- DESCRIPCION: Procedimiento que registra datos de filiacion de una historia clinica
-- Usado por: Sistema de Historias Clinicas - Módulo de Historia Clinica
-- SN-001-2025 Proyecto Historias Clinicas - Módulo de Historia Clinica, Autor: Equipo BD II - 12/10/2025
------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE i_filiacion(
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
    -- Buscar UUIDs de catálogos por descripción
    SELECT id_estado_civil INTO v_id_estado_civil 
    FROM catalogo_estado_civil 
    WHERE descripcion = p_estado_civil_desc;
    
    SELECT id_ocupacion INTO v_id_ocupacion 
    FROM catalogo_ocupacion 
    WHERE descripcion = p_ocupacion_desc;
    
    SELECT id_grado_instruccion INTO v_id_grado_instruccion 
    FROM catalogo_grado_instruccion 
    WHERE descripcion = p_grado_instruccion_desc;
    
    -- Validar que se encontraron todos los catálogos
    IF v_id_estado_civil IS NULL THEN
        RAISE EXCEPTION 'Estado civil "%" no encontrado en catálogo', p_estado_civil_desc;
    END IF;
    
    IF v_id_ocupacion IS NULL THEN
        RAISE EXCEPTION 'Ocupación "%" no encontrada en catálogo', p_ocupacion_desc;
    END IF;
    
    IF v_id_grado_instruccion IS NULL THEN
        RAISE EXCEPTION 'Grado de instrucción "%" no encontrado en catálogo', p_grado_instruccion_desc;
    END IF;

    INSERT INTO filiacion (
        id_historia,
        raza,
        fecha_nacimiento,
        lugar,
        id_estado_civil,
        nombre_conyuge,
        id_ocupacion,
        lugar_procedencia,
        tiempo_residencia_tacna,
        direccion,
        id_grado_instruccion,
        ultima_visita_dentista,
        motivo_visita_dentista,
        ultima_visita_medico,
        motivo_visita_medico,
        contacto_emergencia,
        telefono_emergencia,
        acompaniante
    )
    VALUES (
        p_id_historia,
        p_raza,
        p_fecha_nacimiento,
        p_lugar,
        v_id_estado_civil,
        p_nombre_conyuge,
        v_id_ocupacion,
        p_lugar_procedencia,
        p_tiempo_residencia_tacna,
        p_direccion,
        v_id_grado_instruccion,
        p_ultima_visita_dentista,
        p_motivo_visita_dentista,
        p_ultima_visita_medico,
        p_motivo_visita_medico,
        p_contacto_emergencia,
        p_telefono_emergencia,
        p_acompaniante
    );

    RAISE NOTICE 'Filiacion registrada exitosamente para historia %.', p_id_historia;

EXCEPTION
    WHEN foreign_key_violation THEN
        RAISE EXCEPTION 'Uno de los IDs referenciados no existe (historia, estado civil, ocupacion o grado instruccion).';
    WHEN unique_violation THEN
        RAISE EXCEPTION 'La historia % ya tiene una filiacion registrada.', p_id_historia;
    WHEN others THEN
        RAISE EXCEPTION 'Ocurrio un error al registrar la filiacion: %', SQLERRM;
END;
$$;
