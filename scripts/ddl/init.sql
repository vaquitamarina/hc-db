CREATE EXTENSION IF NOT EXISTS "pgcrypto";

CREATE TABLE usuario (
    id_usuario uuid PRIMARY KEY DEFAULT gen_random_uuid (),
    usuario_login varchar(100) UNIQUE NOT NULL,
    nombre varchar(200) NOT NULL,
    apellido varchar(200) NOT NULL,
    dni varchar(20) UNIQUE NOT NULL,
    email varchar(200) UNIQUE NOT NULL,
    rol varchar(50) NOT NULL,
    contrasena_hash varchar(200) NOT NULL
);

CREATE TABLE paciente (
    id_paciente uuid PRIMARY KEY DEFAULT gen_random_uuid (),
    nombre_completo varchar(200) NOT NULL,
    edad int,
    id_sexo uuid,
    telefono varchar(20),
    email varchar(200),
    CONSTRAINT fk_paciente_sexo FOREIGN KEY (id_sexo) REFERENCES catalogo_sexo (id_sexo)
);

CREATE TABLE historia_clinica (
    id_historia uuid PRIMARY KEY DEFAULT gen_random_uuid (),
    id_paciente uuid NOT NULL,
    id_estudiante uuid NOT NULL,
    fecha_elaboracion date NOT NULL DEFAULT CURRENT_DATE,
    ultima_modificacion timestamp DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_historia_paciente FOREIGN KEY (id_paciente) REFERENCES paciente (id_paciente),
    CONSTRAINT fk_historia_estudiante FOREIGN KEY (id_estudiante) REFERENCES usuario (id_usuario)
);

CREATE TABLE revision_historia (
    id_revision uuid PRIMARY KEY DEFAULT gen_random_uuid (),
    id_historia uuid,
    id_docente uuid,
    fecha date DEFAULT CURRENT_DATE,
    id_estado_revision uuid,
    observaciones text,
    CONSTRAINT fk_revision_historia FOREIGN KEY (id_historia) REFERENCES historia_clinica (id_historia),
    CONSTRAINT fk_revision_docente FOREIGN KEY (id_docente) REFERENCES usuario (id_usuario),
    CONSTRAINT fk_revision_estado FOREIGN KEY (id_estado_revision) REFERENCES catalogo_estado_revision (id_estado_revision)
);

CREATE TABLE auditoria (
    id_auditoria uuid PRIMARY KEY DEFAULT gen_random_uuid (),
    id_usuario uuid NOT NULL,
    fecha_cambio timestamp NOT NULL DEFAULT NOW(),
    nombre_tabla varchar(50) NOT NULL,
    id_registro_afectado uuid NOT NULL,
    accion varchar(10) NOT NULL,
    datos_anteriores jsonb,
    datos_nuevos jsonb,
    CONSTRAINT fk_auditoria_usuarios FOREIGN KEY (id_usuario) REFERENCES usuario (id_usuario)
);

CREATE TABLE filiacion (
    id_filiacion uuid PRIMARY KEY DEFAULT gen_random_uuid (),
    id_historia uuid,
    raza varchar(100),
    fecha_nacimiento date,
    lugar varchar(150),
    id_estado_civil uuid,
    nombre_conyuge varchar(200),
    id_ocupacion uuid,
    lugar_procedencia varchar(150),
    tiempo_residencia_tacna varchar(50),
    direccion varchar(200),
    id_grado_instruccion uuid,
    ultima_visita_dentista date,
    motivo_visita_dentista varchar(300),
    ultima_visita_medico date,
    motivo_visita_medico varchar(300),
    contacto_emergencia varchar(200),
    telefono_emergencia varchar(20),
    acompaniante varchar(200),
    CONSTRAINT fk_paciente_estado_civil FOREIGN KEY (id_estado_civil) REFERENCES catalogo_estado_civil (id_estado_civil),
    CONSTRAINT fk_paciente_ocupacion FOREIGN KEY (id_ocupacion) REFERENCES catalogo_ocupacion (id_ocupacion),
    CONSTRAINT fk_paciente_grado FOREIGN KEY (id_grado_instruccion) REFERENCES catalogo_grado_instruccion (id_grado_instruccion),
    CONSTRAINT fk_historia_filiacion FOREIGN KEY (id_historia) REFERENCES historia_clinica (id_historia)
);

CREATE TABLE motivo_consulta (
    id_motivo uuid PRIMARY KEY DEFAULT gen_random_uuid (),
    id_historia uuid,
    motivo text,
    CONSTRAINT fk_motivo_historia FOREIGN KEY (id_historia) REFERENCES historia_clinica (id_historia)
);

CREATE TABLE enfermedad_actual (
    id_enfermedad_actual uuid PRIMARY KEY DEFAULT gen_random_uuid (),
    id_historia uuid,
    sintoma_principal varchar(300),
    tiempo_enfermedad varchar(100),
    forma_inicio varchar(200),
    curso varchar(200),
    relato text,
    tratamiento_prev text,
    CONSTRAINT fk_enfactual_historia FOREIGN KEY (id_historia) REFERENCES historia_clinica (id_historia)
);

