------------------------------------------------------------------
-- ARCHIVO: deploy_full.sql
-- DESCRIPCION: Script maestro para deployment completo del sistema
-- PROYECTO: SN-001-2025 - Sistema de Historias Clínicas
-- AUTOR: Equipo BD II - ESIS UNJBG
-- FECHA: 12/10/2025
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

\echo '9. Creando funciones...'
\i ../database/functions/usuarios/s_usuario.sql
\i ../database/functions/usuarios/s_usuario_login.sql
\i ../database/functions/historia_clinica/s_filiacion.sql
\i ../database/functions/historia_clinica/i_historia_clinica.sql
\i ../database/functions/estudiantes/s_paciente_adulto.sql

\echo '10. Creando procedimientos...'
\i ../database/procedures/usuarios/i_usuario.sql
\i ../database/procedures/historia_clinica/i_filiacion.sql
\i ../database/procedures/historia_clinica/i_revision_historia.sql
\i ../database/procedures/auditoria/i_auditoria.sql

\echo '11. Desplegando módulo de Pacientes...'
\i ../database/procedures/pacientes/i_paciente.sql
\i ../database/procedures/pacientes/u_paciente.sql
\i ../database/procedures/pacientes/d_paciente.sql
\i ../database/functions/pacientes/s_paciente_by_id.sql
\i ../database/functions/pacientes/s_paciente_by_dni.sql
\i ../database/functions/pacientes/s_all_pacientes.sql
\i ../database/functions/pacientes/s_pacientes_count.sql
\i ../database/functions/pacientes/s_pacientes_sin_historia_clinica.sql
\i ../database/functions/pacientes/s_paciente_existe.sql

\echo '12. Aplicando constraints...'
\i ../database/constraints/foreign_keys.sql
\i ../database/constraints/check_constraints.sql
\i ../database/constraints/business_rules.sql

\echo '13. Insertando datos iniciales (seeds)...'
\i ../seeds/01_catalogos_base.sql
\i ../seeds/02_usuarios_estudiantes.sql
\i ../seeds/03_pacientes_desarrollo.sql

\echo ''
\echo '========================================='
\echo 'DEPLOYMENT COMPLETADO EXITOSAMENTE'
\echo '========================================='
\echo ''
\echo '📊 RESUMEN DE DATOS CARGADOS:'
\echo '  • Estudiantes: 15 usuarios reales'
\echo '  • Pacientes: 50 pacientes de ejemplo'
\echo '  • Primer estudiante: 2023-119018 (Vaquita Marina)'
\echo '  • Rol: student'
\echo ''
\echo '🔐 Las contraseñas están hasheadas con Argon2ID'
\echo ''
\echo '📦 MÓDULOS INSTALADOS:'
\echo '  ✅ Catálogos base'
\echo '  ✅ Usuarios y autenticación'
\echo '  ✅ Módulo de Pacientes (3 procedures, 6 functions)'
\echo '  ✅ Historia Clínica base'
\echo '  ✅ Auditoría'
\echo '========================================'
