------------------------------------------------------------------
-- ARCHIVO: 05_anamnesis.sql
-- DESCRIPCION: Tablas de anamnesis (filiación, motivo consulta, enfermedad actual, antecedentes)
-- PROYECTO: SN-001-2025 - Sistema de Historias Clínicas
-- AUTOR: Equipo BD II - ESIS UNJBG
-- FECHA: 12/10/2025
------------------------------------------------------------------

-- Datos de filiación del paciente
CREATE TABLE filiacion (
    id_filiacion UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    id_historia UUID UNIQUE,
    raza VARCHAR(100),
    fecha_nacimiento DATE,
    lugar VARCHAR(150),
    id_estado_civil UUID,
    nombre_conyuge VARCHAR(200),
    id_ocupacion UUID,
    lugar_procedencia VARCHAR(150),
    tiempo_residencia_tacna VARCHAR(50),
    direccion VARCHAR(200),
    id_grado_instruccion UUID,
    ultima_visita_dentista DATE,
    motivo_visita_dentista VARCHAR(300),
    ultima_visita_medico DATE,
    motivo_visita_medico VARCHAR(300),
    contacto_emergencia VARCHAR(200),
    telefono_emergencia VARCHAR(20),
    acompaniante VARCHAR(200),
    CONSTRAINT fk_filiacion_catalogo_estado_civil FOREIGN KEY (id_estado_civil) 
        REFERENCES catalogo_estado_civil (id_estado_civil),
    CONSTRAINT fk_filiacion_catalogo_ocupacion FOREIGN KEY (id_ocupacion) 
        REFERENCES catalogo_ocupacion (id_ocupacion),
    CONSTRAINT fk_filiacion_catalogo_grado_instruccion FOREIGN KEY (id_grado_instruccion) 
        REFERENCES catalogo_grado_instruccion (id_grado_instruccion),
    CONSTRAINT fk_filiacion_historia_clinica FOREIGN KEY (id_historia) 
        REFERENCES historia_clinica (id_historia)
);

-- Motivo de consulta
CREATE TABLE motivo_consulta (
    id_motivo UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    id_historia UUID,
    motivo TEXT NOT NULL,
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_motivo_consulta_historia_clinica FOREIGN KEY (id_historia) 
        REFERENCES historia_clinica (id_historia)
);

-- Enfermedad actual
CREATE TABLE enfermedad_actual (
    id_enfermedad_actual UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    id_historia UUID UNIQUE,
    sintoma_principal VARCHAR(300),
    tiempo_enfermedad VARCHAR(100),
    forma_inicio VARCHAR(200),
    curso VARCHAR(200),
    relato TEXT,
    tratamiento_prev TEXT,
    CONSTRAINT fk_enfermedad_actual_historia_clinica FOREIGN KEY (id_historia) 
        REFERENCES historia_clinica (id_historia)
);

-- Antecedentes personales
CREATE TABLE antecedente_personal (
    id_antecedente UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    id_historia UUID UNIQUE,
    esta_embarazada BOOLEAN,
    mac VARCHAR(200),
    otros TEXT,
    psicosocial TEXT,
    vacunas TEXT,
    hepatitis_b BOOLEAN,
    id_grupo_sanguineo UUID,
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
    otros_habitos TEXT,
    frecuencia_cepillado INT,
    CONSTRAINT fk_antecedente_personal_historia_clinica FOREIGN KEY (id_historia) 
        REFERENCES historia_clinica (id_historia),
    CONSTRAINT fk_antecedente_personal_catalogo_grupo_sanguineo FOREIGN KEY (id_grupo_sanguineo) 
        REFERENCES catalogo_grupo_sanguineo (id_grupo_sanguineo)
);

-- Antecedentes médicos
CREATE TABLE antecedente_medico (
    id_ant_patologico UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    id_historia UUID UNIQUE,
    salud_general VARCHAR(50),
    bajo_tratamiento BOOLEAN,
    tipo_tratamiento VARCHAR(200),
    hospitalizaciones TEXT,
    traumatismos TEXT,
    alergias TEXT,
    medicamentos_contraindicados TEXT,
    odontologicos TEXT,
    CONSTRAINT fk_antecedente_medico_historia_clinica FOREIGN KEY (id_historia) 
        REFERENCES historia_clinica (id_historia)
);

-- Antecedentes familiares
CREATE TABLE antecedente_familiar (
    id_ant_fam UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    id_historia UUID UNIQUE,
    descripcion TEXT,
    CONSTRAINT fk_antecedente_familiar_historia_clinica FOREIGN KEY (id_historia) 
        REFERENCES historia_clinica (id_historia)
);

-- Antecedentes de cumplimiento
CREATE TABLE antecedente_cumplimiento (
    id_ant_cumplimiento UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    id_historia UUID UNIQUE,
    dentista_dolor BOOLEAN,
    frecuenca_dentista VARCHAR(100),
    higiene_oral VARCHAR(100),
    tranquilo BOOLEAN,
    nervioso BOOLEAN,
    panico BOOLEAN,
    desagrado_atencion TEXT,
    CONSTRAINT fk_antecedente_cumplimiento_historia_clinica FOREIGN KEY (id_historia) 
        REFERENCES historia_clinica (id_historia)
);

COMMENT ON TABLE filiacion IS 'Datos demográficos y sociales del paciente';
COMMENT ON TABLE motivo_consulta IS 'Motivo principal de la consulta';
COMMENT ON TABLE enfermedad_actual IS 'Detalles de la enfermedad actual del paciente';
COMMENT ON TABLE antecedente_personal IS 'Antecedentes personales y hábitos del paciente';
COMMENT ON TABLE antecedente_medico IS 'Antecedentes médicos y patológicos';
COMMENT ON TABLE antecedente_familiar IS 'Antecedentes familiares relevantes';
COMMENT ON TABLE antecedente_cumplimiento IS 'Antecedentes de cumplimiento odontológico';
