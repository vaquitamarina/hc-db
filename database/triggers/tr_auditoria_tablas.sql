------------------------------------------------------------------
-- DESCRIPCION: Triggers de auditoría para tablas críticas del sistema
------------------------------------------------------------------

-- Trigger para tabla USUARIO
CREATE TRIGGER tr_usuario_auditoria
    AFTER INSERT OR UPDATE OR DELETE ON usuario
    FOR EACH ROW
    EXECUTE FUNCTION fn_auditoria_automatica();

-- Trigger para tabla PACIENTE
CREATE TRIGGER tr_paciente_auditoria
    AFTER INSERT OR UPDATE OR DELETE ON paciente
    FOR EACH ROW
    EXECUTE FUNCTION fn_auditoria_automatica();

-- Trigger para tabla HISTORIA_CLINICA
CREATE TRIGGER tr_historia_clinica_auditoria
    AFTER INSERT OR UPDATE OR DELETE ON historia_clinica
    FOR EACH ROW
    EXECUTE FUNCTION fn_auditoria_automatica();

-- Trigger para tabla FILIACION
CREATE TRIGGER tr_filiacion_auditoria
    AFTER INSERT OR UPDATE OR DELETE ON filiacion
    FOR EACH ROW
    EXECUTE FUNCTION fn_auditoria_automatica();

-- Trigger para tabla REVISION_HISTORIA
CREATE TRIGGER tr_revision_historia_auditoria
    AFTER INSERT OR UPDATE OR DELETE ON revision_historia
    FOR EACH ROW
    EXECUTE FUNCTION fn_auditoria_automatica();

-- Trigger para tabla DIAGNOSTICO
CREATE TRIGGER tr_diagnostico_auditoria
    AFTER INSERT OR UPDATE OR DELETE ON diagnostico
    FOR EACH ROW
    EXECUTE FUNCTION fn_auditoria_automatica();
