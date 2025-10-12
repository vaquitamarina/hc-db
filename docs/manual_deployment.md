# 📖 Manual de Deployment

## Sistema de Historias Clínicas - Base de Datos

**Versión:** 1.0.0  
**Fecha:** 12 de Octubre de 2025  
**Equipo:** BD II - ESIS UNJBG

---

## 📋 Requisitos Previos

- PostgreSQL 12 o superior
- Extensión `pgcrypto` disponible
- Usuario con permisos de creación de base de datos
- Acceso a línea de comandos `psql`

---

## 🚀 Instalación Completa

### 1. Crear la Base de Datos

```bash
createdb -U postgres historias_clinicas
```

### 2. Ejecutar Deployment Completo

```bash
cd deployment
psql -U postgres -d historias_clinicas -f deploy_full.sql
```

Este script ejecutará en orden:
1. ✅ Creación de tablas de catálogos
2. ✅ Creación de tabla de usuarios
3. ✅ Creación de tabla de pacientes
4. ✅ Creación de tablas de historia clínica
5. ✅ Creación de tablas de anamnesis
6. ✅ Creación de tablas de exámenes
7. ✅ Creación de tablas de diagnósticos
8. ✅ Creación de tabla de auditoría
9. ✅ Creación de índices
10. ✅ Creación de funciones
11. ✅ Creación de procedimientos
12. ✅ Creación de vistas
13. ✅ Creación de triggers
14. ✅ Configuración de seguridad
15. ✅ Inserción de datos iniciales

### 3. Verificar Instalación

```bash
psql -U postgres -d historias_clinicas -f verify_deployment.sql
```

---

## 👥 Usuarios Creados

| Usuario | Contraseña | Rol | Descripción |
|---------|-----------|-----|-------------|
| `admin` | `Admin123!` | admin | Administrador del sistema |
| `docente01` | `Docente123!` | docente | Docente de prueba |
| `estudiante01` | `Estudiante123!` | estudiante | Estudiante de prueba |

⚠️ **IMPORTANTE:** Cambie estas contraseñas en producción inmediatamente.

---

## 🔐 Cambiar Contraseñas

```sql
-- Cambiar contraseña de admin
UPDATE usuario 
SET contrasena_hash = crypt('NuevaContraseñaSegura', gen_salt('bf'))
WHERE usuario_login = 'admin';
```

---

## 📊 Estructura de Directorios

```
hc-bd/
├── database/
│   ├── tables/          # Tablas del sistema
│   ├── views/           # Vistas
│   ├── functions/       # Funciones (SELECT)
│   ├── procedures/      # Procedimientos (INSERT/UPDATE/DELETE)
│   ├── triggers/        # Triggers
│   ├── indexes/         # Índices
│   └── security/        # Roles y permisos
├── migrations/          # Scripts de migración
├── seeds/              # Datos iniciales
├── deployment/         # Scripts de deployment
└── docs/               # Documentación
```

---

## 🔄 Deployment Incremental

Si solo necesitas ejecutar componentes específicos:

### Solo tablas:
```bash
psql -U postgres -d historias_clinicas -f ../database/tables/01_catalogos.sql
psql -U postgres -d historias_clinicas -f ../database/tables/02_usuarios.sql
# ... continuar según necesidad
```

### Solo funciones:
```bash
psql -U postgres -d historias_clinicas -f ../database/functions/usuarios/s_usuario.sql
```

### Solo vistas:
```bash
psql -U postgres -d historias_clinicas -f ../database/views/vw_historias_estudiante.sql
```

---

## 🧪 Testing

### Probar autenticación de usuario:
```sql
SELECT * FROM s_usuario_login('admin');
```

### Verificar datos de catálogos:
```sql
SELECT * FROM catalogo_sexo;
SELECT * FROM catalogo_estado_revision;
```

### Probar vistas:
```sql
SELECT * FROM vw_pacientes_activos;
SELECT * FROM vw_revision_pendiente;
```

---

## 🔧 Mantenimiento

### Backup:
```bash
pg_dump -U postgres -d historias_clinicas > backup_$(date +%Y%m%d).sql
```

### Restore:
```bash
psql -U postgres -d historias_clinicas < backup_20251012.sql
```

### Limpiar y reinstalar:
```bash
dropdb -U postgres historias_clinicas
createdb -U postgres historias_clinicas
psql -U postgres -d historias_clinicas -f deployment/deploy_full.sql
```

---

## ⚠️ Troubleshooting

### Error: "extension pgcrypto does not exist"
```sql
CREATE EXTENSION IF NOT EXISTS pgcrypto;
```

### Error: "role does not exist"
Asegúrate de ejecutar primero:
```bash
psql -U postgres -d historias_clinicas -f database/security/roles.sql
```

### Error: "permission denied"
Verifica que el usuario tenga permisos:
```sql
GRANT ALL ON DATABASE historias_clinicas TO tu_usuario;
```

---

## 📞 Soporte

Para problemas o consultas:
- **Equipo:** BD II - ESIS UNJBG
- **Proyecto:** SN-001-2025

---

## 📝 Changelog

### Versión 1.0.0 (12/10/2025)
- ✅ Estructura completa de base de datos
- ✅ Funciones y procedimientos estandarizados
- ✅ Vistas para consultas comunes
- ✅ Triggers de auditoría automática
- ✅ Sistema de roles y permisos
- ✅ Datos iniciales (seeds)
