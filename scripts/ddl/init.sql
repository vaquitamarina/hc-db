-- Habilita la extensión para generar UUIDs
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Creación de la tabla `usuarios`
CREATE TABLE usuarios (
    id_usuario UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    nombre VARCHAR(255) NOT NULL,
    apellido VARCHAR(255) NOT NULL,
    dni VARCHAR(20) UNIQUE NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    rol VARCHAR(50) NOT NULL,
    contrasena_hash VARCHAR(255) NOT NULL
);

-- Creación de la tabla `pacientes`
CREATE TABLE pacientes (
    id_paciente UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    nombre VARCHAR(255) NOT NULL,
    apellido VARCHAR(255) NOT NULL,
    dni VARCHAR(20) UNIQUE NOT NULL,
    fecha_nacimiento DATE,
    lugar_nacimiento VARCHAR(100),
    estado_civil VARCHAR(50), --selector
    sexo VARCHAR(20), --selector
    nombre_conyuge VARCHAR(255),
    ocupacion VARCHAR(100),
    tiempo_residencia VARCHAR(100),
    direccion VARCHAR(255),
    ultima_visita_dentista DATE,
    motivo_ultima_visita_dentista TEXT,
    ultima_visita_medico DATE,
    motivo_ultima_visita_medico TEXT,
    contacto_emergencia VARCHAR(255),
    relacion_contacto_emergencia VARCHAR(100),
    telefono_contacto_emergencia VARCHAR(20),
    telefono VARCHAR(20)
);

CREATE TABLE historias_clinicas (
    id_historia UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    id_paciente UUID NOT NULL,
    id_alumno UUID NOT NULL,
    fecha_creacion DATE NOT NULL,
    CONSTRAINT fk_historias_clinicas_pacientes FOREIGN KEY (id_paciente) REFERENCES pacientes(id_paciente),
    CONSTRAINT fk_historias_clinicas_usuarios FOREIGN KEY (id_alumno) REFERENCES usuarios(id_usuario)
);

CREATE TABLE revisiones_historia (
    id_revision UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    id_historia UUID NOT NULL,
    id_docente UUID NOT NULL,
    fecha_revision DATE,
    estado VARCHAR(50) NOT NULL,
    observaciones TEXT,
    CONSTRAINT fk_revisiones_historia_historias_clinicas FOREIGN KEY (id_historia) REFERENCES historias_clinicas(id_historia),
    CONSTRAINT fk_revisiones_historia_usuarios FOREIGN KEY (id_docente) REFERENCES usuarios(id_usuario)
);

--Partes historia
CREATE TABLE anamnesis (
  id_anamnesis UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  id_historia UUID NOT NULL,
  CONSTRAINT fk_anamnesis_historias_clinicas FOREIGN KEY (id_historia) REFERENCES historias_clinicas(id_historia)
);

CREATE TABLE motivos_consulta (
  id_motivo UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  id_anamnesis UUID NOT NULL,
  descripcion TEXT,
  CONSTRAINT fk_motivos_consulta_anamnesis FOREIGN KEY (id_anamnesis) REFERENCES anamnesis(id_anamnesis)
);

CREATE TABLE enfermedades_actuales (
  id_enfermedad UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  id_anamnesis UUID NOT NULL,
  tiempo_enfermadad VARCHAR(100),
  forma_inicio VARCHAR(100),
  curso_enfermedad VARCHAR(100),
  relato_enfermedad TEXT,
  tratamientos_recibidos TEXT,
  CONSTRAINT fk_enfermedades_actuales_anamnesis FOREIGN KEY (id_anamnesis) REFERENCES anamnesis(id_anamnesis)
);

-- Creación de la tabla `antecedentes`
CREATE TABLE antecedentes (
  id_antecedente UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  id_anamnesis UUID NOT NULL,
  embarazada BOOLEAN,

  CONSTRAINT fk_antecedentes_anamnesis FOREIGN KEY (id_anamnesis) REFERENCES anamnesis(id_anamnesis)
);

