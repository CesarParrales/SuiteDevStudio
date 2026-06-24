---
name: harness-template
description: >
  Bundles de harness engineering por topología de proyecto: skills a activar,
  archivos feedforward (AGENTS.md, project-memory), sensores y Definition of Done
  verificable. Usar al iniciar scaffolding grande, nuevo módulo/servicio, o cuando
  el usuario pida plantilla de harness, bundle de skills, o topología Laravel API,
  Next.js SaaS, etc.
---

# Harness Templates

Plantillas que empaquetan **feedforward + feedback** para topologías recurrentes. Un harness template no sustituye skills de dominio: las **ordena y acota**.

## Cuándo usar

- Scaffolding de módulo, microservicio o feature grande (>5 archivos previstos)
- Onboarding de agente en topología conocida del estudio
- El usuario dice "nuevo módulo API Laravel", "arrancar feature con harness", etc.

## Protocolo

1. **Clasificar tarea** → [references/task-routing.md](references/task-routing.md) (FF-3).
2. **Identificar topología** (tabla abajo).
3. **Leer la plantilla** en `templates/<id>.md`.
4. **Activar skills** listadas en la plantilla (en orden).
5. **Crear/actualizar** archivos L2 del repo (`project-memory.md`, `AGENTS.md` desde `suite-dev-studio/templates/AGENTS.md`) si faltan.
6. **Ejecutar Definition of Done** de la plantilla al cerrar.

**Contra-regla FF-3:** palabras del pedido ("SaaS", "dashboard") o del PM ("usemos Next") **no sustituyen** leer `package.json` / `composer.json` y `task-routing.md`.

**Contra-regla social:** PRs del equipo, consenso en stand-up o **amenaza/plazo del PM** **no sustituyen** detección de stack; "validar en paralelo" después de elegir plantilla cuenta como violación FF-3.

## Topologías disponibles

| ID | Plantilla | Stack |
|----|-----------|-------|
| `laravel-api-module` | [templates/laravel-api-module.md](templates/laravel-api-module.md) | Laravel API REST (ver `laravel-backend`; modular: skill externa `laravel-modular` si existe) |
| `nextjs-saas-page` | [templates/nextjs-saas-page.md](templates/nextjs-saas-page.md) | Next.js App Router, SaaS UI + datos |
| `flutter-feature` | [templates/flutter-feature.md](templates/flutter-feature.md) | Flutter feature-first, Riverpod, GoRouter |
| `node-api-nest` | [templates/node-api-nest.md](templates/node-api-nest.md) | NestJS módulo API, DTOs, e2e |
| `laravel-filament-resource` | [templates/laravel-filament-resource.md](templates/laravel-filament-resource.md) | Filament v3+ Resource CRUD |
| `react-native-screen` | [templates/react-native-screen.md](templates/react-native-screen.md) | Expo Router pantalla nueva |
| `inertia-spa-page` | [templates/inertia-spa-page.md](templates/inertia-spa-page.md) | Laravel + Inertia Vue/React |

*(Añadir más plantillas en `templates/` y registrar aquí vía `skill-evolution`.)*

## Referencias del harness

| Tema | Archivo |
|------|---------|
| Enrutamiento por tipo de tarea | [references/task-routing.md](references/task-routing.md) |
| Checklist madurez 20 puntos | [references/readiness-checklist.md](references/readiness-checklist.md) |
| Score automatizado /20 | `scripts/harness-readiness.sh` (`--ci` ≥16) |
| Gate proyecto cliente | `harness-test-project.sh`; `validate-agents.sh` + `validate-code-map.sh` + `validate-project-memory.sh` |
| Meta-harness suite | `validate-meta-harness.sh` (job CI `meta-harness`) |
| Bootstrap strict | `bootstrap-strict-check.sh` tras personalizar plantillas |
| Aislamiento / staging | [references/staging-isolation.md](references/staging-isolation.md) |

## Estructura de cada plantilla

Toda plantilla en `templates/` incluye:

- Skills a activar (orden)
- Archivos feedforward del repo
- Definition of Done con comandos shell
- Sensores computacionales e inferenciales
- Flujo recomendado y anti-patrones
- Reglas de escalación (enlace a `karpathy-guidelines` §6)

## Integración con el harness global

| Pieza | Ubicación |
|-------|-----------|
| Catálogo de fallos | `HARNESS-FAILURES.md` (raíz de `skills/`) |
| Feedback estructurado | `comprobacion-produccion/references/error-feedback-format.md` |
| Behaviour / fixtures | `testing-strategy/references/behaviour-harness.md` |
| Mantenimiento del harness | `skill-evolution` Modo 4–7 |
| Checkpoints / escalación | `karpathy-guidelines` §5–§6 |

## Skills relacionadas

- `skill-evolution` — registrar nuevas topologías y consolidar lecciones
- `team-onboarding` — incluir harness del proyecto en día 1
- `testing-skills-with-subagents` — validar skills de disciplina del bundle
