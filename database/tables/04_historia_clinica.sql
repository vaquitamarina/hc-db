------------------------------------------------------------------
-- ARCHIVO: 04_historia_clinica.sql
-- DESCRIPCION: Tablas principales de historia clínica y revisión
-- PROYECTO: SN-001-2025 - Sistema de Historias Clínicas
-- AUTOR: Equipo BD II - ESIS UNJBG
-- FECHA: 12/10/2025
------------------------------------------------------------------

-- Tabla principal de historia clínica
CREATE TABLE historia_clinica (
    id_historia UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    id_paciente UUID UNIQUE,
    id_estudiante UUID NOT NULL,
    fecha_elaboracion DATE NOT NULL DEFAULT CURRENT_DATE,
    ultima_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    estado VARCHAR(20) DEFAULT 'en_proceso'
);

-- Tabla de revisiones de historia clínica
CREATE TABLE revision_historia (
    id_revision UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    id_historia UUID NOT NULL,
    id_docente UUID NOT NULL,
    fecha DATE DEFAULT CURRENT_DATE,
    id_estado_revision UUID NOT NULL,
    observaciones TEXT
);

-- Tabla de secciones de historia clínica
CREATE TABLE seccion_hc (
    id_seccion_hc UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nombre VARCHAR(100) NOT NULL,
    orden INT NOT NULL UNIQUE
);

-- Tabla de subsecciones de historia clínica
CREATE TABLE subseccion_hc (
    id_subseccion_hc UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    id_seccion_hc UUID,
    nombre VARCHAR(100) NOT NULL,
    orden INT NOT NULL
);
