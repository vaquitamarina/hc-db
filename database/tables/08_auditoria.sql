------------------------------------------------------------------
-- ARCHIVO: 08_auditoria.sql
-- DESCRIPCION: Tabla de auditoría del sistema
------------------------------------------------------------------
CREATE TABLE auditoria (
    id_auditoria uuid PRIMARY KEY DEFAULT gen_random_uuid (),
    id_usuario uuid NOT NULL,
    fecha_cambio timestamp NOT NULL DEFAULT NOW(),
    nombre_tabla varchar(50) NOT NULL,
    id_registro_afectado uuid NOT NULL,
    accion varchar(10) NOT NULL,
    datos_anteriores jsonb,
    datos_nuevos jsonb,
    ip_address varchar(45),
    user_agent text
);

