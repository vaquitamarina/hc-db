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
    id_sexo UUID PRIMARY KEY DEFAULT gen_random_uuid()
    descripcion VARCHAR(20) UNIQUE NOT NULL
);

-- Catálogo de estados civiles
CREATE TABLE catalogo_estado_civil (
    id_estado_civil UUID PRIMARY KEY DEFAULT gen_random_uuid()
    descripcion VARCHAR(50) UNIQUE NOT NULL
);

-- Catálogo de grados de instrucción académica
CREATE TABLE catalogo_grado_instruccion (
    id_grado_instruccion UUID PRIMARY KEY DEFAULT gen_random_uuid()
    descripcion VARCHAR(100) UNIQUE NOT NULL
);

-- Catálogo de ocupaciones
CREATE TABLE catalogo_ocupacion (
    id_ocupacion UUID PRIMARY KEY DEFAULT gen_random_uuid()
    descripcion VARCHAR(100) UNIQUE NOT NULL
);

-- Catálogo de enfermedades
CREATE TABLE catalogo_enfermedad (
    id_enfermedad UUID PRIMARY KEY DEFAULT gen_random_uuid()
    nombre VARCHAR(100) NOT NULL
);

-- Catálogo de hábitos
CREATE TABLE catalogo_habito (
    id_habito UUID PRIMARY KEY DEFAULT gen_random_uuid()
    nombre VARCHAR(100) NOT NULL
);

-- Catálogo de exámenes auxiliares
CREATE TABLE catalogo_examen_auxiliar (
    id_examen UUID PRIMARY KEY DEFAULT gen_random_uuid()
    descripcion VARCHAR(100) NOT NULL
);

-- Catálogo de clínicas especializadas
CREATE TABLE catalogo_clinica (
    id_clinica UUID PRIMARY KEY DEFAULT gen_random_uuid()
    nombre VARCHAR(100) NOT NULL
);

-- Catálogo de grupos sanguíneos
CREATE TABLE catalogo_grupo_sanguineo (
    id_grupo_sanguineo UUID PRIMARY KEY DEFAULT gen_random_uuid()
    descripcion VARCHAR(10) NOT NULL
);

-- Catálogo de estados de revisión de historia clínica
CREATE TABLE catalogo_estado_revision (
    id_estado_revision UUID PRIMARY KEY DEFAULT gen_random_uuid()
    nombre VARCHAR(20) NOT NULL
);

-- Catálogo de posiciones del paciente en examen
CREATE TABLE catalogo_posicion(
    id_posicion UUID PRIMARY KEY DEFAULT gen_random_uuid()
    posicion VARCHAR(50) NOT NULL
);

-- Catálogo de medidas regionales (cabeza y cuello)
CREATE TABLE catalogo_medida_regional (
    id_medida UUID PRIMARY KEY DEFAULT gen_random_uuid()
    tipo_medida VARCHAR(50) NOT NULL
    descripcion VARCHAR(50) NOT NULL
);

-- Catálogo de trayectorias ATM
CREATE TABLE catalogo_atm_trayectoria (
    id_trayectoria UUID PRIMARY KEY DEFAULT gen_random_uuid()
    descripcion VARCHAR(50) NOT NULL
);

-- Catálogo de grados de dolor
CREATE TABLE catalogo_dolor_grado (
    id_grado UUID PRIMARY KEY DEFAULT gen_random_uuid()
    descripcion VARCHAR(50) NOT NULL
);

-- Catálogo de movimientos mandibulares
CREATE TABLE catalogo_movimiento_mandibular (
    id_movimiento UUID PRIMARY KEY DEFAULT gen_random_uuid()
    descripcion VARCHAR(50) NOT NULL
);

