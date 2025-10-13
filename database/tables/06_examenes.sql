------------------------------------------------------------------
-- ARCHIVO: 06_examenes.sql
-- DESCRIPCION: Tablas de exámenes físicos (general, regional, ATM, auxiliares)
-- PROYECTO: SN-001-2025 - Sistema de Historias Clínicas
-- AUTOR: Equipo BD II - ESIS UNJBG
-- FECHA: 12/10/2025
------------------------------------------------------------------

-- Examen físico general
CREATE TABLE examen_general (
    id_examen UUID PRIMARY KEY DEFAULT gen_random_uuid()
    id_historia UUID UNIQUE
    id_posicion UUID
    actitud BOOLEAN
    deambulacion UUID
    facies VARCHAR(100)
    conciencia TEXT
    constitucion VARCHAR(50)
    estado_nutritivo VARCHAR(50)
    temperatura VARCHAR(50)
    presion_arterial VARCHAR(50)
    frecuencia_respiratoria VARCHAR(50)
    pulso VARCHAR(50)
    peso DECIMAL(5, 2)
    talla DECIMAL(5, 2)
    observaciones TEXT
);

-- Examen regional: cabeza y cuello
CREATE TABLE examen_regional (
    id_regional UUID PRIMARY KEY DEFAULT gen_random_uuid()
    id_historia UUID UNIQUE
    -- CABEZA
    id_craneo_forma UUID
    id_cara_forma UUID
    id_perfil_ap UUID
    -- OJOS y ANEXOS
    ojos_cejas_adecuada BOOLEAN
    ojos_implantacion_obs TEXT
    escleroticas VARCHAR(100)
    agudeza_visual_conservada BOOLEAN
    iris_color VARCHAR(50)
    arco_senil VARCHAR(50)
    -- NARIZ
    nariz_forma VARCHAR(100)
    nariz_permeables BOOLEAN
    nariz_secreciones BOOLEAN
    senos_paranasales_dolorosos BOOLEAN
    -- OIDOS
    oidos_anomalias_morfologicas BOOLEAN
    oidos_anomalias_obs TEXT
    oidos_secreciones BOOLEAN
    audicion_conservada BOOLEAN
    -- CUELLO
    cuello_simetrico BOOLEAN
    cuello_simetrico_obs TEXT
    cuello_movilidad_conservada BOOLEAN
    cuello_movilidad_obs TEXT
    laringe_alineada BOOLEAN
    laringe_alineada_obs TEXT
    cuello_otros TEXT
);

-- Examen de ATM (Articulación Temporomandibular)
CREATE TABLE examen_atm (
    id_examen_atm UUID PRIMARY KEY DEFAULT gen_random_uuid()
    id_historia UUID UNIQUE
    id_trayectoria UUID
    coordinacion_condilar BOOLEAN
    apertura_maxima_mm NUMERIC(5, 2)
    observaciones TEXT
    musculos_dolor_presente BOOLEAN
    id_musculos_dolor_grado UUID
    musculos_dolor_zona TEXT
);

-- Movimientos mandibulares en examen ATM
CREATE TABLE atm_movimiento_condicion (
    id_movimiento_condicion UUID PRIMARY KEY DEFAULT gen_random_uuid()
    id_examen_atm UUID NOT NULL
    id_movimiento UUID NOT NULL
    dolor BOOLEAN
    ruido BOOLEAN
    salto BOOLEAN
    UNIQUE (id_examen_atm, id_movimiento)
);

-- Exámenes auxiliares solicitados
CREATE TABLE examen_auxiliar (
    id_examen_auxiliar UUID PRIMARY KEY DEFAULT gen_random_uuid()
    id_historia UUID NOT NULL
    id_examen UUID NOT NULL
    detalle VARCHAR(200)
    fecha_solicitud TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
