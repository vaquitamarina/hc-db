------------------------------------------------------------------
-- DESCRIPCION: Procedimiento que registra los antecedentes personales del paciente
------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE i_antecedente_personal(
    IN p_id_historia UUID,
    IN p_esta_embarazada BOOLEAN,
    IN p_mac VARCHAR(200),
    IN p_otros TEXT,
    IN p_psicosocial TEXT,
    IN p_vacunas TEXT,
    IN p_hepatitis_b BOOLEAN,
    IN p_grupo_sanguineo_desc VARCHAR(10),
    IN p_fuma BOOLEAN,
    IN p_cigarrillos_dia INT,
    IN p_toma_te BOOLEAN,
    IN p_tazas_te_dia INT,
    IN p_toma_alcohol BOOLEAN,
    IN p_frecuencia_alcohol VARCHAR(100),
    IN p_aprieta_dientes BOOLEAN,
    IN p_momento_aprieta VARCHAR(100),
    IN p_rechina BOOLEAN,
    IN p_dolor_muscular BOOLEAN,
    IN p_chupa_dedo BOOLEAN,
    IN p_muerde_objetos BOOLEAN,
    IN p_muerde_labios BOOLEAN,
    IN p_otros_habitos TEXT,
    IN p_frecuencia_cepillado INT
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_id_grupo_sanguineo UUID;
BEGIN
    -- Buscar UUID del grupo sanguíneo
    IF p_grupo_sanguineo_desc IS NOT NULL THEN
        SELECT id_grupo INTO v_id_grupo_sanguineo 
        FROM catalogo_grupo_sanguineo 
        WHERE descripcion = p_grupo_sanguineo_desc;
        
        IF v_id_grupo_sanguineo IS NULL THEN
            RAISE EXCEPTION 'Grupo sanguíneo "%" no encontrado en catálogo', p_grupo_sanguineo_desc;
        END IF;
    END IF;

    INSERT INTO antecedente_personal (
        id_historia,
        esta_embarazada,
        mac,
        otros,
        psicosocial,
        vacunas,
        hepatitis_b,
        id_grupo_sanguineo,
        fuma,
        cigarrillos_dia,
        toma_te,
        tazas_te_dia,
        toma_alcohol,
        frecuencia_alcohol,
        aprieta_dientes,
        momento_aprieta,
        rechina,
        dolor_muscular,
        chupa_dedo,
        muerde_objetos,
        muerde_labios,
        otros_habitos,
        frecuencia_cepillado
    )
    VALUES (
        p_id_historia,
        p_esta_embarazada,
        p_mac,
        p_otros,
        p_psicosocial,
        p_vacunas,
        p_hepatitis_b,
        v_id_grupo_sanguineo,
        p_fuma,
        p_cigarrillos_dia,
        p_toma_te,
        p_tazas_te_dia,
        p_toma_alcohol,
        p_frecuencia_alcohol,
        p_aprieta_dientes,
        p_momento_aprieta,
        p_rechina,
        p_dolor_muscular,
        p_chupa_dedo,
        p_muerde_objetos,
        p_muerde_labios,
        p_otros_habitos,
        p_frecuencia_cepillado
    );

    RAISE NOTICE 'Antecedentes personales registrados para historia %.', p_id_historia;

EXCEPTION
    WHEN foreign_key_violation THEN
        RAISE EXCEPTION 'La historia % no existe o el grupo sanguíneo no es válido.', p_id_historia;
    WHEN unique_violation THEN
        RAISE EXCEPTION 'La historia % ya tiene antecedentes personales registrados.', p_id_historia;
    WHEN others THEN
        RAISE EXCEPTION 'Ocurrio un error al registrar los antecedentes personales: %', SQLERRM;
END;
$$;
