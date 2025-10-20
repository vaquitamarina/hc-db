------------------------------------------------------------------
-- ARCHIVO: 03_pacientes.sql
-- DESCRIPCION: Tabla de pacientes
------------------------------------------------------------------

CREATE TABLE paciente (
    id_paciente UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nombre VARCHAR(200) NOT NULL,
    apellido VARCHAR(200) NOT NULL,
    dni CHAR(8) UNIQUE NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    id_sexo UUID NOT NULL,
    telefono VARCHAR(20),
    email VARCHAR(200),
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    activo BOOLEAN DEFAULT TRUE
);
