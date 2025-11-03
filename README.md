# 💾 Sistema de Historias Clínicas - Base de Datos

**Fecha:** 10 de Octubre de 2025  
**Equipo:** Vaca Code

Este proyecto contiene la base de datos completa del Sistema de Historias Clínicas Odontológicas, diseñado para el manejo académico de historias clínicas por estudiantes de odontología bajo supervisión docente.

---

## 🚀 Inicio Rápido

### Deployment Completo:
```bash
cd deployment
psql -U postgres -d historias_clinicas -f deploy_full.sql
```

### Verificar Instalación:
```bash
psql -U postgres -d historias_clinicas -f verify_deployment.sql
```

---

## 📁 Estructura del Proyecto

```
hc-bd/
├── database/               # Estructura moderna de BD
│   ├── tables/            # Definiciones de tablas (DDL)
│   │   ├── 01_catalogos.sql
│   │   ├── 02_usuarios.sql
│   │   ├── 03_pacientes.sql
│   │   ├── 04_historia_clinica.sql
│   │   ├── 05_anamnesis.sql
│   │   ├── 06_examenes.sql
│   │   ├── 07_diagnosticos.sql
│   │   └── 08_auditoria.sql
│   ├── functions/         # Funciones (SELECT)
│   │   ├── usuarios/
│   │   ├── historia_clinica/
│   │   ├── estudiantes/
│   │   └── pacientes/
│   ├── procedures/        # Procedimientos (INSERT/UPDATE/DELETE)
│   │   ├── usuarios/
│   │   ├── historia_clinica/
│   │   ├── auditoria/
│   │   └── pacientes/
│   ├── views/            # Vistas útiles
│   ├── triggers/         # Triggers de auditoría
│   ├── indexes/          # Índices optimizados
│   └── security/         # Roles y permisos
├── migrations/           # Scripts de migración
├── seeds/               # Datos iniciales
├── deployment/          # Scripts de deployment
├── docs/               # Documentación
└── scripts/            # [DEPRECATED] Estructura antigua
```

---


