# Evaluación Ponytail → integración Suite Dev

**Fecha:** 2026-06-24 · **Decisión:** adoptar escalera, no el plugin completo

## Origen

[Ponytail](https://github.com/DietrichGebert/ponytail) — reglas “lazy senior dev” con escalera YAGNI→stdlib→nativo; benchmarks ~22% menos tokens en sesiones agentic.

## Por qué no instalarlo tal cual

| Riesgo | Mitigación suite |
|--------|------------------|
| `alwaysApply` fijo suma contexto | Regla Cursor **opt-in** (`alwaysApply: false`) |
| Tests mínimos vs pirámide | Escalera excluye recortes en `testing-strategy` |
| Duplica karpathy + vibe-coding | Un solo lugar: `decision-ladder.md` |
| Sin harness RED/GREEN | Escenarios VC-RED en disciplina |

## Qué se integró (oleada 20)

| Artefacto | Ruta |
|-----------|------|
| Escalera | `vibe-coding-token-optimization/references/decision-ladder.md` |
| Revisión diff | `vibe-coding-token-optimization/references/diff-review.md` |
| Regla Cursor opcional | `templates/cursor/minimal-code.mdc` |
| Init proyecto | `install-local.sh --init-minimal-rule` |

## Crédito

Ideas de escalera y revisión anti-bloat inspiradas en Ponytail (MIT). Implementación y gates propios de Suite Dev Studio.

Ver [ADR-H018](harness-decisions.md).
