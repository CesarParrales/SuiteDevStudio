# Suite Dev Studio — Visión y descripción del proyecto

Documento de referencia para mantainers y nuevos integrantes. Entrada principal del repo: [README.md](../README.md).

## Identidad

**Suite Dev Studio** es el repositorio canónico de **Agent Skills** para un estudio de software que construye productos web y mobile (Laravel, Next.js, NestJS, Flutter, React Native) con asistencia de IA en Cursor.

No es una aplicación desplegable: es **conocimiento operativo empaquetado** — reglas, protocolos, plantillas y sensores que el agente sigue al codificar, revisar, estimar o diseñar.

## Problema que ataca

Los equipos que usan IA para desarrollo suelen sufrir:

1. **Inconsistencia** — cada dev (y cada chat) aplica criterios distintos.
2. **Alucinación operativa** — el agente elige stack, omite tests o expande scope bajo presión.
3. **Contexto perdido** — decisiones no persisten entre sesiones ni repos.
4. **Sin feedback loop** — los mismos fallos se repiten sin catálogo ni remediación.

La suite convierte prácticas del estudio en **skills invocables** + **harness verificable** (scripts, CI, escenarios RED/GREEN).

## Propuesta de valor

| Stakeholder | Beneficio |
|-------------|-----------|
| **Developer** | Skills listas por stack y tarea; menos prompt manual |
| **Tech lead** | Gates, ADRs, code-map, disciplina verificada |
| **PM / cliente** | Skills de negocio (scope, pricing, sprints) alineadas al técnico |
| **Diseño** | UX/UI skills con references y auditoría WCAG |
| **Estudio** | Onboarding en días; mismo “sistema operativo” en N proyectos |

## Arquitectura conceptual

### Capas de skills (negocio → diseño)

Ver catálogo detallado en [MANIFIESTO.md](../MANIFIESTO.md).

1. **Negocio / cliente** — contratos, precios, análisis, agile.
2. **Arquitectura técnica** — patrones, stacks, DevOps.
3. **Calidad / proceso / seguridad** — tests, prod, guidelines, supply chain.
4. **Diseño / UX** — research, IA, UI, design system.

### Sistema de memoria (L0–L3)

| Nivel | Qué es | Dónde |
|-------|--------|-------|
| L0 | Sesión de chat | No persistir salvo petición |
| L1 | Skill activa | `skills/*/SKILL.md` + `references/` |
| L2 | Proyecto | `.cursor/project-memory.md` |
| L3 | Aprendizaje | `LEARNINGS.md` por skill → `skill-evolution` |
| Harness | Fallos del agente | `HARNESS-FAILURES.md` |

### Harness engineering (4 dimensiones)

Inspirado en *Harness Engineering* para agentes:

- **Feedforward** — decirle al agente *antes* qué leer y qué no asumir (`AGENTS.md`, routing, plantillas).
- **Feedback** — sensores cuando falla (FB-3, logs estructurados, release RED/GREEN).
- **Infrastructure** — CI, scripts, readiness /20.
- **Team** — onboarding, quarterly review, catálogo de fallos.

Madurez actual: **~100%** (readiness 20/20, disciplina 5/5 con RED/GREEN documentados).

## Flujos principales

### A. Desarrollador día a día

1. Cursor carga skills desde `~/.cursor/skills/` (instalación global).
2. El agente invoca la skill según la tarea (p. ej. `laravel-backend`, `testing-strategy`).
3. Lee L2 del proyecto si existe (`project-memory.md`).
4. Ejecuta protocolo de la skill (pasos + gates shell).

### B. Proyecto nuevo

```bash
git clone <repo-cliente>
cd <repo-cliente>
/path/to/SuiteDevStudio/install-local.sh --project . --bootstrap
# Editar AGENTS.md, docs/code-map.md, .cursor/project-memory.md
/path/to/SuiteDevStudio/install-local.sh --project . --bootstrap --strict
bash scripts/harness-test.sh
```

### C. Maintainer de la suite

1. Editar skill en `skills/`.
2. Si es disciplina → RED + GREEN (`scenarios-discipline.md`).
3. `bash scripts/harness-test.sh`
4. `./install-local.sh` (sync global)
5. Modo 6 (oleada) o Modo 7 (trimestral) en `skill-evolution`.
6. Tag `harness-v*` cuando corresponda.

## Glosario

| Término | Significado |
|---------|-------------|
| **Skill** | Carpeta con `SKILL.md` — instrucciones para el agente |
| **Harness** | Conjunto de reglas + scripts + CI que acotan al agente |
| **RED/GREEN** | Baseline sin skill (debe fallar) vs con skill (debe pasar) |
| **FF-3** | Feedforward: routing de tarea / detección de stack |
| **FB-3** | Feedback: formato estructurado de errores CI |
| **Bootstrap** | Copiar plantillas al proyecto cliente (`--init-*`) |
| **Readiness** | Score /20 de madurez harness (`harness-readiness.sh`) |
| **Oleada** | Ciclo de mejora del harness (Modo 6) |
| **Topología** | Bundle harness-template por stack (p. ej. `nextjs-saas-page`) |

## Historial de releases harness

| Tag | Fecha | Hitos |
|-----|-------|-------|
| `harness-v3.4` | 2026-06-24 | Bootstrap strict, meta-harness CI, disciplina 5/5, Modo 7 |

Ver [harness-release-log.md](harness-release-log.md) y [releases/](releases/).

## Enlaces

- Repositorio: https://github.com/CesarParrales/SuiteDevStudio
- Release v3.4: https://github.com/CesarParrales/SuiteDevStudio/releases/tag/harness-v3.4
