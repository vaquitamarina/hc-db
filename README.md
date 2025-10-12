# 💾 Sistema de Historias Clínicas - Base de Datos

**Versión:** 1.0.0  
**Fecha:** 12 de Octubre de 2025  
**Equipo:** BD II - ESIS UNJBG  
**Proyecto:** SN-001-2025

Este proyecto contiene la base de datos completa del Sistema de Historias Clínicas Odontológicas, diseñado para el manejo académico de historias clínicas por estudiantes de odontología bajo supervisión docente.

---

## 🚀 Inicio Rápido

### Deployment Completo:
```bash
cd deployment
psql -U postgres -d historias_clinicas -f deploy_full.sql
```

### Verificar Instalación:
```bash
psql -U postgres -d historias_clinicas -f verify_deployment.sql
```

Ver [Manual de Deployment](docs/manual_deployment.md) completo.

---

## 📁 Estructura del Proyecto

```
hc-bd/
├── database/               # Estructura moderna de BD
│   ├── tables/            # Definiciones de tablas (DDL)
│   │   ├── 01_catalogos.sql
│   │   ├── 02_usuarios.sql
│   │   ├── 03_pacientes.sql
│   │   ├── 04_historia_clinica.sql
│   │   ├── 05_anamnesis.sql
│   │   ├── 06_examenes.sql
│   │   ├── 07_diagnosticos.sql
│   │   └── 08_auditoria.sql
│   ├── functions/         # Funciones (SELECT)
│   │   ├── usuarios/
│   │   ├── historia_clinica/
│   │   ├── estudiantes/
│   │   └── pacientes/
│   ├── procedures/        # Procedimientos (INSERT/UPDATE/DELETE)
│   │   ├── usuarios/
│   │   ├── historia_clinica/
│   │   ├── auditoria/
│   │   └── pacientes/
│   ├── views/            # Vistas útiles
│   ├── triggers/         # Triggers de auditoría
│   ├── indexes/          # Índices optimizados
│   └── security/         # Roles y permisos
├── migrations/           # Scripts de migración
├── seeds/               # Datos iniciales
├── deployment/          # Scripts de deployment
├── docs/               # Documentación
└── scripts/            # [DEPRECATED] Estructura antigua
```

---

## **📋 Convenciones de Nomenclatura**

### Normas generales
El tamaño de los identificadores van desde los 1 hasta los 63 caracteres, incluye letra simbolos y numeros.
- No se permiten espacios en blanco dentro de los identificadores, 
- Todos los identificadores deben escribirse en minusculas
- En caso de nombres compuestos por varias palabras usar snake_case

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


---

## 🏗️ Esquema de la Base de Datos

Aquí se presenta la estructura completa de las tablas, sus columnas y relaciones. Puedes visualizar el esquema a continuación: 


