------------------------------------------------------------------
-- DESCRIPCION: Función trigger para auditoría automática de cambios
------------------------------------------------------------------

CREATE OR REPLACE FUNCTION fn_auditoria_automatica()
RETURNS TRIGGER AS $$
DECLARE
    v_id_usuario UUID;
    v_datos_anteriores JSONB;
    v_datos_nuevos JSONB;
BEGIN
    -- Obtener el ID de usuario desde la configuración de sesión
    -- El backend debe configurar esto: SET app.current_user_id = 'uuid-del-usuario'
    BEGIN
        v_id_usuario := current_setting('app.current_user_id', true)::UUID;
    EXCEPTION
        WHEN OTHERS THEN
            v_id_usuario := '00000000-0000-0000-0000-000000000000'::UUID; -- Usuario del sistema
    END;

    -- Procesar según el tipo de operación
    IF (TG_OP = 'DELETE') THEN
        -- En DELETE, solo guardamos los datos anteriores
        v_datos_anteriores := row_to_json(OLD)::JSONB;
        v_datos_nuevos := NULL;
        
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
            (row_to_json(OLD)->>'id_' || SUBSTRING(TG_TABLE_NAME, 1, POSITION('_' IN TG_TABLE_NAME || '_') - 1))::UUID,
            'DELETE',
            v_datos_anteriores,
            NULL
        );
        
        RETURN OLD;
        
    ELSIF (TG_OP = 'UPDATE') THEN
        -- En UPDATE, guardamos antes y después
        v_datos_anteriores := row_to_json(OLD)::JSONB;
        v_datos_nuevos := row_to_json(NEW)::JSONB;
        
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
            (row_to_json(NEW)->>'id_' || SUBSTRING(TG_TABLE_NAME, 1, POSITION('_' IN TG_TABLE_NAME || '_') - 1))::UUID,
            'UPDATE',
            v_datos_anteriores,
            v_datos_nuevos
        );
        
        RETURN NEW;
        
    ELSIF (TG_OP = 'INSERT') THEN
        -- En INSERT, solo guardamos los datos nuevos
        v_datos_anteriores := NULL;
        v_datos_nuevos := row_to_json(NEW)::JSONB;
        
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
            (row_to_json(NEW)->>'id_' || SUBSTRING(TG_TABLE_NAME, 1, POSITION('_' IN TG_TABLE_NAME || '_') - 1))::UUID,
            'INSERT',
            NULL,
            v_datos_nuevos
        );
        
        RETURN NEW;
    END IF;
    
    RETURN NULL;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;
