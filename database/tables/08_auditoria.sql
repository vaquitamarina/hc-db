------------------------------------------------------------------
-- ARCHIVO: 08_auditoria.sql
-- DESCRIPCION: Tabla de auditoría del sistema
-- PROYECTO: SN-001-2025 - Sistema de Historias Clínicas
-- AUTOR: Equipo BD II - ESIS UNJBG
-- FECHA: 12/10/2025
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
    user_agent TEXT,
    CONSTRAINT fk_auditoria_usuario FOREIGN KEY (id_usuario) 
        REFERENCES usuario (id_usuario),
    CONSTRAINT chk_auditoria_accion CHECK (accion IN ('INSERT', 'UPDATE', 'DELETE'))
);

-- Índice para mejorar consultas de auditoría
CREATE INDEX idx_auditoria_fecha ON auditoria(fecha_cambio DESC);
CREATE INDEX idx_auditoria_usuario ON auditoria(id_usuario);
CREATE INDEX idx_auditoria_tabla ON auditoria(nombre_tabla);

COMMENT ON TABLE auditoria IS 'Registro de auditoría de todas las operaciones del sistema';
COMMENT ON COLUMN auditoria.accion IS 'Tipo de operación: INSERT, UPDATE, DELETE';
COMMENT ON COLUMN auditoria.datos_anteriores IS 'Estado anterior del registro (en formato JSON)';
COMMENT ON COLUMN auditoria.datos_nuevos IS 'Estado nuevo del registro (en formato JSON)';
COMMENT ON COLUMN auditoria.ip_address IS 'Dirección IP desde donde se realizó la operación';
