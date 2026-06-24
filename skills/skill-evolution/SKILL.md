---
name: skill-evolution
description: >
  Mantiene y mejora la suite de skills de desarrollo: consolida lecciones de uso
  (LEARNINGS.md) en los SKILL.md, audita integridad de enlaces y frontmatter,
  revisa la frescura de datos con caducidad, y registra fallos del harness en
  HARNESS-FAILURES.md (Modo 4). Usar cuando el usuario diga
  "consolida aprendizajes", "actualiza las skills", "revisa la suite",
  "qué lecciones hay pendientes", "audita las skills", "datos caducados",
  "registrar fallo del harness", "steering loop", "madurez harness",
  "readiness assessment", "cierre trimestral harness", "tag harness", o periódicamente
  (recomendado: cada 2-4 semanas o tras un proyecto grande).
---

# Skill Evolution — Mantenimiento y aprendizaje de la suite

Meta-skill que cierra el circuito de aprendizaje de la suite: las skills registran
lecciones durante el uso (`LEARNINGS.md`), y esta skill las convierte en mejoras
permanentes de los `SKILL.md` y sus references.

Raíz de la suite: la carpeta `skills/` que contiene esta skill y sus hermanas.

## Capas de memoria (L0–L3)

La suite usa memoria en capas para reducir fricción y tokens:

| Capa | Ubicación | Cuándo leer | Cuándo escribir |
|------|-----------|-------------|-----------------|
| L0 | Chat / sesión | Siempre | Resumen al cerrar si el usuario lo pide |
| L1 | `SKILL.md` + `references/` | Al activar la skill | Solo vía `skill-evolution` (consolidación) |
| L2 | `.cursor/project-memory.md` del repo | Paso 0 de skills con `## Memoria` | Decisiones de proyecto, gates verificados |
| L3 | `LEARNINGS.md` por skill | `## Pendientes` al iniciar si hay entradas | Gaps/correcciones al cerrar tarea |

**Reglas:** L2 complementa `context.md`/PRD, no los reemplaza. L3 no edita SKILL.md directamente — esta skill consolida. Graphify (`graphify-integration`) es opt-in vía project-memory o petición explícita.

Plantillas: `templates/project-memory.md`, `templates/memoria-section.md`.

**Harness global (raíz `skills/`):** `HARNESS-FAILURES.md` — catálogo de fallos del agente y remedios (Modo 4).

## Protocolo de ejecución

### Modo 1 — Consolidar aprendizajes (default)

1. **Recolectar**: busca entradas pendientes en toda la suite:

```bash
grep -rln "### " skills/*/LEARNINGS.md
```

   Lee la sección `## Pendientes` de cada archivo con resultados.

2. **Clasificar** cada entrada:
   - `gap` → falta contenido: añadir sección/dato al SKILL.md o reference correspondiente
   - `corrección` → contenido erróneo: corregir en el archivo donde vive
   - `mejora` → nuevo default/plantilla/atajo: integrarlo en Defaults o Entregable

3. **Proponer**: presenta al usuario una tabla `Skill | Entrada | Cambio propuesto | Archivo destino`
   y espera aprobación antes de editar. Si una entrada es ambigua o contradice el
   contenido actual, márcala como `requiere decisión` con las dos opciones.

4. **Aplicar** los cambios aprobados. Reglas:
   - Mantener SKILL.md < 500 líneas (mover detalle a references si crece)
   - No duplicar: si el dato existe en una reference, corregir ahí y no copiarlo al SKILL.md
   - Conservar el estándar de portabilidad (ver abajo)

5. **Archivar**: mueve cada entrada consolidada de `## Pendientes` a `## Consolidadas`
   en su LEARNINGS.md, añadiendo `→ aplicado YYYY-MM-DD en <archivo>`.

6. **Verificar** (gate): por cada skill tocada ejecuta la auditoría de integridad del Modo 2.

### Modo 2 — Auditoría de integridad

Ejecutar tras consolidar, o cuando se pida "audita las skills":

