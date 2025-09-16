# 💾 Documentación de la Base de Datos

Este documento describe la estructura y las convenciones de la base de datos del proyecto. Su objetivo es servir como una referencia central para todo el equipo de desarrollo, asegurando la consistencia y facilitando la comprensión del esquema de datos.

---

## 🏗️ Esquema de la Base de Datos

Aquí se presenta la estructura completa de las tablas, sus columnas y relaciones. Puedes visualizar el esquema a continuación: 

```sql
-- Incluir aquí el script completo para la creación de tablas (CREATE TABLE, FOREIGN KEY, etc.)
-- Ejemplo:
-- Tabla `usuarios`
CREATE TABLE usuarios (
    id_usuario UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    nombre VARCHAR(255) NOT NULL,
    apellido VARCHAR(255) NOT NULL,
    dni VARCHAR(20) UNIQUE NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    telefono VARCHAR(20),
    direccion VARCHAR(255),
    rol VARCHAR(50) NOT NULL,
    contrasena_hash VARCHAR(255) NOT NULL
);

-- Tabla `pacientes`
CREATE TABLE pacientes (
    id_paciente UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    nombre VARCHAR(255) NOT NULL,
    apellido VARCHAR(255) NOT NULL,
    dni VARCHAR(20) UNIQUE NOT NULL,
    fecha_nacimiento DATE,
    sexo VARCHAR(20),
    direccion VARCHAR(255),
    telefono VARCHAR(20)
);

-- Tabla `historias_clinicas`
CREATE TABLE historias_clinicas (
    id_historia UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    id_paciente UUID NOT NULL,
    id_alumno UUID NOT NULL,
    fecha_creacion DATE NOT NULL,
    CONSTRAINT fk_historias_clinicas_pacientes FOREIGN KEY (id_paciente) REFERENCES pacientes(id_paciente),
    CONSTRAINT fk_historias_clinicas_usuarios FOREIGN KEY (id_alumno) REFERENCES usuarios(id_usuario)
);

-- Tabla `revisiones_historia`
CREATE TABLE revisiones_historia (
    id_revision UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    id_historia UUID NOT NULL,
    id_docente UUID NOT NULL,
    fecha_revision DATE,
    estado VARCHAR(50) NOT NULL,
    observaciones TEXT,
    CONSTRAINT fk_revisiones_historia_historias_clinicas FOREIGN KEY (id_historia) REFERENCES historias_clinicas(id_historia),
    CONSTRAINT fk_revisiones_historia_usuarios FOREIGN KEY (id_docente) REFERENCES usuarios(id_usuario)
);

-- Tabla `anamnesis`
CREATE TABLE anamnesis (
  id_anamnesis UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  id_historia UUID NOT NULL,
  CONSTRAINT fk_anamnesis_historias_clinicas FOREIGN KEY (id_historia) REFERENCES historias_clinicas(id_historia)
);

-- Tabla `motivos_consulta`
CREATE TABLE motivos_consulta (
  id_motivo UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  id_anamnesis UUID NOT NULL,
  descripcion TEXT,
  CONSTRAINT fk_motivos_consulta_anamnesis FOREIGN KEY (id_anamnesis) REFERENCES anamnesis(id_anamnesis)
);

-- Tabla `enfermedades_actuales`
CREATE TABLE enfermedades_actuales (
  id_enfermedad UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  id_anamnesis UUID NOT NULL,
  descripcion TEXT,
  CONSTRAINT fk_enfermedades_actuales_anamnesis FOREIGN KEY (id_anamnesis) REFERENCES anamnesis(id_anamnesis)
);

-- Tabla `antecedentes`
CREATE TABLE antecedentes (
  id_antecedente UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  id_anamnesis UUID NOT NULL,
  descripcion TEXT,
  CONSTRAINT fk_antecedentes_anamnesis FOREIGN KEY (id_anamnesis) REFERENCES anamnesis(id_anamnesis)
);

-- Tabla `examenes_fisicos`
CREATE TABLE examenes_fisicos (
  id_examen UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  id_historia UUID NOT NULL,
  CONSTRAINT fk_examenes_fisicos_historias_clinicas FOREIGN KEY (id_historia) REFERENCES historias_clinicas(id_historia)
);

-- Tabla `examenes_generales`
CREATE TABLE examenes_generales (
  id_general UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  id_examen UUID NOT NULL,
  descripcion TEXT,
  CONSTRAINT fk_examenes_generales_examenes_fisicos FOREIGN KEY (id_examen) REFERENCES examenes_fisicos(id_examen)
);

-- Tabla `examenes_regionales`
CREATE TABLE examenes_regionales (
  id_regional UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  id_examen UUID NOT NULL,
  descripcion TEXT,
  CONSTRAINT fk_examenes_regionales_examenes_fisicos FOREIGN KEY (id_examen) REFERENCES examenes_fisicos(id_examen)
);

-- Tabla `examenes_clinicos_boca`
CREATE TABLE examenes_clinicos_boca (
  id_clinico UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  id_examen UUID NOT NULL,
  descripcion TEXT,
  CONSTRAINT fk_examenes_clinicos_boca_examenes_fisicos FOREIGN KEY (id_examen) REFERENCES examenes_fisicos(id_examen)
);

-- Tabla `higienes_bucales`
CREATE TABLE higienes_bucales (
  id_higiene UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  id_examen UUID NOT NULL,
  descripcion TEXT,
  CONSTRAINT fk_higienes_bucales_examenes_fisicos FOREIGN KEY (id_examen) REFERENCES examenes_fisicos(id_examen)
);

-- Tabla `odontogramas`
CREATE TABLE odontogramas (
  id_odontograma UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  id_examen UUID NOT NULL,
  descripcion TEXT,
  CONSTRAINT fk_odontogramas_examenes_fisicos FOREIGN KEY (id_examen) REFERENCES examenes_fisicos(id_examen)
);

-- Tabla `diagnosticos_presuntivos`
CREATE TABLE diagnosticos_presuntivos (
  id_diagnostico_presuntivo UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  id_historia UUID NOT NULL,
  descripcion TEXT,
  CONSTRAINT fk_diagnosticos_presuntivos_historias_clinicas FOREIGN KEY (id_historia) REFERENCES historias_clinicas(id_historia)
);

-- Tabla `derivados_clinica`
CREATE TABLE derivados_clinica (
  id_derivado UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  id_historia UUID NOT NULL,
  descripcion TEXT,
  CONSTRAINT fk_derivados_clinica_historias_clinicas FOREIGN KEY (id_historia) REFERENCES historias_clinicas(id_historia)
);

-- Tabla `diagnosticos_clinica`
CREATE TABLE diagnosticos_clinica (
  id_diagnostico_clinica UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  id_historia UUID NOT NULL,
  descripcion TEXT,
  CONSTRAINT fk_diagnosticos_clinica_historias_clinicas FOREIGN KEY (id_historia) REFERENCES historias_clinicas(id_historia)
);

-- Tabla `evoluciones`
CREATE TABLE evoluciones (
  id_evolucion UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  id_historia UUID NOT NULL,
  id_alumno UUID NOT NULL,
  descripcion TEXT,
  CONSTRAINT fk_evoluciones_historias_clinicas FOREIGN KEY (id_historia) REFERENCES historias_clinicas(id_historia),
  CONSTRAINT fk_evoluciones_usuarios FOREIGN KEY (id_alumno) REFERENCES usuarios(id_usuario)
);

-- Tabla de auditoría para registrar cambios
CREATE TABLE auditoria (
  id_auditoria UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  id_usuario UUID NOT NULL,
  fecha_cambio TIMESTAMP NOT NULL DEFAULT NOW(),
  nombre_tabla VARCHAR(50) NOT NULL,
  id_registro_afectado UUID NOT NULL,
  accion VARCHAR(10) NOT NULL,
  datos_anteriores JSONB,
  datos_nuevos JSONB,
  CONSTRAINT fk_auditoria_usuarios FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
);
```

