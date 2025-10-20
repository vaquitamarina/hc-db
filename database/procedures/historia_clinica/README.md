# 📝 Procedimientos de Historia Clínica

Este directorio contiene todos los procedimientos almacenados para registrar información en las historias clínicas odontológicas.

## 📋 Lista de Procedimientos

### Anamnesis

| Procedimiento | Descripción | Archivo |
|--------------|-------------|---------|
| `i_filiacion` | Registra datos de filiación del paciente | `i_filiacion.sql` |
| `i_motivo_consulta` | Registra el motivo de la consulta | `i_motivo_consulta.sql` |
| `i_enfermedad_actual` | Registra la enfermedad actual | `i_enfermedad_actual.sql` |

### Antecedentes

| Procedimiento | Descripción | Archivo |
|--------------|-------------|---------|
| `i_antecedente_personal` | Registra antecedentes personales (hábitos, grupo sanguíneo, etc.) | `i_antecedente_personal.sql` |
| `i_antecedente_medico` | Registra antecedentes médicos (alergias, tratamientos, etc.) | `i_antecedente_medico.sql` |
| `i_antecedente_familiar` | Registra antecedentes familiares | `i_antecedente_familiar.sql` |
| `i_antecedente_cumplimiento` | Registra antecedentes de cumplimiento odontológico | `i_antecedente_cumplimiento.sql` |

### Exámenes

| Procedimiento | Descripción | Archivo |
|--------------|-------------|---------|
| `i_examen_general` | Registra examen físico general | `i_examen_general.sql` |
| `i_examen_regional` | Registra examen de cabeza y cuello | `i_examen_regional.sql` |
| `i_examen_atm` | Registra examen de articulación temporomandibular | `i_examen_atm.sql` |
| `i_atm_movimiento` | Registra movimientos mandibulares en examen ATM | `i_atm_movimiento.sql` |
| `i_examen_auxiliar` | Registra exámenes auxiliares solicitados | `i_examen_auxiliar.sql` |

### Diagnóstico y Evolución

| Procedimiento | Descripción | Archivo |
|--------------|-------------|---------|
| `i_diagnostico` | Registra un diagnóstico | `i_diagnostico.sql` |
| `i_referencia_clinica` | Registra referencia a clínica especializada | `i_referencia_clinica.sql` |
| `i_evolucion` | Registra la evolución del tratamiento | `i_evolucion.sql` |

### Sistema

| Función/Procedimiento | Descripción | Archivo |
|--------------|-------------|---------|
| `fn_crear_historia_clinica` | Crea una nueva historia clínica (función) | `fn_crear_historia_clinica.sql` |
| `i_revision_historia` | Registra revisión docente | `i_revision_historia.sql` |

---

## 🎯 Patrón de Diseño

Todos los procedimientos siguen el mismo patrón:

### 1. **Nomenclatura**
```
i_<nombre_tabla>
```
- `i_` = Insert (procedimiento de inserción)
- Ejemplo: `i_filiacion`, `i_diagnostico`

### 2. **Parámetros con Prefijo**
```sql
IN p_<nombre_campo>
```
- Todos los parámetros comienzan con `p_`
- Ejemplo: `p_id_historia`, `p_descripcion`

### 3. **Conversión de Catálogos**
Los procedimientos reciben **descripciones** y buscan automáticamente los **UUIDs** de los catálogos:

```sql
-- Usuario envía: "Soltero"
IN p_estado_civil_desc VARCHAR(50)

-- Procedimiento busca automáticamente:
SELECT id_estado_civil INTO v_id_estado_civil 
FROM catalogo_estado_civil 
WHERE descripcion = p_estado_civil_desc;

-- Inserta el UUID en la tabla
INSERT INTO filiacion (id_estado_civil) VALUES (v_id_estado_civil);
```

**Ventaja:** El API no necesita conocer los UUIDs, solo las descripciones legibles.

### 4. **Manejo de Errores**
Todos los procedimientos capturan y reportan errores específicos:

```sql
EXCEPTION
    WHEN foreign_key_violation THEN
        RAISE EXCEPTION 'Mensaje específico...';
    WHEN unique_violation THEN
        RAISE EXCEPTION 'Mensaje específico...';
    WHEN others THEN
        RAISE EXCEPTION 'Error genérico: %', SQLERRM;
```

### 5. **Mensajes de Confirmación**
```sql
RAISE NOTICE 'Operación exitosa para historia %.', p_id_historia;
```

---

## 📖 Ejemplos de Uso

### Registrar Filiación Completa
```sql
CALL i_filiacion(
    p_id_historia := '123e4567-e89b-12d3-a456-426614174000',
    p_raza := 'Mestiza',
    p_fecha_nacimiento := '1990-05-15',
    p_lugar := 'Tacna',
    p_estado_civil_desc := 'Soltero',
    p_nombre_conyuge := NULL,
    p_ocupacion_desc := 'Estudiante',
    p_lugar_procedencia := 'Tacna',
    p_tiempo_residencia_tacna := '25 años',
    p_direccion := 'Av. Bolognesi 123',
    p_grado_instruccion_desc := 'Superior Universitaria',
    p_ultima_visita_dentista := '2024-01-10',
    p_motivo_visita_dentista := 'Limpieza dental',
    p_ultima_visita_medico := '2024-03-15',
    p_motivo_visita_medico := 'Chequeo general',
    p_contacto_emergencia := 'María López',
    p_telefono_emergencia := '952123456',
    p_acompaniante := 'Juan Pérez'
);
```

### Registrar Motivo de Consulta
```sql
CALL i_motivo_consulta(
    p_id_historia := '123e4567-e89b-12d3-a456-426614174000',
    p_motivo := 'Dolor en molar inferior derecho de 3 días de evolución'
);
```

