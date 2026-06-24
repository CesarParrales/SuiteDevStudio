# Mapa de código — Suite Dev Studio (FF-2)

Dónde leer **antes de editar**. El agente no debe reescribir skills a ciegas.

`last_updated: 2026-06-24`

## Raíz del repo

| Ruta | Contenido | Cuándo leer |
|------|-----------|-------------|
| `README.md` | Entrada GitHub: install, valor, estructura | Onboarding repo |
| `docs/OVERVIEW.md` | Visión, flujos, glosario | Contexto del proyecto |
| `MANIFIESTO.md` | Alcance, lista de skills, artefactos harness | Cualquier cambio en la suite |
| `install-local.sh` | Instalación global/proyecto; `--bootstrap` en clientes | Cambios de distribución |
| `scripts/harness-test.sh` | Gate FB-2 local + CI | Antes de PR |
| `docs/harness-ci.md` | Jobs CI, umbrales readiness | Cambios en workflows |
| `docs/harness-decisions.md` | ADRs harness (FF-4) | Decisiones de arquitectura del harness |
| `.cursor/project-memory.md` | Gates, log sesión, decisiones recientes | Inicio de sesión en este repo |
| `templates/` | `AGENTS.md`, `project-memory.md`, workflows GitHub | Plantillas para clientes |

## Skills (`skills/<nombre>/`)

| Patrón | Rol |
|--------|-----|
| `SKILL.md` | Reglas operativas (<500 líneas); enlaces a `references/` |
| `references/*.md` | Detalle progressive disclosure |
| `LEARNINGS.md` | Pendientes y lecciones (skill-evolution) |
| `scripts/` | Gates ejecutables (validate-fb3, harness-readiness) |
| `templates/` | Solo en `harness-template` (topologías) |

**Skills de disciplina** (gate RED/GREEN al editar): `comprobacion-produccion`, `karpathy-guidelines`, `testing-strategy`, `vibe-coding-token-optimization`, `harness-template`.

## Enrutamiento por tarea

1. Clasificar tarea → `skills/harness-template/references/task-routing.md`
2. Elegir plantilla → `skills/harness-template/templates/<id>.md`
3. Cierre → `comprobacion-produccion` + gates en `project-memory`

## CI

`.github/workflows/harness-validate.yml` — jobs: `validate-fb3`, `skill-integrity`, `harness-templates`, `harness-readiness` (≥16/20).

## Proyectos cliente (fuera de este repo)

Tras `install-local.sh --project . --bootstrap` (personalizar `AGENTS.md` + `docs/code-map.md` antes del gate):

- Skills en `.cursor/skills/`
- `scripts/harness-test.sh` en el proyecto
- Workflow `.github/workflows/harness-validate.yml`

Leer `context.md` / `AGENTS.md` del cliente antes de tocar código de aplicación.
