------------------------------------------------------------------
-- ARCHIVO: 08_auditoria.sql
-- DESCRIPCION: Tabla de auditoría del sistema
------------------------------------------------------------------

CREATE TABLE auditoria (
    id_auditoria UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    id_usuario UUID NOT NULL,
    fecha_cambio TIMESTAMP NOT NULL DEFAULT NOW(),
    nombre_tabla VARCHAR(50) NOT NULL,
    id_registro_afectado UUID NOT NULL,
    accion VARCHAR(10) NOT NULL,
    datos_anteriores JSONB,
    datos_nuevos JSONB,
    ip_address VARCHAR(45),
    user_agent TEXT
);