### Registrar Antecedentes Personales
```sql
CALL i_antecedente_personal(
    p_id_historia := '123e4567-e89b-12d3-a456-426614174000',
    p_esta_embarazada := FALSE,
    p_mac := NULL,
    p_otros := NULL,
    p_psicosocial := 'Paciente colaborador',
    p_vacunas := 'Esquema completo',
    p_hepatitis_b := TRUE,
    p_grupo_sanguineo_desc := 'O+',
    p_fuma := FALSE,
    p_cigarrillos_dia := 0,
    p_toma_te := TRUE,
    p_tazas_te_dia := 2,
    p_toma_alcohol := FALSE,
    p_frecuencia_alcohol := NULL,
    p_aprieta_dientes := TRUE,
    p_momento_aprieta := 'Durante el sueño',
    p_rechina := FALSE,
    p_dolor_muscular := FALSE,
    p_chupa_dedo := FALSE,
    p_muerde_objetos := FALSE,
    p_muerde_labios := FALSE,
    p_otros_habitos := NULL,
    p_frecuencia_cepillado := 3
);
```

### Registrar Diagnóstico
```sql
CALL i_diagnostico(
    p_id_historia := '123e4567-e89b-12d3-a456-426614174000',
    p_descripcion := 'Caries dental en pieza 4.6 (Molar inferior derecho)',
    p_definitivo := TRUE
);
```

### Registrar Evolución
```sql
CALL i_evolucion(
    p_id_historia := '123e4567-e89b-12d3-a456-426614174000',
    p_actividad := 'Obturación con resina compuesta en pieza 4.6',
    p_alumno := 'Vaquita Marina - 2023-119018',
    p_observaciones := 'Procedimiento realizado sin complicaciones. Paciente toleró bien.'
);
```

---

## 🔄 Flujo de Trabajo Típico

```
1. Crear Historia Clínica
   └─> SELECT fn_crear_historia_clinica(p_id_estudiante)
       └─> Retorna: id_historia (UUID)

2. Registrar Anamnesis
   ├─> CALL i_filiacion(id_historia, ...)
   ├─> CALL i_motivo_consulta(id_historia, ...)
   └─> CALL i_enfermedad_actual(id_historia, ...)

3. Registrar Antecedentes
   ├─> CALL i_antecedente_personal(id_historia, ...)
   ├─> CALL i_antecedente_medico(id_historia, ...)
   ├─> CALL i_antecedente_familiar(id_historia, ...)
   └─> CALL i_antecedente_cumplimiento(id_historia, ...)

4. Registrar Exámenes
   ├─> CALL i_examen_general(id_historia, ...)
   ├─> CALL i_examen_regional(id_historia, ...)
   └─> CALL i_examen_atm(id_historia, ...)
       └─> CALL i_atm_movimiento(id_examen_atm, ...) [múltiples]

5. Solicitar Exámenes Auxiliares
   └─> CALL i_examen_auxiliar(id_historia, ...) [múltiples]

6. Registrar Diagnóstico
   └─> CALL i_diagnostico(id_historia, ...) [múltiples]

7. Registrar Referencias (si aplica)
   └─> CALL i_referencia_clinica(id_historia, ...)

8. Registrar Evoluciones
   └─> CALL i_evolucion(id_historia, ...) [múltiples, una por sesión]

9. Revisión Docente
   └─> CALL i_revision_historia(id_historia, id_docente, ...)
```

---

## ⚠️ Consideraciones Importantes

### Validaciones Automáticas
- ✅ Los procedimientos validan que los catálogos existan
- ✅ Verifican foreign keys automáticamente
- ✅ Previenen duplicados (unique constraints)
- ✅ Reportan errores específicos

### Campos UNIQUE
Estas tablas solo permiten **un registro por historia**:
- `filiacion`
- `enfermedad_actual`
- `antecedente_personal`
- `antecedente_medico`
- `antecedente_familiar`
- `antecedente_cumplimiento`
- `examen_general`
- `examen_regional`
- `examen_atm`

Estas tablas permiten **múltiples registros por historia**:
- `motivo_consulta` (puede haber múltiples motivos)
- `examen_auxiliar` (múltiples exámenes)
- `diagnostico` (múltiples diagnósticos)
- `evolucion` (múltiples evoluciones)
- `referencia_clinica` (múltiples referencias)

### Timestamps Automáticos
Los siguientes campos se registran automáticamente:
- `motivo_consulta.fecha_registro` → CURRENT_TIMESTAMP
- `examen_auxiliar.fecha_solicitud` → CURRENT_TIMESTAMP
- `diagnostico.fecha` → CURRENT_DATE
- `referencia_clinica.fecha` → CURRENT_DATE
- `evolucion.fecha` → CURRENT_DATE

---

## 🎓 Para tu Exposición

**Puntos clave a mencionar:**

1. **"15 procedimientos almacenados"** - Uno para cada sección de la historia clínica

2. **"Patrón consistente"** - Todos siguen la misma estructura y nomenclatura

3. **"Conversión automática de catálogos"** - El API envía descripciones legibles, no UUIDs

4. **"Validación robusta"** - Manejo de errores específico para cada caso

5. **"Integridad referencial"** - Los procedimientos garantizan que no se rompan las relaciones

6. **"Transaccionalidad"** - Si algo falla, no se guarda nada (rollback automático)

---

## 📚 Referencias

- Convenciones de nomenclatura: `_standard.md`
- Estructura de tablas: `database/tables/`
- Catálogos disponibles: `database/tables/01_catalogos.sql`
