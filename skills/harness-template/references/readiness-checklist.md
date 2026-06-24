# Checklist de madurez harness (20 puntos)

Marcar cada ítem: `Hecho` | `Parcial` | `Falta`. Priorizar gaps con mayor costo de fallo.

**Automatizado (heurísticas):**

```bash
# Suite Dev Studio (desde raíz del repo):
bash skills/harness-template/scripts/harness-readiness.sh --suite ./skills

# Proyecto cliente (con skills instaladas):
bash .cursor/skills/harness-template/scripts/harness-readiness.sh --project .
```

Manual o revisión humana: complementar ítems marcados `parcial` (especialmente FF-2).

Ejecutar vía `skill-evolution` **Modo 5** o al auditar un proyecto/repo.

## Feedforward (FF)

| ID | Ítem | Hecho si… |
|----|------|-----------|
| FF-1 | Reglas antes del agente | `AGENTS.md` personalizado (`validate-agents.sh`); suite: `templates/AGENTS.md` |
| FF-2 | Código relevante en contexto | Suite: `docs/suite-code-map.md`; cliente: `docs/code-map.md` **sin placeholders** (`validate-code-map.sh`) |
| FF-3 | Tipo de tarea → skills | Se usa `references/task-routing.md` o `harness-template` |
| FF-4 | Decisiones históricas | `project-memory.md`, `docs/harness-decisions.md` (ADRs) o `docs/` referenciados |
| FF-5 | Presupuesto de contexto | Skills <500 líneas, progressive disclosure, `vibe-coding-token-optimization` |

## Feedback (FB)

| ID | Ítem | Hecho si… |
|----|------|-----------|
| FB-1 | Syntax / types | Linter y/o `tsc`/`pint` en el flujo de cierre |
| FB-2 | Tests automáticos | Suite: `scripts/harness-test.sh`; cliente: mismo vía `--init-harness-test` |
| FB-3 | Errores estructurados | Fallos en formato `error-feedback-format.md` + `validate-fb3.sh` |
| FB-4 | Checkpoints | Tareas largas pausan en >5 archivos / >300 líneas |
| FB-5 | Escalación | 2 fallos iguales → parar (`karpathy-guidelines` §6) |

## Infrastructure (IN)

| ID | Ítem | Hecho si… |
|----|------|-----------|
| IN-1 | Harness en VCS | Suite en repo (suite-dev-studio) + `install-local.sh` |
| IN-2 | Test del harness | Skills RED/GREEN; CI con `harness-readiness` (≥15/20); suite: `scripts/harness-test.sh` |
| IN-3 | Log de sesión | `project-memory` con log `### YYYY-MM-DD` + gates `exit 0`; `validate-project-memory.sh` |
| IN-4 | Coste observable | Métricas por archivos/líneas, no tokens (vibe-coding) |
| IN-5 | Aislamiento riesgoso | Worktrees/subagentes readonly para experimentos (`staging-isolation.md`) |

## Team readiness (TR)

| ID | Ítem | Hecho si… |
|----|------|-----------|
| TR-1 | Checklist revisión agente | `comprobacion-produccion` en cierre de tareas |
| TR-2 | Catálogo de fallos | `HARNESS-FAILURES.md` con entradas recientes |
| TR-3 | Revisiones periódicas | `skill-evolution` cada 2–4 semanas |
| TR-4 | Onboarding harness | `team-onboarding` + AGENTS.md en día 1 |
| TR-5 | Canal de mejora | `LEARNINGS.md` por skill con pendientes atendidos |

## Puntuación rápida

- **Hecho** = 1, **Parcial** = 0.5, **Falta** = 0
- **≥16/20** — harness maduro para trabajo diario con agentes
- **12–15** — usable; cerrar gaps FB e IN primero
- **<12** — priorizar FF-1, FB-2, FB-3 antes de más features en skills

## Formato de informe (Modo 5)

```markdown
# Harness readiness — YYYY-MM-DD — <proyecto o suite>

| Dimensión | Hecho | Parcial | Falta | Score |
|-----------|-------|---------|-------|-------|
| Feedforward | | | | /5 |
| Feedback | | | | /5 |
| Infrastructure | | | | /5 |
| Team | | | | /5 |
| **Total** | | | | **/20** |

## Top 3 gaps (acción esta semana)
1. ...
```
