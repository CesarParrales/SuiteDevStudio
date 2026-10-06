# Evaluación Kiro → integración Suite Dev

**Fecha:** 2026-10-06 · **Decisión:** enganchar el spec al enrutado existente, no instalar Kiro

## Origen

[Kiro](https://kiro.dev/docs/specs/) — spec en tres fases (requisitos, diseño, tareas), spec de bug (actual / esperado / intacto) y tests de propiedades. Hooks y steering quedan fuera: la suite ya los cubre.

## Por qué no instalarlo

| Pieza de Kiro | Motivo |
|---------------|--------|
| IDE, CLI, créditos, `.kiro/` | Otro producto; Cursor ya ejecuta el agente |
| Steering y hooks | `AGENTS.md`, reglas, `LEARNINGS`, hooks de Cursor |
| Oleadas paralelas automáticas | El grafo de tareas duplicaría el harness; el paralelismo queda manual y solo sin archivos compartidos |
| Tests de propiedades por defecto | Chocan con el behaviour harness; quedan opt-in |

## Qué se integró

| Artefacto | Ruta |
|-----------|------|
| Protocolo | `harness-template/references/work-spec.md` |
| Gate | `harness-template/references/task-routing.md` (feature grande y bug crítico) |
| Propiedades | `testing-strategy/references/behaviour-harness.md` § Propiedades |

El flujo corto (implementación acotada) no abre spec.

## Crédito

Ideas de fases, bug de tres comportamientos y propiedades inspiradas en Kiro. Gates y redacción son de Suite Dev Studio.
