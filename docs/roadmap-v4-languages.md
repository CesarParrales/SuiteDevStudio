# Roadmap v4 — Expansión multi-lenguaje

**Estado:** propuesta documentada · **Base:** harness v3.4 · **Fecha:** 2026-06-24

Documento de factibilidad para incluir lenguajes y stacks adicionales en la próxima versión mayor de Suite Dev Studio. Complementa [OVERVIEW.md](OVERVIEW.md) y [MANIFIESTO.md](../MANIFIESTO.md).

---

## 1. Contexto

La suite v3.4 cubre con profundidad operativa:

- **Backend:** PHP/Laravel, TS/Node/Nest
- **Frontend web:** Next.js, React, Inertia
- **Mobile cross-platform:** Flutter, React Native (Expo)
- **Transversal:** UX, calidad, harness, negocio

Otros lenguajes populares aparecen **mencionados** (p. ej. en `software-project-analysis/references/templates.md`) pero **sin skill dedicada ni plantilla harness**.

---

## 2. Qué implica “soportar un lenguaje”

No basta con un `SKILL.md`. El estándar v3.x exige un **stack pack**:

| Componente | Ubicación | Esfuerzo |
|------------|-----------|----------|
| Skill de dominio | `skills/<stack>-backend/` (~450 L + references) | Alto |
| Plantilla harness | `skills/harness-template/templates/` | Medio |
| Enrutamiento FF-3 | `task-routing.md` + detección manifests | Bajo |
| Tests | `testing-strategy/references/unit-*.md` | Medio |
| Supply chain | `supply-chain-security` (pip, go mod, …) | Medio |
| Escenario RED ciego | `scenarios-discipline.md` (opcional por stack) | Medio |
| Docs suite | MANIFIESTO, README, suite-code-map | Bajo |

**Referencia de esfuerzo:** replicar patrón `node-backend` + `node-api-nest` ≈ **3–5 días** por stack completo.

---

## 3. Matriz de candidatos

| Stack | Popularidad mercado | Fit estudio Laravel/Next/mobile | Esfuerzo | Prioridad v4 |
|-------|---------------------|----------------------------------|----------|--------------|
| **Python — FastAPI** | Muy alta | Alta (APIs, scripts, ML adjunto) | Medio | **P0** |
| **Python — Django** | Alta | Media-alta (admin, CMS) | Medio-alto | P1 |
| **Go** | Alta | Media (microservicios) | Medio | P1 |
| **Vue / Nuxt** | Alta | Media | Medio | P1 |
| **Java — Spring Boot** | Muy alta | Baja-media* | Alto | P2 |
| **C# — .NET** | Alta | Baja-media* | Alto | P2 |
| **Ruby — Rails** | Media | Media | Medio | P3 |
| **Rust** | Media-nicho | Baja | Alto | P3 |
| **Swift / Kotlin nativos** | Alta | Media** | Alto | P3 |

\* Priorizar solo con demanda enterprise recurrente.  
\** Flutter/RN ya cubren cross-platform; nativo es línea aparte.

---

## 4. Enfoques factibles

### A. Extensión ligera (no suficiente para v4 “completo”)

- Detección de stack en `task-routing.md`
- References de testing por lenguaje
- Sin plantilla → agente débil en scaffolding

### B. Stack pack estándar (recomendado)

Por cada P0/P1: skill + plantilla + unit tests + 1 escenario HT-RED ciego.

### C. Suite multi-lenguaje amplia

6–8 backends + 2 frontends. Factible a largo plazo; riesgo de mantenimiento sin proyectos piloto.

---

## 5. Roadmap propuesto

### v4.0 — Python API (FastAPI)

- `fastapi-backend` + `fastapi-api-module`
- `unit-python.md` (pytest)
- Detección: `pyproject.toml`, `requirements.txt`
- HT-RED-07 (variante ciega stack Python)
- Tag `harness-v4.0`

### v4.1 — Go + Nuxt

- `go-backend` + plantilla servicio
- `nuxt-fullstack` o skill Vue dedicada

### v4.2 — Enterprise opt-in

- Spring Boot o .NET **solo con demanda comercial**
- Django si hay recurrencia admin/CMS

### Fuera de v4 inicial

Rust; Swift/Kotlin nativos (salvo unidad de negocio mobile nativo).

---

## 6. Riesgos y mitigaciones

| Riesgo | Mitigación |
|--------|------------|
| Skills sin uso real | Proyecto piloto obligatorio antes de tag |
| Explosión de plantillas | Máx. 2 stacks por oleada |
| Regresión detección stack | Escenario ciego por stack nuevo |
| Versiones obsoletas | `stack-versions.md` por skill (patrón Laravel) |

---

## 7. Criterios de cierre v4.x

- [ ] `bash scripts/harness-test.sh` → exit 0
- [ ] Al menos 1 RED/GREEN del stack nuevo
- [ ] Plantilla harness registrada en `harness-template/SKILL.md`
- [ ] README + MANIFIESTO actualizados
- [ ] `./install-local.sh` sincroniza skills nuevas

---

## 8. Decisiones pendientes (RFC)

Antes de implementar v4.0, cerrar:

1. ¿FastAPI, Django o ambos en la misma minor?
2. ¿Proyecto piloto interno o cliente para validar LEARNINGS?
3. ¿Incluir skill `data-analysis-python` separada de `fastapi-backend`?

Ver también: [CAPABILITIES.md](CAPABILITIES.md) — mobile escala media y datos.

---

## Referencias

- [harness-decisions.md](harness-decisions.md) — ADRs H001–H017
- [releases/harness-v3.4.md](releases/harness-v3.4.md) — baseline actual
- [suite-code-map.md](suite-code-map.md) — dónde editar
