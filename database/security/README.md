# Seguridad y Roles - Sistema de Historias Clínicas

## 📋 Estrategia de Seguridad

Este proyecto implementa seguridad **a nivel de aplicación** (backend), no a nivel de base de datos. 

### Arquitectura
```
Frontend (React/Vue/etc) 
    ↓ HTTP/JWT
Backend API (Node.js/Python/etc) 
    ↓ Un solo usuario: hc_api_user
PostgreSQL Database
```

## 🔐 Archivos de Seguridad

### 1. `roles.sql` (OBLIGATORIO)
- **Propósito:** Crear el usuario `hc_api_user` para la API
- **Usar cuando:** Siempre, es el archivo principal
- **Contenido:**
  - Creación del rol `hc_api_user`
  - Permisos completos en tablas, funciones y procedimientos
  - Configuración de connection limits
  - Ejemplos de código para el backend

**Ejecutar:**
```bash
psql -U postgres -d historias_clinicas -f database/security/roles.sql
```

### 2. `row_level_security.sql` (OPCIONAL)
- **Propósito:** Seguridad granular a nivel de filas
- **Usar cuando:** 
  - Necesitas que estudiantes SOLO vean sus propias HC
  - Requisitos estrictos de privacidad
  - Quieres doble capa de seguridad (BD + API)
- **NO usar si:**
  - Tu API ya filtra datos por usuario (recomendado)
  - Prefieres simplicidad
  - Tienes ~200 usuarios (overhead innecesario)

**Ejecutar (solo si lo necesitas):**
```bash
psql -U postgres -d historias_clinicas -f database/security/row_level_security.sql
```

## 🎯 Decisión: ¿Qué usar?

### Para tu proyecto (200 usuarios, API REST):

✅ **USA:** `roles.sql` solamente  
❌ **NO USES:** `row_level_security.sql` (a menos que sea requisito específico)

### Razones:
1. **Simplicidad:** Control de permisos en un solo lugar (backend)
2. **Performance:** Sin overhead de RLS
3. **Mantenibilidad:** Lógica de negocio en código, no en BD
4. **Estándar:** Arquitectura REST/API moderna
5. **Flexibilidad:** Fácil agregar reglas complejas en el backend

## 🚀 Deployment

### Setup Inicial (Primera vez)

```bash
# 1. Crear la base de datos
createdb -U postgres historias_clinicas

# 2. Ejecutar deployment completo
cd deployment
psql -U postgres -d historias_clinicas -f deploy_full.sql

# 3. Configurar seguridad
cd ../database/security
psql -U postgres -d historias_clinicas -f roles.sql
```

### Variables de Entorno (.env)

```bash
# Desarrollo
DB_HOST=localhost
DB_PORT=5432
DB_NAME=historias_clinicas
DB_USER=hc_api_user
DB_PASSWORD=hc_api_2025_secure_password  # ¡CAMBIAR EN PRODUCCIÓN!
DB_MAX_CONNECTIONS=20

# Producción (Neon, Supabase, etc)
DATABASE_URL=postgresql://hc_api_user:PASSWORD@host:5432/historias_clinicas?sslmode=require
```

## 💻 Implementación en el Backend

### Node.js + Express + JWT

