------------------------------------------------------------------
-- ARCHIVO: check_constraints.sql
-- DESCRIPCION: Constraints de validación (CHECK) del sistema
------------------------------------------------------------------

-- Validaciones para tabla usuario
ALTER TABLE usuario ADD CONSTRAINT chk_usuario_rol 
    CHECK (rol IN ('estudiante', 'docente', 'admin'));

ALTER TABLE usuario ADD CONSTRAINT chk_usuario_email 
    CHECK (email ~* '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$');

-- Validaciones para tabla historia_clinica
ALTER TABLE historia_clinica ADD CONSTRAINT chk_historia_clinica_estado 
    CHECK (estado IN ('en_proceso', 'completada', 'aprobada', 'rechazada','borrador'));

-- Validaciones para tabla auditoria
ALTER TABLE auditoria ADD CONSTRAINT chk_auditoria_accion 
    CHECK (accion IN ('INSERT', 'UPDATE', 'DELETE'));