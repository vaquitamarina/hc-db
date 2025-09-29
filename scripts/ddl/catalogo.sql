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
  
