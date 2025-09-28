CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- ==============================
-- CATALOGOS
-- ==============================
CREATE TABLE catalogo_sexo (
    id_sexo INT PRIMARY KEY AUTO_INCREMENT,
    descripcion VARCHAR(20) NOT NULL
);

CREATE TABLE catalogo_estado_civil (
    id_estado_civil INT PRIMARY KEY AUTO_INCREMENT,
    descripcion VARCHAR(50) NOT NULL
);

CREATE TABLE catalogo_grado_instruccion (
    id_grado_instruccion INT PRIMARY KEY AUTO_INCREMENT,
    descripcion VARCHAR(100) NOT NULL
);

CREATE TABLE catalogo_ocupacion (
    id_ocupacion INT PRIMARY KEY AUTO_INCREMENT,
    descripcion VARCHAR(100) NOT NULL
);

CREATE TABLE catalogo_enfermedad (
    id_enfermedad INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL
);

CREATE TABLE catalogo_habito (
    id_habito INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL
);

CREATE TABLE catalogo_examen_auxiliar (
    id_examen INT PRIMARY KEY AUTO_INCREMENT,
    descripcion VARCHAR(100) NOT NULL
);

CREATE TABLE catalogo_clinica (
    id_clinica INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL
);

-- ==============================
-- PACIENTE (con filiación)
-- ==============================
CREATE TABLE paciente (
    id_paciente INT PRIMARY KEY AUTO_INCREMENT,
    nombre_completo VARCHAR(200) NOT NULL,
    edad INT,
    id_sexo INT,
    raza VARCHAR(100),
    fecha_nacimiento DATE,
    lugar VARCHAR(150),
    id_estado_civil INT,
    nombre_conyuge VARCHAR(200),
    id_ocupacion INT,
    lugar_procedencia VARCHAR(150),
    tiempo_residencia_tacna VARCHAR(50),
    direccion VARCHAR(200),
    telefono VARCHAR(20),
    id_grado_instruccion INT,
    ultima_visita_dentista DATE,
    motivo_visita_dentista VARCHAR(300),
    ultima_visita_medico DATE,
    motivo_visita_medico VARCHAR(300),
    contacto_emergencia VARCHAR(200),
    telefono_emergencia VARCHAR(20),
    acompaniante VARCHAR(200),

    CONSTRAINT fk_paciente_sexo FOREIGN KEY (id_sexo) REFERENCES catalogo_sexo(id_sexo),
    CONSTRAINT fk_paciente_estado_civil FOREIGN KEY (id_estado_civil) REFERENCES catalogo_estado_civil(id_estado_civil),
    CONSTRAINT fk_paciente_ocupacion FOREIGN KEY (id_ocupacion) REFERENCES catalogo_ocupacion(id_ocupacion),
    CONSTRAINT fk_paciente_grado FOREIGN KEY (id_grado_instruccion) REFERENCES catalogo_grado_instruccion(id_grado_instruccion)
);

-- ==============================
-- HISTORIA CLINICA
-- ==============================
CREATE TABLE historia_clinica (
    id_historia INT PRIMARY KEY AUTO_INCREMENT,
    id_paciente INT NOT NULL,
    fecha_elaboracion DATE NOT NULL,
    alumno_responsable VARCHAR(200),
    CONSTRAINT fk_historia_paciente FOREIGN KEY (id_paciente) REFERENCES paciente(id_paciente)
);

-- ==============================
-- MOTIVO DE CONSULTA
-- ==============================
CREATE TABLE motivo_consulta (
    id_motivo INT PRIMARY KEY AUTO_INCREMENT,
    id_historia INT,
    motivo TEXT,
    CONSTRAINT fk_motivo_historia FOREIGN KEY (id_historia) REFERENCES historia_clinica(id_historia)
);

-- ==============================
-- ENFERMEDAD ACTUAL
-- ==============================
CREATE TABLE enfermedad_actual (
    id_enfermedad_actual INT PRIMARY KEY AUTO_INCREMENT,
    id_historia INT,
    sintoma_principal VARCHAR(300),
    tiempo_enfermedad VARCHAR(100),
    forma_inicio VARCHAR(200),
    curso VARCHAR(200),
    relato TEXT,
    tratamiento_prev TEXT,
    CONSTRAINT fk_enfactual_historia FOREIGN KEY (id_historia) REFERENCES historia_clinica(id_historia)
);

-- ==============================
-- ANTECEDENTES PERSONALES
-- ==============================
CREATE TABLE antecedente_personal (
    id_antecedente INT PRIMARY KEY AUTO_INCREMENT,
    id_historia INT,
    esta_embarazada BOOLEAN,
    mac VARCHAR(200),
    otros TEXT,
    grupo_sanguineo VARCHAR(10),
    fuma BOOLEAN,
    cigarrillos_dia INT,
    toma_te BOOLEAN,
    tazas_te_dia INT,
    toma_alcohol BOOLEAN,
    frecuencia_alcohol VARCHAR(100),
    aprieta_dientes BOOLEAN,
    momento_aprieta VARCHAR(100),
    rechina BOOLEAN,
    dolor_muscular BOOLEAN,
    chupa_dedo BOOLEAN,
    muerde_objetos BOOLEAN,
    muerde_labios BOOLEAN,
    frecuencia_cepillado INT,
    otros_habitos TEXT,
    CONSTRAINT fk_antpersonal_historia FOREIGN KEY (id_historia) REFERENCES historia_clinica(id_historia)
);