---

### **📋 Convenciones de Nomenclatura**

Para mantener la consistencia, seguimos estas reglas estrictas al nombrar objetos en la base de datos.

---

### 1. Nombres de Tablas

* **Minúsculas y plurales**: Los nombres de las tablas deben ser en minúsculas y en plural.
* **Snake case**: Si el nombre tiene varias palabras, usa un guion bajo (`_`) para separarlas.
* **Ejemplos**: `usuarios`, `pacientes`, `historias_clinicas`.

---

### 2. Nombres de Columnas

* **Minúsculas y snake case**: Todas las columnas deben usar minúsculas y guiones bajos.
* **Identificadores (`id`)**: Para las claves primarias, usa el formato `id_nombre_de_la_tabla_en_singular`.
    * **Ejemplo**: `id_usuario`.
* **Claves Foráneas**: Las claves foráneas deben reflejar el nombre de la columna que referencian, con el formato `id_nombre_de_la_tabla_referenciada_en_singular`.
    * **Ejemplos**: `id_paciente`, `id_alumno`.

---

### 3. Restricciones y Relaciones

* **Claves Primarias (`pk`)**: Las restricciones de clave primaria se nombran con la convención `pk_nombre_de_la_tabla`.
    * **Ejemplo**: `pk_usuarios`.
* **Claves Foráneas (`fk`)**: Las restricciones de clave foránea se nombran con el formato `fk_tabla_origen_tabla_destino`.
    * **Ejemplos**: `fk_historias_clinicas_pacientes`, `fk_historias_clinicas_usuarios`.
* **Índices (`idx`)**: Los índices se nombran con el formato `idx_nombre_de_la_tabla_nombre_de_la_columna_o_columnas`.
    * **Ejemplos**: `idx_usuarios_dni`, `idx_pacientes_dni`.
