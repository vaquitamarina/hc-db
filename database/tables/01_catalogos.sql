------------------------------------------------------------------
-- ARCHIVO: 01_catalogos.sql
-- DESCRIPCION: Tablas de catálogos del sistema
-- PROYECTO: SN-001-2025 - Sistema de Historias Clínicas
-- AUTOR: Equipo BD II - ESIS UNJBG
-- FECHA: 12/10/2025
------------------------------------------------------------------

-- Extensión requerida para UUID
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- Catálogo de sexo biológico
CREATE TABLE catalogo_sexo (
    id_sexo UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    descripcion VARCHAR(20) NOT NULL
);

-- Catálogo de estados civiles
CREATE TABLE catalogo_estado_civil (
    id_estado_civil UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    descripcion VARCHAR(50) NOT NULL
);

-- Catálogo de grados de instrucción académica
CREATE TABLE catalogo_grado_instruccion (
    id_grado_instruccion UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    descripcion VARCHAR(100) NOT NULL
);

-- Catálogo de ocupaciones
CREATE TABLE catalogo_ocupacion (
    id_ocupacion UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    descripcion VARCHAR(100) NOT NULL
);

-- Catálogo de enfermedades
CREATE TABLE catalogo_enfermedad (
    id_enfermedad UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nombre VARCHAR(100) NOT NULL
);

-- Catálogo de hábitos
CREATE TABLE catalogo_habito (
    id_habito UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nombre VARCHAR(100) NOT NULL
);

-- Catálogo de exámenes auxiliares
CREATE TABLE catalogo_examen_auxiliar (
    id_examen UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    descripcion VARCHAR(100) NOT NULL
);

-- Catálogo de clínicas especializadas
CREATE TABLE catalogo_clinica (
    id_clinica UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nombre VARCHAR(100) NOT NULL
);

-- Catálogo de grupos sanguíneos
CREATE TABLE catalogo_grupo_sanguineo (
    id_grupo_sanguineo UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    descripcion VARCHAR(10) NOT NULL
);

-- Catálogo de estados de revisión de historia clínica
CREATE TABLE catalogo_estado_revision (
    id_estado_revision UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nombre VARCHAR(20) NOT NULL
);

-- Catálogo de posiciones del paciente en examen
CREATE TABLE catalogo_posicion(
    id_posicion UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    posicion VARCHAR(50) NOT NULL
);

-- Catálogo de medidas regionales (cabeza y cuello)
CREATE TABLE catalogo_medida_regional (
    id_medida UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    tipo_medida VARCHAR(50) NOT NULL,
    descripcion VARCHAR(50) NOT NULL
);

-- Catálogo de trayectorias ATM
CREATE TABLE catalogo_atm_trayectoria (
    id_trayectoria UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    descripcion VARCHAR(50) NOT NULL
);

-- Catálogo de grados de dolor
CREATE TABLE catalogo_dolor_grado (
    id_grado UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    descripcion VARCHAR(50) NOT NULL
);

-- Catálogo de movimientos mandibulares
CREATE TABLE catalogo_movimiento_mandibular (
    id_movimiento UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    descripcion VARCHAR(50) NOT NULL
);

COMMENT ON TABLE catalogo_sexo IS 'Catálogo de sexo biológico del paciente';
COMMENT ON TABLE catalogo_estado_civil IS 'Estados civiles disponibles';
COMMENT ON TABLE catalogo_grado_instruccion IS 'Niveles educativos';
COMMENT ON TABLE catalogo_ocupacion IS 'Ocupaciones y profesiones';
COMMENT ON TABLE catalogo_enfermedad IS 'Catálogo de enfermedades comunes';
COMMENT ON TABLE catalogo_habito IS 'Catálogo de hábitos (fumar, alcohol, etc)';
COMMENT ON TABLE catalogo_examen_auxiliar IS 'Tipos de exámenes auxiliares disponibles';
COMMENT ON TABLE catalogo_clinica IS 'Clínicas especializadas para derivación';
COMMENT ON TABLE catalogo_grupo_sanguineo IS 'Grupos sanguíneos (A+, O-, etc)';
COMMENT ON TABLE catalogo_estado_revision IS 'Estados de revisión (pendiente, aprobada, rechazada)';
COMMENT ON TABLE catalogo_posicion IS 'Posiciones del paciente durante examen';
COMMENT ON TABLE catalogo_medida_regional IS 'Medidas para examen regional de cabeza y cuello';
COMMENT ON TABLE catalogo_atm_trayectoria IS 'Trayectorias de apertura ATM';
COMMENT ON TABLE catalogo_dolor_grado IS 'Graduación de dolor en escala';
COMMENT ON TABLE catalogo_movimiento_mandibular IS 'Tipos de movimientos mandibulares';
