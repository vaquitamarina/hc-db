------------------------------------------------------------------
-- ARCHIVO: 02_usuarios.sql
-- DESCRIPCION: Tabla de usuarios del sistema
-- PROYECTO: SN-001-2025 - Sistema de Historias Clínicas
-- AUTOR: Equipo BD II - ESIS UNJBG
-- FECHA: 12/10/2025
------------------------------------------------------------------

CREATE TABLE usuario (
    id_usuario UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    codigo_usuario VARCHAR(100) UNIQUE NOT NULL,
    nombre VARCHAR(200) NOT NULL,
    apellido VARCHAR(200) NOT NULL,
    dni VARCHAR(20) UNIQUE NOT NULL,
    email VARCHAR(200) UNIQUE NOT NULL,
    rol VARCHAR(50) NOT NULL,
    contrasena_hash VARCHAR(255) NOT NULL,
    activo BOOLEAN DEFAULT TRUE,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