```bash
# 1. Enlaces rotos a references (excluye skill-evolution: sus ejemplos contienen rutas genéricas)
for d in skills/*/; do
  [ "$d" = "skills/skill-evolution/" ] && continue
  for ref in $(grep -o 'references/[a-zA-Z0-9_-]*\.md' "$d/SKILL.md" 2>/dev/null | sort -u); do
    [ -f "$d$ref" ] || echo "ROTO: $d → $ref"
  done
done

# 2. Frontmatter no portable (solo name y description son válidos)
grep -ln 'auto_reference\|^complementa:\|contexto_critico\|^version:\|^based_on:' skills/*/SKILL.md | grep -v skill-evolution

# 3. Herramientas de runtime específico
# (rollup-plugin-visualizer y vite-bundle-visualizer son paquetes npm válidos, no son hallazgo)
grep -rn 'visualizer\|show_widget' skills/ | grep -v 'skill-evolution\|rollup-plugin\|vite-bundle\|visualizer('

# 4. SKILL.md sobre el límite
wc -l skills/*/SKILL.md | awk '$1 > 500 {print "LARGO:", $2, $1}'
```

Gate: los 4 chequeos deben devolver vacío. Si no, corregir antes de cerrar.
Nota: esta skill se excluye de los chequeos 1-3 porque sus propios scripts contienen los patrones buscados.

### Modo 3 — Revisión de frescura

1. Localiza datos con caducidad:

```bash
grep -rln 'last_updated\|Datos con caducidad\|revisar_cada' skills/
```

2. Para cada archivo: compara `last_updated` con la fecha actual y su `revisar_cada`
   (default: 90 días). Lista los vencidos.
3. Para cada vencido, actualiza con búsqueda web: CVEs e incidentes de supply chain,
   versiones de frameworks, precios/free tiers, modelos de IA, tendencias de diseño.
4. Actualiza el contenido y el `last_updated`. Registra el cambio en el LEARNINGS.md
   de la skill afectada (sección Consolidadas, tipo `frescura`).

### Modo 4 — Steering loop (HARNESS-FAILURES)

Ejecutar cuando un fallo del agente sea **repetido** o el usuario pida "registrar fallo del harness":

1. Leer `HARNESS-FAILURES.md` (raíz de `skills/`, hermana de esta carpeta).
2. Añadir entrada con formato del archivo (fecha, fallo, contexto, remediación, estado).
3. Si la remediación es una regla permanente → proponer cambio en la skill afectada (Modo 1) y marcar entrada `cerrado` con `→ aplicado YYYY-MM-DD en <archivo>`.
4. Si el fallo sugiere nueva topología → añadir plantilla en `harness-template/templates/` y registrar en su SKILL.md.

No duplicar entradas abiertas para el mismo fallo; actualizar la existente.

### Modo 5 — Readiness harness

Ejecutar cuando pidan "madurez harness", "readiness assessment" o tras cambios grandes al harness:

1. Leer [harness-template/references/readiness-checklist.md](../harness-template/references/readiness-checklist.md).
2. Ejecutar el script (heurísticas):

```bash
# Suite (gate completo)
bash scripts/harness-test.sh

# Solo score
bash skills/harness-template/scripts/harness-readiness.sh --suite ./skills --project . --ci

# Proyecto cliente
bash .cursor/skills/harness-template/scripts/harness-readiness.sh --suite .cursor/skills --project . --ci
```

3. Revisar ítems `parcial`/`falta` y ajustar manualmente si el contexto lo requiere.
4. Entregar informe del script + **top 3 gaps** con una acción concreta por gap.
5. Proponer una mejora por gap de mayor impacto; registrar en LEARNINGS o HARNESS-FAILURES si aplica.

### Modo 6 — Release harness (oleada)

Al cerrar una oleada del MANIFIESTO harness (v3.x):

1. Leer [docs/harness-release.md](../../../docs/harness-release.md).
2. Ejecutar `bash scripts/harness-test.sh`.
3. **RED + GREEN** de 1 escenario (`scenarios-discipline.md`) con subagentes frescos.
4. Append en [docs/harness-release-log.md](../../../docs/harness-release-log.md).
5. Sincronizar skills a `~/.cursor/skills/` si hubo cambios.

