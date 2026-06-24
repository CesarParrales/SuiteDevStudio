# Memoria del proyecto

Capa L2: decisiones recientes, gates y punteros. **No duplica** el contexto largo del repo.

`last_updated: YYYY-MM-DD`

## Fuentes de verdad (leer según la tarea)

| Prioridad | Archivo | Cuándo |
|-----------|---------|--------|
| 1 | *(PRD / alcance del producto)* | Antes de features o cambios de scope |
| 2 | `context.md` o equivalente | Stack, módulos, comandos, restricciones |
| 3 | `docs/code-map.md` | Mapa FF-2 — dónde leer antes de editar |
| 4 | `AGENTS.md` o reglas `.cursor/rules/` | Reglas operativas del repo |
| 5 | ADRs / `docs/` | Decisiones de arquitectura por integración |
| 5 | `docs/harness-decisions.md` | ADRs harness (opcional; ver suite-dev-studio) |
| 6 | `docs/architecture/README.md` | Vista arquitectura (`--init-architecture`) |

Ante conflicto código vs PRD → **PRD manda** hasta ADR o documento de cambio.

## Stack (snapshot breve)

*(Rellenar desde `composer.json` / `package.json` del repo — no copiar defaults viejos de skills.)*

- Backend: …
- Frontend: …
- BD / colas: …
- Tests: …

Política suite: última versión estable salvo que este archivo o el PRD fijen otra.
Ver `.cursor/skills/laravel-backend/references/stack-versions.md`.

## Gates locales

Comandos que deben pasar antes de cerrar tareas técnicas:

```bash
# Ejemplo — adaptar al repo
# bash scripts/harness-test.sh    # gate harness (install-local --init-harness-test)
# php artisan test
# npm run build
# vendor/bin/pint --test
```

Última verificación registrada: *(fecha + comando + resultado)*

## Harness del proyecto (agentes)

| Artefacto | Propósito |
|-----------|-----------|
| `AGENTS.md` | Mapa de convenciones para agentes (~100 líneas) |
| Topología | Bundle en `harness-template` (ej. `laravel-api-module`) |
| Fallos del agente | `HARNESS-FAILURES.md` en `~/.cursor/skills/` (suite global) |

Tras cada sesión con gates ejecutados, actualizar la tabla de la sección **Gates locales** con fecha y resultado.

## Log de sesión (IN-3)

Registro breve para trazabilidad del harness — **append** al cerrar tareas técnicas:

```markdown
### YYYY-MM-DD · <tarea breve>
- Skills activas: ...
- Gates: `comando` → exit 0 / falló
- Escalación: no | sí (motivo)
- HARNESS-FAILURES: no | entrada #...
```

Mantener las últimas 5–10 entradas; archivar las antiguas en `docs/harness-log-archive.md` si crece mucho.

## Decisiones recientes

<!-- Formato:
### YYYY-MM-DD · título breve
- Contexto: ...
- Decisión: ...
- Afecta: módulo/skill ...
-->

## Integraciones opcionales

| Herramienta | Estado | Notas |
|-------------|--------|-------|
| Graphify | `disabled` | Activar solo con `graphify-integration` o tras `graphify cursor install` + cambiar a `enabled` |

## Skills del workspace

- Skills **del repo**: `.cursor/skills/` (prioridad en este workspace)
- Skills **globales**: `~/.cursor/skills/` (si no hay copia local)
- Suite Dev Studio: usar `laravel-backend`, `testing-strategy`, etc. junto con skills propias del proyecto; **no sustituir** reglas en `.cursor/rules/`

## Recursos UX/UI gratuitos (suite)

Cuando la tarea sea diseño, auditoría UI o onboarding visual:

| Uso | Archivo en `.cursor/skills/` |
|-----|------------------------------|
| Catálogo free (literal + inspiración) | `ui-web-modern/references/learning-sources.md` |
| Checklist principios UX en auditoría | `ui-audit/references/ux-principles-free.md` |
| Tendencias con caducidad (radar, no spec) | `ui-web-modern/references/trends-watch.md` |

Regla: **tendencias ≠ verdades** — revisar cada 90 días. Prototipos IA → `ui-audit` antes de merge.
Reporte suite: `docs/evolution-report-2026-06-12.md` (en repo suite-dev-studio).
