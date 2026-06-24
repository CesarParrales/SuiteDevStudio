# Node API (NestJS) — Harness Template

Bundle feedforward + feedback para un **módulo o recurso API** en NestJS (DTOs, service, controller, tests e2e).

## Cuándo usar

- Nuevo módulo Nest (`nest g module`)
- CRUD o endpoint con validación, auth y persistencia (Prisma/TypeORM)
- El usuario pide "API NestJS", "módulo orders", "endpoint Node"

## Skills a activar (en orden)

| Orden | Skill | Rol |
|-------|-------|-----|
| 1 | `harness-template` | Este bundle |
| 2 | `node-backend` | Módulos, DTOs, guards, Prisma, BullMQ |
| 3 | `api-design` | REST, versionado, códigos HTTP |
| 4 | `karpathy-guidelines` | Checkpoints, escalación |
| 5 | `testing-strategy` | Unit + e2e (`references/integration-e2e.md`) |
| 6 | `comprobacion-produccion` | Post-implementación + FB-3 |

Opcional: `security-checklist` (auth, rate limit), `devops-base` (CI).

## Archivos feedforward

| Archivo | Contenido |
|---------|-----------|
| `.cursor/project-memory.md` | `npm run test`, `npm run test:e2e`, health URL |
| `AGENTS.md` | Convenciones Nest del repo |
| `src/<module>/` | Un módulo por dominio |

## Definition of Done

```bash
npm run lint                 # si existe
npx tsc --noEmit             # si TypeScript
npm run test                 # unit
npm run test:e2e             # e2e del módulo (o --testPathPattern=orders)
curl -s -o /dev/null -w "%{http_code}" http://localhost:3000/api/v1/health
# Endpoint nuevo (ejemplo):
curl -s -X POST http://localhost:3000/api/v1/orders -H "Content-Type: application/json" -d '{}' 
# → 401/422 esperado según auth/validación, no 500
```

Gate: tests e2e del recurso en verde; Swagger actualizado si el proyecto lo usa; sin secretos en el diff.

## Flujo recomendado

1. **AC** + contrato request/response
2. **RED:** e2e o unit que falla (`supertest` / `nestjs testing`)
3. **Scaffold:** `nest g module|controller|service` + DTOs con `class-validator`
4. **Service** + Prisma/repository
5. **GREEN** + lint/tsc
6. **Post-impl:** `comprobacion-produccion` §0

## Sensores

| Sensor | Cuándo |
|--------|--------|
| `npm run test:e2e` | Tras cada endpoint nuevo |
| `npx tsc --noEmit` | Tras cambios en DTOs/services |
| FB-3 script | Si reformateas salida de CI (`validate-fb3.sh`) |

## Anti-patrones

- Lógica de negocio en el controller
- DTOs sin `whitelist` / validación
- e2e que no asserta status ni body
- Jobs síncronos que deberían ir a BullMQ

## Escalación

- Auth/guards globales afectados → escalar antes de merge
- Migración Prisma destructiva → plan + backup
