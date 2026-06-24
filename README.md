# Suite Dev Studio

**Sistema operativo de skills para desarrollo web y mobile asistido por IA.**

Suite canónica de [Cursor Agent Skills](https://cursor.com/docs/context/skills) para un estudio de software: arquitectura, backend, frontend, UX, calidad, seguridad, negocio y **harness engineering** — reglas, gates y memoria que hacen al agente más predecible entre proyectos y personas.

| | |
|---|---|
| **Versión harness** | `v3.4` ([release](docs/releases/harness-v3.4.md)) |
| **Skills** | 38 (33 dominio + 4 meta + 1 opt-in) |
| **Readiness** | 20/20 automatizado |
| **Tag** | [`harness-v3.4`](https://github.com/CesarParrales/SuiteDevStudio/releases/tag/harness-v3.4) |

---

## Valor en una frase

Menos improvisación del agente, más entregables repetibles: el mismo criterio de arquitectura, tests, deploy y UX en cada repo y cada dev.

## Qué resuelve

| Problema | Cómo lo aborda la suite |
|----------|-------------------------|
| El agente “inventa” stack o salta convenciones | Skills de disciplina + escenarios RED/GREEN |
| Cada proyecto arranca distinto | Plantillas `AGENTS.md`, `project-memory`, code-map, bootstrap |
| Errores de CI sin formato útil | Feedback FB-3 (`comprobacion-produccion`) |
| Deuda de prompts dispersa | 38 skills con protocolo, references y LEARNINGS |
| Onboarding lento | `team-onboarding`, harness por topología (`harness-template`) |

## Dónde vive la suite (3 capas)

```
┌─────────────────────────────────────────────────────────────┐
│  1. Repo canónico (este GitHub)                             │
│     Fuente de verdad · CI · releases harness-v*             │
└──────────────────────────┬──────────────────────────────────┘
                           │ ./install-local.sh
                           ▼
┌─────────────────────────────────────────────────────────────┐
│  2. Cursor global (~/.cursor/skills/)                       │
│     Skills disponibles en cualquier chat / proyecto         │
└──────────────────────────┬──────────────────────────────────┘
                           │ ./install-local.sh --project . --bootstrap
                           ▼
┌─────────────────────────────────────────────────────────────┐
│  3. Proyecto cliente (Laravel, Next, etc.)                  │
│     AGENTS.md · .cursor/project-memory.md · harness-test    │
└─────────────────────────────────────────────────────────────┘
```

---

## Inicio rápido

### 1. Clonar e instalar skills en Cursor

```bash
git clone https://github.com/CesarParrales/SuiteDevStudio.git
cd SuiteDevStudio
./install-local.sh
```

Copia las 38 skills a `~/.cursor/skills/`. No borra skills personales ajenas a la suite.

### 2. Bootstrap en un proyecto cliente

Desde la raíz del repo de tu app:

```bash
/path/to/SuiteDevStudio/install-local.sh --project . --bootstrap
```

Crea (si no existen):

| Artefacto | Ruta |
|-----------|------|
| Memoria L2 | `.cursor/project-memory.md` |
| Mapa para el agente | `AGENTS.md` |
| Mapa FF-2 | `docs/code-map.md` |
| Arquitectura + ADR | `docs/architecture/` |
| Gate local | `scripts/harness-test.sh` |
| CI proyecto | `.github/workflows/harness-validate.yml` |

**Personaliza** `AGENTS.md`, `docs/code-map.md` y `.cursor/project-memory.md`, luego:

```bash
/path/to/SuiteDevStudio/install-local.sh --project . --bootstrap --strict
bash scripts/harness-test.sh
```

### 3. Verificar la suite (maintainers)

```bash
bash scripts/harness-test.sh
```

---

## Catálogo de skills (resumen)

Detalle completo en [`MANIFIESTO.md`](MANIFIESTO.md).

| Capa | Skills | Enfoque |
|------|--------|---------|
| **Negocio** | 4 | Propuestas, pricing, análisis, sprints |
| **Arquitectura** | 10 | Web, DB, API, Laravel, Node, Next, React, Flutter, RN, DevOps |
| **Calidad** | 12 | Tests, prod gates, Karpathy, tokens, seguridad, git, observabilidad, onboarding |
| **Diseño / UX** | 8 | Discovery, IA, UI web/mobile, design system, atomic, admin |
| **Meta** | 4 | `skill-evolution`, `harness-template`, `testing-skills-with-subagents`, `HARNESS-FAILURES` |
| **Opt-in** | 1 | `graphify-integration` |

### Skills de disciplina (gate RED/GREEN)

Al editar reglas en estas skills, ejecutar escenario RED + GREEN (`testing-skills-with-subagents`):

- `comprobacion-produccion`
- `karpathy-guidelines`
- `testing-strategy`
- `vibe-coding-token-optimization`
- `harness-template`

---

## Harness engineering

La suite implementa **feedforward + feedback + infraestructura + team readiness**:

| Dimensión | Ejemplos en el repo |
|-----------|---------------------|
| **Feedforward (FF)** | `AGENTS.md`, `project-memory`, `task-routing`, plantillas por topología |
| **Feedback (FB)** | FB-3, `HARNESS-FAILURES.md`, release log RED/GREEN |
| **Infrastructure (IN)** | `harness-test.sh`, CI 7 jobs, `validate-*` scripts |
| **Team (TR)** | Onboarding, Modo 5 readiness /20, quarterly harness |

### Topologías (`harness-template`)

| ID | Stack |
|----|-------|
| `laravel-api-module` | Laravel API REST |
| `nextjs-saas-page` | Next.js App Router |
| `inertia-spa-page` | Laravel + Inertia |
| `node-api-nest` | NestJS |
| `laravel-filament-resource` | Filament CRUD |
| `flutter-feature` | Flutter + Riverpod |
| `react-native-screen` | Expo Router |

---

## Estructura del repositorio

```
SuiteDevStudio/
├── README.md                 ← Estás aquí
├── MANIFIESTO.md             ← Catálogo y políticas de la suite
├── install-local.sh          ← Instalador global y por proyecto
├── scripts/
│   ├── harness-test.sh       ← Gate unificado (local + CI)
│   └── tag-harness-release.sh
├── skills/                   ← 38 skills (SKILL.md + references/)
├── templates/                ← Plantillas para proyectos cliente
├── docs/
│   ├── suite-code-map.md     ← Mapa FF-2 de este repo
│   ├── harness-*.md          ← CI, releases, decisiones (ADRs)
│   └── releases/             ← Notas por versión harness
└── .github/workflows/        ← CI de la suite
```

---

## CI y calidad

En cada push/PR que toque `skills/` o `templates/`:

| Job | Valida |
|-----|--------|
| `validate-fb3` | Formato feedback FB-3 |
| `skill-integrity` | Frontmatter, enlaces, ≤500 líneas |
| `harness-templates` | Plantillas + AGENTS |
| `harness-readiness` | Score ≥16/20 |
| `red-scenarios` | 19 escenarios RED estructurados |
| `release-red` | Release log vigente (≤90 días) |
| `meta-harness` | Artefactos de madurez ~100% |

Ver [`docs/harness-ci.md`](docs/harness-ci.md).

---

## Documentación

| Documento | Contenido |
|-----------|-----------|
| [MANIFIESTO.md](MANIFIESTO.md) | Catálogo, memoria L0–L3, política de stack |
| [docs/OVERVIEW.md](docs/OVERVIEW.md) | Visión, flujos y glosario |
| [docs/suite-code-map.md](docs/suite-code-map.md) | Dónde editar qué en este repo |
| [docs/harness-release.md](docs/harness-release.md) | Cierre de oleadas (Modo 6) |
| [docs/harness-quarterly-2026-06.md](docs/harness-quarterly-2026-06.md) | Informe Modo 7 trimestral |
| [docs/harness-decisions.md](docs/harness-decisions.md) | ADRs del harness (H001–H017) |
| [docs/releases/harness-v3.4.md](docs/releases/harness-v3.4.md) | Release actual |

---

## Mantenimiento

| Tarea | Cuándo | Cómo |
|-------|--------|------|
| Sincronizar Cursor | Tras editar skills | `./install-local.sh` |
| Cerrar oleada | Cambios en harness | Modo 6 → `skill-evolution` |
| Cierre trimestral | 8–12 semanas | Modo 7 → `quarterly-harness.md` |
| Nuevo release | Gates en verde | `bash scripts/tag-harness-release.sh vX.Y` |

---

## Compatibilidad

- **Cursor** (skills en `~/.cursor/skills/` o `.cursor/skills/` del proyecto)
- Frontmatter portable (`name` + `description`) — compatible con otros IDEs que soporten el formato Agent Skills
- **Stacks:** Laravel, Next.js, NestJS, Flutter, React Native, Inertia (ver skills de capa 2)

---

## Autor

**Cesar Parrales** — [GitHub @CesarParrales](https://github.com/CesarParrales)

Suite Dev Studio — estudio de desarrollo web/mobile con agentes de IA.

---

## Licencia

Uso privado del estudio salvo que se indique otra licencia en releases futuros. Consultar al maintainer antes de redistribución.