```javascript
// db.js - Configuración de conexión
const { Pool } = require('pg');

const pool = new Pool({
  user: process.env.DB_USER,
  host: process.env.DB_HOST,
  database: process.env.DB_NAME,
  password: process.env.DB_PASSWORD,
  port: process.env.DB_PORT,
  max: 20, // Connection pool
  idleTimeoutMillis: 30000,
  connectionTimeoutMillis: 2000,
});

module.exports = pool;

// middleware/auth.js - Autenticación y autorización
const jwt = require('jsonwebtoken');

// Verificar JWT token
function authenticateToken(req, res, next) {
  const token = req.headers['authorization']?.split(' ')[1];
  
  if (!token) {
    return res.status(401).json({ error: 'Token no proporcionado' });
  }

  jwt.verify(token, process.env.JWT_SECRET, (err, user) => {
    if (err) {
      return res.status(403).json({ error: 'Token inválido' });
    }
    req.user = user; // { id, email, tipo_usuario }
    next();
  });
}

// Verificar roles permitidos
function requireRole(...allowedRoles) {
  return (req, res, next) => {
    if (!req.user) {
      return res.status(401).json({ error: 'No autenticado' });
    }

    if (!allowedRoles.includes(req.user.tipo_usuario)) {
      return res.status(403).json({ 
        error: 'Acceso denegado',
        requiredRoles: allowedRoles,
        yourRole: req.user.tipo_usuario
      });
    }
    next();
  };
}

module.exports = { authenticateToken, requireRole };

// routes/historias.js - Ejemplo de rutas protegidas
const express = require('express');
const router = express.Router();
const pool = require('../db');
const { authenticateToken, requireRole } = require('../middleware/auth');

// Solo admin y estudiantes pueden ver historias
router.get('/', 
  authenticateToken, 
  requireRole('admin', 'estudiante'),
  async (req, res) => {
    try {
      // Estudiantes solo ven sus historias
      let query, params;
      
      if (req.user.tipo_usuario === 'estudiante') {
        query = 'SELECT * FROM historia_clinica WHERE id_usuario_estudiante = $1';
        params = [req.user.id];
      } else {
        // Admin ve todas
        query = 'SELECT * FROM historia_clinica';
        params = [];
      }

      const result = await pool.query(query, params);
      res.json(result.rows);
    } catch (err) {
      res.status(500).json({ error: err.message });
    }
  }
);

// Solo admin puede crear usuarios
router.post('/usuarios', 
  authenticateToken, 
  requireRole('admin'),
  async (req, res) => {
    try {
      const { email, password, tipo_usuario } = req.body;
      
      // Llamar al procedimiento almacenado
      await pool.query(
        'CALL i_usuario($1, $2, $3)',
        [email, password, tipo_usuario]
      );
      
      // Registrar auditoría
      await pool.query(
        'CALL i_auditoria($1, $2, $3, $4, $5)',
        [req.user.id, 'INSERT', 'usuario', null, `Usuario ${email} creado`]
      );
      
      res.status(201).json({ message: 'Usuario creado' });
    } catch (err) {
      res.status(500).json({ error: err.message });
    }
  }
);

module.exports = router;
```

### Python + FastAPI

```python
# database.py
import os
import asyncpg
from fastapi import Depends

async def get_db_pool():
    pool = await asyncpg.create_pool(
        host=os.getenv('DB_HOST'),
        port=int(os.getenv('DB_PORT', 5432)),
        database=os.getenv('DB_NAME'),
        user=os.getenv('DB_USER'),
        password=os.getenv('DB_PASSWORD'),
        min_size=5,
        max_size=20
    )
    return pool

# auth.py
from fastapi import Depends, HTTPException, status
from fastapi.security import HTTPBearer, HTTPAuthorizationCredentials
import jwt

security = HTTPBearer()

def get_current_user(credentials: HTTPAuthorizationCredentials = Depends(security)):
    token = credentials.credentials
    try:
        payload = jwt.decode(token, os.getenv('JWT_SECRET'), algorithms=['HS256'])
        return payload  # { id, email, tipo_usuario }
    except jwt.InvalidTokenError:
        raise HTTPException(status_code=401, detail="Token inválido")

def require_role(*allowed_roles: str):
    def role_checker(user: dict = Depends(get_current_user)):
        if user['tipo_usuario'] not in allowed_roles:
            raise HTTPException(
                status_code=403,
                detail=f"Acceso denegado. Roles permitidos: {allowed_roles}"
            )
        return user
    return role_checker

# main.py
from fastapi import FastAPI, Depends
from typing import List

app = FastAPI()

@app.get("/historias")
async def get_historias(
    user: dict = Depends(require_role('admin', 'estudiante')),
    pool = Depends(get_db_pool)
):
    async with pool.acquire() as conn:
        if user['tipo_usuario'] == 'estudiante':
            query = "SELECT * FROM historia_clinica WHERE id_usuario_estudiante = $1"
            historias = await conn.fetch(query, user['id'])
        else:
            historias = await conn.fetch("SELECT * FROM historia_clinica")
        
        return [dict(h) for h in historias]

@app.post("/usuarios")
async def create_usuario(
    email: str,
    password: str,
    tipo_usuario: str,
    user: dict = Depends(require_role('admin')),
    pool = Depends(get_db_pool)
):
    async with pool.acquire() as conn:
        await conn.execute(
            "CALL i_usuario($1, $2, $3)",
            email, password, tipo_usuario
        )
        return {"message": "Usuario creado"}
```