CREATE TABLE antecedente_personal (
    id_antecedente uuid PRIMARY KEY DEFAULT gen_random_uuid (),
    id_historia uuid,
    esta_embarazada boolean,
    mac varchar(200),
    otros text,
    psicosocial text,
    vacunas text,
    hepatitis_b boolean,
    id_grupo_sanguineo uuid,
    fuma boolean,
    cigarrillos_dia int,
    toma_te boolean,
    tazas_te_dia int,
    toma_alcohol boolean,
    frecuencia_alcohol varchar(100),
    aprieta_dientes boolean,
    momento_aprieta varchar(100),
    rechina boolean,
    dolor_muscular boolean,
    chupa_dedo boolean,
    muerde_objetos boolean,
    muerde_labios boolean,
    otros_habitos text,
    frecuencia_cepillado int,
    CONSTRAINT fk_antpersonal_historia FOREIGN KEY (id_historia) REFERENCES historia_clinica (id_historia),
    CONSTRAINT fk_grupo_sanguineo FOREIGN KEY (id_grupo_sanguineo) REFERENCES catalogo_grupo_sanguineo (id_grupo_sanguineo)
);

CREATE TABLE antecedente_medico (
    id_ant_patologico uuid PRIMARY KEY DEFAULT gen_random_uuid (),
    id_historia uuid,
    salud_general varchar(50),
    bajo_tratamiento boolean,
    tipo_tratamiento varchar(200),
    hospitalizaciones text,
    traumatismos text,
    alergias text,
    medicamentos_contraindicados text,
    odontologicos text,
    CONSTRAINT fk_antpat_historia FOREIGN KEY (id_historia) REFERENCES historia_clinica (id_historia)
);

CREATE TABLE antecedente_familiar (
    id_ant_fam uuid PRIMARY KEY DEFAULT gen_random_uuid (),
    id_historia uuid,
    descripcion text,
    CONSTRAINT fk_antfam_historia FOREIGN KEY (id_historia) REFERENCES historia_clinica (id_historia)
);

CREATE TABLE antecedente_cumplimiento (
    id_ant_cumplimiento uuid PRIMARY KEY DEFAULT gen_random_uuid (),
    id_historia uuid,
    dentista_dolor boolean,
    frecuenca_dentista varchar(100),
    higiene_oral varchar(100),
    tranquilo boolean,
    nervioso boolean,
    panico boolean,
    desagrado_atencion text,
    CONSTRAINT fk_antcumpl_historia FOREIGN KEY (id_historia) REFERENCES historia_clinica (id_historia)
);

CREATE TABLE examen_general (
    id_examen uuid PRIMARY KEY DEFAULT gen_random_uuid (),
    id_historia uuid,
    id_posicion uuid,
    actitud boolean,
    deambulacion uuid,
    facies varchar(100),
    conciencia text,
    constitucion varchar(50),
    estado_nutritivo varchar(50),
    temperatura varchar(50),
    presion_arterial varchar(50),
    frecuencia_respiratoria varchar(50),
    pulso varchar(50),
    peso DECIMAL(5, 2),
    talla DECIMAL(5, 2),
    observaciones text,
    CONSTRAINT fk_examen_historia FOREIGN KEY (id_historia) REFERENCES historia_clinica (id_historia),
    CONSTRAINT fk_posicion FOREIGN KEY (id_posicion) REFERENCES catalogo_posicion (id_posicion)
);

-- 2. EXAMEN REGIONAL: CABEZA Y CUELLO
CREATE TABLE examen_regional (
    id_regional uuid PRIMARY KEY DEFAULT gen_random_uuid (),
    id_historia uuid UNIQUE,
    -- CABEZA (FKs a catalogo_medida_regional)
    id_craneo_forma uuid,
    id_cara_forma uuid,
    id_perfil_ap uuid,
    -- OJOS y ANEXOS
    ojos_cejas_adecuada boolean, -- Adecuada/Alterada (usando booleano, si es FALSE el texto va a obs)
    ojos_implantacion_obs text, -- Caja de texto de "Alterada"
    escleroticas varchar(100), -- Limpias/Pigmentadas
    agudeza_visual_conservada boolean, -- Sí/No
    iris_color varchar(50),
    arco_senil varchar(50),
    -- NARIZ
    nariz_forma varchar(100),
    nariz_permeables boolean, -- Sí/No
    nariz_secreciones boolean, -- Sí/No
    senos_paranasales_dolorosos boolean, -- Sí/No
    -- OIDOS
    oidos_anomalias_morfologicas boolean, -- No/Sí
    oidos_anomalias_obs text, -- Caja de texto de "Sí"
    oidos_secreciones boolean, -- Sí/No
    audicion_conservada boolean, -- Sí/No
    -- CUELLO (2.2 CUELLO)
    cuello_simetrico boolean, -- Simétrico/No simétrico
    cuello_simetrico_obs text,
    cuello_movilidad_conservada boolean, -- Conservada/Disminuida
    cuello_movilidad_obs text,
    laringe_alineada boolean, -- Alineada/No alineada
    laringe_alineada_obs text,
    cuello_otros text,
    CONSTRAINT fk_er_historia FOREIGN KEY (id_historia) REFERENCES historia_clinica (id_historia),
    CONSTRAINT fk_er_craneo FOREIGN KEY (id_craneo_forma) REFERENCES catalogo_medida_regional (id_medida),
    CONSTRAINT fk_er_cara FOREIGN KEY (id_cara_forma) REFERENCES catalogo_medida_regional (id_medida),
    CONSTRAINT fk_er_perfil FOREIGN KEY (id_perfil_ap) REFERENCES catalogo_medida_regional (id_medida)
);

