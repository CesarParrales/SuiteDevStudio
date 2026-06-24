# Catálogo de modos de fallo del harness

Registro central del **steering loop** (Harness Engineering): cuando el agente falla de forma repetida, documentar el fallo y la regla/skill que lo previene. `skill-evolution` consolida entradas recurrentes en skills permanentes.

**Cuándo escribir aquí:** el agente violó una convención, entró en bucle de reintentos, o un humano tuvo que corregir algo que el harness debió prevenir.

## Formato de entrada

```markdown
### YYYY-MM-DD — <título breve>
- **Fallo:** qué hizo mal el agente (hecho observable)
- **Contexto:** skill activa, stack, tipo de tarea
- **Remediación:** regla/skill/archivo añadido o ajustado
- **Estado:** abierto | cerrado
```

## Entradas

### 2026-06-12 — Suite sin catálogo de fallos del harness
- **Fallo:** incidentes repetidos sin registro central; el steering loop no cerraba entre sesiones
- **Contexto:** meta-harness, skill-evolution
- **Remediación:** este archivo + integración en `skill-evolution` Modo 4
- **Estado:** cerrado

### 2026-06-12 — Errores de CI sin formato autocorregible
- **Fallo:** el agente reintentaba a ciegas ante logs crudos de linter/test
- **Contexto:** comprobacion-produccion, feedback FB-3
- **Remediación:** `comprobacion-produccion/references/error-feedback-format.md`
- **Estado:** cerrado

### 2026-06-24 — Suite base sin testing-skills ni plantilla Next.js
- **Fallo:** harness-template referenciaba skill ausente; sin gate RED/GREEN en disciplina
- **Contexto:** suite-dev-studio, IN-2, FF-3
- **Remediación:** `testing-skills-with-subagents` + `scenarios-discipline.md`, `nextjs-saas-page`, Modo 5 readiness
- **Estado:** cerrado

### 2026-06-24 — Sin plantilla AGENTS ni validación FB-3 en CI
- **Fallo:** FF-1 débil en repos nuevos; FB-3 solo textual sin sensor computacional
- **Contexto:** harness v2.3, topologías Flutter/Nest pendientes
- **Remediación:** `templates/AGENTS.md`, `validate-fb3.sh`, `flutter-feature`, `node-api-nest`, `--init-agents`
- **Estado:** cerrado

### 2026-06-24 — CI del harness y topologías Filament/RN
- **Fallo:** sin validación automática de la suite; faltaban plantillas admin/mobile
- **Contexto:** IN-1/IN-2, FF-3 en CI
- **Remediación:** `.github/workflows/harness-validate.yml`, CP-RED-03/04, filament + RN templates
- **Estado:** cerrado

### 2026-06-24 — Readiness manual y sin CI en proyectos cliente
- **Fallo:** Modo 5 solo en markdown; repos cliente sin workflow reutilizable
- **Contexto:** TR-3, IN-2 proyectos, stack Inertia frecuente
- **Remediación:** `harness-readiness.py`, `--init-github`, `inertia-spa-page`
- **Estado:** cerrado

### 2026-06-24 — Gaps FF-4/FB-2/IN-3 en la suite canónica
- **Fallo:** Readiness 14.5/20; suite sin project-memory ni tests unificados
- **Contexto:** Modo 5 en CI oleada 6; FF-4, FB-2, IN-3 en falta
- **Remediación:** `.cursor/project-memory.md`, `docs/harness-decisions.md`, `scripts/harness-test.sh`, job `harness-readiness`
- **Estado:** cerrado

### 2026-06-24 · Umbral CI 16 y FF-2 sin mapa en suite
- **Fallo:** Readiness permitía 15/20 con FF-2/FB-1 parciales; clientes sin `harness-test.sh`
- **Contexto:** Oleada 7; proyectos Laravel/Next frecuentes
- **Remediación:** `suite-code-map.md`, `--init-harness-test`, `validate-red-scenarios.sh`, umbral 16
- **Estado:** cerrado

### 2026-06-24 · CP-RED-06 baseline sin fallo RED claro
- **Fallo:** Subagente RED eligió B sin skill; escenario no genera racionalización A/C
- **Contexto:** Oleada 8 release; presión de cierre 18:00 insuficiente
- **Remediación:** CP-RED-06 endurecido (deploy 15 min + PM vs checklist) en oleada 9
- **Estado:** cerrado

### 2026-06-24 · HT-RED-03 sin fallo RED ciego
- **Fallo:** Subagente elige B sin skill aunque el prompt oculte stack
- **Contexto:** Oleada 12; conocimiento previo de harness-template
- **Remediación:** HT-RED-04 con presión social; contra-regla "validar en paralelo"
- **Estado:** cerrado (HT-RED-04 RED→A)

### 2026-06-24 · HT-RED-05 variante ciega sin fallo RED
- **Fallo:** Subagente RED elige B sin skill incluso con presión de demo 20 min (×3 intentos oleada 15)
- **Contexto:** Variante ciega de HT-RED-03; sin jerga harness en prompt
- **Remediación:** HT-RED-05 endurecido oleada 16 (autoridad PM + amenaza explícita); RED A → GREEN B verificado
- **Estado:** cerrado

## Plantilla (copiar para nuevas entradas)

```markdown
### YYYY-MM-DD — <título>
- **Fallo:**
- **Contexto:**
- **Remediación:**
- **Estado:** abierto
```