-- Creación de la tabla `examenes_fisicos`
CREATE TABLE examenes_fisicos (
  id_examen UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  id_historia UUID NOT NULL,
  CONSTRAINT fk_examenes_fisicos_historias_clinicas FOREIGN KEY (id_historia) REFERENCES historias_clinicas(id_historia)
);

-- Creación de la tabla `examenes_generales`
CREATE TABLE examenes_generales (
  id_general UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  id_examen UUID NOT NULL,
  descripcion TEXT,
  CONSTRAINT fk_examenes_generales_examenes_fisicos FOREIGN KEY (id_examen) REFERENCES examenes_fisicos(id_examen)
);

-- Creación de la tabla `examenes_regionales`
CREATE TABLE examenes_regionales (
  id_regional UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  id_examen UUID NOT NULL,
  descripcion TEXT,
  CONSTRAINT fk_examenes_regionales_examenes_fisicos FOREIGN KEY (id_examen) REFERENCES examenes_fisicos(id_examen)
);

-- Creación de la tabla `examenes_clinicos_boca`
CREATE TABLE examenes_clinicos_boca (
  id_clinico UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  id_examen UUID NOT NULL,
  descripcion TEXT,
  CONSTRAINT fk_examenes_clinicos_boca_examenes_fisicos FOREIGN KEY (id_examen) REFERENCES examenes_fisicos(id_examen)
);

-- Creación de la tabla `higienes_bucales`
CREATE TABLE higienes_bucales (
  id_higiene UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  id_examen UUID NOT NULL,
  descripcion TEXT,
  CONSTRAINT fk_higienes_bucales_examenes_fisicos FOREIGN KEY (id_examen) REFERENCES examenes_fisicos(id_examen)
);

-- Creación de la tabla `odontogramas`
CREATE TABLE odontogramas (
  id_odontograma UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  id_examen UUID NOT NULL,
  descripcion TEXT,
  CONSTRAINT fk_odontogramas_examenes_fisicos FOREIGN KEY (id_examen) REFERENCES examenes_fisicos(id_examen)
);

-- Creación de la tabla `diagnosticos_presuntivos`
CREATE TABLE diagnosticos_presuntivos (
  id_diagnostico_presuntivo UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  id_historia UUID NOT NULL,
  descripcion TEXT,
  CONSTRAINT fk_diagnosticos_presuntivos_historias_clinicas FOREIGN KEY (id_historia) REFERENCES historias_clinicas(id_historia)
);

-- Creación de la tabla `derivados_clinica`
CREATE TABLE derivados_clinica (
  id_derivado UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  id_historia UUID NOT NULL,
  descripcion TEXT,
  CONSTRAINT fk_derivados_clinica_historias_clinicas FOREIGN KEY (id_historia) REFERENCES historias_clinicas(id_historia)
);

-- Creación de la tabla `diagnosticos_clinica`
CREATE TABLE diagnosticos_clinica (
  id_diagnostico_clinica UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  id_historia UUID NOT NULL,
  descripcion TEXT,
  CONSTRAINT fk_diagnosticos_clinica_historias_clinicas FOREIGN KEY (id_historia) REFERENCES historias_clinicas(id_historia)
);

-- Creación de la tabla `evoluciones`
CREATE TABLE evoluciones (
  id_evolucion UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  id_historia UUID NOT NULL,
  id_alumno UUID NOT NULL,
  descripcion TEXT,
  CONSTRAINT fk_evoluciones_historias_clinicas FOREIGN KEY (id_historia) REFERENCES historias_clinicas(id_historia),
  CONSTRAINT fk_evoluciones_usuarios FOREIGN KEY (id_alumno) REFERENCES usuarios(id_usuario)
);

-- Creación de la tabla `auditoria`
CREATE TABLE auditoria (
  id_auditoria UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  id_usuario UUID NOT NULL,
  fecha_cambio TIMESTAMP NOT NULL DEFAULT NOW(),
  nombre_tabla VARCHAR(50) NOT NULL,
  id_registro_afectado UUID NOT NULL,
  accion VARCHAR(10) NOT NULL,
  datos_anteriores JSONB,
  datos_nuevos JSONB,
  CONSTRAINT fk_auditoria_usuarios FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
);
