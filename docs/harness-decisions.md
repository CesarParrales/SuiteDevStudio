# Decisiones de harness — Suite Dev Studio

Registro FF-4: decisiones que afectan skills, CI y proyectos cliente. Formato ADR ligero.

---

## ADR-H001 — Skills de disciplina con gate RED/GREEN

**Fecha:** 2026-06-24  
**Estado:** aceptado

**Contexto:** Skills con reglas violables (deploy, tests, tokens) degradan sin prueba bajo presión.

**Decisión:** Al editar sustancialmente estas skills, ejecutar ≥1 escenario RED+GREEN de `testing-skills-with-subagents/references/scenarios-discipline.md`:

- `comprobacion-produccion`
- `karpathy-guidelines`
- `testing-strategy`
- `vibe-coding-token-optimization`
- `harness-template`

**Consecuencias:** Más tiempo al editar; menos regresiones en steering.

---

## ADR-H002 — Readiness automatizado con umbral CI 15/20

**Fecha:** 2026-06-24  
**Estado:** aceptado

**Contexto:** Modo 5 manual no escalaba; la suite no tenía `project-memory` ni comando de test unificado.

**Decisión:**

- `scripts/harness-test.sh` como gate FB-2 de la suite
- Job `harness-readiness` en CI con `--ci` (falla si &lt;15/20)
- `.cursor/project-memory.md` + este archivo para FF-4 e IN-3

**Consecuencias:** PRs que bajan madurez harness bloquean merge en suite-dev-studio.

---

## ADR-H003 — FB-3 como formato canónico de errores al agente

**Fecha:** 2026-06-24  
**Estado:** aceptado

**Contexto:** Logs crudos de CI saturan contexto y ocultan acción.

**Decisión:** Reformatear fallos con `comprobacion-produccion/references/error-feedback-format.md` y validar con `validate-fb3.sh` antes de pegar al agente.

**Consecuencias:** Escenarios CP-RED-03; fixture en CI.

---

## ADR-H004 — Plantillas por topología, no por stack genérico

**Fecha:** 2026-06-24  
**Estado:** aceptado

**Contexto:** Bundles monolíticos confunden al agente (ej. Laravel plantilla para Nest).

**Decisión:** Una plantilla por topología en `harness-template/templates/`; enrutar vía `task-routing.md`. Escenario HT-RED-01.

**Consecuencias:** 7 plantillas registradas; CI verifica presencia.

---

## ADR-H005 — Umbral CI readiness 16/20 y mapa de código suite

**Fecha:** 2026-06-24  
**Estado:** aceptado

**Contexto:** Score 18.5/20 con gaps FF-2/FB-1/IN-1 en parcial; proyectos cliente sin gate unificado.

**Decisión:**

- `docs/suite-code-map.md` como proxy FF-2 en suite-dev-studio
- `--ci` exige **16/20** (antes 15)
- `scripts/harness-test.sh` en clientes vía `--init-harness-test`
- `validate-red-scenarios.sh` en CI (estructura RED, no subagentes)

**Consecuencias:** PRs con regresión de madurez o escenarios mal formados fallan antes de merge.

---

## ADR-H006 — Mapa código cliente y release RED obligatorio

**Fecha:** 2026-06-24  
**Estado:** aceptado

**Contexto:** Clientes sin FF-2 estructurado; escenarios RED no se ejecutaban por release.

**Decisión:**

- Plantilla `templates/code-map.md` + `--init-code-map`
- `docs/harness-release-log.md` + `validate-release-red.sh` en `harness-test.sh`
- Modo 6 en `skill-evolution` al cerrar oleadas

**Consecuencias:** Proyectos nuevos tienen mapa; suite exige entrada RED reciente en CI.

---

## ADR-H007 — Arquitectura mínima en clientes y CP-RED-06 endurecido

**Fecha:** 2026-06-24  
**Estado:** aceptado

