------------------------------------------------------------------
-- ARCHIVO: README_constraints.md
-- DESCRIPCION: Guía de constraints separados
-- PROYECTO: SN-001-2025 - Sistema de Historias Clínicas
-- AUTOR: Equipo BD II - ESIS UNJBG
-- FECHA: 13/10/2025
------------------------------------------------------------------

# CONSTRAINTS SEPARADOS

## Estructura creada:

```
database/
├── constraints/
│   ├── check_constraints.sql      # Validaciones CHECK
│   ├── foreign_keys.sql           # Relaciones entre tablas
│   ├── unique_constraints.sql     # Constraints UNIQUE 
```

## Orden de ejecución en deployment:

1. **Crear tablas** (sin constraints)
2. **Crear funciones y procedimientos**
3. **Aplicar constraints** (en este orden):
   - foreign_keys.sql
   - check_constraints.sql
   - business_rules.sql
4. **Insertar datos** (seeds)

## Ventajas:

- ✅ **Modularidad**: Cada tipo de constraint en su archivo
- ✅ **Mantenimiento**: Fácil encontrar y modificar reglas
- ✅ **Deployment**: Se pueden aplicar constraints después de cargar datos
- ✅ **Testing**: Probar constraints por separado
- ✅ **Organización**: Código más profesional y estructurado

## Archivo de deployment actualizado:

El `deploy_full.sql` ahora incluye la aplicación de constraints en el paso 11, antes de insertar los datos.
