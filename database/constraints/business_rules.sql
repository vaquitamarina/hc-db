------------------------------------------------------------------
-- ARCHIVO: business_rules.sql
-- DESCRIPCION: Reglas de negocio complejas del sistema
------------------------------------------------------------------

-- Reglas de validación de fechas
ALTER TABLE filiacion ADD CONSTRAINT chk_filiacion_fecha_nacimiento 
    CHECK (fecha_nacimiento <= CURRENT_DATE);

ALTER TABLE filiacion ADD CONSTRAINT chk_filiacion_ultima_visita_dentista 
    CHECK (ultima_visita_dentista <= CURRENT_DATE);

ALTER TABLE filiacion ADD CONSTRAINT chk_filiacion_ultima_visita_medico 
    CHECK (ultima_visita_medico <= CURRENT_DATE);

-- Validaciones de formato DNI (8 dígitos)
ALTER TABLE usuario ADD CONSTRAINT chk_usuario_dni_formato 
    CHECK (dni ~ '^[0-9]{8}$');

ALTER TABLE paciente ADD CONSTRAINT chk_paciente_dni_formato 
    CHECK (dni ~ '^[0-9]{8}$');

-- Validaciones para antecedentes personales
ALTER TABLE antecedente_personal ADD CONSTRAINT chk_antecedente_personal_cigarrillos 
    CHECK (cigarrillos_dia >= 0 AND cigarrillos_dia <= 100);

ALTER TABLE antecedente_personal ADD CONSTRAINT chk_antecedente_personal_tazas_te 
    CHECK (tazas_te_dia >= 0 AND tazas_te_dia <= 20);

ALTER TABLE antecedente_personal ADD CONSTRAINT chk_antecedente_personal_frecuencia_cepillado 
    CHECK (frecuencia_cepillado >= 0 AND frecuencia_cepillado <= 10);

-- Validaciones para examen general
ALTER TABLE examen_general ADD CONSTRAINT chk_examen_general_peso 
    CHECK (peso > 0 AND peso <= 500);

ALTER TABLE examen_general ADD CONSTRAINT chk_examen_general_talla 
    CHECK (talla > 0 AND talla <= 300);

-- Validaciones para historia clínica
ALTER TABLE historia_clinica ADD CONSTRAINT chk_historia_clinica_fecha_elaboracion 
    CHECK (fecha_elaboracion <= CURRENT_DATE);

-- Validaciones para revisión
ALTER TABLE revision_historia ADD CONSTRAINT chk_revision_historia_fecha 
    CHECK (fecha <= CURRENT_DATE);

-- Validaciones para diagnóstico
ALTER TABLE diagnostico ADD CONSTRAINT chk_diagnostico_fecha 
    CHECK (fecha <= CURRENT_DATE);

-- Validaciones para referencia clínica
ALTER TABLE referencia_clinica ADD CONSTRAINT chk_referencia_clinica_fecha 
    CHECK (fecha <= CURRENT_DATE);

ALTER TABLE referencia_clinica ADD CONSTRAINT chk_referencia_clinica_estado 
    CHECK (estado IN ('pendiente', 'atendida', 'cancelada'));

-- Validaciones para evolución
ALTER TABLE evolucion ADD CONSTRAINT chk_evolucion_fecha 
    CHECK (fecha <= CURRENT_DATE);