**Contexto:** FF-4 débil en proyectos nuevos; CP-RED-06 no generaba fallo RED (baseline B sin skill).

**Decisión:**

- `templates/docs/architecture/README.md` + `--init-architecture`
- CP-RED-06 con presión PM + deploy 15 min; contra-regla en GREEN
- Job `release-red` explícito en workflows suite y cliente

**Consecuencias:** RED oleada 9 eligió A (válido); skill previene en GREEN.

---

## ADR-H008 — code-map personalizado y ciclo RED→GREEN CP-RED-06

**Fecha:** 2026-06-24  
**Estado:** aceptado

**Contexto:** Clientes dejaban placeholders en `docs/code-map.md`; CP-RED-06 tenía RED (A) sin GREEN verificado en release.

**Decisión:**

- `validate-code-map.sh` en gate proyecto (sin `{{`, `YYYY-MM-DD`, ejemplos)
- `adr/000-template.md` en `--init-architecture`
- GREEN oleada 10 documentado; contra-regla en `comprobacion-produccion` §0

**Consecuencias:** FF-2 parcial si code-map es plantilla sin editar.

---

## ADR-H009 — Bootstrap único y validate-agents

**Fecha:** 2026-06-24  
**Estado:** aceptado

**Contexto:** Siete flags `--init-*` fragmentaban onboarding; AGENTS.md plantilla contaba como FF-1 hecho.

**Decisión:**

- `--bootstrap` activa todos los init de proyecto
- `validate-agents.sh` en `harness-test-project.sh`
- HT-RED-03: keyword "SaaS" ≠ stack Next

**Consecuencias:** Proyectos nuevos fallan gate hasta personalizar AGENTS y code-map.

---

## ADR-H010 — Meta-harness 98% y project-memory validado

**Fecha:** 2026-06-24  
**Estado:** aceptado

**Contexto:** FF/IN en clientes con plantillas sin editar; HT-RED-03 filtraba stack en el prompt.

**Decisión:**

- `validate-project-memory.sh` en gate proyecto
- `validate-meta-harness.sh` + `harness-meta-checklist.md`
- HT-RED-03 sin datos de stack; contra-regla en `harness-template`

**Consecuencias:** Suite declara ~98%; RED puro de HT-RED-03 sigue difícil sin subagente ciego.

---

## ADR-H011 — Bootstrap strict y presión social HT-RED-04

**Fecha:** 2026-06-24  
**Estado:** aceptado

**Contexto:** HT-RED-03 no fallaba RED; clientes dejaban placeholders tras bootstrap.

**Decisión:**

- `--bootstrap --strict` + `bootstrap-strict-check.sh`
- HT-RED-04 (consenso equipo → A); contra-regla "validar en paralelo"
- Job CI `meta-harness` explícito

**Consecuencias:** RED oleada 13 eligió A; GREEN con skill debe elegir B.

---

## ADR-H012 — Tag harness-v3.4 y cierre trimestral (Modo 7)

**Fecha:** 2026-06-24  
**Estado:** aceptado

**Contexto:** Oleadas 1–13 sin release formal; HT-RED-04 RED sin GREEN documentado en tag.

**Decisión:**

- `docs/releases/harness-v3.4.md` + `scripts/tag-harness-release.sh`
- Modo 7 en `skill-evolution` + `quarterly-harness.md`
- GREEN HT-RED-04 registrado en release-log

**Consecuencias:** Tag manual tras `tag-harness-release.sh`; revisión trimestral calendarizada.

---

## ADR-H013 — Escenarios RED ciegos (sin jerga harness)

**Fecha:** 2026-06-24  
**Estado:** aceptado

**Contexto:** HT-RED-03/04 con vocabulario de plantillas permitían acertar por conocimiento previo de la suite; RED ciego a veces no genera fallo (HT-RED-05).

**Decisión:**

