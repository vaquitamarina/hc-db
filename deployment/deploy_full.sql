------------------------------------------------------------------
-- ARCHIVO: deploy_full.sql
-- DESCRIPCION: Script maestro para deployment completo del sistema
-- USO: psql -U postgres -d nombre_bd -f deploy_full.sql
------------------------------------------------------------------

\echo '========================================='
\echo 'INICIO DE DEPLOYMENT'
\echo 'Sistema de Historias Clínicas'
\echo 'Versión: 1.0.0'
\echo '========================================='
\echo ''

-- Configuración de la sesión
SET client_min_messages TO WARNING;

\echo '1. Creando tablas de catálogos...'
\i ../database/tables/01_catalogos.sql

\echo '2. Creando tabla de usuarios...'
\i ../database/tables/02_usuarios.sql

\echo '3. Creando tabla de pacientes...'
\i ../database/tables/03_pacientes.sql

\echo '4. Creando tablas de historia clínica...'
\i ../database/tables/04_historia_clinica.sql

\echo '5. Creando tablas de anamnesis...'
\i ../database/tables/05_anamnesis.sql

\echo '6. Creando tablas de exámenes...'
\i ../database/tables/06_examenes.sql

\echo '7. Creando tablas de diagnósticos...'
\i ../database/tables/07_diagnosticos.sql

\echo '8. Creando tabla de auditoría...'
\i ../database/tables/08_auditoria.sql

\echo '9. Creando funciones de consulta...'
\i ../database/functions/usuarios/fn_obtener_usuario.sql
\i ../database/functions/usuarios/fn_obtener_usuario_login.sql
\i ../database/functions/historia_clinica/fn_obtener_filiacion.sql
\i ../database/functions/historia_clinica/fn_crear_historia_clinica.sql
\i ../database/functions/estudiantes/fn_obtener_pacientes_adultos.sql

\echo '10. Creando procedimientos de usuarios y auditoría...'
\i ../database/procedures/usuarios/i_usuario.sql
\i ../database/procedures/auditoria/i_auditoria.sql

\echo '10a. Creando procedimientos de historia clínica - Anamnesis...'
\i ../database/procedures/historia_clinica/i_filiacion.sql
\i ../database/procedures/historia_clinica/i_motivo_consulta.sql
\i ../database/procedures/historia_clinica/i_enfermedad_actual.sql

\echo '10b. Creando procedimientos de historia clínica - Antecedentes...'
\i ../database/procedures/historia_clinica/i_antecedente_personal.sql
\i ../database/procedures/historia_clinica/i_antecedente_medico.sql
\i ../database/procedures/historia_clinica/i_antecedente_familiar.sql
\i ../database/procedures/historia_clinica/i_antecedente_cumplimiento.sql

\echo '10c. Creando procedimientos de historia clínica - Exámenes...'
\i ../database/procedures/historia_clinica/i_examen_general.sql
\i ../database/procedures/historia_clinica/i_examen_regional.sql
\i ../database/procedures/historia_clinica/i_examen_atm.sql
\i ../database/procedures/historia_clinica/i_atm_movimiento.sql
\i ../database/procedures/historia_clinica/i_examen_auxiliar.sql

\echo '10d. Creando procedimientos de historia clínica - Diagnóstico y Evolución...'
\i ../database/procedures/historia_clinica/i_diagnostico.sql
\i ../database/procedures/historia_clinica/i_referencia_clinica.sql
\i ../database/procedures/historia_clinica/i_evolucion.sql
\i ../database/procedures/historia_clinica/i_revision_historia.sql

\echo '11. Desplegando módulo de Pacientes...'
\i ../database/procedures/pacientes/i_paciente.sql
\i ../database/procedures/pacientes/u_paciente.sql
\i ../database/procedures/pacientes/d_paciente.sql
\i ../database/functions/pacientes/fn_obtener_paciente_por_id.sql
\i ../database/functions/pacientes/fn_buscar_paciente_por_dni.sql
\i ../database/functions/pacientes/fn_listar_pacientes.sql
\i ../database/functions/pacientes/s_pacientes_count.sql
\i ../database/functions/pacientes/s_pacientes_sin_historia_clinica.sql
\i ../database/functions/pacientes/fn_verificar_paciente_existe.sql

\echo '12. Aplicando constraints...'
\i ../database/constraints/foreign_keys.sql
\i ../database/constraints/check_constraints.sql
\i ../database/constraints/business_rules.sql

\echo '13. Creando triggers y funciones auxiliares...'
\i ../database/triggers/fn_auditoria_automatica.sql

\echo '14. Creando usuario del sistema...'
-- Insertar usuario del sistema para auditoría (sin trigger porque aún no están activos en esta tabla)
INSERT INTO usuario (
    id_usuario,
    codigo_usuario,
    nombre,
    apellido,
    dni,
    email,
    rol,
    contrasena_hash,
    activo
) VALUES (
    '00000000-0000-0000-0000-000000000000',
    'SYSTEM',
    'Sistema',
    'Automatico',
    '00000000',
    'system@historiaclinica.local',
    'admin',
    '$argon2id$v=19$m=65536,t=3,p=4$c29tZXNhbHQ$hash',  -- Hash dummy
    true
);
\i ../database/triggers/tr_auditoria_tablas.sql


\echo '15. Configurando usuario del sistema para seeds...'
-- Configurar usuario del sistema para que los triggers de auditoría funcionen
SET app.current_user_id = '00000000-0000-0000-0000-000000000000';

\echo '16. Insertando datos iniciales (seeds)...'
\i ../seeds/01_catalogos_base.sql
\i ../seeds/02_usuarios_estudiantes.sql
\i ../seeds/03_pacientes_desarrollo.sql
\i ../seeds/04_historias_filiaciones.sql

-- Limpiar configuración de sesión
RESET app.current_user_id;

\echo ''
\echo '========================================='
\echo 'DEPLOYMENT COMPLETADO EXITOSAMENTE'
\echo '========================================='
\echo ''
\echo '📊 RESUMEN DE DATOS CARGADOS:'
\echo '  • Estudiantes: 15 usuarios reales'
\echo '  • Pacientes: 50 pacientes de ejemplo'
\echo '  • Historias Clínicas: 10 con filiación completa'
\echo '  • Primer estudiante: 2023-119018 (Vaquita Marina)'
\echo '  • Rol: student'
\echo ''
\echo '🔐 Las contraseñas están hasheadas con Argon2ID'
\echo ''
\echo '📦 MÓDULOS INSTALADOS:'
\echo '  ✅ Catálogos base'
\echo '  ✅ Usuarios y autenticación'
\echo '  ✅ Módulo de Pacientes (3 procedures, 6 functions)'
\echo '  ✅ Historia Clínica (15 procedures para inserción)'
\echo '     • Anamnesis: filiación, motivo consulta, enfermedad actual'
\echo '     • Antecedentes: personal, médico, familiar, cumplimiento'
\echo '     • Exámenes: general, regional, ATM, auxiliares'
\echo '     • Diagnóstico: diagnóstico, referencias, evolución, revisión'
\echo '  ✅ Auditoría automática'
\echo '  ✅ Validaciones de negocio'
\echo '  ✅ Protección contra eliminación'
\echo ''
\echo '📝 TOTAL DE PROCEDIMIENTOS: 21'
\echo '🔍 TOTAL DE FUNCIONES: 11'
\echo '⚡ TOTAL DE TRIGGERS: 5'
\echo '========================================'
