# 📁 Documentación de Migración a Nueva Estructura

**Fecha:** 12 de Octubre de 2025  
**Proyecto:** Sistema de Historias Clínicas - Base de Datos

---

## ⚠️ INFORMACIÓN IMPORTANTE

Este directorio (`scripts/`) contiene la **estructura antigua** del proyecto.

**Nueva ubicación:** Toda la funcionalidad ha sido reorganizada en la carpeta `database/`

---

## 🔄 Mapeo de Migración

### DDL (Data Definition Language)
| Archivo Antiguo | Nueva Ubicación |
|-----------------|-----------------|
| `scripts/ddl/catalogo.sql` | `database/tables/01_catalogos.sql` |
| `scripts/ddl/init.sql` | Dividido en: |
| | - `database/tables/02_usuarios.sql` |
| | - `database/tables/03_pacientes.sql` |
| | - `database/tables/04_historia_clinica.sql` |
| | - `database/tables/05_anamnesis.sql` |
| | - `database/tables/06_examenes.sql` |
| | - `database/tables/07_diagnosticos.sql` |
| | - `database/tables/08_auditoria.sql` |
| `scripts/ddl/seccion_hc.sql` | Incluido en `database/tables/04_historia_clinica.sql` |

### DML - Funciones (SELECT)
| Archivo Antiguo | Nueva Ubicación |
|-----------------|-----------------|
| `scripts/dml/usuarios/usuario_login.sql` | `database/functions/usuarios/s_usuario_login.sql` |
| `scripts/dml/usuarios/usuario_id.sql` | `database/functions/usuarios/s_usuario.sql` |
| `scripts/dml/historia_clinica/fn_obtener_filiacion.sql` | `database/functions/historia_clinica/s_filiacion.sql` |
| `scripts/dml/estudiantes/fn_obtener_paciente_adulto.sql` | `database/functions/estudiantes/s_paciente_adulto.sql` |

### DML - Procedimientos (INSERT/UPDATE/DELETE)
| Archivo Antiguo | Nueva Ubicación |
|-----------------|-----------------|
| `scripts/dml/usuarios/registrar_usuario.sql` | `database/procedures/usuarios/i_usuario.sql` |
| `scripts/dml/historia_clinica/registrar_historia.sql` | `database/procedures/historia_clinica/i_historia_clinica.sql` |
| `scripts/dml/historia_clinica/registrar_filiacion.sql` | `database/procedures/historia_clinica/i_filiacion.sql` |
| `scripts/dml/historia_clinica/revision_historia.sql` | `database/procedures/historia_clinica/i_revision_historia.sql` |
| `scripts/dml/auditoria/registrar_auditoria.sql` | `database/procedures/auditoria/i_auditoria.sql` |

---

## ✨ Nuevas Funcionalidades

Las siguientes funcionalidades **NO existían** en la estructura antigua:

### Vistas
- `database/views/vw_historias_estudiante.sql`
- `database/views/vw_revision_pendiente.sql`
- `database/views/vw_pacientes_activos.sql`

### Triggers
- `database/triggers/tr_auditoria_historia_iu.sql`
- `database/triggers/tr_update_timestamp.sql`

### Índices
- `database/indexes/indexes.sql`

### Seguridad
- `database/security/roles.sql`
- `database/security/permissions.sql`

### Seeds
- `seeds/01_catalogos_base.sql`
- `seeds/02_usuario_admin.sql`

### Deployment
- `deployment/deploy_full.sql`
- `deployment/verify_deployment.sql`

---

## 🚀 Cómo usar la nueva estructura

### Para deployment completo:
```bash
cd deployment
psql -U postgres -d historias_clinicas -f deploy_full.sql
```

### Para verificación:
```bash
psql -U postgres -d historias_clinicas -f verify_deployment.sql
```

Ver documentación completa en: `docs/manual_deployment.md`

---

## 🗑️ Eliminación de esta carpeta

Este directorio será eliminado en una versión futura.  
Por favor, actualice todas las referencias a utilizar la nueva estructura en `database/`.

---

## 📞 Preguntas

Para consultas sobre la migración, contactar al equipo BD II - ESIS UNJBG
