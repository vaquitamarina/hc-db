------------------------------------------------------------------
-- DESCRIPCION: Funcion que obtiene los datos de filiacion de una historia clinica
------------------------------------------------------------------
CREATE OR REPLACE FUNCTION s_filiacion (p_id_historia uuid)
    RETURNS TABLE (
        id_filiacion uuid,
        id_historia uuid,
        raza varchar,
        fecha_nacimiento date,
        lugar varchar,
        estado_civil varchar,
        nombre_conyuge varchar,
        ocupacion varchar,
        lugar_procedencia varchar,
        tiempo_residencia_tacna varchar,
        direccion varchar,
        grado_instruccion varchar,
        ultima_visita_dentista date,
        motivo_visita_dentista varchar,
        ultima_visita_medico date,
        motivo_visita_medico varchar,
        contacto_emergencia varchar,
        telefono_emergencia varchar,
        acompaniante varchar
    )
    AS $$
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
    FROM
        filiacion f
        INNER JOIN catalogo_estado_civil ec ON f.id_estado_civil = ec.id_estado_civil
        INNER JOIN catalogo_ocupacion oc ON f.id_ocupacion = oc.id_ocupacion
        INNER JOIN catalogo_grado_instruccion gi ON f.id_grado_instruccion = gi.id_grado_instruccion
    WHERE
        f.id_historia = p_id_historia;
END;
$$
LANGUAGE plpgsql;

