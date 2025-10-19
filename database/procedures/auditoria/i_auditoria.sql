------------------------------------------------------------------
-- DESCRIPCION: Procedimiento que registra eventos de auditoria en el sistema
------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE i_auditoria(
    IN p_id_usuario UUID,
    IN p_nombre_tabla VARCHAR(50),
    IN p_id_registro_afectado UUID,
    IN p_accion VARCHAR(10),
    IN p_datos_anteriores JSONB DEFAULT NULL,
    IN p_datos_nuevos JSONB DEFAULT NULL
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO auditoria (
        id_usuario,
        nombre_tabla,
        id_registro_afectado,
        accion,
        datos_anteriores,
        datos_nuevos
    )
    VALUES (
        p_id_usuario,
        p_nombre_tabla,
        p_id_registro_afectado,
        p_accion,
        p_datos_anteriores,
        p_datos_nuevos
    );

    RAISE NOTICE 'Registro de auditoria creado para tabla % con accion %.', p_nombre_tabla, p_accion;

EXCEPTION
    WHEN foreign_key_violation THEN
        RAISE EXCEPTION 'El id_usuario % no existe.', p_id_usuario;
    WHEN others THEN
        RAISE EXCEPTION 'Ocurrio un error al registrar la auditoria: %', SQLERRM;
END;
$$;
