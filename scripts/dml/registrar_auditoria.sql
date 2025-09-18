CREATE OR REPLACE FUNCTION registrar_auditoria(
  p_id_usuario UUID,
  p_nombre_tabla VARCHAR,
  p_id_registro UUID,
  p_accion VARCHAR,
  p_datos_anteriores JSONB DEFAULT NULL,
  p_datos_nuevos JSONB DEFAULT NULL
) RETURNS UUID AS $$
DECLARE
  v_accion_upper VARCHAR;
  v_id_auditoria UUID := uuid_generate_v4();
BEGIN
  IF p_accion IS NULL THEN
    RAISE EXCEPTION 'p_accion no puede ser NULL';
  END IF;

  v_accion_upper := upper(p_accion);
  IF v_accion_upper NOT IN ('INSERT','UPDATE','DELETE') THEN
    RAISE EXCEPTION 'Acción inválida: % (debe ser INSERT, UPDATE o DELETE)', p_accion;
  END IF;

  INSERT INTO auditoria (
    id_auditoria,
    id_usuario,
    fecha_cambio,
    nombre_tabla,
    id_registro_afectado,
    accion,
    datos_anteriores,
    datos_nuevos
  ) VALUES (
    v_id_auditoria,
    p_id_usuario,
    NOW(),
    p_nombre_tabla,
    p_id_registro,
    v_accion_upper,
    p_datos_anteriores,
    p_datos_nuevos
  );

  RETURN v_id_auditoria;
END;
$$ LANGUAGE plpgsql;