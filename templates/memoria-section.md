<!-- Bloque estándar para pegar en SKILL.md bajo el título principal, antes del Protocolo -->

## Memoria

**Al iniciar** (solo si existen; no recargar lo ya presente en el chat):

1. `.cursor/project-memory.md` — decisiones, gates, punteros al repo.
2. Fuentes que indique project-memory (p. ej. `context.md`, `AGENTS.md`).
3. `LEARNINGS.md` de **esta skill** — solo `## Pendientes` si hay entradas.

**Durante la tarea:** leer cada `references/*.md` únicamente cuando el protocolo lo indique en el paso N.

**Al cerrar:**

- Decisiones del **proyecto** → `.cursor/project-memory.md` (sección Decisiones).
- Gaps de la **skill** → `LEARNINGS.md` de **la skill cargada** (p. ej. `~/.cursor/skills/<skill>/LEARNINGS.md` en Cursor global, o `.cursor/skills/<skill>/` si el proyecto tiene copia local). No atar L3 a un repo cliente concreto.
- **Mismo error 2+ veces** o **3+ iteraciones** sin avance → `HARNESS-FAILURES.md` (raíz de skills activa) **antes** de cerrar; actualizar entrada abierta existente si aplica.
- Fallos repetidos del agente (steering loop) → `HARNESS-FAILURES.md` + `skill-evolution` Modo 4 al consolidar.
- Entregable → archivo en el repo (`docs/…`), no solo en el chat.

**Ciclo suite:** `collect-learnings.sh` (global → canónico) → `skill-evolution` Modo 1 → `./install-local.sh`.

**Graphify:** solo si project-memory marca `Graphify: enabled` o el usuario lo pide explícitamente → skill `graphify-integration`. No reemplaza gates ni fuentes de verdad del proyecto.