- Añadir `HT-RED-05` / `HT-RED-06` como variantes sin nombres de plantilla ni "harness"
- Oleada release con escenario ciego endurecido que sí produce RED→A (`HT-RED-06`)
- Gaps de escenario sin RED claro → `HARNESS-FAILURES.md` abierto

**Consecuencias:** Validar variantes ciegas en Modo 7; endurecer si RED→B sin skill (patrón oleada 16: autoridad PM + amenaza explícita a opción B).

---

## ADR-H014 — Endurecimiento HT-RED-05 (presión PM ciega)

**Fecha:** 2026-06-24  
**Estado:** aceptado

**Contexto:** HT-RED-05 no generaba RED→A tras 3 intentos (oleada 15); subagentes elegían B por pragmatismo.

**Decisión:**

- Añadir autoridad PM explícita + amenaza a quien lea configs + scaffold ajeno validado
- Contra-regla social ampliada: amenaza/plazo del PM no sustituye detección de stack
- RED A → GREEN B verificado oleada 16

**Consecuencias:** Escenarios ciegos FF-3 requieren presión equivalente a HT-RED-04/06 para baseline RED fiable.

---

## ADR-H015 — Disciplina karpathy-guidelines en release (Modo 7)

**Fecha:** 2026-06-24  
**Estado:** aceptado

**Contexto:** Modo 7 oleada 17; solo `harness-template` y `comprobacion-produccion` tenían RED/GREEN en release log.

**Decisión:**

- Endurecer KG-RED-01/03 con presión reviewer/deploy
- RED+GREEN verificados; contra-reglas en §3 y §6
- `docs/harness-quarterly-2026-06.md` como entregable Modo 7

**Consecuencias:** `vibe-coding-token-optimization` pendiente de gate disciplina.

---

## ADR-H016 — Disciplina testing-strategy en release (oleada 18)

**Fecha:** 2026-06-24  
**Estado:** aceptado

**Contexto:** TS-RED-01/02 baseline elegía B sin skill; presión PM/lead insuficiente.

**Decisión:**

- Endurecer TS-RED-01 (PM/CTO prohíben tests) y TS-RED-02 (lead prohíbe integración)
- RED A → GREEN B verificados; contra-reglas MVP/CI en SKILL.md

**Consecuencias:** Patrón endurecimiento aplicable a VC-RED-* pendientes.

---

## ADR-H017 — Disciplina vibe-coding completa (oleada 19)

**Fecha:** 2026-06-24  
**Estado:** aceptado

**Contexto:** Última skill de disciplina sin RED/GREEN en release log; VC-RED-02 baseline elegía B.

**Decisión:**

- Endurecer VC-RED-02 con política de auditoría (log total obligatorio)
- RED A → GREEN B verificado; contra-regla contexto acotado
- **5/5 skills de disciplina** con gate RED/GREEN documentado

**Consecuencias:** Suite disciplina cerrada; próximo foco tag v3.4 o mantenimiento Modo 7.

---

## ADR-H018 — Escalera código mínimo (inspiración Ponytail, suite nativa)

**Fecha:** 2026-06-24  
**Estado:** aceptado

**Contexto:** Ponytail (comunidad) promete ~22% menos tokens; riesgo de conflicto con tests/harness si se usa always-on externo.

**Decisión:**

- Escalera en `vibe-coding-token-optimization` (`decision-ladder.md`, `diff-review.md`)
- Regla Cursor opt-in (`minimal-code.mdc`, `--init-minimal-rule`)
- Sin plugin externo; `docs/evaluation-ponytail.md`
- Tests/DoD harness fuera de recortes de la escalera

**Consecuencias:** VC-RED-03; medir ahorro en proyectos piloto.

---

## Plantilla (nueva decisión)

```markdown
## ADR-H00N — Título
**Fecha:** YYYY-MM-DD
**Estado:** propuesto | aceptado | obsoleto
**Contexto:** ...
**Decisión:** ...
**Consecuencias:** ...
```