-- HABITOS (relación N:M con catálogo)
CREATE TABLE antecedente_habito (
    id_ant_habito INT PRIMARY KEY AUTO_INCREMENT,
    id_antecedente INT,
    id_habito INT,
    valor BOOLEAN,
    CONSTRAINT fk_anthabito_ant FOREIGN KEY (id_antecedente) REFERENCES antecedente_personal(id_antecedente),
    CONSTRAINT fk_anthabito_catalogo FOREIGN KEY (id_habito) REFERENCES catalogo_habito(id_habito)
);

-- ==============================
-- ANTECEDENTES PATOLOGICOS
-- ==============================
CREATE TABLE antecedente_patologico (
    id_ant_patologico INT PRIMARY KEY AUTO_INCREMENT,
    id_historia INT,
    salud_general VARCHAR(50),
    bajo_tratamiento BOOLEAN,
    tipo_tratamiento VARCHAR(200),
    hospitalizaciones TEXT,
    traumatismos TEXT,
    alergias TEXT,
    medicamentos_contraindicados TEXT,
    odontologicos TEXT,
    CONSTRAINT fk_antpat_historia FOREIGN KEY (id_historia) REFERENCES historia_clinica(id_historia)
);

-- Enfermedades específicas (N:M con catálogo)
CREATE TABLE antecedente_enfermedad (
    id_ant_enf INT PRIMARY KEY AUTO_INCREMENT,
    id_ant_patologico INT,
    id_enfermedad INT,
    tiene BOOLEAN,
    CONSTRAINT fk_antenf_ant FOREIGN KEY (id_ant_patologico) REFERENCES antecedente_patologico(id_ant_patologico),
    CONSTRAINT fk_antenf_catalogo FOREIGN KEY (id_enfermedad) REFERENCES catalogo_enfermedad(id_enfermedad)
);

-- ==============================
-- ANTECEDENTES FAMILIARES
-- ==============================
CREATE TABLE antecedente_familiar (
    id_ant_fam INT PRIMARY KEY AUTO_INCREMENT,
    id_historia INT,
    descripcion TEXT,
    CONSTRAINT fk_antfam_historia FOREIGN KEY (id_historia) REFERENCES historia_clinica(id_historia)
);

-- ==============================
-- EXAMEN FISICO
-- ==============================
CREATE TABLE examen_fisico (
    id_examen INT PRIMARY KEY AUTO_INCREMENT,
    id_historia INT,
    aspecto_general VARCHAR(200),
    conciencia TEXT,
    constitucion VARCHAR(50),
    estado_nutritivo VARCHAR(50),
    temperatura VARCHAR(50),
    presion_arterial VARCHAR(50),
    frecuencia_respiratoria VARCHAR(50),
    pulso VARCHAR(50),
    peso DECIMAL(5,2),
    talla DECIMAL(5,2),
    observaciones TEXT,
    CONSTRAINT fk_examen_historia FOREIGN KEY (id_historia) REFERENCES historia_clinica(id_historia)
);

-- ==============================
-- DIAGNOSTICOS
-- ==============================
CREATE TABLE diagnostico (
    id_diagnostico INT PRIMARY KEY AUTO_INCREMENT,
    id_historia INT,
    descripcion TEXT,
    definitivo BOOLEAN,
    fecha DATE,
    CONSTRAINT fk_diag_historia FOREIGN KEY (id_historia) REFERENCES historia_clinica(id_historia)
);

-- ==============================
-- REFERENCIAS A CLINICAS
-- ==============================
CREATE TABLE referencia_clinica (
    id_ref INT PRIMARY KEY AUTO_INCREMENT,
    id_historia INT,
    id_clinica INT,
    observaciones TEXT,
    fecha DATE,
    CONSTRAINT fk_ref_historia FOREIGN KEY (id_historia) REFERENCES historia_clinica(id_historia),
    CONSTRAINT fk_ref_clinica FOREIGN KEY (id_clinica) REFERENCES catalogo_clinica(id_clinica)
);

-- ==============================
-- EXAMENES AUXILIARES
-- ==============================
CREATE TABLE examen_auxiliar (
    id_examen_auxiliar INT PRIMARY KEY AUTO_INCREMENT,
    id_historia INT,
    id_examen INT,
    detalle VARCHAR(200),
    CONSTRAINT fk_exaux_historia FOREIGN KEY (id_historia) REFERENCES historia_clinica(id_historia),
    CONSTRAINT fk_exaux_catalogo FOREIGN KEY (id_examen) REFERENCES catalogo_examen_auxiliar(id_examen)
);

-- ==============================
-- EVOLUCION
-- ==============================
CREATE TABLE evolucion (
    id_evolucion INT PRIMARY KEY AUTO_INCREMENT,
    id_historia INT,
    fecha DATE,
    actividad TEXT,
    alumno VARCHAR(200),
    CONSTRAINT fk_evol_historia FOREIGN KEY (id_historia) REFERENCES historia_clinica(id_historia)
);

