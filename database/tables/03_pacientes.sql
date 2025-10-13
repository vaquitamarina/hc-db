------------------------------------------------------------------
-- ARCHIVO: 03_pacientes.sql
-- DESCRIPCION: Tabla de pacientes
-- PROYECTO: SN-001-2025 - Sistema de Historias Clínicas
-- AUTOR: Equipo BD II - ESIS UNJBG
-- FECHA: 12/10/2025
------------------------------------------------------------------

CREATE TABLE paciente (
    id_paciente UUID PRIMARY KEY DEFAULT gen_random_uuid()
    nombre_completo VARCHAR(200) NOT NULL
    dni CHAR(8) UNIQUE NOT NULL
    fecha_nacimiento DATE NOT NULL
    id_sexo UUID NOT NULL
    telefono VARCHAR(20)
    email VARCHAR(200)
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    activo BOOLEAN DEFAULT TRUE
);
