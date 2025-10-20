------------------------------------------------------------------
-- DESCRIPCION: Función trigger para auditoría automática de cambios
------------------------------------------------------------------

CREATE OR REPLACE FUNCTION fn_auditoria_automatica()
RETURNS TRIGGER AS $$
DECLARE
    v_id_usuario UUID;
    v_datos_anteriores JSONB;
    v_datos_nuevos JSONB;
    v_id_registro UUID;
    v_json_data JSONB;
    v_key TEXT;
BEGIN
    -- Obtener el ID de usuario desde la configuración de sesión
    BEGIN
        v_id_usuario := current_setting('app.current_user_id', true)::UUID;
    EXCEPTION
        WHEN OTHERS THEN
            v_id_usuario := '00000000-0000-0000-0000-000000000000'::UUID;
    END;

    -- Procesar según el tipo de operación
    IF (TG_OP = 'DELETE') THEN
        v_datos_anteriores := row_to_json(OLD)::JSONB;
        v_datos_nuevos := NULL;
        v_json_data := v_datos_anteriores;
        
    ELSIF (TG_OP = 'UPDATE') THEN
        v_datos_anteriores := row_to_json(OLD)::JSONB;
        v_datos_nuevos := row_to_json(NEW)::JSONB;
        v_json_data := v_datos_nuevos;
        
    ELSIF (TG_OP = 'INSERT') THEN
        v_datos_anteriores := NULL;
        v_datos_nuevos := row_to_json(NEW)::JSONB;
        v_json_data := v_datos_nuevos;
    END IF;
    
    -- Buscar el campo ID en el JSON (intenta diferentes patrones comunes)
    -- Primero intenta: id_<nombre_tabla>
    v_key := 'id_' || TG_TABLE_NAME;
    v_id_registro := (v_json_data->>v_key)::UUID;
    
    -- Si no lo encuentra, intenta solo 'id'
    IF v_id_registro IS NULL THEN
        v_id_registro := (v_json_data->>'id')::UUID;
    END IF;
    
    -- Si aún es NULL, intenta buscar cualquier clave que empiece con 'id_'
    IF v_id_registro IS NULL THEN
        SELECT (v_json_data->>key)::UUID INTO v_id_registro
        FROM jsonb_object_keys(v_json_data) AS key
        WHERE key LIKE 'id_%'
        LIMIT 1;
    END IF;
    
    -- Insertar en auditoría
    INSERT INTO auditoria (
        id_usuario,
        fecha_cambio,
        nombre_tabla,
        id_registro_afectado,
        accion,
        datos_anteriores,
        datos_nuevos
    ) VALUES (
        v_id_usuario,
        CURRENT_TIMESTAMP,
        TG_TABLE_NAME,
        v_id_registro,
        TG_OP,
        v_datos_anteriores,
        v_datos_nuevos
    );
    
    -- Retornar el registro apropiado
    IF (TG_OP = 'DELETE') THEN
        RETURN OLD;
    ELSE
        RETURN NEW;
    END IF;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;