-- 1. EXAMEN ATM MAESTRO
CREATE TABLE examen_atm (
    id_examen_atm uuid PRIMARY KEY DEFAULT gen_random_uuid (),
    id_historia uuid UNIQUE,
    -- 1. Trayectoria de Apertura (de descanso a apertura)
    id_trayectoria uuid, -- FK a catalogo_atm_trayectoria (Recta, Deflexión, Desviación)
    -- 2. Movimiento Mandibular (Coordinación y Apertura Máxima)
    coordinacion_condilar boolean, -- Checkbox: Sí/No
    apertura_maxima_mm numeric(5, 2), -- Apertura máxima … mm
    observaciones text, -- Observaciones
    -- 3. Músculos masticatorios (Dolor)
    musculos_dolor_presente boolean, -- Presente/Ausente
    id_musculos_dolor_grado uuid, -- FK a catalogo_dolor_grado
    musculos_dolor_zona text, -- Caja de texto (zona)
    CONSTRAINT fk_eatm_historia FOREIGN KEY (id_historia) REFERENCES historia_clinica (id_historia),
    CONSTRAINT fk_eatm_trayectoria FOREIGN KEY (id_trayectoria) REFERENCES catalogo_atm_trayectoria (id_trayectoria),
    CONSTRAINT fk_eatm_grado FOREIGN KEY (id_musculos_dolor_grado) REFERENCES catalogo_dolor_grado (id_grado)
);

-- Movimiento Mandibular (Lateralidad, Protrusión, Apertura, Cierre)
CREATE TABLE atm_movimiento_condicion (
    id_movimiento_condicion uuid PRIMARY KEY DEFAULT gen_random_uuid (),
    id_examen_atm uuid NOT NULL,
    id_movimiento uuid NOT NULL, -- FK a catalogo_movimiento_mandibular
    -- Los síntomas de cada movimiento (Radio button Sí/No)
    dolor boolean,
    ruido boolean,
    salto boolean,
    CONSTRAINT fk_amc_examen FOREIGN KEY (id_examen_atm) REFERENCES examen_atm (id_examen_atm),
    CONSTRAINT fk_amc_movimiento FOREIGN KEY (id_movimiento) REFERENCES catalogo_movimiento_mandibular (id_movimiento),
    UNIQUE (id_examen_atm, id_movimiento) -- Solo puede haber un registro por tipo de movimiento por examen.
);

CREATE TABLE diagnostico (
    id_diagnostico uuid PRIMARY KEY DEFAULT gen_random_uuid (),
    id_historia uuid,
    descripcion text,
    definitivo boolean,
    fecha date,
    CONSTRAINT fk_diag_historia FOREIGN KEY (id_historia) REFERENCES historia_clinica (id_historia)
);

CREATE TABLE referencia_clinica (
    id_ref uuid PRIMARY KEY DEFAULT gen_random_uuid (),
    id_historia uuid,
    id_clinica uuid,
    observaciones text,
    fecha date,
    CONSTRAINT fk_ref_historia FOREIGN KEY (id_historia) REFERENCES historia_clinica (id_historia),
    CONSTRAINT fk_ref_clinica FOREIGN KEY (id_clinica) REFERENCES catalogo_clinica (id_clinica)
);

CREATE TABLE examen_auxiliar (
    id_examen_auxiliar uuid PRIMARY KEY DEFAULT gen_random_uuid (),
    id_historia uuid,
    id_examen uuid,
    detalle varchar(200),
    CONSTRAINT fk_exaux_historia FOREIGN KEY (id_historia) REFERENCES historia_clinica (id_historia),
    CONSTRAINT fk_exaux_catalogo FOREIGN KEY (id_examen) REFERENCES catalogo_examen_auxiliar (id_examen)
);

CREATE TABLE evolucion (
    id_evolucion uuid PRIMARY KEY DEFAULT gen_random_uuid (),
    id_historia uuid,
    fecha date,
    actividad text,
    alumno varchar(200),
    CONSTRAINT fk_evol_historia FOREIGN KEY (id_historia) REFERENCES historia_clinica (id_historia)
);

