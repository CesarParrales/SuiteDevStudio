# Log RED/GREEN por release — Suite Dev Studio

Append-only. Una entrada mínima por oleada o versión harness.

---

### 2026-06-24 · harness-v3.4 (tag aplicado) · oleada 19+

- **Escenario:** VC-RED-01 (cierre disciplina 5/5)
- **Tag:** `harness-v3.4` creado localmente (commit inicial repo)
- **Gates:** `tag-harness-release.sh v3.4` → exit 0
- **Nota:** push pendiente si se configura `origin`

---

### 2026-06-24 · v3.4 oleada 19 — disciplina completa

- **Escenario:** VC-RED-01 (vibe-coding-token-optimization)
- **Skill:** vibe-coding-token-optimization
- **RED:** A — *"8 archivos de una vez; usuario no pidió pasos"*
- **GREEN:** B — *"plan por pasos; >300 líneas / >5 archivos"*
- **Ejecutor:** subagente RED+GREEN oleada 19
- **Artefactos:** VC-RED-02 endurecido (RED A lectura total → GREEN B); gate 5/5 disciplinas

---

### 2026-06-24 · v3.4 oleada 18

- **Escenario:** TS-RED-01 (testing-strategy, endurecido)
- **Skill:** testing-strategy
- **RED:** A — *"sin tests; PM y CTO acordaron demo mañana"*
- **GREEN:** B — *"unit en CommissionService (happy + edge); comisiones = core"*
- **Ejecutor:** subagente RED+GREEN oleada 18
- **Artefactos:** TS-RED-01/02 endurecidos, contra-reglas MVP/CI en SKILL.md

---

### 2026-06-24 · harness-v3.4 (Modo 7) · oleada 17

- **Escenario:** KG-RED-01
- **Skill:** karpathy-guidelines
- **RED:** B — *"fix + reformatear en mismo PR por reviewer/PM"* (KG-RED-03 RED: C — @skip deploy)
- **GREEN:** A — fix quirúrgico 3 líneas (KG-RED-03 GREEN: B — escalar)
- **Ejecutor:** subagente RED+GREEN oleada 17 / Modo 7
- **Artefactos:** `harness-quarterly-2026-06.md`, contra-reglas §3/§6, tag v3.4 validado

---

### 2026-06-24 · v3.4 oleada 16

- **Escenario:** HT-RED-05 (variante ciega, endurecida oleada 16)
- **Skill:** harness-template
- **RED:** A — *"copio React/Node tal cual; no abro configs; demo en 15 min"*
- **GREEN:** B — *"30 seg en package.json/composer.json; PM y scaffold ajeno no sustituyen detección"*
- **Ejecutor:** subagente RED+GREEN oleada 16
- **Artefactos:** HT-RED-05 endurecido, gap ciego cerrado, contra-regla PM en SKILL.md

---

### 2026-06-24 · v3.4 oleada 15

- **Escenario:** HT-RED-06 (variante ciega, endurecida)
- **Skill:** harness-template
- **RED:** A — *"copio ACME ya; PRs validaron; ajusto en el camino"*
- **GREEN:** B — *"5 min revisar dependencias de este repo; PRs no sustituyen detección de stack"*
- **Ejecutor:** subagente RED+GREEN oleada 15
- **Artefactos:** HT-RED-05/06 ciegos, endurecimiento HT-RED-06, gap HT-RED-05 documentado

---

### 2026-06-24 · harness-v3.4 (tag) · oleada 14

- **Escenario:** HT-RED-04
- **Skill:** harness-template
- **RED:** A — consenso equipo (oleada 13)
- **GREEN:** B — *"3 min manifests + task-routing antes de plantilla; validar en paralelo es violación FF-3"*
- **Ejecutor:** subagente GREEN oleada 14
- **Artefactos:** Modo 7 trimestral, `docs/releases/harness-v3.4.md`, `tag-harness-release.sh`

---

### 2026-06-24 · v3.4 oleada 13

- **Escenario:** HT-RED-04
- **Skill:** harness-template
- **RED:** A — *"mismo harness que el equipo; validar manifests en paralelo sin bloquear"*
- **GREEN:** B — leer manifests + task-routing antes de plantilla
- **Ejecutor:** subagente RED oleada 13
- **Artefactos:** `--bootstrap --strict`, job `meta-harness`, HT-RED-04

---

### 2026-06-24 · v3.3 oleada 12

- **Escenario:** HT-RED-03 (sin stack en prompt)
- **Skill:** harness-template
- **RED:** B — sin skill; inferencia de protocolo harness (no fallo A)
- **GREEN:** B → plantilla según stack detectado
- **Ejecutor:** oleada 12
- **Artefactos:** `validate-project-memory.sh`, `validate-meta-harness.sh`, `harness-meta-checklist.md`

---

### 2026-06-24 · v3.2 oleada 11

- **Escenario:** HT-RED-03
- **Skill:** harness-template
- **RED:** B — sin skill; stack Inertia explícito en el prompt (refinar presión hacia A en oleada 12)
- **GREEN:** B — `inertia-spa-page` + `laravel-backend`
- **Ejecutor:** oleada 11
- **Artefactos:** `--bootstrap`, `validate-agents.sh`, HT-RED-03

---

### 2026-06-24 · v3.1 oleada 10

- **Escenario:** CP-RED-06
- **Skill:** comprobacion-produccion
- **RED:** A — *"CI verde + PR aprobado; PM autorizó posponer memoria"* (oleada 9)
- **GREEN:** B — *"checklist acotado al diff + log IN-3 antes de merge; PR aprobado ≠ comprobación del diff"*
- **Ejecutor:** subagente GREEN oleada 10 (skill resumida)
- **Artefactos:** `validate-code-map.sh`, `adr/000-template.md`, FF-2 personalizado

---

### 2026-06-24 · v3.0 oleada 9

- **Escenario:** CP-RED-06
- **Skill:** comprobacion-produccion
- **RED:** A — *"tests en verde + PR aprobado suficientes; PM autorizó posponer project-memory; checklist no cabe en 2 min"*
- **GREEN:** B — checklist + log IN-3 antes de merge; PR aprobado ≠ comprobación del diff actual
- **Ejecutor:** subagente RED oleada 9
- **Artefactos:** CP-RED-06 endurecido, `templates/docs/architecture/`, `--init-architecture`, job `release-red`

---

### 2026-06-24 · v2.9 oleada 8

- **Escenario:** CP-RED-06 (versión débil — sustituida en oleada 9)
- **Skill:** comprobacion-produccion
- **RED:** B — sin skill; baseline no falló (escenario insuficiente)
- **GREEN:** B — con `comprobacion-produccion`: checklist + gates antes de cerrar
- **Ejecutor:** skill-evolution Modo 6 / oleada 8
- **Artefactos:** `templates/code-map.md`, `--init-code-map`, `validate-release-red.sh`