## 🔍 Roles de la Aplicación

| Rol | Permisos |
|-----|----------|
| **admin** | Acceso completo: crear usuarios, ver todas las HC, gestionar sistema |
| **estudiante** | Crear y editar sus propias HC, ver pacientes, registrar datos |
| **docente** | Revisar y aprobar HC de estudiantes, ver estadísticas |

### Tabla de Permisos por Endpoint

| Endpoint | admin | estudiante | docente |
|----------|-------|------------|---------|
| GET /usuarios | ✅ | ❌ | ❌ |
| POST /usuarios | ✅ | ❌ | ❌ |
| GET /historias | ✅ (todas) | ✅ (propias) | ✅ (todas) |
| POST /historias | ✅ | ✅ | ❌ |
| PUT /historias/:id | ✅ | ✅ (propias) | ✅ (revisar) |
| GET /pacientes | ✅ | ✅ | ✅ |
| POST /pacientes | ✅ | ✅ | ❌ |

## 📊 Auditoría

Todas las operaciones importantes deben registrarse:

```javascript
async function logAudit(userId, action, tableName, recordId, details) {
  await pool.query(
    'CALL i_auditoria($1, $2, $3, $4, $5)',
    [userId, action, tableName, recordId, details]
  );
}

// Usar después de cada operación importante
await logAudit(req.user.id, 'INSERT', 'historia_clinica', newId, 'HC creada');
```

## 🔐 Seguridad Adicional

1. **JWT:** Tokens con expiración (1 hora recomendado)
2. **Rate Limiting:** Limitar requests por IP/usuario
3. **Input Validation:** Validar todos los inputs (SQL injection)
4. **HTTPS:** Siempre en producción
5. **Environment Variables:** Nunca hardcodear credenciales
6. **SQL Prepared Statements:** Usar siempre parametrized queries
7. **Password Hashing:** Argon2ID (ya implementado en la BD)

## 📝 Checklist de Producción

- [ ] Cambiar contraseña de `hc_api_user`
- [ ] Configurar SSL/TLS en PostgreSQL
- [ ] Variables de entorno seguras
- [ ] Connection pooling configurado
- [ ] Rate limiting implementado
- [ ] Logs de auditoría activos
- [ ] Backups automáticos
- [ ] Monitoreo de conexiones
- [ ] HTTPS habilitado
- [ ] CORS configurado correctamente

## 🆘 Comandos Útiles

```sql
-- Ver conexiones activas
SELECT pid, usename, application_name, client_addr, state 
FROM pg_stat_activity 
WHERE usename = 'hc_api_user';

-- Ver permisos del rol
\du hc_api_user

-- Cambiar contraseña
ALTER ROLE hc_api_user WITH PASSWORD 'nueva_password';

-- Ver auditoría reciente
SELECT * FROM auditoria 
ORDER BY fecha_accion DESC 
LIMIT 50;
```

## 🎓 Recomendación Final

Para tu proyecto académico con ~200 usuarios:

1. ✅ **Usa:** `roles.sql` (un solo usuario de BD)
2. ✅ **Implementa:** Control de roles en el backend (JWT + middleware)
3. ✅ **Registra:** Todas las acciones en la tabla `auditoria`
4. ❌ **NO uses:** Row Level Security (complejidad innecesaria)

Esta es la arquitectura estándar de la industria y es perfecta para tu caso de uso.
