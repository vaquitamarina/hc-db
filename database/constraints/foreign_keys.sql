------------------------------------------------------------------
-- ARCHIVO: foreign_keys.sql
-- DESCRIPCION: Foreign Keys (relaciones) del sistema
------------------------------------------------------------------

-- Foreign Keys de tabla paciente
ALTER TABLE paciente ADD CONSTRAINT fk_paciente_catalogo_sexo 
    FOREIGN KEY (id_sexo) REFERENCES catalogo_sexo (id_sexo);

-- Foreign Keys de tabla historia_clinica
ALTER TABLE historia_clinica ADD CONSTRAINT fk_historia_clinica_paciente 
    FOREIGN KEY (id_paciente) REFERENCES paciente (id_paciente);

ALTER TABLE historia_clinica ADD CONSTRAINT fk_historia_clinica_usuario 
    FOREIGN KEY (id_estudiante) REFERENCES usuario (id_usuario);

-- Foreign Keys de tabla revision_historia
ALTER TABLE revision_historia ADD CONSTRAINT fk_revision_historia_historia_clinica 
    FOREIGN KEY (id_historia) REFERENCES historia_clinica (id_historia);

ALTER TABLE revision_historia ADD CONSTRAINT fk_revision_historia_usuario 
    FOREIGN KEY (id_docente) REFERENCES usuario (id_usuario);

ALTER TABLE revision_historia ADD CONSTRAINT fk_revision_historia_catalogo_estado_revision 
    FOREIGN KEY (id_estado_revision) REFERENCES catalogo_estado_revision (id_estado_revision);

-- Foreign Keys de tabla filiacion
ALTER TABLE filiacion ADD CONSTRAINT fk_filiacion_catalogo_estado_civil 
    FOREIGN KEY (id_estado_civil) REFERENCES catalogo_estado_civil (id_estado_civil);

ALTER TABLE filiacion ADD CONSTRAINT fk_filiacion_catalogo_ocupacion 
    FOREIGN KEY (id_ocupacion) REFERENCES catalogo_ocupacion (id_ocupacion);

ALTER TABLE filiacion ADD CONSTRAINT fk_filiacion_catalogo_grado_instruccion 
    FOREIGN KEY (id_grado_instruccion) REFERENCES catalogo_grado_instruccion (id_grado_instruccion);

ALTER TABLE filiacion ADD CONSTRAINT fk_filiacion_historia_clinica 
    FOREIGN KEY (id_historia) REFERENCES historia_clinica (id_historia);

-- Foreign Keys de tabla motivo_consulta
ALTER TABLE motivo_consulta ADD CONSTRAINT fk_motivo_consulta_historia_clinica 
    FOREIGN KEY (id_historia) REFERENCES historia_clinica (id_historia);

-- Foreign Keys de tabla enfermedad_actual
ALTER TABLE enfermedad_actual ADD CONSTRAINT fk_enfermedad_actual_historia_clinica 
    FOREIGN KEY (id_historia) REFERENCES historia_clinica (id_historia);

-- Foreign Keys de tabla antecedente_personal
ALTER TABLE antecedente_personal ADD CONSTRAINT fk_antecedente_personal_historia_clinica 
    FOREIGN KEY (id_historia) REFERENCES historia_clinica (id_historia);

ALTER TABLE antecedente_personal ADD CONSTRAINT fk_antecedente_personal_catalogo_grupo_sanguineo 
    FOREIGN KEY (id_grupo_sanguineo) REFERENCES catalogo_grupo_sanguineo (id_grupo_sanguineo);

-- Foreign Keys de tabla antecedente_medico
ALTER TABLE antecedente_medico ADD CONSTRAINT fk_antecedente_medico_historia_clinica 
    FOREIGN KEY (id_historia) REFERENCES historia_clinica (id_historia);

-- Foreign Keys de tabla antecedente_familiar
ALTER TABLE antecedente_familiar ADD CONSTRAINT fk_antecedente_familiar_historia_clinica 
    FOREIGN KEY (id_historia) REFERENCES historia_clinica (id_historia);

-- Foreign Keys de tabla antecedente_cumplimiento
ALTER TABLE antecedente_cumplimiento ADD CONSTRAINT fk_antecedente_cumplimiento_historia_clinica 
    FOREIGN KEY (id_historia) REFERENCES historia_clinica (id_historia);

