# 💾 Documentación de la Base de Datos

Este documento describe la estructura y las convenciones de la base de datos del proyecto. Su objetivo es servir como una referencia central para todo el equipo de desarrollo, asegurando la consistencia y facilitando la comprensión del esquema de datos.


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


