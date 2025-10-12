CREATE TABLE seccion_hc (
  id_seccion_hc UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  nombre VARCHAR(100) NOT NULL,
  orden INT NOT NULL UNIQUE
);

CREATE TABLE subseccion_hc (
  id_subseccion_hc UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  id_seccion_hc UUID,
  nombre VARCHAR(100) NOT NULL,
  orden INT NOT NULL,
  CONSTRAINT fk_subseccion_hc_seccion_hc FOREIGN KEY (id_seccion_hc) REFERENCES seccion_hc(id_seccion_hc),
  UNIQUE (id_seccion_hc, orden)
);

INSERT INTO seccion_hc (nombre, orden) VALUES
('Anamnesis', 1),
('Examen fisico', 2),
('Diagnosticos presuntivos', 3),
('Derivado a clinicas', 4),
('Diagnostico en clinicas', 5),
('Evolucion', 6);

