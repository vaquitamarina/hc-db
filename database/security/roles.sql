------------------------------------------------------------------
-- ARCHIVO: roles.sql
-- DESCRIPCION: Configuración de roles y permisos de la base de datos
-- PROYECTO: SN-001-2025 - Sistema de Historias Clínicas
-- AUTOR: Equipo BD II - ESIS UNJBG
-- FECHA: 13/10/2025
------------------------------------------------------------------

/*
ESTRATEGIA DE SEGURIDAD:
========================
Este proyecto usa un ÚNICO usuario de BD (hc_api_user) que se conecta desde el backend.
La autorización y control de permisos se maneja a nivel de APLICACIÓN (API), no en PostgreSQL.

RAZONES:
- Connection pooling eficiente
- Arquitectura API REST estándar
- Control de roles mediante JWT tokens
- Auditoría en tabla 'auditoria'
- Simplicidad y mantenibilidad

ROLES DE APLICACIÓN (Backend):
- admin: Acceso completo al sistema
- estudiante: Registra y consulta historias clínicas
- docente: Revisa y aprueba historias clínicas

NOTA: Los roles se validan en el backend usando el campo 'tipo_usuario' de la tabla 'usuario'
*/

------------------------------------------------------------------
-- 1. CREAR ROL PARA LA API
------------------------------------------------------------------

-- Verificar si el rol existe, si no, crearlo
DO $$
BEGIN
    IF NOT EXISTS (SELECT FROM pg_roles WHERE rolname = 'hc_api_user') THEN
        CREATE ROLE hc_api_user WITH 
            LOGIN 
            PASSWORD 'hc_api_2025_secure_password'  -- CAMBIAR EN PRODUCCIÓN
            CONNECTION LIMIT 50;  -- Límite de conexiones simultáneas
        
        RAISE NOTICE 'Rol hc_api_user creado exitosamente';
    ELSE
        RAISE NOTICE 'Rol hc_api_user ya existe';
    END IF;
END
$$;

-- Comentario del rol
COMMENT ON ROLE hc_api_user IS 'Usuario de base de datos para la API del sistema de historias clínicas';

------------------------------------------------------------------
-- 2. PERMISOS BÁSICOS DE CONEXIÓN
------------------------------------------------------------------

-- Permiso para conectarse a la base de datos
-- NOTA: Reemplazar 'historias_clinicas' con el nombre real de tu BD
GRANT CONNECT ON DATABASE postgres TO hc_api_user;

-- Permiso para usar el esquema public
GRANT USAGE ON SCHEMA public TO hc_api_user;

------------------------------------------------------------------
-- 3. PERMISOS EN TABLAS
------------------------------------------------------------------

-- Permisos completos en todas las tablas existentes
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO hc_api_user;

-- Permisos en secuencias (para IDs autoincrementales si existieran)
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA public TO hc_api_user;

------------------------------------------------------------------
-- 4. PERMISOS EN FUNCIONES Y PROCEDIMIENTOS
------------------------------------------------------------------

-- Permisos para ejecutar funciones
GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA public TO hc_api_user;

-- Permisos para ejecutar procedimientos almacenados
GRANT EXECUTE ON ALL PROCEDURES IN SCHEMA public TO hc_api_user;

------------------------------------------------------------------
-- 5. PERMISOS PARA OBJETOS FUTUROS
------------------------------------------------------------------

-- Garantizar que los objetos creados en el futuro también tengan permisos
ALTER DEFAULT PRIVILEGES IN SCHEMA public 
    GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO hc_api_user;

ALTER DEFAULT PRIVILEGES IN SCHEMA public 
    GRANT USAGE, SELECT ON SEQUENCES TO hc_api_user;

ALTER DEFAULT PRIVILEGES IN SCHEMA public 
    GRANT EXECUTE ON FUNCTIONS TO hc_api_user;

ALTER DEFAULT PRIVILEGES IN SCHEMA public 
    GRANT EXECUTE ON PROCEDURES TO hc_api_user;

------------------------------------------------------------------
-- 6. VERIFICACIÓN DE PERMISOS
------------------------------------------------------------------

-- Ver permisos del rol
\echo ''
\echo '========================================='
\echo 'PERMISOS ASIGNADOS A hc_api_user:'
\echo '========================================='

-- Listar tablas con permisos
SELECT 
    schemaname,
    tablename,
    HAS_TABLE_PRIVILEGE('hc_api_user', schemaname||'.'||tablename, 'SELECT') AS can_select,
    HAS_TABLE_PRIVILEGE('hc_api_user', schemaname||'.'||tablename, 'INSERT') AS can_insert,
    HAS_TABLE_PRIVILEGE('hc_api_user', schemaname||'.'||tablename, 'UPDATE') AS can_update,
    HAS_TABLE_PRIVILEGE('hc_api_user', schemaname||'.'||tablename, 'DELETE') AS can_delete
FROM pg_tables 
WHERE schemaname = 'public'
ORDER BY tablename;

\echo ''
\echo 'Configuración de roles completada exitosamente'
\echo ''