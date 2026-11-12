# Evaluación gstack → integración Suite Dev

**Fecha:** 2026-11-12 · **Decisión:** destilar tres patrones al harness, no instalar gstack

## Origen

[gstack](https://github.com/garrytan/gstack) (MIT, Garry Tan / YC) — suite de ~40
skills que convierte a Claude Code en un equipo virtual (CEO, diseñador, QA, CSO,
release engineer). 141k estrellas, releases lunes/jueves, soporte Cursor en tier
experimental. Misma categoría de producto que esta suite: pipeline de sprint
(Think → Plan → Build → Review → Test → Ship → Reflect) con artefactos encadenados
entre skills.

## Por qué no instalarlo

| Pieza de gstack | Motivo |
|-----------------|--------|
| `./setup --host cursor`, binarios compilados, Bun, Chromium embebido | Infraestructura pesada y sin firmar; la suite es Markdown puro auditable |
| Hooks de auto-update y canales stable/main | La suite versiona con tags `harness-v*` y release log propio |
| Outside reviews (envía código a Codex/Claude por defecto) | Política de datos de cliente incompatible; revisión cruzada queda manual |
| Telemetría, `gstack-doctor`, question tuning | El readiness 20/20 y HARNESS-FAILURES ya cubren el diagnóstico |
| Idioma inglés, Claude Code-first, safety skills "advisory" en Cursor | Suite en español, Cursor-first, con gates que sí bloquean |

## Qué se integró

| Patrón de gstack | Ruta en la suite |
|------------------|------------------|
| Gate integrity de `/review` y `/ship`: inventariar → leer → hallazgo; todo gate debilitado (skip, umbral, snapshot, pragma, bypass CI) llega a decisión humana con motivo; línea `Gates editados:` en el informe | `comprobacion-produccion/references/gate-integrity.md` |
| `/test-audit`: barrido de tests que cuestan más de lo que protegen, con pre-filtro mecánico, barra de retención, tarjeta de evidencia por candidato y solo-lectura hasta lote aprobado | `testing-strategy/references/test-audit.md` |
| Edit ladder de `/write-skill`: cinco peldaños anti-bloat (arreglar debajo de la skill, ganarse el sitio, editar no anexar, elegir nivel, regla no historia) + disciplina de tamaño | `skill-evolution/references/edit-ladder.md`, enlazada desde el Modo 1 |
| Vigilancia continua | Fila en `skill-evolution/references/upstream-watch.md`, cadencia 60 días |

Escenarios de presión nuevos para el gate de disciplina: `CP-RED-07` (skip de test
bajo presión) y `TS-RED-03` (purga de tests lentos) en
`testing-skills-with-subagents/references/scenarios-discipline.md`.

**Gate RED+GREEN ejecutado (2026-11-12, subagentes frescos, variantes ciegas):**
`CP-RED-07` resistió en RED (B sin skill) y GREEN B citando GI-1/GI-9 — se
mantiene como regresión. `TS-RED-03` **falló en RED con C** ("moverlos a nightly
técnicamente no borra nada"); REFACTOR añadió la contra-regla "nightly no es
borrar" a `test-audit.md`; GREEN B citándola textualmente. Capturas verbatim en
los LEARNINGS de ambas skills.

## Qué queda en observación (próxima pasada del Modo 8)

- Encadenado explícito de artefactos entre skills (design doc → plan → QA): la
  suite lo hace vía project-memory; comparar cuando gstack estabilice el formato.
- `Value card` por test (`protects=`, `fails_when=`, `no_claim=`) como header
  comentado: útil si el behaviour harness lo pide.
- Modelo de releases con frescura garantizada (<1 semana): referencia para el
  cierre trimestral si el ritmo de la suite sube.

## Crédito

Ideas de gate integrity, test audit y edit ladder destiladas de gstack (MIT).
Catálogos, ids, redacción y gates son de Suite Dev Studio.
