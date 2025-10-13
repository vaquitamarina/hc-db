#!/bin/bash

# Script para remover todos los CONSTRAINT de las tablas
# Los constraints se moverán a archivos separados en constraints/

echo "Limpiando constraints de archivos de tablas..."

# Remover constraints de 04_historia_clinica.sql
sed -i '' '/CONSTRAINT fk_revision_historia_historia_clinica/,+1d' /Users/vaq/Dev/historias-clinicas/hc-bd/database/tables/04_historia_clinica.sql
sed -i '' '/CONSTRAINT fk_revision_historia_usuario/,+1d' /Users/vaq/Dev/historias-clinicas/hc-bd/database/tables/04_historia_clinica.sql
sed -i '' '/CONSTRAINT fk_revision_historia_catalogo_estado_revision/,+1d' /Users/vaq/Dev/historias-clinicas/hc-bd/database/tables/04_historia_clinica.sql
sed -i '' '/CONSTRAINT fk_subseccion_hc_seccion_hc/,+1d' /Users/vaq/Dev/historias-clinicas/hc-bd/database/tables/04_historia_clinica.sql

echo "Constraints limpiados exitosamente"