------------------------------------------------------------------
-- ARCHIVO: 02_usuarios_estudiantes.sql
-- DESCRIPCION: Usuarios estudiantes reales del sistema
-- PROYECTO: SN-001-2025 - Sistema de Historias Clínicas
-- AUTOR: Equipo BD II - ESIS UNJBG
-- FECHA: 12/10/2025
-- NOTA: Datos reales de estudiantes con contraseñas ya hasheadas
------------------------------------------------------------------

-- Insertar estudiantes reales
-- Las contraseñas ya están hasheadas con Argon2ID

-- Vaquita Marina
INSERT INTO usuario (
    id_usuario,
    usuario_login,
    nombre,
    apellido,
    dni,
    email,
    rol,
    contrasena_hash,
    activo
) VALUES (
    'de4cd964-3e8b-4552-b90a-1bd30cca2f21',
    '2023-119018',
    'Vaquita',
    'Marina',
    '70801433',
    'caflores@unjbg.edu.pe',
    'estudiante',
    '$argon2id$v=19$m=65536,t=3,p=4$3LpAgbt2Q9nZCzKdMj/WIQ$J3Dq4u3K7/4+NrCduPhE1omYlROTFXrlNIjUTznZVkQ',
    TRUE
);

-- Cristhiany Lesly Conde Escobar
INSERT INTO usuario (
    id_usuario,
    usuario_login,
    nombre,
    apellido,
    dni,
    email,
    rol,
    contrasena_hash,
    activo
) VALUES (
    'cc3d2b62-cd07-41f7-a3de-43ebf5be8eda',
    '2022-124008',
    'Cristhiany',
    'Lesly Conde Escobar',
    '72154839',
    'ccondeesc@unjbg.edu.pe',
    'estudiante',
    '$argon2id$v=19$m=65536,t=3,p=4$i0PGfENF8tOgdU4xyUAGGQ$838o27Nzh3sCZBikUrHhMcFL5oezq/aiS6ObL3jTGI8',
    TRUE
);

-- Alicia Danitza Vera Cohaila
INSERT INTO usuario (
    id_usuario,
    usuario_login,
    nombre,
    apellido,
    dni,
    email,
    rol,
    contrasena_hash,
    activo
) VALUES (
    'd6f37f1a-f8ef-467a-b17f-5823603dd767',
    '2024-124031',
    'Alicia',
    'Danitza Vera Cohaila',
    '85694712',
    'averac@unjbg.edu.pe',
    'estudiante',
    '$argon2id$v=19$m=65536,t=3,p=4$bB5qzQSpVs4gaaVfvPAk6g$XwSuoA69JC4fy9cz2yc3mgIK4aucvXrolqKM13X++m0',
    TRUE
);

-- Ariana Ninel Condori Vilcape
INSERT INTO usuario (
    id_usuario,
    usuario_login,
    nombre,
    apellido,
    dni,
    email,
    rol,
    contrasena_hash,
    activo
) VALUES (
    'a519fd27-825e-42dc-9ed0-95eacbdbb5e0',
    '2022-124009',
    'Ariana',
    'Ninel Condori Vilcape',
    '79516342',
    'ariana200381@gmail.com',
    'estudiante',
    '$argon2id$v=19$m=65536,t=3,p=4$BSR99cdO2Y8jbl4Ehq2mqg$I1eZok/RbAEP6SBa8aekg2MDXiqM/tm6GK5oUKEli70',
    TRUE
);

-- Yusbel Clever Mayta Chipana
INSERT INTO usuario (
    id_usuario,
    usuario_login,
    nombre,
    apellido,
    dni,
    email,
    rol,
    contrasena_hash,
    activo
) VALUES (
    '8fc76451-87b3-4ed6-83bb-b3db65842929',
    '2022-124010',
    'Yusbel',
    'Clever Mayta Chipana',
    '70325641',
    'ymaytachi@unjbg.edu.pe',
    'estudiante',
    '$argon2id$v=19$m=65536,t=3,p=4$2YJnzDRzWbM4pJcDdxSwvg$uISvQqua2WPC9ncNsclfxY4Lbi/4dbc8/p6opXXSH2o',
    TRUE
);

-- Nicolett Agnes Cahuana Tacuri
INSERT INTO usuario (
    id_usuario,
    usuario_login,
    nombre,
    apellido,
    dni,
    email,
    rol,
    contrasena_hash,
    activo
) VALUES (
    'fcf4b66c-ac68-43b7-b314-f73d2555a0a5',
    '2021-124021',
    'Nicolett',
    'Agnes Cahuana Tacuri',
    '89564723',
    'nacahuanat@unjbg.edu.pe',
    'estudiante',
    '$argon2id$v=19$m=65536,t=3,p=4$90Suo61evqMGBBr9cJgA8g$R9G4bC8gGm79YVJS6XKfEAd1mrUBmd47t2Z5978kj50',
    TRUE
);

-- Rodrigo Fernando Laura Guadalupe
INSERT INTO usuario (
    id_usuario,
    usuario_login,
    nombre,
    apellido,
    dni,
    email,
    rol,
    contrasena_hash,
    activo
) VALUES (
    'b8727ab2-4006-4a75-bf4a-bd7f9228288f',
    '2022-124003',
    'Rodrigo',
    'Fernando Laura Guadalupe',
    '78154296',
    'rlauragua@unjbg.edu.pe',
    'estudiante',
    '$argon2id$v=19$m=65536,t=3,p=4$PEz0EjezOvwZGlOY0KmdFg$zLktLDXKGYyaTZR0VmYltuK123Oyt5cc7XJVh6J/2Z0',
    TRUE
);

