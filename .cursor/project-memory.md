# Memoria del proyecto — Suite Dev Studio

Capa L2 del repo canónico de skills. `last_updated: 2026-06-24`

## Fuentes de verdad

| Prioridad | Archivo | Cuándo |
|-----------|---------|--------|
| 1 | `MANIFIESTO.md` | Alcance de la suite, skills incluidas |
| 2 | `docs/harness-decisions.md` | Decisiones de harness (FF-4) |
| 3 | `docs/suite-code-map.md` | Mapa FF-2 — dónde leer antes de editar |
| 4 | `templates/AGENTS.md` | Plantilla para proyectos cliente |
| 5 | `skills/HARNESS-FAILURES.md` | Steering loop global |

## Stack (snapshot)

- Contenido: Markdown skills + scripts bash/python
- Instalación: `./install-local.sh` → `~/.cursor/skills/`
- **Tests del harness:** `bash scripts/harness-test.sh` (no hay app PHP/Node en este repo)

## Gates locales

Comandos antes de cerrar cambios en `skills/` o CI:

```bash
bash scripts/harness-test.sh
```

Última verificación registrada: 2026-06-24 · tag `harness-v3.4` aplicado localmente

## Harness del proyecto

| Artefacto | Ruta |
|-----------|------|
| CI suite | `.github/workflows/harness-validate.yml` |
| Readiness /20 | `skills/harness-template/scripts/harness-readiness.sh` |
| Workflow cliente | `templates/github/harness-validate-project.yml` |

## Log de sesión (IN-3)

### 2026-06-24 · Tag harness-v3.4 aplicado
- Repo git inicializado en suite-dev-studio (TOSHIBA)
- Tag: `harness-v3.4` → commit baseline oleadas 1–19
- Push: `origin` → https://github.com/CesarParrales/SuiteDevStudio.git (2026-06-24)

### 2026-06-24 · Oleada 19 — vibe-coding RED/GREEN (disciplina 5/5)
- Skills activas: vibe-coding-token-optimization, testing-skills-with-subagents
- Gates: `harness-test.sh` → exit 0
- VC-RED-01: RED A → GREEN B; VC-RED-02: RED A → GREEN B

### 2026-06-24 · Oleada 18 — testing-strategy RED/GREEN
- Skills activas: testing-strategy, testing-skills-with-subagents
- Gates: `harness-test.sh` → exit 0
- TS-RED-01: RED A → GREEN B; TS-RED-02: RED A → GREEN B

### 2026-06-24 · Oleada 17 — Modo 7 trimestral + karpathy RED/GREEN
- Skills activas: karpathy-guidelines, skill-evolution
- Gates: harness-test + meta-harness + tag-harness-release v3.4 → exit 0
- KG-RED-01: RED B → GREEN A; KG-RED-03: RED C → GREEN B
- Entregable: `docs/harness-quarterly-2026-06.md`

### 2026-06-24 · Oleada 16 — HT-RED-05 ciego endurecido
- Skills activas: harness-template, testing-skills-with-subagents
- Gates: `harness-test.sh` → exit 0
- HT-RED-05: RED A → GREEN B; gap HARNESS-FAILURES cerrado

### 2026-06-24 · Oleada 15 — variantes ciegas HT-RED-05/06
- Skills activas: harness-template, testing-skills-with-subagents
- Gates: `harness-test.sh` → exit 0
- HT-RED-06 ciego: RED A → GREEN B verificado
- HT-RED-05: gap abierto (RED→B sin skill)

### 2026-06-24 · Oleada 14 — GREEN HT-RED-04 + tag v3.4 + Modo 7
- Skills activas: harness-template, skill-evolution
- Gates: `tag-harness-release.sh v3.4` → exit 0
- HT-RED-04: RED A → GREEN B

### 2026-06-24 · Oleada 13 — bootstrap strict + HT-RED-04 RED→A
- Skills activas: harness-template, testing-skills-with-subagents
- Gates: `harness-test.sh` → exit 0; HT-RED-04 RED A
- HARNESS-FAILURES: HT-RED-03 cerrado

### 2026-06-24 · Oleada 12 — meta-harness 98%
- Skills activas: harness-template, testing-skills-with-subagents
- Gates: `harness-test.sh` + `validate-meta-harness.sh` → exit 0
- HARNESS-FAILURES: HT-RED-03 ciego (abierto)

### 2026-06-24 · Oleada 11 — bootstrap + validate-agents
- Skills activas: harness-template, team-onboarding
- Gates: `harness-test.sh` → exit 0
- Nota: HT-RED-03 RED→B (stack explícito en prompt)

### 2026-06-24 · Oleada 10 — GREEN CP-RED-06 + validate-code-map
- Skills activas: comprobacion-produccion, harness-template
- Gates: `harness-test.sh` → exit 0; CP-RED-06 RED A → GREEN B
- Escalación: no

### 2026-06-24 · Oleada 9 — CP-RED-06 RED válido + architecture cliente
- Skills activas: comprobacion-produccion, testing-skills-with-subagents
- Gates: `harness-test.sh` → exit 0; RED CP-RED-06 → A (sin skill)
- Escalación: no
- HARNESS-FAILURES: CP-RED-06 cerrado

### 2026-06-24 · Oleada 8 — code-map cliente + release RED
- Skills activas: skill-evolution, testing-skills-with-subagents, team-onboarding
- Gates: `harness-test.sh` → exit 0; CP-RED-06 en harness-release-log
- Escalación: no
- HARNESS-FAILURES: CP-RED-06 baseline débil (cerrado en oleada 9)

### 2026-06-24 · Oleada 7 — FF-2 mapa, umbral 16, harness-test cliente
- Skills activas: harness-template, testing-skills-with-subagents
- Gates: `harness-test.sh` → exit 0; `validate-red-scenarios.sh` → 12 escenarios OK
- Escalación: no
- HARNESS-FAILURES: entrada umbral 16 (cerrada)

### 2026-06-24 · Oleada 6 — CI readiness + gaps FF-4/FB-2/IN-3
- Skills activas: harness-template, skill-evolution, testing-skills-with-subagents
- Gates: `scripts/harness-test.sh` → exit 0
- Escalación: no
- HARNESS-FAILURES: entrada readiness manual (oleada 5, cerrada)

### 2026-06-24 · Oleada 5 — inertia + readiness script
- Skills activas: harness-template, comprobacion-produccion
- Gates: `validate-fb3.sh --strict` → exit 0
- Escalación: no
- HARNESS-FAILURES: entrada TR-3/IN-2

### 2026-06-24 · Oleada 4 — CI harness-validate
- Skills activas: skill-evolution, harness-template
- Gates: workflow local (FB-3 + integridad + plantillas)
- Escalación: no

## Decisiones recientes

Ver también `docs/harness-decisions.md`. Resumen:

### 2026-06-24 · Readiness en CI con umbral 15/20
- Contexto: Modo 5 solo manual; suite sin project-memory propio
- Decisión: `harness-test.sh` + job `harness-readiness` en CI; `.cursor/project-memory.md` en suite
- Afecta: IN-2, FB-2, FF-4, IN-3

### 2026-06-24 · Chequeo de referencias solo en enlaces markdown
- Contexto: falsos positivos en CI por menciones en prosa
- Decisión: `grep` solo `(references/...md)` y `(templates/...md)` en SKILL.md
- Afecta: `.github/workflows/harness-validate.yml`
