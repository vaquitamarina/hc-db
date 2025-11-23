------------------------------------------------------------------
-- ARCHIVO: 06_examenes.sql
-- DESCRIPCION: Tablas de exámenes físicos (general, regional, ATM, auxiliares)
------------------------------------------------------------------

-- Examen físico general
CREATE TABLE examen_general (
    id_examen UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    id_historia UUID UNIQUE,
    
    -- Aspecto General
    posicion VARCHAR(50),        -- Pie, Sentado, De cúbito
    actitud VARCHAR(50),         -- Activa, Pasiva
    deambulacion VARCHAR(50),    -- Embásica, Disbásica, Abásica
    facies VARCHAR(50),          -- No característica, Característica
    facies_obs TEXT,             -- Caja de texto para "Característica"
    conciencia TEXT,             -- Caja de texto GRANDE (G° conciencia, orientación, etc)
    constitucion VARCHAR(50),    -- Pícnico, Asténico, Normotipo
    estado_nutritivo VARCHAR(50),-- Adecuado, No adecuado
    
    -- Signos Vitales (Cajas de texto según tu pedido)
    temperatura VARCHAR(50),
    presion_arterial VARCHAR(50),
    frecuencia_respiratoria VARCHAR(50),
    pulso VARCHAR(50),
    peso DECIMAL(5,2),           -- Numérico kg
    talla DECIMAL(5,2),          -- Numérico cm
    
    -- Piel y Anexos
    piel_color VARCHAR(100),     -- Caja de texto
    piel_humedad VARCHAR(50),    -- Conservada, Disminuida
    piel_lesiones VARCHAR(50),   -- Ausentes, Presentes
    piel_lesiones_obs TEXT,      -- Caja de texto
    piel_anexos VARCHAR(50),     -- Sin Alteraciones, Alterados
    piel_anexos_obs TEXT,        -- Caja de texto
    
    -- Tejido Celular Subcutáneo (TCS)
    tcs_distribucion VARCHAR(50), -- Adecuada, No adecuada
    tcs_distribucion_obs TEXT,    -- Caja de texto
    tcs_cantidad VARCHAR(50),     -- Regular, Escasa, Abundante
    ganglios VARCHAR(50),         -- No palpables, Palpables
    ganglios_obs TEXT,            -- Caja de texto
    
    CONSTRAINT fk_examen_general_historia FOREIGN KEY (id_historia) REFERENCES historia_clinica(id_historia)
);

CREATE TABLE examen_regional (
    id_regional UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    id_historia UUID UNIQUE,
    
    -- === SECCIÓN 1: CABEZA ===
    cabeza_posicion VARCHAR(50),        -- Erecta, Deflexión
    cabeza_movimientos VARCHAR(50),     -- Tic, Temblor, Otros
    cabeza_movimientos_obs TEXT,        -- Caja texto
    craneo_tamano VARCHAR(50),          -- Mesa/Macro/Micro
    craneo_forma VARCHAR(50),           -- Braqui/Meso/Dolico
    cara_forma_frente VARCHAR(50),      -- Braqui/Meso/Dolico
    cara_forma_perfil VARCHAR(50),      -- Recto/Cóncavo/Convexo

    -- === SECCIÓN 2: ÓRGANOS DE LOS SENTIDOS ===
    -- Ojos
    ojos_cejas_adecuada BOOLEAN,
    ojos_implantacion_obs TEXT,
    ojos_escleroticas VARCHAR(50),
    ojos_agudeza_visual BOOLEAN,
    ojos_iris_color VARCHAR(50),
    ojos_arco_senil BOOLEAN,
    -- Nariz
    nariz_forma VARCHAR(100),
    nariz_permeables BOOLEAN,
    nariz_secreciones BOOLEAN,
    nariz_senos_dolorosos BOOLEAN,
    -- Oídos
    oidos_anomalias_morfologicas BOOLEAN,
    oidos_anomalias_obs TEXT,
    oidos_secreciones BOOLEAN,
    oidos_audicion_conservada BOOLEAN,

    -- === SECCIÓN 3: ATM (Aplanado para fácil manejo) ===
    atm_trayectoria VARCHAR(50),        -- Recta, Deflexión, Desviación
    
    -- Movimiento: Lateralidad Izquierda
    atm_lat_izq_dolor BOOLEAN,
    atm_lat_izq_ruido BOOLEAN,
    atm_lat_izq_salto BOOLEAN,
    -- Movimiento: Lateralidad Derecha
    atm_lat_der_dolor BOOLEAN,
    atm_lat_der_ruido BOOLEAN,
    atm_lat_der_salto BOOLEAN,
    -- Movimiento: Protrusión
    atm_prot_dolor BOOLEAN,
    atm_prot_ruido BOOLEAN,
    atm_prot_salto BOOLEAN,
    -- Movimiento: Apertura
    atm_aper_dolor BOOLEAN,
    atm_aper_ruido BOOLEAN,
    atm_aper_salto BOOLEAN,
    -- Movimiento: Cierre
    atm_cierre_dolor BOOLEAN,
    atm_cierre_ruido BOOLEAN,
    atm_cierre_salto BOOLEAN,

    -- Datos extra ATM
    atm_coordinacion_condilar BOOLEAN, -- Sí/No
    atm_apertura_maxima_mm NUMERIC(5,2),
    atm_observaciones TEXT,
    
    -- Músculos Masticatorios
    atm_musculos_dolor BOOLEAN,       -- Ausente/Presente
    atm_musculos_dolor_grado VARCHAR(50), -- Grado 0, 1, 2, 3
    atm_musculos_dolor_zona TEXT,     -- Caja de texto (zona)

    -- === SECCIÓN 4: CUELLO ===
    cuello_simetrico BOOLEAN,         -- Simétrico/No simétrico
    cuello_simetrico_obs TEXT,
    cuello_movilidad_conservada BOOLEAN, -- Conservada/Disminuida
    cuello_movilidad_obs TEXT,
    laringe_alineada BOOLEAN,         -- Alineada/No alineada
    laringe_alineada_obs TEXT,
    cuello_otros TEXT,

    CONSTRAINT fk_examen_regional_historia FOREIGN KEY (id_historia) REFERENCES historia_clinica(id_historia)
);

-- Exámenes auxiliares solicitados
CREATE TABLE examen_auxiliar (
    id_examen_auxiliar UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    id_historia UUID NOT NULL,
    id_examen UUID NOT NULL,
    detalle VARCHAR(200),
    fecha_solicitud TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
