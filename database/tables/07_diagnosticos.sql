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
    fecha DATE DEFAULT CURRENT_DATE
);

-- Referencias a clínicas especializadas
CREATE TABLE referencia_clinica (
    id_ref UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    id_historia UUID NOT NULL,
    id_clinica UUID NOT NULL,
    observaciones TEXT,
    fecha DATE DEFAULT CURRENT_DATE,
    estado VARCHAR(20) DEFAULT 'pendiente'
);

-- Evolución del tratamiento
CREATE TABLE evolucion (
    id_evolucion UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    id_historia UUID NOT NULL,
    fecha DATE DEFAULT CURRENT_DATE,
    actividad TEXT NOT NULL,
    alumno VARCHAR(200),
    observaciones TEXT
);
