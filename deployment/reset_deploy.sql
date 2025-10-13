SET client_min_messages TO WARNING;
\echo 'Borrando schema public...'
DROP SCHEMA public CASCADE;

\echo 'Creando schema public...'
CREATE SCHEMA public;

\i ./deploy_full.sql
