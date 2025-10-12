------------------------------------------------------------------
-- ARCHIVO: 07_diagnosticos.sql
-- DESCRIPCION: Tablas de diagnósticos, referencias y evolución
-- PROYECTO: SN-001-2025 - Sistema de Historias Clínicas
-- AUTOR: Equipo BD II - ESIS UNJBG
-- FECHA: 12/10/2025
------------------------------------------------------------------

-- Diagnósticos del paciente
CREATE TABLE diagnostico (
    id_diagnostico UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    id_historia UUID NOT NULL,
    descripcion TEXT NOT NULL,
    definitivo BOOLEAN DEFAULT FALSE,
    fecha DATE DEFAULT CURRENT_DATE,
    CONSTRAINT fk_diagnostico_historia_clinica FOREIGN KEY (id_historia) 
        REFERENCES historia_clinica (id_historia)
);

-- Referencias a clínicas especializadas
CREATE TABLE referencia_clinica (
    id_ref UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    id_historia UUID NOT NULL,
    id_clinica UUID NOT NULL,
    observaciones TEXT,
    fecha DATE DEFAULT CURRENT_DATE,
    estado VARCHAR(20) DEFAULT 'pendiente',
    CONSTRAINT fk_referencia_clinica_historia_clinica FOREIGN KEY (id_historia) 
        REFERENCES historia_clinica (id_historia),
    CONSTRAINT fk_referencia_clinica_catalogo_clinica FOREIGN KEY (id_clinica) 
        REFERENCES catalogo_clinica (id_clinica)
);

-- Evolución del tratamiento
CREATE TABLE evolucion (
    id_evolucion UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    id_historia UUID NOT NULL,
    fecha DATE DEFAULT CURRENT_DATE,
    actividad TEXT NOT NULL,
    alumno VARCHAR(200),
    observaciones TEXT,
    CONSTRAINT fk_evolucion_historia_clinica FOREIGN KEY (id_historia) 
        REFERENCES historia_clinica (id_historia)
);

COMMENT ON TABLE diagnostico IS 'Diagnósticos presuntivos y definitivos';
COMMENT ON COLUMN diagnostico.definitivo IS 'TRUE si es diagnóstico definitivo, FALSE si es presuntivo';
COMMENT ON TABLE referencia_clinica IS 'Referencias a clínicas especializadas';
COMMENT ON COLUMN referencia_clinica.estado IS 'Estado: pendiente, atendida, cancelada';
COMMENT ON TABLE evolucion IS 'Registro de evolución y seguimiento del paciente';