-- Mariela Castro Quispe
INSERT INTO usuario (
    id_usuario,
    usuario_login,
    nombre,
    apellido,
    dni,
    email,
    rol,
    contrasena_hash,
    activo
) VALUES (
    '60edd6bc-3e3d-4873-a50b-d4a0d3195418',
    '2021-124030',
    'Mariela',
    'Castro Quispe',
    '86971253',
    'mcastroq@gmail.com',
    'estudiante',
    '$argon2id$v=19$m=65536,t=3,p=4$SimYNWFyL2pFgtG2P77vSA$9P65Y6v8ocfpK5S7MnM/i4FTGAp1bNhLdbJtcF6+j1U',
    TRUE
);

-- Joselyn Cori Ticona
INSERT INTO usuario (
    id_usuario,
    usuario_login,
    nombre,
    apellido,
    dni,
    email,
    rol,
    contrasena_hash,
    activo
) VALUES (
    '7c6b97f0-27bf-4ad2-af79-d42294e78fc9',
    '2021-124035',
    'Joselyn',
    'Cori Ticona',
    '79125684',
    'jgfcorit@unjbg.edu.pe',
    'estudiante',
    '$argon2id$v=19$m=65536,t=3,p=4$Q2pFh/ui0/lKKAN3FhFA8A$C/mY7zZrggeWf5LVpAvMtddIt1h2Qa5QOSYa4zTl4Hc',
    TRUE
);

-- Nilo Javier Sinticala Mamani
INSERT INTO usuario (
    id_usuario,
    usuario_login,
    nombre,
    apellido,
    dni,
    email,
    rol,
    contrasena_hash,
    activo
) VALUES (
    '936cb450-875a-4ca8-9807-ef4bddc2393e',
    '2022-124005',
    'Nilo',
    'Javier Sinticala Mamani',
    '71859462',
    'nsinticalamam@unjbg.edu.pe',
    'estudiante',
    '$argon2id$v=19$m=65536,t=3,p=4$bu2mIefG7gIhuHkq8ygVEw$zLQMqd9dEUCI3nPFGmmDK6TwRigBB30U1czNom2LuX0',
    TRUE
);

-- Kendra Saraí Vilca Cabrera
INSERT INTO usuario (
    id_usuario,
    usuario_login,
    nombre,
    apellido,
    dni,
    email,
    rol,
    contrasena_hash,
    activo
) VALUES (
    'abcaeb82-22a9-41c4-a5d5-1254fa64b257',
    '2022-124018',
    'Kendra',
    'Saraí Vilca Cabrera',
    '84516792',
    'kvilcaca@unjbg.edu.pe',
    'estudiante',
    '$argon2id$v=19$m=65536,t=3,p=4$xkXSNW1bXfni8TdNA+4a0Q$3D68TxhGVR5rCzx4G6SylCyI+34CS6yIWgU1CoGYYIw',
    TRUE
);

-- Henry Romario Ortega Luque
INSERT INTO usuario (
    id_usuario,
    usuario_login,
    nombre,
    apellido,
    dni,
    email,
    rol,
    contrasena_hash,
    activo
) VALUES (
    'c2ed22f0-60b2-4217-a069-f36f81d02b5a',
    '2021-124043',
    'Henry',
    'Romario Ortega Luque',
    '75483169',
    'ho23416@gmail.com',
    'estudiante',
    '$argon2id$v=19$m=65536,t=3,p=4$z//foB8YWxo8bDKTbtxrXA$3gFO5AFm8aK+gLuMln7OWc3NwfcmSLT7wvJ+PtByEQ0',
    TRUE
);

-- Mirian Gabriela Mamani Mamani
INSERT INTO usuario (
    id_usuario,
    usuario_login,
    nombre,
    apellido,
    dni,
    email,
    rol,
    contrasena_hash,
    activo
) VALUES (
    'fee06968-22a2-4469-b23e-ed1ecac91ca8',
    '2022-124013',
    'Mirian',
    'Gabriela Mamani Mamani',
    '80231564',
    'mmamanimam@unjbg.edu.pe',
    'estudiante',
    '$argon2id$v=19$m=65536,t=3,p=4$TUa/ub/n7MeFomu7dv2r2w$GZnF3gIBNvsRViib4By5/vppLLPeyXnDWcZ2NERkYvM',
    TRUE
);

-- Samuel Rojas Cutipa
INSERT INTO usuario (
    id_usuario,
    usuario_login,
    nombre,
    apellido,
    dni,
    email,
    rol,
    contrasena_hash,
    activo
) VALUES (
    'd4d1f1bc-f542-4e66-a588-30c14f1fde02',
    '2011124008',
    'Samuel',
    'Rojas Cutipa',
    '76254198',
    'Evangeli_wor_22@hotmail.com',
    'estudiante',
    '$argon2id$v=19$m=65536,t=3,p=4$CrGLFgi83KsWIyrjyohb5Q$6itY9PIG98kFVS6uMocHwgNmtGWp8qIjmtQZB5lbnAc',
    TRUE
);

-- Veronica Gianella Garcia Montufar
INSERT INTO usuario (
    id_usuario,
    usuario_login,
    nombre,
    apellido,
    dni,
    email,
    rol,
    contrasena_hash,
    activo
) VALUES (
    'a40a90e1-ab65-450d-bfc1-9a0f3fbf3fb6',
    '2021-124024',
    'Veronica',
    'Gianella Garcia Montufar',
    '71425983',
    'Vggarciam@unjbg.edu.pe',
    'estudiante',
    '$argon2id$v=19$m=65536,t=3,p=4$L8fFyGVYGscIHYvU+s/3Dg$n1DVYO+m7gDfQkBMRWkmIpfBg2sIroRrT/bMYvqtRGI',
    TRUE
);

COMMENT ON TABLE usuario IS 'Estudiantes reales del curso de Base de Datos II - ESIS UNJBG';
