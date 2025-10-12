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
    id_paciente UUID NOT NULL,
    id_estudiante UUID NOT NULL,
    fecha_elaboracion DATE NOT NULL DEFAULT CURRENT_DATE,
    ultima_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    estado VARCHAR(20) DEFAULT 'en_proceso',
    CONSTRAINT fk_historia_clinica_paciente FOREIGN KEY (id_paciente) 
        REFERENCES paciente (id_paciente),
    CONSTRAINT fk_historia_clinica_usuario FOREIGN KEY (id_estudiante) 
        REFERENCES usuario (id_usuario)
);

-- Tabla de revisiones de historia clínica
CREATE TABLE revision_historia (
    id_revision UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    id_historia UUID NOT NULL,
    id_docente UUID NOT NULL,
    fecha DATE DEFAULT CURRENT_DATE,
    id_estado_revision UUID NOT NULL,
    observaciones TEXT,
    CONSTRAINT fk_revision_historia_historia_clinica FOREIGN KEY (id_historia) 
        REFERENCES historia_clinica (id_historia),
    CONSTRAINT fk_revision_historia_usuario FOREIGN KEY (id_docente) 
        REFERENCES usuario (id_usuario),
    CONSTRAINT fk_revision_historia_catalogo_estado_revision FOREIGN KEY (id_estado_revision) 
        REFERENCES catalogo_estado_revision (id_estado_revision)
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
    orden INT NOT NULL,
    CONSTRAINT fk_subseccion_hc_seccion_hc FOREIGN KEY (id_seccion_hc) 
        REFERENCES seccion_hc(id_seccion_hc),
    UNIQUE (id_seccion_hc, orden)
);

COMMENT ON TABLE historia_clinica IS 'Registro principal de historia clínica';
COMMENT ON COLUMN historia_clinica.estado IS 'Estado: en_proceso, completada, revisada';
COMMENT ON TABLE revision_historia IS 'Revisiones realizadas por docentes';
COMMENT ON TABLE seccion_hc IS 'Secciones de la historia clínica';
COMMENT ON TABLE subseccion_hc IS 'Subsecciones dentro de cada sección';
