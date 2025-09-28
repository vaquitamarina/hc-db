CREATE EXTENSION IF NOT EXISTS "pgcrypto";

CREATE TABLE usuario (
    id_usuario UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    usuario_login VARCHAR(100) UNIQUE NOT NULL,
    nombre VARCHAR(200) NOT NULL,
    apellido VARCHAR(200) NOT NULL,
    dni VARCHAR(20) UNIQUE NOT NULL,
    email VARCHAR(200) UNIQUE NOT NULL,
    rol VARCHAR(50) NOT NULL,
    contrasena_hash VARCHAR(200) NOT NULL
);
CREATE TABLE paciente (
    id_paciente UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nombre_completo VARCHAR(200) NOT NULL,
    edad INT,
    id_sexo UUID,
    raza VARCHAR(100),
    fecha_nacimiento DATE,
    lugar VARCHAR(150),
    id_estado_civil UUID,
    nombre_conyuge VARCHAR(200),
    id_ocupacion UUID,
    lugar_procedencia VARCHAR(150),
    tiempo_residencia_tacna VARCHAR(50),
    direccion VARCHAR(200),
    telefono VARCHAR(20),
    id_grado_instruccion UUID,
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

CREATE TABLE historia_clinica (
    id_historia UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    id_paciente UUID NOT NULL,
    id_estudiante UUID NOT NULL,
    fecha_elaboracion DATE NOT NULL DEFAULT CURRENT_DATE,
    ultima_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_historia_paciente FOREIGN KEY (id_paciente) REFERENCES paciente(id_paciente),
    CONSTRAINT fk_historia_estudiante FOREIGN KEY (id_estudiante) REFERENCES usuario(id_usuario
);

CREATE TABLE revision_historia (
  id_revision UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  id_historia UUID,
  id_docente UUID,
  fecha DATE DEFAULT CURRENT_DATE,
  id_estado_revision UUID,
  observaciones TEXT,
  CONSTRAINT fk_revision_historia FOREIGN KEY (id_historia) REFERENCES historia_clinica(id_historia),
  CONSTRAINT fk_revision_docente FOREIGN KEY (id_docente) REFERENCES usuario(id_usuario),
  CONSTRAINT fk_revision_estado FOREIGN KEY (id_estado_revision) REFERENCES catalogo_estado_revision(id_estado_revision)
);

CREATE TABLE motivo_consulta (
    id_motivo UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    id_historia UUID,
    motivo TEXT,
    CONSTRAINT fk_motivo_historia FOREIGN KEY (id_historia) REFERENCES historia_clinica(id_historia)
);

CREATE TABLE enfermedad_actual (
    id_enfermedad_actual UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    id_historia UUID,
    sintoma_principal VARCHAR(300),
    tiempo_enfermedad VARCHAR(100),
    forma_inicio VARCHAR(200),
    curso VARCHAR(200),
    relato TEXT,
    tratamiento_prev TEXT,
    CONSTRAINT fk_enfactual_historia FOREIGN KEY (id_historia) REFERENCES historia_clinica(id_historia)
);

CREATE TABLE antecedente_personal (
    id_antecedente UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    id_historia UUID,
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
    CONSTRAINT fk_antpersonal_historia FOREIGN KEY (id_historia) REFERENCES historia_clinica(id_historia),
    CONSTRAINT fk_grupo_sanguineo FOREIGN KEY (id_grupo_sanguineo) REFERENCES catalogo_grupo_sanguineo(id_grupo_sanguineo)
);

CREATE TABLE antecedente_habito (
    id_ant_habito UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    id_antecedente UUID,
    id_habito UUID,
    valor BOOLEAN,
    CONSTRAINT fk_anthabito_ant FOREIGN KEY (id_antecedente) REFERENCES antecedente_personal(id_antecedente),
    CONSTRAINT fk_anthabito_catalogo FOREIGN KEY (id_habito) REFERENCES catalogo_habito(id_habito)
);

CREATE TABLE antecedente_patologico (
    id_ant_patologico UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    id_historia UUID,
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

CREATE TABLE antecedente_enfermedad (
    id_ant_enf UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    id_ant_patologico UUID,
    id_enfermedad UUID,
    tiene BOOLEAN,
    CONSTRAINT fk_antenf_ant FOREIGN KEY (id_ant_patologico) REFERENCES antecedente_patologico(id_ant_patologico),
    CONSTRAINT fk_antenf_catalogo FOREIGN KEY (id_enfermedad) REFERENCES catalogo_enfermedad(id_enfermedad)
);

CREATE TABLE antecedente_familiar (
    id_ant_fam UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    id_historia UUID,
    descripcion TEXT,
    CONSTRAINT fk_antfam_historia FOREIGN KEY (id_historia) REFERENCES historia_clinica(id_historia)
);

CREATE TABLE examen_fisico (
    id_examen UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    id_historia UUID,
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

CREATE TABLE diagnostico (
    id_diagnostico UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    id_historia UUID,
    descripcion TEXT,
    definitivo BOOLEAN,
    fecha DATE,
    CONSTRAINT fk_diag_historia FOREIGN KEY (id_historia) REFERENCES historia_clinica(id_historia)
);

CREATE TABLE referencia_clinica (
    id_ref UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    id_historia UUID,
    id_clinica UUID,
    observaciones TEXT,
    fecha DATE,
    CONSTRAINT fk_ref_historia FOREIGN KEY (id_historia) REFERENCES historia_clinica(id_historia),
    CONSTRAINT fk_ref_clinica FOREIGN KEY (id_clinica) REFERENCES catalogo_clinica(id_clinica)
);

CREATE TABLE examen_auxiliar (
    id_examen_auxiliar UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    id_historia UUID,
    id_examen UUID,
    detalle VARCHAR(200),
    CONSTRAINT fk_exaux_historia FOREIGN KEY (id_historia) REFERENCES historia_clinica(id_historia),
    CONSTRAINT fk_exaux_catalogo FOREIGN KEY (id_examen) REFERENCES catalogo_examen_auxiliar(id_examen)
);

CREATE TABLE evolucion (
    id_evolucion UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    id_historia UUID,
    fecha DATE,
    actividad TEXT,
    alumno VARCHAR(200),
    CONSTRAINT fk_evol_historia FOREIGN KEY (id_historia) REFERENCES historia_clinica(id_historia)
);

