------------------------------------------------------------------
-- ARCHIVO: 03_pacientes.sql
-- DESCRIPCION: Tabla de pacientes
-- PROYECTO: SN-001-2025 - Sistema de Historias Clínicas
-- AUTOR: Equipo BD II - ESIS UNJBG
-- FECHA: 12/10/2025
------------------------------------------------------------------

CREATE TABLE paciente (
    id_paciente UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nombre_completo VARCHAR(200) NOT NULL,
    edad INT,
    id_sexo UUID,
    telefono VARCHAR(20),
    email VARCHAR(200),
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    activo BOOLEAN DEFAULT TRUE,
    CONSTRAINT fk_paciente_catalogo_sexo FOREIGN KEY (id_sexo) 
        REFERENCES catalogo_sexo (id_sexo)
);

COMMENT ON TABLE paciente IS 'Datos básicos de los pacientes atendidos';
COMMENT ON COLUMN paciente.nombre_completo IS 'Nombre completo del paciente';
COMMENT ON COLUMN paciente.edad IS 'Edad del paciente en años';
COMMENT ON COLUMN paciente.activo IS 'Indica si el paciente está activo';