-- Foreign Keys de tabla examen_general
ALTER TABLE examen_general ADD CONSTRAINT fk_examen_general_historia_clinica 
    FOREIGN KEY (id_historia) REFERENCES historia_clinica (id_historia);

ALTER TABLE examen_general ADD CONSTRAINT fk_examen_general_catalogo_posicion 
    FOREIGN KEY (id_posicion) REFERENCES catalogo_posicion (id_posicion);

-- Foreign Keys de tabla examen_regional
ALTER TABLE examen_regional ADD CONSTRAINT fk_examen_regional_historia_clinica 
    FOREIGN KEY (id_historia) REFERENCES historia_clinica (id_historia);

ALTER TABLE examen_regional ADD CONSTRAINT fk_examen_regional_catalogo_medida_regional_craneo 
    FOREIGN KEY (id_craneo_forma) REFERENCES catalogo_medida_regional (id_medida);

ALTER TABLE examen_regional ADD CONSTRAINT fk_examen_regional_catalogo_medida_regional_cara 
    FOREIGN KEY (id_cara_forma) REFERENCES catalogo_medida_regional (id_medida);

ALTER TABLE examen_regional ADD CONSTRAINT fk_examen_regional_catalogo_medida_regional_perfil 
    FOREIGN KEY (id_perfil_ap) REFERENCES catalogo_medida_regional (id_medida);

-- Foreign Keys de tabla examen_atm
ALTER TABLE examen_atm ADD CONSTRAINT fk_examen_atm_historia_clinica 
    FOREIGN KEY (id_historia) REFERENCES historia_clinica (id_historia);

ALTER TABLE examen_atm ADD CONSTRAINT fk_examen_atm_catalogo_atm_trayectoria 
    FOREIGN KEY (id_trayectoria) REFERENCES catalogo_atm_trayectoria (id_trayectoria);

ALTER TABLE examen_atm ADD CONSTRAINT fk_examen_atm_catalogo_dolor_grado 
    FOREIGN KEY (id_grado_dolor) REFERENCES catalogo_dolor_grado (id_grado);

-- Foreign Keys de tabla atm_movimiento_condicion
ALTER TABLE atm_movimiento_condicion ADD CONSTRAINT fk_atm_movimiento_condicion_examen_atm 
    FOREIGN KEY (id_examen_atm) REFERENCES examen_atm (id_examen_atm);

ALTER TABLE atm_movimiento_condicion ADD CONSTRAINT fk_atm_movimiento_condicion_catalogo_movimiento_mandibular 
    FOREIGN KEY (id_movimiento) REFERENCES catalogo_movimiento_mandibular (id_movimiento);

-- Foreign Keys de tabla examen_auxiliar
ALTER TABLE examen_auxiliar ADD CONSTRAINT fk_examen_auxiliar_historia_clinica 
    FOREIGN KEY (id_historia) REFERENCES historia_clinica (id_historia);

ALTER TABLE examen_auxiliar ADD CONSTRAINT fk_examen_auxiliar_catalogo_examen_auxiliar 
    FOREIGN KEY (id_examen) REFERENCES catalogo_examen_auxiliar (id_examen);

-- Foreign Keys de tabla diagnostico
ALTER TABLE diagnostico ADD CONSTRAINT fk_diagnostico_historia_clinica 
    FOREIGN KEY (id_historia) REFERENCES historia_clinica (id_historia);

-- Foreign Keys de tabla referencia_clinica
ALTER TABLE referencia_clinica ADD CONSTRAINT fk_referencia_clinica_historia_clinica 
    FOREIGN KEY (id_historia) REFERENCES historia_clinica (id_historia);

ALTER TABLE referencia_clinica ADD CONSTRAINT fk_referencia_clinica_catalogo_clinica 
    FOREIGN KEY (id_clinica) REFERENCES catalogo_clinica (id_clinica);

-- Foreign Keys de tabla evolucion
ALTER TABLE evolucion ADD CONSTRAINT fk_evolucion_historia_clinica 
    FOREIGN KEY (id_historia) REFERENCES historia_clinica (id_historia);

-- Foreign Keys de tabla auditoria
ALTER TABLE auditoria ADD CONSTRAINT fk_auditoria_usuario 
    FOREIGN KEY (id_usuario) REFERENCES usuario (id_usuario);