```bash
skills/testing-skills-with-subagents/scripts/validate-release-red.sh
```

### Modo 7 — Cierre trimestral harness

Cada **8–12 semanas** o antes de etiquetar `harness-v*`:

1. Leer [references/quarterly-harness.md](references/quarterly-harness.md).
2. Ejecutar Modos **2 + 3 + 5** (auditoría, frescura, readiness).
3. Modo **1** si hay LEARNINGS pendientes en skills de disciplina.
4. Modo **4** — cerrar entradas aplicadas en `HARNESS-FAILURES.md`.
5. Verificar último RED+GREEN en `docs/harness-release-log.md`.
6. Actualizar `docs/releases/harness-vX.Y.md` y `MANIFIESTO.md`.
7. Sincronizar global: `./install-local.sh`.

```bash
bash scripts/tag-harness-release.sh v3.4   # valida gates; muestra git tag
```

### Gate — skills de disciplina

Al **editar** (no solo leer) una skill de disciplina, antes de dar por cerrado el cambio:

| Skill | Gate |
|-------|------|
| `comprobacion-produccion` | ≥1 escenario RED+GREEN (`testing-skills-with-subagents` + `scenarios-discipline.md`) |
| `karpathy-guidelines` | idem |
| `testing-strategy` | idem |
| `vibe-coding-token-optimization` | idem |
| `harness-template` | idem |

Si el usuario declina explícitamente el gate, registrar en LEARNINGS de la skill editada con motivo.

## Defaults si falta contexto

- Sin instrucción específica → ejecutar Modo 1 y cerrar con Modo 2.
- Sin aprobación explícita por entrada → agrupar y pedir una sola aprobación del lote.
- Entrada pendiente con >60 días sin consolidar → tratarla como prioritaria.
- Conflicto entre una lección y el contenido actual → gana la lección solo si incluye
  evidencia (comando, error, versión); si no, `requiere decisión`.

## Entregable

```markdown
# Reporte de evolución — YYYY-MM-DD

## Lecciones consolidadas
| Skill | Tipo | Cambio aplicado | Archivo |
|-------|------|-----------------|---------|

## Integridad
- Enlaces rotos: 0
- Frontmatter no portable: 0
- Herramientas no portables: 0
- SKILL.md > 500 líneas: 0

## Frescura
| Archivo | last_updated | Estado | Acción |
|---------|--------------|--------|--------|

## Pendientes que requieren decisión
- ...

## Harness (steering loop)
- Entradas nuevas en HARNESS-FAILURES.md: ...
- Entradas cerradas / consolidadas en skills: ...

## Readiness (Modo 5)
- Score /20: ...
- Top gaps: ...
```

## Estándar de portabilidad de la suite

Toda edición debe respetar (funciona en Cursor, Claude Code y otros IDEs):

1. Frontmatter YAML solo con `name` y `description` (tercera persona, QUÉ + CUÁNDO, <1024 caracteres).
2. Relaciones entre skills en el cuerpo (`## Skills relacionadas`), nunca en frontmatter.
3. Sin herramientas de runtime específico; visuales con Mermaid, tablas markdown o ASCII.
4. Gates con comandos shell estándar.
5. Enlaces relativos de un solo nivel (`references/<archivo>.md`).
6. Información time-sensitive aislada con `last_updated` + `revisar_cada`.

## Skills relacionadas

Esta skill opera sobre todas las demás skills de la suite. No requiere ninguna en particular.

## Aprendizaje continuo

Al cerrar una tarea donde se usó esta skill, registra en `LEARNINGS.md` (misma carpeta) cualquier hallazgo:

- **Gap**: información que faltó o estaba desactualizada
- **Corrección**: instrucción que resultó incorrecta o ambigua
- **Mejora**: default o plantilla que habría acelerado la tarea

Formato: fecha, contexto (1 línea), hallazgo, cambio propuesto. La skill `skill-evolution` consolida estas entradas en el SKILL.md periódicamente.
