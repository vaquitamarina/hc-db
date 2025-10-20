------------------------------------------------------------------
-- SEEDS: Historias Clínicas con Filiaciones
-- DESCRIPCION: 10 historias clínicas completas con datos de filiación
------------------------------------------------------------------

-- Variables para almacenar IDs
DO $$
DECLARE
    v_id_historia UUID;
    v_id_paciente UUID;
    v_id_estudiante UUID;
    v_contador INT := 0;
BEGIN
    -- ============================================================
    -- HISTORIA 1: Juan Carlos Pérez García (Masculino, 39 años)
    -- ============================================================
    SELECT id_paciente INTO v_id_paciente FROM paciente WHERE dni = '12345678';
    SELECT id_usuario INTO v_id_estudiante FROM usuario WHERE codigo_usuario = '2023-119018' LIMIT 1;
    
    INSERT INTO historia_clinica (id_paciente, id_estudiante, estado)
    VALUES (v_id_paciente, v_id_estudiante, 'en_proceso')
    RETURNING id_historia INTO v_id_historia;
    
    CALL i_filiacion(
        p_id_historia := v_id_historia,
        p_raza := 'Mestizo',
        p_fecha_nacimiento := '1985-03-15',
        p_lugar := 'Lima, Perú',
        p_estado_civil_desc := 'Casado',
        p_nombre_conyuge := 'María Luisa García Fernández',
        p_ocupacion_desc := 'Profesional',
        p_lugar_procedencia := 'Lima',
        p_tiempo_residencia_tacna := '5 años',
        p_direccion := 'Av. Bolognesi 1234, Tacna',
        p_grado_instruccion_desc := 'Universitario completo',
        p_ultima_visita_dentista := '2024-06-15',
        p_motivo_visita_dentista := 'Limpieza dental y chequeo general',
        p_ultima_visita_medico := '2024-08-20',
        p_motivo_visita_medico := 'Control anual de salud',
        p_contacto_emergencia := 'María Luisa García - Esposa',
        p_telefono_emergencia := '987654321',
        p_acompaniante := 'Solo'
    );
    
    v_contador := v_contador + 1;
    RAISE NOTICE '% - Filiación creada para: Juan Carlos Pérez García', v_contador;

    -- ============================================================
    -- HISTORIA 2: María Elena García Fernández (Femenino, 34 años)
    -- ============================================================
    SELECT id_paciente INTO v_id_paciente FROM paciente WHERE dni = '12345679';
    SELECT id_usuario INTO v_id_estudiante FROM usuario WHERE codigo_usuario = '2022-124008' LIMIT 1;
    
    INSERT INTO historia_clinica (id_paciente, id_estudiante, estado)
    VALUES (v_id_paciente, v_id_estudiante, 'en_proceso')
    RETURNING id_historia INTO v_id_historia;
    
    CALL i_filiacion(
        p_id_historia := v_id_historia,
        p_raza := 'Mestiza',
        p_fecha_nacimiento := '1990-04-12',
        p_lugar := 'Arequipa, Perú',
        p_estado_civil_desc := 'Soltero',
        p_nombre_conyuge := NULL,
        p_ocupacion_desc := 'Empleado/a',
        p_lugar_procedencia := 'Arequipa',
        p_tiempo_residencia_tacna := '2 años',
        p_direccion := 'Calle San Martín 567, Tacna',
        p_grado_instruccion_desc := 'Universitario completo',
        p_ultima_visita_dentista := '2023-12-10',
        p_motivo_visita_dentista := 'Dolor de muela',
        p_ultima_visita_medico := '2024-09-05',
        p_motivo_visita_medico := 'Chequeo ginecológico',
        p_contacto_emergencia := 'Rosa García - Madre',
        p_telefono_emergencia := '987654346',
        p_acompaniante := 'Su madre'
    );
    
    v_contador := v_contador + 1;
    RAISE NOTICE '% - Filiación creada para: María Elena García Fernández', v_contador;

    -- ============================================================
    -- HISTORIA 3: Carlos Eduardo Mamani Quispe (Masculino, 36 años)
    -- ============================================================
    SELECT id_paciente INTO v_id_paciente FROM paciente WHERE dni = '34567890';
    SELECT id_usuario INTO v_id_estudiante FROM usuario WHERE codigo_usuario = '2024-124031' LIMIT 1;
    
    INSERT INTO historia_clinica (id_paciente, id_estudiante, estado)
    VALUES (v_id_paciente, v_id_estudiante, 'en_proceso')
    RETURNING id_historia INTO v_id_historia;
    
    CALL i_filiacion(
        p_id_historia := v_id_historia,
        p_raza := 'Andino',
        p_fecha_nacimiento := '1988-11-30',
        p_lugar := 'Puno, Perú',
        p_estado_civil_desc := 'Conviviente',
        p_nombre_conyuge := 'Patricia Torres Silva',
        p_ocupacion_desc := 'Comerciante',
        p_lugar_procedencia := 'Puno',
        p_tiempo_residencia_tacna := '10 años',
        p_direccion := 'Jr. Zela 890, Tacna',
        p_grado_instruccion_desc := 'Secundaria completa',
        p_ultima_visita_dentista := '2022-03-20',
        p_motivo_visita_dentista := 'Extracción de muela del juicio',
        p_ultima_visita_medico := '2024-07-15',
        p_motivo_visita_medico := 'Dolor de espalda',
        p_contacto_emergencia := 'Patricia Torres - Conviviente',
        p_telefono_emergencia := '987654323',
        p_acompaniante := 'Su conviviente'
    );
    
    v_contador := v_contador + 1;
    RAISE NOTICE '% - Filiación creada para: Carlos Eduardo Mamani Quispe', v_contador;

    -- ============================================================
    -- HISTORIA 4: Ana Lucía Rodríguez Pérez (Femenino, 39 años)
    -- ============================================================
    SELECT id_paciente INTO v_id_paciente FROM paciente WHERE dni = '23456780';
    SELECT id_usuario INTO v_id_estudiante FROM usuario WHERE codigo_usuario = '2022-124009' LIMIT 1;
    
    INSERT INTO historia_clinica (id_paciente, id_estudiante, estado)
    VALUES (v_id_paciente, v_id_estudiante, 'completada')
    RETURNING id_historia INTO v_id_historia;
    
    CALL i_filiacion(
        p_id_historia := v_id_historia,
        p_raza := 'Mestiza',
        p_fecha_nacimiento := '1985-08-25',
        p_lugar := 'Cusco, Perú',
        p_estado_civil_desc := 'Divorciado',
        p_nombre_conyuge := NULL,
        p_ocupacion_desc := 'Independiente',
        p_lugar_procedencia := 'Cusco',
        p_tiempo_residencia_tacna := '3 años',
        p_direccion := 'Av. Pinto 456, Tacna',
        p_grado_instruccion_desc := 'Técnico completo',
        p_ultima_visita_dentista := '2024-01-10',
        p_motivo_visita_dentista := 'Blanqueamiento dental',
        p_ultima_visita_medico := '2024-05-12',
        p_motivo_visita_medico := 'Control de presión arterial',
        p_contacto_emergencia := 'Luis Rodríguez - Hermano',
        p_telefono_emergencia := '987654322',
        p_acompaniante := 'Su hija'
    );
    
    v_contador := v_contador + 1;
    RAISE NOTICE '% - Filiación creada para: Ana Lucía Rodríguez Pérez', v_contador;

    -- ============================================================
    -- HISTORIA 5: Miguel Ángel Torres Vargas (Masculino, 32 años)
    -- ============================================================
    SELECT id_paciente INTO v_id_paciente FROM paciente WHERE dni = '45678901';
    SELECT id_usuario INTO v_id_estudiante FROM usuario WHERE codigo_usuario = '2022-124010' LIMIT 1;
    
    INSERT INTO historia_clinica (id_paciente, id_estudiante, estado)
    VALUES (v_id_paciente, v_id_estudiante, 'en_proceso')
    RETURNING id_historia INTO v_id_historia;
    
    CALL i_filiacion(
        p_id_historia := v_id_historia,
        p_raza := 'Mestizo',
        p_fecha_nacimiento := '1992-05-18',
        p_lugar := 'Tacna, Perú',
        p_estado_civil_desc := 'Soltero',
        p_nombre_conyuge := NULL,
        p_ocupacion_desc := 'Estudiante',
        p_lugar_procedencia := 'Tacna',
        p_tiempo_residencia_tacna := 'Toda la vida',
        p_direccion := 'Calle Apurímac 234, Tacna',
        p_grado_instruccion_desc := 'Universitario incompleto',
        p_ultima_visita_dentista := '2023-11-20',
        p_motivo_visita_dentista := 'Caries dental',
        p_ultima_visita_medico := '2024-02-14',
        p_motivo_visita_medico := 'Gripe común',
        p_contacto_emergencia := 'Rosa Vargas - Madre',
        p_telefono_emergencia := '987654324',
        p_acompaniante := 'Solo'
    );
    
    v_contador := v_contador + 1;
    RAISE NOTICE '% - Filiación creada para: Miguel Ángel Torres Vargas', v_contador;

    -- ============================================================
    -- HISTORIA 6: Carmen Rosa Mamani Quispe (Femenino, 32 años)
    -- ============================================================
    SELECT id_paciente INTO v_id_paciente FROM paciente WHERE dni = '34567891';
    SELECT id_usuario INTO v_id_estudiante FROM usuario WHERE codigo_usuario = '2021-124021' LIMIT 1;
    
    INSERT INTO historia_clinica (id_paciente, id_estudiante, estado)
    VALUES (v_id_paciente, v_id_estudiante, 'en_proceso')
    RETURNING id_historia INTO v_id_historia;
    
    CALL i_filiacion(
        p_id_historia := v_id_historia,
        p_raza := 'Andina',
        p_fecha_nacimiento := '1992-12-30',
        p_lugar := 'Juliaca, Perú',
        p_estado_civil_desc := 'Casado',
        p_nombre_conyuge := 'Roberto Huanca Nina',
        p_ocupacion_desc := 'Ama de casa',
        p_lugar_procedencia := 'Puno',
        p_tiempo_residencia_tacna := '7 años',
        p_direccion := 'Av. Circunvalación 789, Tacna',
        p_grado_instruccion_desc := 'Secundaria completa',
        p_ultima_visita_dentista := '2024-03-05',
        p_motivo_visita_dentista := 'Control de ortodoncia',
        p_ultima_visita_medico := '2024-09-18',
        p_motivo_visita_medico := 'Control prenatal',
        p_contacto_emergencia := 'Roberto Huanca - Esposo',
        p_telefono_emergencia := '987654326',
        p_acompaniante := 'Su esposo'
    );
    
    v_contador := v_contador + 1;
    RAISE NOTICE '% - Filiación creada para: Carmen Rosa Mamani Quispe', v_contador;

    -- ============================================================
    -- HISTORIA 7: Roberto Carlos Huanca Nina (Masculino, 29 años)
    -- ============================================================
    SELECT id_paciente INTO v_id_paciente FROM paciente WHERE dni = '67890123';
    SELECT id_usuario INTO v_id_estudiante FROM usuario WHERE codigo_usuario = '2022-124003' LIMIT 1;
    
    INSERT INTO historia_clinica (id_paciente, id_estudiante, estado)
    VALUES (v_id_paciente, v_id_estudiante, 'completada')
    RETURNING id_historia INTO v_id_historia;
    
    CALL i_filiacion(
        p_id_historia := v_id_historia,
        p_raza := 'Andino',
        p_fecha_nacimiento := '1995-01-12',
        p_lugar := 'Puno, Perú',
        p_estado_civil_desc := 'Casado',
        p_nombre_conyuge := 'Carmen Rosa Mamani Quispe',
        p_ocupacion_desc := 'Empleado/a',
        p_lugar_procedencia := 'Puno',
        p_tiempo_residencia_tacna := '7 años',
        p_direccion := 'Av. Circunvalación 789, Tacna',
        p_grado_instruccion_desc := 'Universitario completo',
        p_ultima_visita_dentista := '2024-02-20',
        p_motivo_visita_dentista := 'Implante dental',
        p_ultima_visita_medico := '2024-06-10',
        p_motivo_visita_medico := 'Examen médico laboral',
        p_contacto_emergencia := 'Carmen Mamani - Esposa',
        p_telefono_emergencia := '987654348',
        p_acompaniante := 'Solo'
    );
    
    v_contador := v_contador + 1;
    RAISE NOTICE '% - Filiación creada para: Roberto Carlos Huanca Nina', v_contador;

    -- ============================================================
    -- HISTORIA 8: Patricia Isabel Torres Silva (Femenino, 36 años)
    -- ============================================================
    SELECT id_paciente INTO v_id_paciente FROM paciente WHERE dni = '45678902';
    SELECT id_usuario INTO v_id_estudiante FROM usuario WHERE codigo_usuario = '2021-124030' LIMIT 1;
    
    INSERT INTO historia_clinica (id_paciente, id_estudiante, estado)
    VALUES (v_id_paciente, v_id_estudiante, 'en_proceso')
    RETURNING id_historia INTO v_id_historia;
    
    CALL i_filiacion(
        p_id_historia := v_id_historia,
        p_raza := 'Mestiza',
        p_fecha_nacimiento := '1988-06-15',
        p_lugar := 'Moquegua, Perú',
        p_estado_civil_desc := 'Viudo',
        p_nombre_conyuge := NULL,
        p_ocupacion_desc := 'Profesional',
        p_lugar_procedencia := 'Moquegua',
        p_tiempo_residencia_tacna := '4 años',
        p_direccion := 'Calle Coronel Vidal 345, Tacna',
        p_grado_instruccion_desc := 'Posgrado',
        p_ultima_visita_dentista := '2024-07-08',
        p_motivo_visita_dentista := 'Endodoncia',
        p_ultima_visita_medico := '2024-08-22',
        p_motivo_visita_medico := 'Control de diabetes',
        p_contacto_emergencia := 'Laura Silva - Hermana',
        p_telefono_emergencia := '987654349',
        p_acompaniante := 'Su hijo'
    );
    
    v_contador := v_contador + 1;
    RAISE NOTICE '% - Filiación creada para: Patricia Isabel Torres Silva', v_contador;

    -- ============================================================
    -- HISTORIA 9: Fernando Luis Apaza Choque (Masculino, 35 años)
    -- ============================================================
    SELECT id_paciente INTO v_id_paciente FROM paciente WHERE dni = '78901234';
    SELECT id_usuario INTO v_id_estudiante FROM usuario WHERE codigo_usuario = '2021-124035' LIMIT 1;
    
    INSERT INTO historia_clinica (id_paciente, id_estudiante, estado)
    VALUES (v_id_paciente, v_id_estudiante, 'en_proceso')
    RETURNING id_historia INTO v_id_historia;
    
    CALL i_filiacion(
        p_id_historia := v_id_historia,
        p_raza := 'Andino',
        p_fecha_nacimiento := '1989-04-08',
        p_lugar := 'Tacna, Perú',
        p_estado_civil_desc := 'Conviviente',
        p_nombre_conyuge := 'Gabriela Apaza Nina',
        p_ocupacion_desc := 'Independiente',
        p_lugar_procedencia := 'Tacna',
        p_tiempo_residencia_tacna := 'Toda la vida',
        p_direccion := 'Pasaje Los Andes 123, Tacna',
        p_grado_instruccion_desc := 'Técnico completo',
        p_ultima_visita_dentista := '2023-09-15',
        p_motivo_visita_dentista := 'Prótesis dental',
        p_ultima_visita_medico := '2024-04-30',
        p_motivo_visita_medico := 'Lesión deportiva',
        p_contacto_emergencia := 'Gabriela Apaza - Conviviente',
        p_telefono_emergencia := '987654352',
        p_acompaniante := 'Su conviviente'
    );
    
    v_contador := v_contador + 1;
    RAISE NOTICE '% - Filiación creada para: Fernando Luis Apaza Choque', v_contador;

    -- ============================================================
    -- HISTORIA 10: Laura Sofía Flores Vargas (Femenino, 29 años)
    -- ============================================================
    SELECT id_paciente INTO v_id_paciente FROM paciente WHERE dni = '56789013';
    SELECT id_usuario INTO v_id_estudiante FROM usuario WHERE codigo_usuario = '2022-124005' LIMIT 1;
    
    INSERT INTO historia_clinica (id_paciente, id_estudiante, estado)
    VALUES (v_id_paciente, v_id_estudiante, 'completada')
    RETURNING id_historia INTO v_id_historia;
    
    CALL i_filiacion(
        p_id_historia := v_id_historia,
        p_raza := 'Mestiza',
        p_fecha_nacimiento := '1995-02-20',
        p_lugar := 'Lima, Perú',
        p_estado_civil_desc := 'Soltero',
        p_nombre_conyuge := NULL,
        p_ocupacion_desc := 'Profesional',
        p_lugar_procedencia := 'Lima',
        p_tiempo_residencia_tacna := '1 año',
        p_direccion := 'Calle Arias Aragüez 678, Tacna',
        p_grado_instruccion_desc := 'Universitario completo',
        p_ultima_visita_dentista := '2024-05-25',
        p_motivo_visita_dentista := 'Limpieza y fluorización',
        p_ultima_visita_medico := '2024-09-10',
        p_motivo_visita_medico := 'Chequeo anual preventivo',
        p_contacto_emergencia := 'Rosa Flores - Madre',
        p_telefono_emergencia := '987654325',
        p_acompaniante := 'Sola'
    );
    
    v_contador := v_contador + 1;
    RAISE NOTICE '% - Filiación creada para: Laura Sofía Flores Vargas', v_contador;

    RAISE NOTICE '';
    RAISE NOTICE '========================================';
    RAISE NOTICE '✅ SEED COMPLETADO: % filiaciones creadas', v_contador;
    RAISE NOTICE '========================================';
END $$;

-- Verificación de datos insertados
\echo ''
\echo '========================================='
\echo '📊 RESUMEN DE HISTORIAS Y FILIACIONES'
\echo '========================================='

SELECT 
    'Total Historias Clínicas' as concepto,
    COUNT(*)::TEXT as cantidad
FROM historia_clinica
UNION ALL
SELECT 
    'Historias en Proceso',
    COUNT(*)::TEXT
FROM historia_clinica WHERE estado = 'en_proceso'
UNION ALL
SELECT 
    'Historias Completadas',
    COUNT(*)::TEXT
FROM historia_clinica WHERE estado = 'completada'
UNION ALL
SELECT 
    'Total Filiaciones',
    COUNT(*)::TEXT
FROM filiacion;


\echo ''
\echo '========================================='
\echo '✅ SEED 04: Historias y Filiaciones completado exitosamente'
\echo '========================================='
