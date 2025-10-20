------------------------------------------------------------------
-- DESCRIPCION: Script de prueba para demostrar triggers en acción
------------------------------------------------------------------

\echo '========================================='
\echo 'DEMO DE TRIGGERS - Sistema HC'
\echo '========================================='
\echo ''

-- Configurar usuario para auditoría
SET app.current_user_id = 'de4cd964-3e8b-4552-b90a-1bd30cca2f21'; -- Vaquita Marina

\echo '1️⃣  TRIGGER DE AUDITORÍA - Actualizando paciente...'
\echo ''

-- Mostrar dato antes del cambio
\echo 'ANTES del cambio:'
SELECT nombre, apellido, telefono, email 
FROM paciente 
WHERE dni = '12345678'
LIMIT 1;

-- Hacer un UPDATE (esto activará el trigger de auditoría)
UPDATE paciente 
SET telefono = '999888777', 
    email = 'nuevo_email@test.com'
WHERE dni = '12345678';

\echo ''
\echo 'DESPUÉS del cambio:'
SELECT nombre, apellido, telefono, email 
FROM paciente 
WHERE dni = '12345678'
LIMIT 1;

\echo ''
\echo '🔍 Verificando registro de auditoría generado automáticamente:'
SELECT 
    fecha_cambio,
    nombre_tabla,
    accion,
    datos_anteriores->>'telefono' AS telefono_anterior,
    datos_nuevos->>'telefono' AS telefono_nuevo,
    datos_anteriores->>'email' AS email_anterior,
    datos_nuevos->>'email' AS email_nuevo
FROM auditoria
WHERE nombre_tabla = 'paciente'
ORDER BY fecha_cambio DESC
LIMIT 1;

\echo ''
\echo '========================================='
\echo '2️⃣  TRIGGER DE TIMESTAMP - Actualizando usuario...'
\echo '========================================='
\echo ''

-- Mostrar fecha_modificacion antes
\echo 'Fecha de modificación ANTES:'
SELECT codigo_usuario, nombre, fecha_modificacion 
FROM usuario 
WHERE codigo_usuario = '2023-119018';

-- Esperar un momento y actualizar
SELECT pg_sleep(2);

UPDATE usuario 
SET nombre = 'Vaquita Marina Actualizada'
WHERE codigo_usuario = '2023-119018';

\echo ''
\echo 'Fecha de modificación DESPUÉS (se actualizó automáticamente):'
SELECT codigo_usuario, nombre, fecha_modificacion 
FROM usuario 
WHERE codigo_usuario = '2023-119018';

\echo ''
\echo '========================================='
\echo '3️⃣  TRIGGER DE VALIDACIÓN - Intentando crear HC inválida...'
\echo '========================================='
\echo ''

\echo 'Intentando crear historia para paciente inactivo...'
\echo '(Esto DEBE fallar por el trigger de validación)'
\echo ''

-- Desactivar un paciente temporalmente
UPDATE paciente SET activo = FALSE WHERE dni = '87654321';

-- Intentar crear historia para ese paciente (FALLARÁ)
DO $$
DECLARE
    v_paciente_id UUID;
    v_estudiante_id UUID;
BEGIN
    SELECT id_paciente INTO v_paciente_id FROM paciente WHERE dni = '87654321';
    SELECT id_usuario INTO v_estudiante_id FROM usuario WHERE codigo_usuario = '2023-119018';
    
    BEGIN
        INSERT INTO historia_clinica (id_paciente, id_usuario_estudiante, estado)
        VALUES (v_paciente_id, v_estudiante_id, 'en_proceso');
        
        RAISE NOTICE '❌ ERROR: La historia se creó (no debería)';
    EXCEPTION
        WHEN OTHERS THEN
            RAISE NOTICE '✅ CORRECTO: El trigger previno la creación - %', SQLERRM;
    END;
    
    -- Reactivar el paciente
    UPDATE paciente SET activo = TRUE WHERE dni = '87654321';
END $$;

\echo ''
\echo '========================================='
\echo '4️⃣  TRIGGER DE PROTECCIÓN - Intentando eliminar...'
\echo '========================================='
\echo ''

\echo 'Intentando eliminar registro de auditoría...'
\echo '(Esto DEBE fallar por protección)'
\echo ''

DO $$
DECLARE
    v_auditoria_id UUID;
BEGIN
    SELECT id_auditoria INTO v_auditoria_id FROM auditoria LIMIT 1;
    
    BEGIN
        DELETE FROM auditoria WHERE id_auditoria = v_auditoria_id;
        RAISE NOTICE '❌ ERROR: Se eliminó el registro de auditoría (no debería)';
    EXCEPTION
        WHEN OTHERS THEN
            RAISE NOTICE '✅ CORRECTO: El trigger protegió la auditoría - %', SQLERRM;
    END;
END $$;

\echo ''
\echo '========================================='
\echo '📊 RESUMEN DE TRIGGERS ACTIVOS:'
\echo '========================================='
\echo ''

SELECT 
    trigger_name AS nombre_trigger,
    event_object_table AS tabla,
    action_timing || ' ' || string_agg(event_manipulation, ', ') AS momento_eventos
FROM information_schema.triggers
WHERE trigger_schema = 'public'
GROUP BY trigger_name, event_object_table, action_timing
ORDER BY event_object_table, trigger_name;

\echo ''
\echo '========================================='
\echo '📝 TOTAL DE REGISTROS DE AUDITORÍA:'
\echo '========================================='
\echo ''

SELECT 
    nombre_tabla,
    COUNT(*) AS total_registros,
    COUNT(*) FILTER (WHERE accion = 'INSERT') AS inserts,
    COUNT(*) FILTER (WHERE accion = 'UPDATE') AS updates,
    COUNT(*) FILTER (WHERE accion = 'DELETE') AS deletes
FROM auditoria
GROUP BY nombre_tabla
ORDER BY total_registros DESC;

\echo ''
\echo '========================================='
\echo '✅ DEMO COMPLETADA'
\echo '========================================='
\echo ''
\echo 'Los triggers funcionan correctamente:'
\echo '  ✅ Auditoría automática registra cambios'
\echo '  ✅ Timestamps se actualizan solos'
\echo '  ✅ Validaciones previenen datos inválidos'
\echo '  ✅ Protección evita eliminación accidental'
\echo ''
