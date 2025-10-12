------------------------------------------------------------------
-- ARCHIVO: verify_deployment.sql
-- DESCRIPCION: Script para verificar que el deployment fue exitoso
-- PROYECTO: SN-001-2025 - Sistema de Historias Clínicas
-- AUTOR: Equipo BD II - ESIS UNJBG
-- FECHA: 12/10/2025
------------------------------------------------------------------

\echo '========================================='
\echo 'VERIFICACIÓN DE DEPLOYMENT'
\echo '========================================='
\echo ''

-- Verificar tablas creadas
\echo '1. Verificando tablas...'
SELECT COUNT(*) AS total_tablas 
FROM information_schema.tables 
WHERE table_schema = 'public' 
AND table_type = 'BASE TABLE';

\echo ''
\echo 'Tablas principales:'
SELECT table_name 
FROM information_schema.tables 
WHERE table_schema = 'public' 
AND table_type = 'BASE TABLE'
ORDER BY table_name;

\echo ''
\echo '2. Verificando funciones...'
SELECT COUNT(*) AS total_funciones 
FROM information_schema.routines 
WHERE routine_schema = 'public' 
AND routine_type = 'FUNCTION';

\echo ''
\echo '3. Verificando procedimientos...'
SELECT COUNT(*) AS total_procedimientos 
FROM information_schema.routines 
WHERE routine_schema = 'public' 
AND routine_type = 'PROCEDURE';

\echo ''
\echo '4. Verificando vistas...'
SELECT COUNT(*) AS total_vistas 
FROM information_schema.views 
WHERE table_schema = 'public';

\echo ''
\echo '5. Verificando triggers...'
SELECT COUNT(*) AS total_triggers 
FROM information_schema.triggers 
WHERE trigger_schema = 'public';

\echo ''
\echo '6. Verificando datos de catálogos...'
SELECT 'catalogo_sexo' AS catalogo, COUNT(*) AS registros FROM catalogo_sexo
UNION ALL
SELECT 'catalogo_estado_civil', COUNT(*) FROM catalogo_estado_civil
UNION ALL
SELECT 'catalogo_grupo_sanguineo', COUNT(*) FROM catalogo_grupo_sanguineo
UNION ALL
SELECT 'catalogo_estado_revision', COUNT(*) FROM catalogo_estado_revision;

\echo ''
\echo '7. Verificando usuarios creados...'
SELECT usuario_login, nombre, apellido, rol 
FROM usuario 
WHERE activo = TRUE;

\echo ''
\echo '========================================='
\echo 'VERIFICACIÓN COMPLETADA'
\echo '========================================='
