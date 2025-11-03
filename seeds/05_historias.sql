--insert de una historia clinica y un paciente asociado de prueba
-- CREATE TABLE paciente (
 --   id_paciente UUID PRIMARY KEY DEFAULT gen_random_uuid(),
   -- nombre VARCHAR(200) NOT NULL,
    --apellido VARCHAR(200) NOT NULL,
    --dni CHAR(8) UNIQUE NOT NULL,
    --fecha_nacimiento DATE NOT NULL,
    --id_sexo UUID NOT NULL,
    --telefono VARCHAR(20),
    --email VARCHAR(200),
    --fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    --activo BOOLEAN DEFAULT TRUE
--);
INSERT INTO paciente (id_paciente, nombre, apellido, dni, fecha_nacimiento, id_sexo, telefono, email, fecha_registro, activo)
VALUES ('33333333-3333-3333-3333-333333333333', 'Juan', 'Pérez', '99999999', '1990-01-01', 
        (SELECT id_sexo FROM catalogo_sexo WHERE descripcion = 'Masculino'), '987654321', 'juan.perez@example.com', CURRENT_TIMESTAMP, TRUE);

INSERT INTO historia_clinica (id_historia, id_estudiante, id_paciente)
VALUES ('11111111-1111-1111-1111-111111111111', 'de4cd964-3e8b-4552-b90a-1bd30cca2f21', '33333333-3333-3333-3333-333333333333');