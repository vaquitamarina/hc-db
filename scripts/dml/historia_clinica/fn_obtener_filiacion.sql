CREATE OR REPLACE FUNCTION obtener_filiacion(p_id_historia UUID)
RETURNS TABLE (
    id_filiacion UUID,
    id_historia UUID,
    raza VARCHAR,
    fecha_nacimiento DATE,
    lugar VARCHAR,
    estado_civil VARCHAR,
    nombre_conyuge VARCHAR,
    ocupacion VARCHAR,
    lugar_procedencia VARCHAR,
    tiempo_residencia_tacna VARCHAR,
    direccion VARCHAR,
    grado_instruccion VARCHAR,
    ultima_visita_dentista DATE,
    motivo_visita_dentista VARCHAR,
    ultima_visita_medico DATE,
    motivo_visita_medico VARCHAR,
    contacto_emergencia VARCHAR,
    telefono_emergencia VARCHAR,
    acompaniante VARCHAR
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        f.id_filiacion,
        f.id_historia,
        f.raza,
        f.fecha_nacimiento,
        f.lugar,
        ec.descripcion AS estado_civil,
        f.nombre_conyuge,
        oc.descripcion AS ocupacion,
        f.lugar_procedencia,
        f.tiempo_residencia_tacna,
        f.direccion,
        gi.descripcion AS grado_instruccion,
        f.ultima_visita_dentista,
        f.motivo_visita_dentista,
        f.ultima_visita_medico,
        f.motivo_visita_medico,
        f.contacto_emergencia,
        f.telefono_emergencia,
        f.acompaniante
    FROM filiacion f
    INNER JOIN catalogo_estado_civil ec ON f.id_estado_civil = ec.id_estado_civil
    INNER JOIN catalogo_ocupacion oc ON f.id_ocupacion = oc.id_ocupacion
    INNER JOIN catalogo_grado_instruccion gi ON f.id_grado_instruccion = gi.id_grado_instruccion
    WHERE f.id_historia = p_id_historia;
END;
$$ LANGUAGE plpgsql;
