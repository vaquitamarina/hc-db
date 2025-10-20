------------------------------------------------------------------
-- ARCHIVO: 01_catalogos_base.sql
-- DESCRIPCION: Datos iniciales de catálogos del sistema
------------------------------------------------------------------

-- Catálogo de Sexo
INSERT INTO catalogo_sexo (descripcion) VALUES
('Masculino'),
('Femenino');

-- Catálogo de Estado Civil
INSERT INTO catalogo_estado_civil (descripcion) VALUES
('Soltero'),
('Casado'),
('Conviviente'),
('Divorciado'),
('Viudo');

-- Catálogo de Grado de Instrucción
INSERT INTO catalogo_grado_instruccion (descripcion) VALUES
('Sin estudios'),
('Primaria incompleta'),
('Primaria completa'),
('Secundaria incompleta'),
('Secundaria completa'),
('Técnico incompleto'),
('Técnico completo'),
('Universitario incompleto'),
('Universitario completo'),
('Posgrado');

-- Catálogo de Ocupaciones
INSERT INTO catalogo_ocupacion (descripcion) VALUES
('Estudiante'),
('Empleado/a'),
('Independiente'),
('Ama de casa'),
('Jubilado/a'),
('Desempleado/a'),
('Profesional'),
('Comerciante'),
('Agricultor/a'),
('Otros');

-- Catálogo de Grupos Sanguíneos
INSERT INTO catalogo_grupo_sanguineo (descripcion) VALUES
('O+'),
('O-'),
('A+'),
('A-'),
('B+'),
('B-'),
('AB+'),
('AB-');

-- Catálogo de Estados de Revisión
INSERT INTO catalogo_estado_revision (nombre) VALUES
('Pendiente'),
('En revisión'),
('Aprobada'),
('Rechazada'),
('Requiere corrección');

-- Catálogo de Posiciones
INSERT INTO catalogo_posicion (posicion) VALUES
('Sentado'),
('De pie'),
('Decúbito dorsal'),
('Decúbito ventral'),
('Decúbito lateral');

-- Catálogo de Medidas Regionales
INSERT INTO catalogo_medida_regional (tipo_medida, descripcion) VALUES
('CRANEO_FORMA', 'Braquicéfalo'),
('CRANEO_FORMA', 'Dolicocéfalo'),
('CRANEO_FORMA', 'Mesocéfalo'),
('CARA_FORMA', 'Euriprosopo'),
('CARA_FORMA', 'Leptoprosopo'),
('CARA_FORMA', 'Mesoprosopo'),
('PERFIL_AP', 'Recto'),
('PERFIL_AP', 'Convexo'),
('PERFIL_AP', 'Cóncavo');

-- Catálogo de Trayectoria ATM
INSERT INTO catalogo_atm_trayectoria (descripcion) VALUES
('Recta'),
('Deflexión'),
('Desviación');

-- Catálogo de Grado de Dolor
INSERT INTO catalogo_dolor_grado (descripcion) VALUES
('Sin dolor'),
('Leve'),
('Moderado'),
('Severo'),
('Insoportable');

-- Catálogo de Movimientos Mandibulares
INSERT INTO catalogo_movimiento_mandibular (descripcion) VALUES
('Lateralidad derecha'),
('Lateralidad izquierda'),
('Protrusión'),
('Apertura'),
('Cierre');

-- Catálogo de Clínicas
INSERT INTO catalogo_clinica (nombre) VALUES
('Clínica de Odontología General'),
('Clínica de Ortodoncia'),
('Clínica de Periodoncia'),
('Clínica de Endodoncia'),
('Clínica de Cirugía Oral'),
('Clínica de Prótesis'),
('Clínica de Pediatría Odontológica'),
('Clínica de Rehabilitación Oral');

-- Catálogo de Exámenes Auxiliares
INSERT INTO catalogo_examen_auxiliar (descripcion) VALUES
('Radiografía periapical'),
('Radiografía panorámica'),
('Tomografía computarizada'),
('Modelos de estudio'),
('Fotografías clínicas'),
('Biopsia'),
('Hemograma completo'),
('Pruebas de coagulación'),
('Glicemia'),
('Otros análisis de laboratorio');

-- Secciones de Historia Clínica
INSERT INTO seccion_hc (nombre, orden) VALUES
('Anamnesis', 1),
('Examen físico', 2),
('Diagnósticos presuntivos', 3),
('Derivado a clínicas', 4),
('Diagnóstico en clínicas', 5),
('Evolución', 6);

COMMENT ON TABLE catalogo_sexo IS 'Datos seed insertados';
