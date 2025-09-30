CREATE EXTENSION IF NOT EXISTS "pgcrypto";

CREATE TABLE catalogo_sexo (
    id_sexo UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    descripcion VARCHAR(20) NOT NULL
);

CREATE TABLE catalogo_estado_civil (
    id_estado_civil UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    descripcion VARCHAR(50) NOT NULL
);

CREATE TABLE catalogo_grado_instruccion (
    id_grado_instruccion UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    descripcion VARCHAR(100) NOT NULL
);

CREATE TABLE catalogo_ocupacion (
    id_ocupacion UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    descripcion VARCHAR(100) NOT NULL
);

CREATE TABLE catalogo_enfermedad (
    id_enfermedad UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nombre VARCHAR(100) NOT NULL
);

CREATE TABLE catalogo_habito (
    id_habito UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nombre VARCHAR(100) NOT NULL
);

CREATE TABLE catalogo_examen_auxiliar (
    id_examen UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    descripcion VARCHAR(100) NOT NULL
);

CREATE TABLE catalogo_clinica (
    id_clinica UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nombre VARCHAR(100) NOT NULL
);

CREATE TABLE catalogo_grupo_sanguineo (
    id_grupo_sanguineo UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    descripcion VARCHAR(10) NOT NULL
);

CREATE TABLE catalogo_estado_revision (
    id_estado_revision UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nombre VARCHAR(20) NOT NULL
);

CREATE TABLE catalogo_posicion(
    id_posicion UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    posicion VARCHAR(50) NOT NULL
);

-- CATÁLOGOS BASE PARA EXAMEN REGIONAL 
CREATE TABLE catalogo_medida_regional (
    id_medida UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    tipo_medida VARCHAR(50) NOT NULL, -- Ej: 'CRANEO_FORMA', 'CARA_FORMA', 'PERFIL_AP'
    descripcion VARCHAR(50) NOT NULL
);

CREATE TABLE catalogo_atm_trayectoria (
    id_trayectoria UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    descripcion VARCHAR(50) NOT NULL -- 'Recta', 'Deflexión', 'Desviación'
);

CREATE TABLE catalogo_dolor_grado (
    id_grado UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    descripcion VARCHAR(50) NOT NULL
);

-- catálogo para los tipos de movimiento (Lateralidad, Protrusión, Apertura, Cierre)
CREATE TABLE catalogo_movimiento_mandibular (
    id_movimiento UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    descripcion VARCHAR(50) NOT NULL
);