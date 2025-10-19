------------------------------------------------------------------
-- ARCHIVO: 05_anamnesis.sql
-- DESCRIPCION: Tablas de anamnesis (filiación, motivo consulta, enfermedad actual, antecedentes)
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
    acompaniante VARCHAR(200)
);

-- Motivo de consulta
CREATE TABLE motivo_consulta (
    id_motivo UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    id_historia UUID,
    motivo TEXT NOT NULL,
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
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
    tratamiento_prev TEXT
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
    frecuencia_cepillado INT
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
    odontologicos TEXT
);

-- Antecedentes familiares
CREATE TABLE antecedente_familiar (
    id_ant_fam UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    id_historia UUID UNIQUE,
    descripcion TEXT
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
    desagrado_atencion TEXT
);